package game.weapons 
{
	import flash.display.*;
	import game.entities.Fireball;
	import game.Weapon;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Benjin
	 */
	public class FireCannon extends Weapon
	{
		private var pressed:Boolean = false;
		private var image:Image;
		private var damage:int = 500;
		private var aoe:Number = 10;
		private var sfx:Sfx;
		
		public function FireCannon() 
		{
			this.width = 60;
			this.height = 50;
			image = new Image (Assets.firecannonBD);
			this.centerOrigin ();
			this.graphic = image;
			image.centerOrigin ();
			
			this.x = FP.stage.stageWidth - this.width / 2;
			this.y = 100;
			
			this.x = 593;
			this.y = 212;
			
			this.cooldown = 1;
			
			this.flash = new Image (Assets.firecannonWhiteBD);
			this.flash.alpha = 0;
			flash.centerOO ();
			this.addGraphic (flash);
			
			this.SetMaxAmmo (5);
			
			sfx = new Sfx (Assets.sndFireball);
		}
		
		public override function update ():void {
			super.update ();
			
			
		}
		
		public override function CheckInput ():void {
			if (this.unlocked == false) {
				return;
			}
			
			if (ready) {
				if (Input.mousePressed && this.collidePoint (this.x, this.y, Input.mouseX, Input.mouseY)) {
					pressed = true;
				}
				
				if (pressed && Input.mouseReleased) {
					pressed = false;
					FP.world.add (new Fireball (this.x, this.y, Math.atan2 (Input.mouseY - (this.y), Input.mouseX - (this.x)), damage, aoe));
					this.JustFired ();
					sfx.play (Math.random () * 0.9 + 0.1);
				}
			}
		}
		
		public function Upgrade ():void {
			this.aoe += 3;
		}
	}

}