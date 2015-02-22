package game.entities 
{
	import flash.display.*;
	import flash.geom.Point;
	import game.GameWorld;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.tweens.misc.VarTween;
	/**
	 * ...
	 * @author Benjin
	 */
	public class UpgradeLightning extends Entity
	{
		private var image:Image;
		private var frame:int = 10;
		private var x1:Number;
		private var y1:Number;
		private var x2:Number;
		private var y2:Number;
		
		public function UpgradeLightning(x1:Number, y1:Number, x2:Number, y2:Number) 
		{
			this.type = "upgradeLightning";
			this.x1 = x1;
			this.y1 = y1;
			this.x2 = x2;
			this.y2 = y2;
			
			
			//var tween:VarTween = new VarTween (onFadeDone);
			//tween.tween (image, "alpha", 0, 0.3);
			//this.addTween (tween);
			
		}
		
		public override function added ():void {
			
		}
		
		public override function removed ():void {
			
		}
		
		public override function update ():void {
			if (frame > 0) {
				frame--;
			}
			
			GameWorld.techEmit.emit ("tech", x2, y2);
			
			if (frame == 0) {
				frame = 2;
				
				var dist:Number = Math.sqrt ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
				this.layer = -1000000;
				var bd:BitmapData = new BitmapData (FP.width, FP.height, true, 0x00000000);
				var p1:Point = new Point (x1, y1);
				var p2:Point = new Point ();
				
				Draw.setTarget (bd);
				var incs:int = 15;
				
				for (var i:int = 1; i < incs; i++) {
					var angle:Number = Math.atan2 (y2 - p1.y, x2 - p1.x) * 180 / Math.PI;
					angle += Math.random () * 40 - 20;
					angle *= Math.PI / 180;
					p2.x = p1.x + Math.cos (angle) * dist / incs;
					p2.y = p1.y + Math.sin (angle) * dist / incs;
					Draw.linePlus (p1.x, p1.y, p2.x, p2.y, 0xffff00, 1, 0.2 + (7 / incs * (incs - i)));
					p1.x = p2.x;
					p1.y = p2.y;
				}
				
				Draw.linePlus (p1.x, p1.y, x2, y2, 0xffff00, 1, 1);
				
				image = new Image (bd);
				
				this.graphic = image;
			}
		}
		
		private function onFadeDone ():void {
			FP.world.remove (this);
		}
		
	}

}