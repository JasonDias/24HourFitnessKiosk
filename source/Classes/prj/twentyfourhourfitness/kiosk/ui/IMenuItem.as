package prj.twentyfourhourfitness.kiosk.ui 
{
	import prj.twentyfourhourfitness.kiosk.data.BlinderData;	
	
	/**
	 * @author Jason Dias
	 */
	public interface IMenuItem 
	{
		function setLabel(myValue:String):void;
		function setURL(myValue:String):void;
		function setColor(myValue:Number):void;
		function setImage(myValue:String):void;
		function setBlinder(myValue:BlinderData):void;
	}
}
