package prj.twentyfourhourfitness.kiosk.ui 
{
	import flash.text.TextField;	
	import flash.display.MovieClip;

	import prj.twentyfourhourfitness.kiosk.data.BlinderData;	

	/**
	 * @author Jason Dias
	 */
	public class RegisterButton extends MovieClip implements IHTMLLoadable, IMenuItem
	{
		public var url:String;
		public var labelDisplay:TextField;
		private var ourBlinderData:BlinderData;

		public function RegisterButton():void
		{
			buttonMode=true;
			mouseChildren=false;
		}
		public function getURL():String
		{
			return url;
		}
		
		public function setLabel(myValue:String):void
		{
		}
		
		public function setURL(myValue:String):void
		{
			url = myValue;
		}

		public function setColor(myValue:Number):void
		{
		}
		
		public function setImage(myValue:String):void
		{
		}
		
		public function getBlinderData():BlinderData
		{
			return ourBlinderData;
		}
		
		public function setBlinder(myValue:BlinderData):void
		{
			ourBlinderData = myValue;
		}
	}
}
