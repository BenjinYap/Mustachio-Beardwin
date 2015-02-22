package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Benjin
	 */
	public class GameText extends Entity
	{
		private var callback:Function;
		public var text:Text;
		
		public function GameText(x:Number, y:Number, width:Number, height:Number, text:String, callback:Function, layer:int = 0) 
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.layer = layer;
			
			this.callback = callback;
			
			this.text = new Text (text, 0, 0, {shadow:true, shadowColor:0x194239, embed:true});
			this.text.font = "Gabriola";
			this.text.embed = true;
			this.graphic = this.text;
		}
		
		public override function update ():void {
			if (Input.mousePressed && this.collidePoint (this.x, this.y, Input.mouseX, Input.mouseY)) {
				callback ();
			}
		}
	}

}