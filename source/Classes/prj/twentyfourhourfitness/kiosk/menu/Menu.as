package prj.twentyfourhourfitness.kiosk.menu 
{
	import prj.twentyfourhourfitness.kiosk.ui.IMenuItem;	
	
	import flash.display.MovieClip;
	
	import prj.twentyfourhourfitness.kiosk.data.MenuItemData;
	import prj.twentyfourhourfitness.kiosk.ui.MenuItemMovieClip;			

	/**
	 * @author Jason Dias
	 */
	public class Menu extends MovieClip implements IMenu
	{
		public var link1:MenuItemMovieClip;
		
		public function populate(myArray:Array):void
		{
			for each(var myMenuItemData:MenuItemData in myArray)
			{
				var myMenuItemMovieClip:IMenuItem = getChildByName(myMenuItemData.id) as IMenuItem;
				if(myMenuItemMovieClip != null)
				{
					myMenuItemMovieClip.setLabel(myMenuItemData.label); 
					myMenuItemMovieClip.setColor(myMenuItemData.color);
					myMenuItemMovieClip.setBlinder(myMenuItemData.blinder);
				}
			}
		}
	}
}