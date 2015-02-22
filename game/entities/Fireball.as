package game.entities 
{
	import flash.display.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import game.*;
	/**
	 * ...
	 * @author Benjin
	 */
	public class Fireball extends Entity
	{
		private var angleRad:Number = 0;
		private var speed:Number = 20;
		private var xSpeed:Number = 0;
		private var ySpeed:Number = 0;
		private var image:Image;
		private var emitter:Emitter;
		public var damage:int = 0;
		public var aoe:int = 0;
		
		public function Fireball(x:Number, y:Number, angleRad:Number, damage:int, aoe:Number) 
		{
			this.damage = damage;
			this.aoe = aoe;
			
			this.width = 20;
			this.height = 20;
			this.layer = -100;
			this.type = "fireball";
			
			this.centerOrigin ();
			image = new Image (Assets.fireballBD);
			image.centerOrigin ();
			this.graphic = image;
			
			this.x = x;
			this.y = y;
			
			image.angle = angleRad * -180 / Math.PI;
			image.scale = 0.5 + ((aoe-10) / 20);
			xSpeed = Math.cos (angleRad) * speed;
			ySpeed = Math.sin (angleRad) * speed;
			
			this.layer = -3;
			
			
		}
		
		public override function added ():void {
			
		}
		
		public override function removed ():void {
			for (var i:int = 0; i < 50; i++) {
				GameWorld.fireballEmit.emit ("explosion", this.x + Math.random () * 20 - 10, this.y + Math.random () * 40 - 20);
			}
		}
		
		public override function update ():void {
			this.x += xSpeed;
			this.y += ySpeed;
			ySpeed += 0.2;
			
			//image.angle = Math.atan2 (ySpeed, xSpeed) * -180 / Math.PI;
			image.angle += 10;
			
			for (var i:int = 0; i < 2; i++) GameWorld.fireballEmit.emit ("fireball", this.x, this.y);
			
			if (this.x + this.halfWidth < 0 || this.x - this.halfWidth > FP.width) {
				FP.world.remove (this);
			}
		}
	}

}