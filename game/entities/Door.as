package game.entities 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Benjin
	 */
	public class Door extends Entity
	{
		private var image:Image;
		public var hp:int = 90;
		
		public function Door() 
		{
			
			this.type = "door";
			this.name = "door";
			image = new Image (Assets.doorBD);
			this.x = 522;
			this.y = 193;
			this.graphic = image;
		}
		
		public function Damage (n:int):void {
			hp -= n;
			
			if (hp <= 0) {
				FP.world.remove (this);
			}
		}
		
		/*public override function update ():void {
			this.x = Input.mouseX;
			this.y = Input.mouseY;
			trace (this.x, this.y);
		}*/
	}

}