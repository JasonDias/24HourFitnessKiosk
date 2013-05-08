package prj.twentyfourhourfitness.kiosk.data 
{
	import com.carlcalderon.arthropod.Debug;	
	
	import flash.geom.Point;	
	import flash.events.*;
	import flash.net.*;	

	/**
	 * @author Jason Dias
	 */
	public class XMLConfigurationLoader extends EventDispatcher 
	{
		private var ourData:XML;
		private var ourURLLoader:URLLoader;
		private var ourMenuItemDataArray:Array;
		
		public function XMLConfigurationLoader():void
		{
			ourURLLoader = new URLLoader();
			ourURLLoader.addEventListener(Event.COMPLETE, loadComplete);
		}
		
		private function loadComplete(myEvent:Event):void
		{
			ourData = new XML(myEvent.target.data);
			ourMenuItemDataArray = new Array();
			var myList:XMLList = ourData..link;
			for each(var myLink:XML in myList)
			{
				var myMenuItemData:MenuItemData = new MenuItemData();
				myMenuItemData.color 	= myLink.color;				myMenuItemData.label 	= myLink.label;				myMenuItemData.url 		= myLink.url;				myMenuItemData.id 		= myLink.id;				myMenuItemData.imageURL = myLink.image;
				if(myLink.child("blinder").children().length() > 0)
				{
					myMenuItemData.blinder = new BlinderData();
					myMenuItemData.blinder.color = myLink.blinder.color;					myMenuItemData.blinder.upperLeft = new Point(myLink.blinder.upperLeft.x, myLink.blinder.upperLeft.y);					myMenuItemData.blinder.lowerRight = new Point(myLink.blinder.lowerRight.x, myLink.blinder.lowerRight.y);
				}
				ourMenuItemDataArray.push(myMenuItemData);
			}
			var myXMLConfigLoaderEvent:XMLConfigLoaderEvent = new XMLConfigLoaderEvent(XMLConfigLoaderEvent.LOADED);
			myXMLConfigLoaderEvent.data = ourMenuItemDataArray;
			myXMLConfigLoaderEvent.timeout = (ourData..timeout)*1000;
			dispatchEvent(myXMLConfigLoaderEvent);
		}

		public function loadXML(myValue:String):void
		{
			ourURLLoader.load(new URLRequest(myValue));
		}
	}
}
