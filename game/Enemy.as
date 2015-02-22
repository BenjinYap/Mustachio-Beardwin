package game 
{
	import flash.display.BitmapData;
	import game.entities.PointOrb;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.VarTween;
	/**
	 * ...
	 * @author Benjin
	 */
	public class Enemy extends Entity
	{
		public static const BASIC_GOBLIN:String = "BasicGoblin";
		
		public var maxHP:int = 0;
		public var hp:int = 0;
		public var speed:Number = 0;
		public var disabled:Boolean = false;
		public var shaking:Boolean = false;
		public var stunTime:Number = 0;
		protected var damage:int = 0;
		protected var countdown:int = 0;
		protected var cooldown:int = 0;
		private var dying:Boolean = false;
		protected var points:int = 0;
		
		protected var map:Spritemap;
		
		public function Enemy() 
		{
			this.type = "enemy";
			
		}
		
		protected function SetMaxHP (n:int):void {
			maxHP = n;
			hp = n;
		}
		
		public override function update ():void {
			if (dying == false) {
				if (stunTime <= 0) {
					this.x += speed;
					disabled = false;
				}
				
				
				if (shaking) {
					disabled = true;
				}
			}
		}
		
		public function Die ():void {
			var tween:VarTween = new VarTween (onDieComplete);
			tween.tween (this.graphic, "alpha", 0, 0.1);
			this.addTween (tween);
			dying = true;
			
			for (var i:int = 0; i < 10; i++) {
				//GameWorld.techEmit.emit ("tech", this.x, this.y);
				FP.world.add (new PointOrb (this.x, this.y));
				
			}
			
			GameWorld.totalPoints += this.points;
		}
		
		public function Stun (time:Number):void {
			stunTime = time;
			var tween:VarTween = new VarTween ();
			tween.tween (this, "stunTime", 0, time);
			this.addTween (tween);
		}
		
		private function onDieComplete ():void {
			FP.world.remove (this);
		}
	}

}