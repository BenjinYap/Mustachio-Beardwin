package game.entities 
{
	import flash.display.*;
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.tweens.misc.VarTween;
	/**
	 * ...
	 * @author Benjin
	 */
	public class Lightning extends Entity
	{
		private var image:Image;
		public var damage:int;
		public var aoe:Number;
		public var stunTime:Number;
		
		public function Lightning(x:Number, y:Number, damage:int, aoe:Number, stunTime:Number) 
		{
			this.type = "lightning";
			
			this.width = 30;
			this.height = FP.stage.stageHeight;
			this.originX = this.halfWidth
			var bd:BitmapData = new BitmapData (this.width, this.height, true, 0x00000000);
			var p1:Point = new Point (Math.random () * width, 0);
			var p2:Point = new Point ();
			
			Draw.setTarget (bd);
			var incs:int = 15;
			
			for (var i:int = 1; i < incs; i++) {
				p2.x = Math.random () * width;
				p2.y = FP.stage.stageHeight / incs * i;
				Draw.linePlus (p1.x, p1.y, p2.x, p2.y, 0xffff00, 1, 0.2 + (7 / 15 * (incs - i)));
				p1.x = p2.x;
				p1.y = p2.y;
			}
			
			image = new Image (bd);
			image.originX = this.halfWidth;
			this.graphic = image;
			
			this.x = x;
			this.y = y;
			
			var tween:VarTween = new VarTween (onFadeDone);
			tween.tween (image, "alpha", 0, 0.3);
			this.addTween (tween);
			
			this.damage = damage;
			this.aoe = aoe;
			this.stunTime = stunTime;
		}
		
		public override function added ():void {
			
		}
		
		public override function removed ():void {
			
		}
		
		public override function update ():void {
			
		}
		
		private function onFadeDone ():void {
			FP.world.remove (this);
		}
	}

}