package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Benjin
	 */
	public class TextBlurb extends Entity
	{
		public var text:Text;
		private var clickCallback:Function;
		
		public function TextBlurb(text:String, width:Number, height:Number, size:Number, clickCallback:Function = null) 
		{
			this.width = width;
			this.height = height;
			
			this.text = new Text (text, 0, 0, {shadow:true, shadowColor:0x194239, embed:true});
			this.text.font = "Gabriola";
			this.text.embed = true;
			this.text.size = size;
			this.text.centerOO ();
			this.addGraphic (this.text);
			this.text.width = this.width;
			this.text.wordWrap = true;
			this.clickCallback = clickCallback;
		}
		
		public override function update ():void {
			if (clickCallback != null) {
				if (Input.mousePressed && this.collidePoint (this.x, this.y, Input.mouseX, Input.mouseY)) {
					clickCallback ();
				}
			}
		}
	}

}