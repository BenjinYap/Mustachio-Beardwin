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
	public class Skeleton extends Enemy
	{
		private var sfx:Sfx;
		private static var sound:Boolean = false;
		public function Skeleton() 
		{
			this.width = 30;
			this.height = 70;
			this.centerOrigin ();
			this.points = 15 + Math.random () * 5;
			this.SetMaxHP (4000);
			this.speed = 0.7;
			
			this.damage = 2;
			this.cooldown = 90;
			
			this.map = new Spritemap (Assets.skeletonBD, 30, 70, onAnimComplete);
			this.map.centerOO ();
			this.map.originY = this.height;
			this.map.add ("walk", [0, 3, 1, 2, 1, 3], 10);
			this.map.add ("attackStart", [0, 3], 10, false);
			this.map.add ("attackEnd", [4, 4, 4, 3, 0], 10, false);
			this.map.play ("walk");
			this.graphic = map;
			
			this.sfx = new Sfx (Assets.sndDoorbang2);
		}
		
		public override function update ():void {
			super.update ();
			
			if (disabled == false) {
				var door:Door = Door (FP.world.getInstance ("door"));
				
				if (door == null) {
					
				} else {
					if (this.right >= door.left + 30 && door.hp > 0) {
						this.x = door.left - this.halfWidth + 30;
						
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
					door.Damage (this.damage);
					var tween:VarTween = new VarTween ();
					tween.tween (this, "x",this.x - 2, 0.1,Ease.quadIn);
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