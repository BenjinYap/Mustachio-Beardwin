package  
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.utils.*;
	/**
	 * ...
	 * @author 
	 */
	public class Assets 
	{
		[Embed(source = "../assets/fonts/Gabriola.ttf", mimeType="application/x-font-truetype", embedAsCFF = "false", fontFamily = "Gabriola")]
		public static var Gabriola:Class;
		
		[Embed(source = "../assets/images/backdrop.png")]
		private static var Backdrop:Class;
		public static var backdropBD:BitmapData = (new Backdrop () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/door.png")]
		private static var Door:Class;
		public static var doorBD:BitmapData = (new Door () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/grass_back.png")]
		private static var Grass:Class;
		public static var grassBD:BitmapData = (new Grass () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/dirt_back.png")]
		private static var Dirt:Class;
		public static var dirtBD:BitmapData = (new Dirt () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/dirt_back_white.png")]
		private static var DirtWhite:Class;
		public static var dirtWhiteBD:BitmapData = (new DirtWhite () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/mountain.png")]
		private static var Mountain:Class;
		public static var mountainBD:BitmapData = (new Mountain () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/wizard.png")]
		private static var Wizard:Class;
		public static var wizardBD:BitmapData = (new Wizard () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/basicgoblin.png")]
		private static var BasicGoblin:Class;
		public static var basicGoblinBD:BitmapData = (new BasicGoblin () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/goblin.png")]
		private static var Goblin:Class;
		public static var goblinBD:BitmapData = (new Goblin () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/rockguy.png")]
		private static var Rocker:Class;
		public static var rockerBD:BitmapData = (new Rocker () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/skeleton.png")]
		private static var Skeleton:Class;
		public static var skeletonBD:BitmapData = (new Skeleton () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/cavern.png")]
		private static var Firecannon:Class;
		public static var firecannonBD:BitmapData = (new Firecannon () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/cavern_white.png")]
		private static var FirecannonWhite:Class;
		public static var firecannonWhiteBD:BitmapData = (new FirecannonWhite () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/fireball.png")]
		private static var Fireball:Class;
		public static var fireballBD:BitmapData = (new Fireball () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/firepebble.png")]
		private static var Firepebble:Class;
		public static var firepebbleBD:BitmapData = (new Firepebble () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/clouds.png")]
		private static var LightningCloud:Class;
		public static var lightningCloudBD:BitmapData = (new LightningCloud () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/clouds_white.png")]
		private static var LightningCloudWhite:Class;
		public static var lightningCloudWhiteBD:BitmapData = (new LightningCloudWhite () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/images/levelCompleteWindow.png")]
		private static var LevelCompleteWindow:Class;
		public static var levelCompleteWindowBD:BitmapData = (new LevelCompleteWindow () as Bitmap).bitmapData;
		
		[Embed(source = "../assets/levels/level1.oel", mimeType = "application/octet-stream")]
		public static var Level1:Class;
		
		public static var levels:Array = [Level1];
		
		////////////SOUNDS
		[Embed(source = "../assets/sounds/fireball.mp3")]
		public static var sndFireball:Class;
		
		[Embed(source = "../assets/sounds/thunder.mp3")]
		public static var sndThunder:Class;
		
		[Embed(source = "../assets/sounds/doorbang.mp3")]
		public static var sndDoorbang:Class;
		
		[Embed(source = "../assets/sounds/doorbang2.mp3")]
		public static var sndDoorbang2:Class;
		
		[Embed(source = "../assets/sounds/pop.mp3")]
		public static var sndPop:Class;
	}

}