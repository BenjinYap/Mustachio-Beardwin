package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Benjin
	 */
	public class GameButton extends Entity
	{
		private var callback:Function;
		
		public function GameButton(x:Number, y:Number, width:Number, height:Number, source:*, callback:Function, layer:int = 0) 
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.layer = layer;
			
			this.callback = callback;
			
			this.graphic = new Image (source);
		}
		
		public override function update ():void {
			if (Input.mousePressed && this.collidePoint (this.x, this.y, Input.mouseX, Input.mouseY)) {
				callback ();
			}
		}
	}

}