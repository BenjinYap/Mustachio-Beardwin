package game.enemies 
{
	import flash.display.*;
	import game.entities.Door;
	import mx.core.BitmapAsset;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import game.*;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author Benjin
	 */
	public class Rocker extends Enemy
	{
		private var sfx:Sfx;
		private static var sound:Boolean = false;
		
		public function Rocker() 
		{
			this.width = 37;
			this.height = 30;
			this.centerOrigin ();
			this.points = 20 + Math.random () * 5;
			this.graphic = map;
			this.SetMaxHP (10000);
			this.speed = Math.random()*0.3+0.8;
			
			this.damage = 3;
			this.cooldown = 120;
			
			this.map = new Spritemap (Assets.rockerBD, 37, 30, onAnimComplete);
			this.map.centerOO ();
			this.map.originY = this.height;
			this.map.add ("walk", [0, 1, 3, 2, 0, 1, 3, 2, 4], speed*10);
			this.map.add ("attackStart", [5, 6], 10, false);
			this.map.add ("attackEnd", [7, 7, 7, 6, 5, 0], 10, false);
			this.map.play ("walk",Math.random()*3);
			this.graphic = map;
			
			sfx = new Sfx (Assets.sndDoorbang);
		}
		
		public override function update ():void {
			super.update ();
			
			if (disabled == false) {
				var door:Door = Door (FP.world.getInstance ("door"));
				
				if (door == null) {
					
				} else {
					if (this.right >= door.left + 20 && door.hp > 0) {
						this.x = door.left - this.halfWidth + 20;
						
						if (this.countdown == 0) {
							this.countdown--;
							this.map.play ("attackStart");
						}
					}
				}
				
				if (this.countdown > 0) {
					this.countdown--;
				}
			}
		}
		
		private function onAnimComplete ():void {
			if (this.map.currentAnim == "attackStart") {
				var door:Door = Door (FP.world.getInstance ("door"));
				
				if (door != null) {
					if (!sound) {
						sfx.play (Math.random () * 0.7 + 0.3);
						sound = true;
					}
					sfx.play (Math.random () * 0.7 + 0.3);
					door.Damage (this.damage);
					var tween:VarTween = new VarTween ();
					tween.tween (this, "x",x - 1, 0.1,Ease.quadIn);
					this.addTween (tween);
					this.map.play ("attackEnd");
				}
			} else if (this.map.currentAnim == "attackEnd") {
				this.countdown = this.cooldown;
				sound = false;
			}
		}
		
	}

}