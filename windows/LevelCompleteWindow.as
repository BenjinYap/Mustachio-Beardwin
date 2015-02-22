package windows 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Benjin
	 */
	public class LevelCompleteWindow extends Entity
	{
		private var levelText:GameText;
		private var totalPointsText:GameText;
		
		private var next:GameText;
		private var menu:GameText;
		
		private var nextCallback:Function;
		private var menuCallback:Function;
		
		public function LevelCompleteWindow(level:int, totalPoints:int, nextCallback:Function, menuCallback:Function) 
		{
			
			levelText = new GameText (0, 0, 0, 0, "Level " + level.toString () + " Done", null);
			levelText.text.size = 80;
			levelText.text.width = FP.width;
			levelText.text.align = "center";
			levelText.text.font = "Gabriola";
			levelText.layer = this.layer - 1;
			levelText.y = 0;
			FP.world.add (levelText);
			
			totalPointsText = new GameText (0, 100, 0, 0, "Total Points: " + totalPoints.toString (), null);
			totalPointsText.text.font = "Gabriola";
			totalPointsText.text.size = 50;
			totalPointsText.text.width = FP.width;
			totalPointsText.text.align = "center";
			totalPointsText.text.font = "Gabriola";
			totalPointsText.layer = this.layer - 1;
			FP.world.add (totalPointsText);
			
			next = new GameText (50, 260, 200, 50, "Next Level", nextCallback);
			next.originY = -20;
			next.layer = this.layer - 1;
			next.text.font = "Gabriola";
			next.text.size = 50;
			FP.world.add (next);
			
			menu = new GameText (400, 260, 100, 50, "Menu", menuCallback);
			menu.layer = this.layer - 1;
			menu.originY = -20;
			menu.text.size = 50;
			menu.text.font = "Gabriola";
			FP.world.add (menu);
		}
		
		public override function removed ():void {
			FP.world.remove (levelText);
			FP.world.remove (totalPointsText);
			FP.world.remove (next);
			FP.world.remove (menu);
		}
		
	}

}