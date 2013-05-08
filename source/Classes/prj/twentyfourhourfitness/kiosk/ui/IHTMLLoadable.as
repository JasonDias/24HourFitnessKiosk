package prj.twentyfourhourfitness.kiosk.ui 
{
	import prj.twentyfourhourfitness.kiosk.data.BlinderData;	
	
	/**
	 * @author Jason Dias
	 */
	public interface IHTMLLoadable 
	{
		function getURL():String;		function getBlinderData():BlinderData;
	}
}
