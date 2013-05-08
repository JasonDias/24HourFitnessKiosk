package prj.twentyfourhourfitness.kiosk.ui 
{
	import gs.TweenLite;	
	
	import prj.twentyfourhourfitness.kiosk.data.BlinderData;	
	
	import flash.display.Sprite;
	
	public class Blinder extends Sprite 
	{
		public function Blinder()
		{
		}
		
		public function drawBlinder(myBlinderData:BlinderData):void
		{
			graphics.clear();
			var myWidth:Number = myBlinderData.lowerRight.x - myBlinderData.upperLeft.x;			var myHeight:Number =  myBlinderData.lowerRight.y - myBlinderData.upperLeft.y;
			graphics.beginFill(0x0000FF);
			graphics.drawRect(myBlinderData.upperLeft.x, myBlinderData.upperLeft.y, myWidth, myHeight);
			graphics.endFill();
		}
		
		public function setColor(myColor:Number):void
		{
			TweenLite.to(this, .1, {tint:myColor});
		}
	}
}
