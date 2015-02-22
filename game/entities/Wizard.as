package game.entities 
{
	import flash.display.*;
	import game.entities.Fireball;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	/**
	 * ...
	 * @author Benjin
	 */
	public class Wizard extends Entity
	{
		private var image:Image;
		private var map:Spritemap;
		
		public function Wizard() 
		{
			this.width = 300;
			this.height = 60;
			map = new Spritemap (Assets.wizardBD, 60, 56, function () {
				if (map.currentAnim == "upgrade") {
					map.play ("flap");
				}
			});
			map.add ("flap", [0,0,3,3,3,0,0,1,0,0,0,0,0,0,0,0,2],10,true);
			map.add ("upgrade", [0, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5], 10, false);
			this.centerOrigin ();
			this.graphic = map;
			map.centerOrigin ();
			map.play ("flap");
			
			this.x = FP.stage.stageWidth / 2;
			this.y = 0;
		}
		
		public function Upgrade ():void {
			map.play ("upgrade");
		}
	}

}