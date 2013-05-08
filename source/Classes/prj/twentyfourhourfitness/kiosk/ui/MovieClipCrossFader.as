package prj.twentyfourhourfitness.kiosk.ui 
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import gs.TweenLite;		

	/**
	 * @author Jason Dias
	 */
	public class MovieClipCrossFader 
	{
		private var ourMovieClips:Array;
		private var ourTimer:Timer;
		private var ourCurrentClip:DisplayObject;
		private var ourCurrentId:Number;
		
		public function MovieClipCrossFader(myTimeOut:Number=15000):void
		{
			ourCurrentId = 0;
			ourMovieClips = new Array();
			ourTimer = new Timer(myTimeOut);
			ourTimer.addEventListener(TimerEvent.TIMER, crossFade);
		}
		
		private function crossFade(myEvent:TimerEvent):void
		{
			TweenLite.to(ourCurrentClip, .5, {alpha:0});
			ourCurrentId++;
			if(ourCurrentId == ourMovieClips.length)
				ourCurrentId=0;
			var myNextClip:DisplayObject = ourMovieClips[ourCurrentId];
			TweenLite.to(myNextClip, .5, {alpha:1});
			ourCurrentClip = myNextClip;
		}

		public function addMovieClip(myValue:DisplayObject):void
		{
			if(ourMovieClips.length > 0)
				myValue.alpha=0;
			ourMovieClips.push(myValue);
		}

		public function start():void
		{
			if(ourMovieClips.length > 0)
			{
				ourCurrentClip = ourMovieClips[0];
				ourTimer.start();
			} else 
				throw new Error('No Items To CrossFade');
		}

		public function stop():void
		{
			ourTimer.stop();
		}
	}
}
