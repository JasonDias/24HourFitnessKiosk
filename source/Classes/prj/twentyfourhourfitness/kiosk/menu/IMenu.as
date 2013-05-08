package prj.twentyfourhourfitness.kiosk.menu 
{
	import flash.events.IEventDispatcher;		

	/**
	 * @author Jason Dias
	 */
	public interface IMenu extends IEventDispatcher
	{
		function populate(myArray:Array):void;
	}
}
