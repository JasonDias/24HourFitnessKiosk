package prj.twentyfourhourfitness.kiosk 
{
	import flash.desktop.NativeApplication;
	import flash.display.*;
	import flash.events.*;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	
	import com.carlcalderon.arthropod.Debug;
	
	import gs.TweenLite;	

	/**
	 * @author Jason Dias
	 */
	public class Concept extends MovieClip 
	{
		public var loadingDisplay:MovieClip;
		public var item1:MovieClip;
		private var ourHTMLLoader:HTMLLoader;
		
		public function Concept():void
		{
			NativeApplication.nativeApplication.autoExit = true;
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);			NativeApplication.nativeApplication.addEventListener(Event.EXITING, applicationExit);
			
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP_LEFT;
			stage.displayState 	= StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			loadingDisplay.stop();
			loadingDisplay.alpha=0;
			loadingDisplay.visible=false;
		}
		
		private function applicationExit(myEvent:Event):void
		{
			Debug.log("Application Exit", Debug.RED);
		}

		private function resizeEvent(event:Event):void
		{
			ourHTMLLoader.x = stage.stageWidth-(ourHTMLLoader.width+15);
		}

		private function pageLoaded(myEvent:Event):void
		{
			Debug.log('Page Loaded', Debug.GREEN);
			ourHTMLLoader.removeEventListener(Event.COMPLETE, pageLoaded);
			
			if(!ourHTMLLoader.visible)
				TweenLite.to(ourHTMLLoader, .5, {autoAlpha:1});

			TweenLite.to(loadingDisplay, .3, {autoAlpha:0});
			loadingDisplay.stop();
		}

		private function loadHTML(event:MouseEvent):void
		{
			TweenLite.to(loadingDisplay, .3, {autoAlpha:1});
			loadingDisplay.play();
			ourHTMLLoader.addEventListener(Event.COMPLETE, pageLoaded);
			ourHTMLLoader.load(new URLRequest("https://www.24hourfitness.com/fit24/Membership.html?clubid=00654&agencyEmployeeId=null&agencySrcTypeId=null&memType=null&appid=654A"));
		}
		
		private function onInvoke(myEvent:InvokeEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
			
			ourHTMLLoader = new HTMLLoader();
			
			ourHTMLLoader.alpha=0;
			ourHTMLLoader.visible=false;
			ourHTMLLoader.addEventListener(Event.COMPLETE, pageLoaded);
			ourHTMLLoader.width = 1024;			ourHTMLLoader.height = 900;

			resizeEvent(null);

			addChild(ourHTMLLoader);

			stage.nativeWindow.addEventListener(Event.RESIZE, resizeEvent);
			
			item1.buttonMode=true;
			item1.addEventListener(MouseEvent.CLICK, loadHTML);		}
	}
}
