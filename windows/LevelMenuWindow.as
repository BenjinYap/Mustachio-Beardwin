package windows 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Benjin
	 */
	public class LevelMenuWindow extends Entity
	{
		private var nextCallback:Function;
		private var menuCallback:Function;
		private var image:Image;
		
		private var next:TextBlurb;
		private var menu:TextBlurb;
		
		public function LevelMenuWindow(nextCallback:Function, menuCallback:Function) 
		{
			this.nextCallback = nextCallback;
			this.menuCallback = menuCallback;
			
			this.width = 500;
			this.height = 200;
			this.centerOrigin ();
			this.x = FP.halfWidth;
			this.y = FP.halfHeight;
			
			image = new Image (Assets.levelCompleteWindowBD);
			image.centerOO ();
			this.graphic = image;
			
			this.layer = -100;
			
			next = new TextBlurb ("Next Level", 100, 50, 12, nextCallback);
			next.layer = this.layer - 1;
			next.x = this.x;
			next.y = this.y - 50;
			next.centerOrigin ();
			FP.world.add (next);
			
			menu = new TextBlurb ("Menu", 100, 50, 12, menuCallback);
			menu.layer = this.layer - 1;
			menu.x = this.x;
			menu.y = this.y + 50;
			menu.centerOrigin ();
			FP.world.add (menu);
		}
		
		public override function removed ():void {
			FP.world.remove (next);
			FP.world.remove (menu);
		}
	}

}