package prj.twentyfourhourfitness.kiosk.ui 
{
	import gs.easing.Back;	
	
	import flash.events.MouseEvent;	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import gs.TweenLite;
	
	import prj.twentyfourhourfitness.kiosk.data.BlinderData;		

	/**
	 * @author Jason Dias
	 */
	public class MenuItemMovieClip extends MovieClip implements IHTMLLoadable, IMenuItem
	{
		public var labelDisplay:TextField;
		public var frame:MovieClip;
		public var imageHolder:MovieClip;
		public var url:String;
		public var blinderData:BlinderData;
		
		private var ourImageLoader:Loader;
		private var ourOrigScale:Number;

		public function MenuItemMovieClip():void
		{
			ourImageLoader = new Loader();
			imageHolder.addChild(ourImageLoader);
			buttonMode=true;
			mouseChildren=false;
			addEventListener(MouseEvent.CLICK, feedback);
			ourOrigScale = scaleX;
		}
		
		private function feedback(event:MouseEvent):void
		{
			scaleX = ourOrigScale-.05;			scaleY = ourOrigScale-.05;
			TweenLite.to(this, .5, {scaleX:ourOrigScale, scaleY:ourOrigScale, ease:Back.easeInOut});
		}

		public function getURL():String
		{
			return url;
		}
		
		public function setColor(myValue:Number):void
		{
			TweenLite.to(frame, .3, {tint:myValue});
		}
		
		public function setLabel(myValue:String):void
		{
			labelDisplay.text = myValue;
		}
		
		public function setURL(myValue:String):void
		{
			url = myValue;
		}

		public function setImage(myValue:String):void
		{
			ourImageLoader.load(new URLRequest(myValue));
		}
		
		public function setBlinder(myValue:BlinderData):void
		{
			blinderData = myValue;
		}
		
		public function getBlinderData():BlinderData
		{
			return blinderData;
		}
	}
}
