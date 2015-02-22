package menu 
{
	import game.entities.Door;
	import game.entities.Wizard;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Benjin
	 */
	public class MenuWorld extends World
	{
		
		public function MenuWorld() 
		{
			this.addGraphic (new Image (Assets.backdropBD), 10000);
			
			var grass:TiledImage = new TiledImage (Assets.grassBD, FP.stage.stageWidth, 128);
			grass.y = 250;
			this.addGraphic (grass);
			
			var dirt:TiledImage = new TiledImage (Assets.dirtBD, FP.stage.stageWidth, 30);
			dirt.y = 343;
			this.addGraphic (dirt);
			
			var mountain:Image = new Image (Assets.mountainBD);
			mountain.originX = mountain.width;
			mountain.x = FP.width;
			mountain.y = 137;
			this.addGraphic (mountain, -1);
			
			var wizard:Wizard = new Wizard ();
			wizard.x = 587;
			wizard.y = 130;
			this.add (wizard);
			
			var door:Door = new Door ();
			door.layer = -10;
			this.add (door);
			
			var text:Text = new Text ("Mustachio Beardwin", 0, 0, {shadow:true, shadowColor:0x194239, embed:true});
			text.x = 40;
			text.y = -15;
			text.size = 70;
			text.font = "Gabriola";
			this.addGraphic (text);
			
			var play:GameText;
			play = new GameText (41, 87, 108, 89, "Play", function () {
				Main (FP.engine).GoNewGame (false);
			});
			play.text.size = 70;
			play.originY = -40;
			this.add (play);
			
			var tutorial:GameText;
			tutorial = new GameText (230, 123, 104, 41, "Tutorial", function () {
				Main (FP.engine).GoNewGame (true);
			});
			tutorial.text.size = 40;
			tutorial.originY = -20;
			this.add (tutorial);
		}
		
		
		public override function begin ():void {
			//Main (FP.engine).GoNewGame (false);
		}
		
		public override function end ():void {
			
		}
		
		public override function update ():void {
			super.update ();
			//tutorial.x = Input.mouseX;
			//tutorial.y = Input.mouseY;
			//trace (tutorial.x, tutorial.y);
		}
	}

}