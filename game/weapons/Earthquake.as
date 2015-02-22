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
	public class Earthquake extends Weapon
	{
		private var pressed:Boolean = false;
		private var grass:TiledImage;
		private var dirt:TiledImage;
		
		private var dragState:int = 0;
		public var shaking:Boolean = false;
		private var tween:VarTween;
		
		public var damage:int = 10;
		
		private var flash2:TiledImage;
		
		public function Earthquake() 
		{
			this.width = 540;
			this.height = 110;
			
			grass = new TiledImage (Assets.grassBD, FP.stage.stageWidth, 128);
			
			dirt = new TiledImage (Assets.dirtBD, FP.stage.stageWidth, 30);
			
			this.addGraphic (grass);
			
			this.y = 250;
			this.addGraphic (dirt);
			dirt.y = 93;
			
			tween = new VarTween ();
			this.addTween (tween, false);
			
			this.cooldown = 1;
			
			this.flash = new TiledImage (Assets.dirtWhiteBD, FP.stage.stageWidth, 30);
			this.flash.alpha = 0;
			this.addGraphic (flash);
			
			flash2 = new TiledImage (Assets.dirtWhiteBD, FP.stage.stageWidth, 30);
			flash2.alpha = 0;
			flash2.y = 93;
			this.addGraphic (flash2);
			
			this.SetMaxAmmo (6);
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
					if (Input.mouseY >= this.y) {
						if (dragState == 0 && Input.mouseX > this.halfWidth) {
							dragState = 1;
						} else if (dragState == 1 && Input.mouseX < this.halfWidth) {
							dragState = 2;
						} else if (dragState == 2 && Input.mouseX > this.halfWidth && shaking == false) {
							dragState = 0;
							shaking = true;
							tween.complete = onShakeLeftComplete;
							tween.tween (this, "x", -10, 0.05);
							tween.start ();
						}
					}
				}
				
				if (Input.mouseReleased) {
					dragState = 0;
					pressed = false;
				}
			}
		}
		
		protected override function JustReady ():void {
			pressed = false;
			
			var t:Entity = this;
			var d:Number = 0.2;
			var tween:VarTween = new VarTween (function ():void {
				var tween:VarTween = new VarTween (null, Tween.ONESHOT);
				tween.tween (flash2, "alpha", 0, d);
				t.addTween (tween);
			}, Tween.ONESHOT);
			tween.tween (flash2, "alpha", 1, d);
			this.addTween (tween);
		}
		
		private function onShakeLeftComplete ():void {
			tween.complete = onShakeRightComplete;
			tween.tween (this, "x", 0, 0.05);
			tween.start ();
		}
		
		private function onShakeRightComplete ():void {
			shaking = false;
			tween.complete = null;
			
			this.JustFired ();
		}
		
		public function Upgrade ():void {
			this.SetMaxAmmo (this.maxAmmo + 1);
		}
	}

}