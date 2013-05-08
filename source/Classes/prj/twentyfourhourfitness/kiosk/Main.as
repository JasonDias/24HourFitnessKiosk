package prj.twentyfourhourfitness.kiosk 
{
	import prj.twentyfourhourfitness.kiosk.data.BlinderData;	
	
	import flash.printing.PrintJob;	
	import flash.desktop.NativeApplication;
	import flash.display.*;
	import flash.events.*;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import com.carlcalderon.arthropod.Debug;
	import com.yahoo.astra.fl.managers.AlertManager;
	
	import fl.controls.ScrollBar;
	import fl.controls.ScrollBarDirection;
	import fl.events.ScrollEvent;
	
	import gs.TweenLite;
	
	import prj.twentyfourhourfitness.kiosk.data.XMLConfigLoaderEvent;
	import prj.twentyfourhourfitness.kiosk.data.XMLConfigurationLoader;
	import prj.twentyfourhourfitness.kiosk.menu.MainMenu;
	import prj.twentyfourhourfitness.kiosk.menu.Menu;
	import prj.twentyfourhourfitness.kiosk.ui.IHTMLLoadable;
	import prj.twentyfourhourfitness.kiosk.ui.SidePanel;
	import prj.twentyfourhourfitness.kiosk.ui.Blinder;		

	/**
	 * @author Jason Dias
	 */
	public class Main extends MovieClip 
	{
		public var loadingDisplay:MovieClip;
		public var mainMenu:MainMenu;
		public var sideMenu:SidePanel;
		public var printBtn:MovieClip;
		public var bg:MovieClip;
		
		private var ourShowPrintButton:Boolean;
		private var ourHTMLLoader:HTMLLoader;
		private var ourXMLConfigLoader:XMLConfigurationLoader;
		private var ourTimeout:Number;
		private var ourVScrollBar:ScrollBar;
		private var ourTimeoutId:Number;
		private var alertTimeoutId:uint;
		private var ourAlertManager:AlertManager;
		private var ourBlinder:Blinder;
		private var maskContent:Boolean;

		public function Main():void
		{
			NativeApplication.nativeApplication.autoExit = true;
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);			NativeApplication.nativeApplication.addEventListener(Event.EXITING, applicationExit);
			
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP_LEFT;
			stage.displayState 	= StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			loadingDisplay.stop();
			loadingDisplay.alpha=0;
			loadingDisplay.visible=false;
			
			printBtn.visible=false;
			printBtn.alpha=0;
			printBtn.y = 20;
			
			ourShowPrintButton = false;
			ourTimeoutId=0;
			
			maskContent = false;
		}

		private function applicationExit(myEvent:Event):void
		{
			Debug.log("Application Exit", Debug.RED);
		}

		private function resizeEvent(event:Event):void
		{
			var myStageWidth:Number = stage.stageWidth;			var myStageHeight:Number = stage.stageHeight;
			
			var myRatio:Number = myStageHeight / sideMenu.height;			sideMenu.scaleY = sideMenu.scaleY * myRatio;			sideMenu.scaleX = sideMenu.scaleX * myRatio;
			
			var myHTMLWidth:Number = myStageWidth;// - sideMenu.width;
			
			ourHTMLLoader.width = myHTMLWidth-20;
			ourHTMLLoader.height = myStageHeight;
			
			ourVScrollBar.height = ourHTMLLoader.height;
			ourVScrollBar.pageSize = ourHTMLLoader.height;
			
			ourHTMLLoader.x = 20;
			ourVScrollBar.x = myStageWidth-15;//ourHTMLLoader.x + ourHTMLLoader.width;
			ourVScrollBar.y = 0;
			
			loadingDisplay.x = ourHTMLLoader.x + (ourHTMLLoader.width / 2); 			loadingDisplay.y = ourHTMLLoader.height / 2; 
			
			var myMenuRatioW:Number = (myStageWidth-240) / mainMenu.width;			var myMenuRatioH:Number = (myStageHeight-96) / mainMenu.height;
			var myMenuRatio:Number = (myMenuRatioW < myMenuRatioH)?myMenuRatioW:myMenuRatioH;
			
			mainMenu.scaleX = mainMenu.scaleX * myMenuRatio;
			mainMenu.scaleY = mainMenu.scaleY * myMenuRatio;
			
			
			mainMenu.x = myStageWidth / 2;
			mainMenu.y = myStageHeight / 2;
			
			printBtn.x = myStageWidth - 56;			
			bg.width = stage.stageWidth;			bg.height = stage.stageHeight;
			bg.x = (myStageWidth - bg.width) / 2;			bg.x = (myStageHeight - bg.height) / 2;
		}
		
		private function resetTimeout(myEvent:MouseEvent):void
		{
			Debug.log('reset timeout');
			clearTimeout(ourTimeoutId);
			ourTimeoutId = setTimeout(triggerTimeout, ourTimeout);
		}
		
		private function triggerTimeout():void
		{
			alertTimeoutId = setTimeout(hideAlertAndGoHome, 30000);
			ourAlertManager = AlertManager.createAlert(this, "Do you need more time?", "Alert", null, needsMoreTime);
		}
		
		private function needsMoreTime(event:MouseEvent):void
		{
			Debug.log("I need more time");
			clearTimeout(alertTimeoutId);
			ourTimeoutId = setTimeout(triggerTimeout, ourTimeout);
		}

		private function hideAlertAndGoHome():void
		{
			Debug.log("Times Up!");
			ourAlertManager.manageQueue(null);
			goHome();
		}

		private function loadHTML(event:MouseEvent):void
		{
			resetTimeout(null);
			var myTarget:IHTMLLoadable = event.target as IHTMLLoadable;
			if(myTarget != null)
			{
				ourShowPrintButton = (event.target.labelDisplay.text == "class schedule");
				Debug.log(event.target.labelDisplay.text+' '+ourShowPrintButton);
				if(mainMenu.visible)
				{
					TweenLite.to(mainMenu, .5, {autoAlpha:0});
					mainMenu.imageRotator.stopRotation();
					sideMenu.minimize();				}
				TweenLite.to(loadingDisplay, .3, {autoAlpha:1});
				TweenLite.to(printBtn, .3, {autoAlpha:0});
				loadingDisplay.play();
				ourHTMLLoader.addEventListener(Event.COMPLETE, pageLoaded);
				
//				if(ourHTMLLoader.visible)
//					TweenLite.to(ourHTMLLoader, .3, {autoAlpha:0});
					
				var myBlinderData:BlinderData = myTarget.getBlinderData();
				if(myBlinderData != null)
				{
					ourBlinder.drawBlinder(myBlinderData);					ourBlinder.setColor(myBlinderData.color);
					maskContent=true;
				} else
					maskContent=false;
				ourHTMLLoader.load(new URLRequest(myTarget.getURL()));
			}
		}
		
		private function pageLoaded(myEvent:Event):void
		{
			Debug.log('Page Loaded', Debug.GREEN);
			ourHTMLLoader.removeEventListener(Event.COMPLETE, pageLoaded);
			
			if(!ourHTMLLoader.visible || ourHTMLLoader.alpha < 1)
				TweenLite.to(ourHTMLLoader, .5, {autoAlpha:1});
			
			if(maskContent)
			{
				ourHTMLLoader.mask = ourBlinder;
			}else {
				ourHTMLLoader.mask = null;
			}
			
			TweenLite.to(loadingDisplay, .3, {autoAlpha:0});
			TweenLite.to(ourVScrollBar, .5, {autoAlpha:1});
			
			if(ourShowPrintButton)
				TweenLite.to(printBtn, .3, {autoAlpha:1});
			
			updateScrollBar();
			loadingDisplay.stop();
		}

		private function goHome():void
		{
			if(!mainMenu.visible)
			{
				TweenLite.to(mainMenu, .5, {autoAlpha:1});
				mainMenu.imageRotator.startRotation();
				sideMenu.hide();
			}
			TweenLite.to(ourHTMLLoader, .5, {autoAlpha:0});
			TweenLite.to(ourVScrollBar, .5, {autoAlpha:0});
			TweenLite.to(loadingDisplay, .3, {autoAlpha:0});			TweenLite.to(printBtn, .3, {autoAlpha:0});
			loadingDisplay.stop();
		}
		
		private function goBack(myEvent:MouseEvent):void
		{
			clearTimeout(ourTimeoutId);
			goHome();
		}
		
		private function onInvoke(myEvent:InvokeEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
			
			ourXMLConfigLoader = new XMLConfigurationLoader();
			ourXMLConfigLoader.addEventListener(XMLConfigLoaderEvent.LOADED, configLoaded);
			ourXMLConfigLoader.loadXML('config.xml');
			ourVScrollBar = new ScrollBar();
			ourVScrollBar.direction = ScrollBarDirection.VERTICAL;
			ourVScrollBar.lineScrollSize = 15;
			
			ourBlinder = new Blinder();
			ourBlinder.visible=false;
			addChild(ourBlinder);
			ourHTMLLoader = new HTMLLoader();
			ourHTMLLoader.alpha=0;
			ourHTMLLoader.visible=false;
			ourHTMLLoader.addEventListener(Event.COMPLETE, pageLoaded);

			ourVScrollBar.visible=false;
			ourVScrollBar.alpha=0;
			resizeEvent(null);
			addChild(ourHTMLLoader);
			addChild(ourVScrollBar);
			ourTimeout = 60000;
			
			ourVScrollBar.addEventListener(ScrollEvent.SCROLL, onVScroll);
			stage.nativeWindow.addEventListener(Event.RESIZE, resizeEvent);			mainMenu.addEventListener(MouseEvent.CLICK, loadHTML);			sideMenu.navigation.addEventListener(MouseEvent.CLICK, loadHTML);
			sideMenu.backButton.addEventListener(MouseEvent.CLICK, goBack);
			sideMenu.addEventListener("IS_SHOWING", sideMenuShowing);			sideMenu.addEventListener("IS_HIDING", sideMenuHiding);
			printBtn.buttonMode = true;
			printBtn.addEventListener(MouseEvent.CLICK, printHTMLPage);
			
			swapChildren(printBtn, ourHTMLLoader);
			swapChildren(ourHTMLLoader, ourVScrollBar);
			swapChildren(ourHTMLLoader, sideMenu);
		}
		
		private function sideMenuHiding(e:Event):void
		{
			ourBlinder.x = 0;
			TweenLite.to(ourHTMLLoader, 0, {x:20});
		}

		private function sideMenuShowing(e:Event):void
		{
			ourBlinder.x = sideMenu.width;
			TweenLite.to(ourHTMLLoader, 0, {x:sideMenu.width});
		}

		private function printHTMLPage(myEvent:MouseEvent):void
		{
			var myPrintJob:PrintJob = new PrintJob();
			if(myPrintJob.start())
			{
				myPrintJob.addPage(ourHTMLLoader);
				myPrintJob.send();
			}
		}

		private function updateScrollBar():void
		{
			ourBlinder.y = 0;
			if(ourHTMLLoader.contentHeight > ourHTMLLoader.height)
			{
				ourVScrollBar.enabled = true;
				ourVScrollBar.minScrollPosition = 0;
				ourVScrollBar.maxScrollPosition = ourHTMLLoader.contentHeight - ourHTMLLoader.height;
			} else 
				ourVScrollBar.enabled = false;
		}
		
		private function onVScroll(myEvent:ScrollEvent):void
		{
			ourBlinder.y = -myEvent.position;
			ourHTMLLoader.scrollV = myEvent.position;
		}

		private function configLoaded(myEvent:XMLConfigLoaderEvent):void
		{
			ourTimeout = myEvent.timeout;
			mainMenu.populate(myEvent.data);
			sideMenu.navigation.populate(myEvent.data);
		}
	}
}
