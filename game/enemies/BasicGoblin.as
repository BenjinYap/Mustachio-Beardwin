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
	public class BasicGoblin extends Enemy
	{
		private var sfx:Sfx;
		private static var sound:Boolean = false;
		
		public function BasicGoblin() 
		{
			this.width = 50;
			this.height = 68;
			this.centerOrigin ();
			this.points = 10 + Math.random () * 5;
			this.SetMaxHP (1000);
			this.speed = Math.random()*0.3+0.3//0.5;
			
			this.damage = 1;
			this.cooldown = 60;
			
			this.map = new Spritemap (Assets.goblinBD, 50, 68, onAnimComplete);
			this.map.centerOO ();
			this.map.originY = this.height;
			this.map.add ("walk", [0, 1, 2, 3, 4], 20*this.speed);
			this.map.add ("attackStart", [5, 6], 10, false);
			this.map.add ("attackEnd", [7, 7, 7, 6, 5, 4], 10, false);
			this.map.play ("walk",Math.random()*4);
			this.graphic = map;
			
			this.sfx = new Sfx (Assets.sndDoorbang2);
		}
		
		public override function update ():void {
			super.update ();
			
			if (disabled == false) {
				var door:Door = Door (FP.world.getInstance ("door"));
				
				if (door != null) {
					
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
					if (sound == false) {
						sfx.play (Math.random () * 0.7 + 0.3);
						sound = true;
					}
					door.Damage (this.damage);
					var tween:VarTween = new VarTween ();
					tween.tween (this, "x",x - 4, 0.1,Ease.quadIn);
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