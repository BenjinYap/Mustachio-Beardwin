package game.weapons 
{
	import flash.display.*;
	import flash.geom.Point;
	import game.entities.Lightning;
	import game.Weapon;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Benjin
	 */
	public class LightningCloud extends Weapon
	{
		private var pressed:Boolean = false;
		private var image:Image;
		public var struck:Boolean = false;
		private var damage:int = 250;
		private var stunTime:Number = 1;
		private var aoe:Number = 10;
		private var sfx:Sfx;
		
		public function LightningCloud() 
		{
			this.width = 560;
			this.height = 40;
			image = new Image (Assets.lightningCloudBD);
			//this.centerOrigin ();
			this.graphic = image;
			//image.centerOrigin ();
			
			this.x = 0;
			this.y = 0;
			
			this.cooldown = 1;
			
			this.flash = new Image (Assets.lightningCloudWhiteBD);
			this.flash.alpha = 0;
			this.addGraphic (flash);
			
			this.SetMaxAmmo (4);
			
			sfx = new Sfx (Assets.sndThunder);
		}
		
		public override function update ():void {
			super.update ();
			
			
		}
		
		public override function CheckInput ():void {
			if (this.unlocked == false) {
				return;
			}
			
			if (this.ready) {
				if (Input.mousePressed && this.collidePoint (this.x, this.y, Input.mouseX, Input.mouseY)) {
					pressed = true;
				}
				
				if (pressed) {
					if (Input.mouseY - this.y > 60) {
						pressed = false;
						FP.world.add (new Lightning (Input.mouseX, this.y, damage, aoe, stunTime));
						struck = true;
						this.JustFired ();
						sfx.play (Math.random () * 0.5 + 0.5);
					}
				} else {
					struck = false;
				}
			}
		}
		
		public function Upgrade ():void {
			stunTime += 0.2;
		}
	}

}