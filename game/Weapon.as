package game 
{
	import flash.display.BitmapData;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.tweens.misc.VarTween;
	/**
	 * ...
	 * @author Benjin
	 */
	public class Weapon extends Entity
	{
		protected var ready:Boolean = true;
		protected var cooldown:Number = 0;  //in seconds
		private var countdown:int = 0;  //in frames
		protected var flash:Image;
		protected var maxAmmo:int = 0;
		private var ammo:int = 0;
		public var unlocked:Boolean = false;
		
		public function Weapon() 
		{
			
		}
		
		public override function update ():void {
			if (countdown > 0) {
				countdown--;
				
				if (countdown == 0) {
					ammo = maxAmmo;
					JustReady ();
					
					var t:Entity = this;
					var d:Number = 0.2;
					var tween:VarTween = new VarTween (function ():void {
						var tween:VarTween = new VarTween (null, Tween.ONESHOT);
						tween.tween (flash, "alpha", 0, d);
						t.addTween (tween);
					}, Tween.ONESHOT);
					tween.tween (flash, "alpha", 1, d);
					this.addTween (tween);
				}
			} else if (countdown == 0) {
				ready = true;
			}
		}
		
		protected function SetMaxAmmo (n:int):void {
			maxAmmo = n;
			ammo = n;
		}
		
		protected function JustReady ():void {
			
		}
		
		protected function JustFired ():void {
			ammo--;
			
			if (ammo <= 0) {
				Cooldown ();
			}
		}
		
		protected function Cooldown ():void {
			countdown = cooldown * FP.assignedFrameRate;
			ready = false;
		}
		
		public function CheckInput ():void {
			
		}
		
		public function Enable ():void {
			countdown = 1;
		}
		
		public function Disable ():void {
			ready = false;
			countdown = -1;
		}
	}

}