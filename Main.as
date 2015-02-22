package 
{
	import flash.desktop.*;
	import flash.events.*;
	import flash.display.*;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.ui.*;
	import flash.xml.*;
	import net.flashpunk.*;
	import pause.PauseWorld;
	import splash.*;
	import game.*;
	import menu.*;
	
	/**
	 * ...
	 * @author Benjin
	 */
	public class Main extends Engine 
	{
		
		private var gameWorld:GameWorld;
		private var world:World;
		
		public function Main():void 
		{
			new Assets.Gabriola ();
			
			super (640, 360, 60, false);
			FP.screen.color = 0xffffff;
			//stage.scaleMode = StageScaleMode.SHOW_ALL;
			//stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			stage.addEventListener (Event.ACTIVATE, activate);
			//FP.console.enable ();
			//FP.screen.scale = 0.5;
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			stage.quality = StageQuality.LOW;
		}
		
		public override function init ():void {
			GoSplash ();
		}
		
		private function activate (e:Event):void {
			if (world != null) {
				FP.world = world;
			}
		}
		
		private function deactivate(e:Event):void 
		{
			FP.world = null;
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
		public function GoSplash ():void {
			world = new SplashWorld ();
			FP.world = world;
			
		}
		
		public function GoMenu ():void {
			world = new MenuWorld ();
			FP.world = world;
		}
		
		public function GoNewGame (tutorial:Boolean):void {
			gameWorld = new GameWorld (tutorial);
			world = gameWorld;
			FP.world = world;
		}
		
		public function GoGame ():void {
			FP.world = gameWorld;
		}
		
		public function GoPause ():void {
			world = new PauseWorld ();
			FP.world = world;
		}
	}
	
}