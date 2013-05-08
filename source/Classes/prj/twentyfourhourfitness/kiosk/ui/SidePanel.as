package prj.twentyfourhourfitness.kiosk.ui 
{
	import flash.events.Event;	
	import flash.events.MouseEvent;	
	import flash.display.MovieClip;
	
	import gs.TweenLite;
	
	import prj.twentyfourhourfitness.kiosk.menu.Menu;		

	/**
	 * @author Jason Dias
	 */
	public class SidePanel extends MovieClip 
	{
		public var navigation:Menu;
		public var backButton:MovieClip;
		
		public function SidePanel():void
		{
			alpha=0;
			backButton.buttonMode=true;
			addEventListener(MouseEvent.ROLL_OVER, showMenu);			addEventListener(MouseEvent.ROLL_OUT, minimizeMenu);
		}
		
		private function minimizeMenu(event:MouseEvent):void
		{
			minimize();
		}

		private function showMenu(event:MouseEvent):void
		{
			show();
		}

		public function show():void
		{
			TweenLite.to(this, .5, {autoAlpha:1, x:-1});
			dispatchEvent(new Event("IS_SHOWING"));
		}
		
		public function minimize():void
		{
			TweenLite.to(this, .5, {autoAlpha:1, x:-(width-20), onComplete:minimizeComplete});
		}
		
		private function minimizeComplete():void
		{
			dispatchEvent(new Event("IS_HIDING"));
		}
		
		public function hide():void
		{
			TweenLite.to(this, .5, {autoAlpha:0, x:-width});
		}
	}
}
