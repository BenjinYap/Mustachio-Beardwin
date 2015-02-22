package pause 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Benjin
	 */
	public class PauseWorld extends World
	{
		var r:GameText;
		var m:GameText;
		
		public function PauseWorld() 
		{
			this.addGraphic (new Image (Assets.backdropBD));
			
			var text:GameText = new GameText (0, 0, 0, 0, "Paused", null);
			text.text.size = 100;
			text.text.width = FP.width;
			text.y = -30;
			text.text.align = "center";
			this.add (text);
			
			r = new GameText (66, 119, 160, 50, "Resume", Resume);
			r.originY = -30;
			r.text.size = 60;
			this.add (r);
			
			m = new GameText (270, 239, 126, 53, "Menu", Menu);
			m.originY = -30;
			m.text.size = 60;
			this.add (m);
		}
		
		public override function update ():void {
			super.update ();
			//m.x = Input.mouseX;
			//m.y = Input.mouseY;
			//trace (m.x, m.y);
		}
		
		private function Resume ():void {
			Main (FP.engine).GoGame ();
		}
		
		private function Menu ():void {
			Main (FP.engine).GoMenu ();
		}
	}

}