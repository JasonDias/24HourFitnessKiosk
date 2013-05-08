package prj.twentyfourhourfitness.kiosk.ui 
{
	import flash.display.MovieClip;	

	/**
	 * @author Jason Dias
	 */
	public class ImagesDisplay extends MovieClip 
	{
		private var ourMovieClipCrossFader:MovieClipCrossFader;
		public var image1:MovieClip;		public var image2:MovieClip;		public var image3:MovieClip;		public var image4:MovieClip;
		
		public function ImagesDisplay():void
		{
			ourMovieClipCrossFader = new MovieClipCrossFader(3000);
			
			ourMovieClipCrossFader.addMovieClip(image1);
			ourMovieClipCrossFader.addMovieClip(image2);
			ourMovieClipCrossFader.addMovieClip(image3);
			ourMovieClipCrossFader.addMovieClip(image4);
			
			ourMovieClipCrossFader.start();
		}
		
		public function startRotation():void
		{
			ourMovieClipCrossFader.start();
		}
		
		public function stopRotation():void
		{
			ourMovieClipCrossFader.stop();
		}
	}
}
