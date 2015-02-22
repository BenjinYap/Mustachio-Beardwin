package game 
{
	import flash.xml.*;
	import flash.utils.*;
	import game.*;
	import game.enemies.*;
	import net.flashpunk.*;
	/**
	 * ...
	 * @author Benjin
	 */
	public class LevelData 
	{
		public static var levels:Array;
		
		public static function Reset ():void {
			var l1:Array = [
				new Wave (BasicGoblin, 10, 0, 15),
				new Wave (BasicGoblin, 8, 25, 15)
			]
			
			var l2:Array = [
				
				new Wave (BasicGoblin, 10, 0, 10),
				new Wave (BasicGoblin,14, 25, 20),
				new Wave (BasicGoblin,8, 38, 20),
			]
			var l3:Array = [
				
				new Wave (BasicGoblin, 15, 0, 25),
				new Wave (BasicGoblin,16, 30, 30),
				new Wave (BasicGoblin,3, 45, 10),
			]
			var l4:Array = [
				
				new Wave (BasicGoblin, 20, 0, 30),
				new Wave (Skeleton,    1, 10,10),
				new Wave (BasicGoblin, 10, 30, 15),
				new Wave (Skeleton,    2, 40,5),
			]
			var l5:Array = [
				
				new Wave (BasicGoblin, 20, 0,  60),
				new Wave (Skeleton,    4,  25, 40),
				new Wave (BasicGoblin, 10, 40, 15),
				new Wave (Skeleton,    2,  50, 5),
				new Wave (Skeleton,    5,  70, 14),
			]
			var l6:Array = [
				
				new Wave (BasicGoblin, 30, 0,  100),
				new Wave (Skeleton,    4,  10, 30),
				new Wave (Skeleton,    5,  40, 10),
				new Wave (Skeleton,    8,  80, 20),
			]
			var l7:Array = [
				new Wave (Skeleton,    10,  0, 30),
				new Wave (BasicGoblin, 10,  40, 25),
				new Wave (Skeleton,    10,  70, 20),
				new Wave (Rocker,      3,   80, 20),
				new Wave (BasicGoblin, 8,   90,  20),
				new Wave (Rocker,      4,   110, 20),
			]
			var l8:Array = [
				new Wave (Skeleton,    10,  0, 30),
				new Wave (BasicGoblin, 10,  40, 25),
				new Wave (Skeleton,    10,  70, 20),
				new Wave (Rocker,      3,   80, 20),
				new Wave (BasicGoblin, 8,   90,  20),
				new Wave (Rocker,      4,   110, 20),
			]
			var l9:Array = [
				new Wave (BasicGoblin, 20,  0, 160),
				new Wave (Skeleton,    50,  50, 200),
				new Wave (Rocker,      40,   150, 100),
				
				new Wave (Skeleton,    100,  250, 5000),
				new Wave (Rocker,      1000,   200, 6000),
			]
			
			levels = [l1, l2,l3,l4,l5,l6,l7,l8,l9];
		}
		
		public static function GetLevelEnemies (level:int):Array {
			var a:Array = [];
			var o:Object = [];
			var xml:XML = new XML (new (Assets.levels [level - 1]) ());
			var list:XMLList = xml.enemies.children ();
			
			for each (var item:XML in list) {
				var type:String = item.name ();
				var e:Enemy;
				
				if (type == Enemy.BASIC_GOBLIN) {
					e = new BasicGoblin ();
				}
				
				o.instance = e;
				o.spawn = Number (item.@spawn) * FP.assignedFrameRate;
				a.push (o);
			}
			
			return a;
		}
		
		public static function GetLevel (level:int):Array {
			var a:Array = [];
			
			for (var i:int = 0; i < levels [level - 1].length; i++) {
				a.push (levels [level - 1][i].Clone ());
			}
			
			return a;
		}
	}

}