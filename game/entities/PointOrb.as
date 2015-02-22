package game.entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.motion.*;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author Benjin
	 */
	public class PointOrb extends Entity
	{
		private var image:Image;
		var path:QuadPath = new QuadPath (onPathComplete);
		
		private var sfx:Sfx;
		public static var pop:Boolean = false;
		
		public function PointOrb(x:Number, y:Number) 
		{
			this.x = x;
			this.y = y;
			this.centerOrigin ();
			
			image = new Image (Assets.firepebbleBD);
			image.centerOO ();
			this.graphic = image;
			
			
			path.addPoint (this.x, this.y);
			//path.addPoint (this.x + Math.random () * 40, this.y - Math.random () * 40);
			var tx:Number = 587 + Math.random () * 10 - 5;
			var ty:Number = 130 + Math.random () * 10 - 5;
			
			
			for (var i:int = 0; i < 1; i++) {
				path.addPoint (this.x + Math.random () * (tx - x), this.y - Math.random () * (y - ty));
			}
			
			path.addPoint (tx, ty);
			this.addTween (path, true);
			
			path.setMotion (Math.random () * 1.8 + 0.4, Ease.cubeIn);
			
			this.layer = -3;
			
			sfx = new Sfx (Assets.sndPop, function () {
				PointOrb.pop = false;
			});
		}
		public override function update ():void {
			this.x = path.x;
			this.y = path.y;
		}
		
		private function onPathComplete ():void {
			FP.world.remove (this);
			if (PointOrb.pop == false) {
				sfx.play ();
				PointOrb.pop = true;
			}
		}
	}

}