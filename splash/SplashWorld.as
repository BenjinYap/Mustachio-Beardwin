package splash 
{
	import flash.display.Bitmap;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Benjin
	 */
	public class SplashWorld extends World
	{
		
		public function SplashWorld() 
		{
			
		}
		
		public override function begin ():void {
			//addGraphic(new Image(Assets.SPR_SPLASH));
			Main (FP.engine).GoMenu ();
		}
		
		public override function end ():void {
			
		}
	}

}