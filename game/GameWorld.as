package game 
{
	import flash.display.*;
	import flash.geom.Rectangle;
	import game.weapons.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;
	import game.entities.*;
	import game.enemies.*;
	import windows.LevelCompleteWindow;
	import windows.LevelMenuWindow;
	
	/**
	 * ...
	 * @author Benjin
	 */
	public class GameWorld extends World
	{
		private static const LEVEL_START:int = 0;
		private static const LEVEL_ACTIVE:int = 1;
		private static const POPUP:int = 2;
		private static const LEVEL_DONE:int = 3;
		private static const PAUSE:int = 4;
		private static const UPGRADE:int = 5;
		private static const LEVEL_MENU:int = 6;
		private static const DEATH:int = 7;
		
		public static var fireballEmit:Emitter;
		public static var techEmit:Emitter;
		
		private var state:int;
		
		private var level:int = 8;
		public static var totalPoints:int = 0;
		
		private var framesElapsed:int = 0;
		private var waitingEnemies:Array;
		private var waves:Array;
		
		private var landTopY:Number = 296;
		private var landBottomY:Number = 340;
		
		private var wizard:Wizard;
		private var door:Door;
		
		private var fireCannon:FireCannon;
		private var lightningCloud:LightningCloud;
		private var earthquake:Earthquake;
		
		private var levelText:Text;
		
		private var popup:Text;
		
		private var tutorial:Boolean = true;
		private var showedPopup:Boolean = false;
		
		private var lightningUnlockLevel:int = 4;
		private var earthUnlockLevel:int = 7;
		
		private var deathText:Text;
		
		public function GameWorld(tutorial:Boolean) 
		{
			totalPoints = 0;
			
			this.tutorial = tutorial;
			
			InitEmitters ();
			LevelData.Reset ();
			
			this.addGraphic (new Image (Assets.backdropBD), 10000);
			
			var mountain:Image = new Image (Assets.mountainBD);
			mountain.originX = mountain.width;
			mountain.x = FP.stage.stageWidth;
			mountain.y = 137;
			this.addGraphic (mountain, -3);
			
			fireCannon = new FireCannon ();
			fireCannon.layer = -4;
			this.add (fireCannon);
			
			lightningCloud = new LightningCloud ();
			lightningCloud.layer = -1;
			this.add (lightningCloud);
			
			earthquake = new Earthquake ();
			earthquake.layer = 1000;
			this.add (earthquake);
			
			wizard = new Wizard ();
			wizard.x = 587;
			wizard.y = 130;
			wizard.layer = -2;
			this.add (wizard);
			
			door = new Door ();
			this.add (door);
			door.layer = -4;
			
			levelText = new Text ("", 0, 0, {shadow:true, shadowColor:0x194239, embed:true});
			levelText.color = 0xffffff;
			levelText.size = 100;
			levelText.font = "Gabriola";
			levelText.width = FP.width;
			levelText.centerOO ();
			levelText.align = "center";
			levelText.x = FP.halfWidth;
			levelText.y = 0;
			this.addGraphic (levelText, -100);
			
			
			fireCannon.unlocked = true;
			lightningCloud.unlocked = false;
			earthquake.unlocked = false;
			
			GoLevel (++level);
			
			
		}
		
		public override function begin ():void {
			
		}
		
		public override function end ():void {
			
		}
		
		public override function render ():void {
			super.render ();
			
			//Draw.line (0, landTopY, 960, landTopY, 0xff0000);
			//Draw.line (0, landBottomY, 960, landBottomY, 0xff0000);
			//Draw.line (0, Input.mouseY, 960, Input.mouseY, 0xff0000);
			//Draw.line (0, Input.mouseY - 68, 960, Input.mouseY - 68, 0xff0000);
			//trace (Input.mouseY);
		}
		
		public override function update ():void {
			
			if (state != GameWorld.POPUP) {
				super.update ();
				
			} else {
				if (Input.mousePressed) {
					state = GameWorld.LEVEL_ACTIVE;
					popup.clear ();
				}
			}
			
			if (state == GameWorld.LEVEL_START) {
				
			} else if (state == GameWorld.LEVEL_ACTIVE || state == GameWorld.DEATH) {
				framesElapsed++;
				
				if (tutorial) {
					if (showedPopup == false) {
						if (level == 1) {
							DoPopup ("Defend your castle from the evil creatures!\n\nCast fireballs by tapping on the cave of fire\nbeneath you and dragging a trajectory.", 100);
						} else if (level == lightningUnlockLevel) {
							DoPopup ("You have mastered lightning!\n\nTap on the clouds and drag down to\nstrike down on your invaders.", 100);
						} else if (level == earthUnlockLevel) {
							DoPopup ("You have learned to control the ground beneath you!\n\nDrag the ground beneath the enemies left to right repeatedly\nto hurt and throw them backwards.", 100);
						}
					}
				}
				
				if (level == 9 && showedPopup == false) {
					DoPopup ("Good job on getting this far! If we had more time we would\nhave made more levels, so enjoy this\nimpossible level!", 100);
				}
				
				if (state == GameWorld.LEVEL_ACTIVE) {
					fireCannon.CheckInput ();
					lightningCloud.CheckInput ();
					earthquake.CheckInput ();
				}
				
				CheckSpawn ();
				
				var fireballs:Array = [];
				this.getType ("fireball", fireballs);
				
				for (var i:int = 0; i < fireballs.length; i++) {
					var fireball:Fireball = fireballs [i];
					
					if (fireball.y > landTopY + (landBottomY - landTopY) / 2 - 10) {
						this.remove (fireball);
						
						var fireballRect:Rectangle = new Rectangle (fireball.x - fireball.halfWidth, landTopY, fireball.width, landBottomY - landTopY);
						
						var enemies:Array = [];
						this.getType ("enemy", enemies);
						
						for each (var enemy:Enemy in enemies) {
							if (enemy.collideRect (enemy.x, enemy.y, fireballRect.x, fireballRect.y, fireballRect.width, fireballRect.height)) {
								enemy.hp -= fireball.damage;
								var tween:VarTween = new VarTween ();
								tween.tween (enemy, "x", enemy.x - 5, 0.1);
								enemy.addTween (tween);
								
								if (enemy.hp <= 0) {
									enemy.Die ();
									
								}
							}
						}
					}
				}
				
				var lightnings:Array = [];
				this.getType ("lightning", lightnings);
				
				for (i = 0; i < lightnings.length; i++) {
					var lightning:Lightning = lightnings [i];
					
					var enemies:Array = [];
					this.getType ("enemy", enemies);
					
					for each (var enemy:Enemy in enemies) {
						if (enemy is Skeleton == false) {
							if (enemy.collideRect (enemy.x, enemy.y, lightning.x - lightning.width / 4, lightning.y, lightning.halfWidth, lightning.height)) {
								lightning.type = "spentLightning";
								enemy.hp -= lightning.damage;
								
								if (enemy.hp <= 0) {
									enemy.Die ();
								} else {
									enemy.Stun (lightning.stunTime);
								}
							}
						}
					}
				}
				
				CheckEarthquake ();
				
				if (framesElapsed > 10) {
					if (FP.world._add.length <= 0) {
						CheckWin ();
					}
				}
				
				if (door.hp <= 0 && state == GameWorld.LEVEL_ACTIVE) {
					Die ();
				}
			} else if (state == GameWorld.POPUP) {
				
			}
			
			if (state == GameWorld.DEATH) {
				if (Input.mousePressed) {
					Main (FP.engine).GoMenu ();
				}
			}
		}
		
		private function GoLevel (n:int):void {
			state = GameWorld.LEVEL_START;
			waves = LevelData.GetLevel (level);
			levelText.text = "Level " + n.toString ();
			levelText.alpha = 1;
			var tween:VarTween = new VarTween (function ():void {
				state = GameWorld.LEVEL_ACTIVE;
				var p:GameText;
				
				p = new GameText (566, 304, 60, 27, "Pause", Pause);
				p.name = "pause";
				p.originY = -20;
				p.text.size = 30;
				p.layer = -10;
				FP.world.add (p);
			}, Tween.ONESHOT);
			tween.delay = 1.5;
			tween.tween (levelText, "alpha", 0, 1);
			//tween.tween (levelText, "alpha", 0, 0.1);
			this.addTween (tween);
			framesElapsed = 0;
			
			if (level >= lightningUnlockLevel) {
				lightningCloud.unlocked = true;
			}
			
			if (level >= earthUnlockLevel) {
				earthquake.unlocked = true;
			}
			
			showedPopup = false;
		}
		
		private function InitEmitters ():void {
			fireballEmit = new Emitter (Assets.firepebbleBD);
			fireballEmit.newType ("fireball");
			fireballEmit.setAlpha ("fireball");
			fireballEmit.setMotion ("fireball", 0, 20, 0.2, 360, 0);
			fireballEmit.newType ("explosion");
			fireballEmit.setAlpha ("explosion");
			fireballEmit.setMotion ("explosion", 70, 70, 0.2, 40, 0);
			this.addGraphic (fireballEmit, -3);
			
			techEmit = new Emitter (Assets.firepebbleBD);
			techEmit.newType ("tech");
			techEmit.setAlpha ("tech");
			techEmit.setMotion ("tech", 0, 30, 0.5, 360, 0);
			this.addGraphic (techEmit, -3);
		}
		
		private function CheckSpawn ():void {
			for (var i:int = 0; i < waves.length; i++) {
				var wave:Wave = waves [i];
				
				if (framesElapsed >= wave.delay * 60) {
					for (var j:int = 0; j < wave.count; j++) {
						var enemy:Enemy = new wave.enemy ();
						var t:Number = Math.random () * (wave.duration * 60);
						enemy.x = -enemy.speed * t - enemy.halfWidth;
						//enemy.x = 300 + Math.random () * 100;
						//enemy.x = 480;
						enemy.y = landTopY + Math.random () * (landBottomY - landTopY);
						this.add (enemy);
					}
					
					waves.splice (i, 1);
					i--;
				}
			}
			
			LayerEnemies ();
		}
		
		private function LayerEnemies ():void {
			var a:Array = [];
			this.getType ("enemy", a);
			a.sort (function (e1:Enemy, e2:Enemy):int {
				if (e1.y > e2.y) {
					return -1;
				} else {
					return 1;
				}
			});
			
			for (var i:int = 0; i < a.length; i++) {
				a [i].layer = i;
			}
		}
		
		private function CheckEarthquake ():void {
			if (earthquake.shaking) {
				var enemies:Array = [];
				this.getType ("enemy", enemies);
				
				for each (var enemy:Enemy in enemies) {
					if (enemy.right > 0) {
						enemy.shaking = true;
						
						if (enemy is Rocker) {
							enemy.x -= 1;
						} else {
							enemy.hp -= earthquake.damage;
							enemy.x -= 3;
						}
						
						if (enemy.hp <= 0) {
							enemy.Die ();
						}
					}
				}
			} else {
				var enemies:Array = [];
				this.getType ("enemy", enemies);
				
				for each (var enemy:Enemy in enemies) {
					enemy.shaking = false;
					enemy.disabled = false;
				}
			}
		}
		
		private function CheckWin ():void {
			var enemies:Array = [];
			this.getType ("enemy", enemies);
			
			if (waves.length <= 0 && enemies.length <= 0) {
				//LevelComplete ();
				GoUpgradeState ();
			}
			//LevelComplete ();
			//GoUpgradeState ();
		}
		
		private function LevelComplete ():void {
			state = GameWorld.LEVEL_DONE;
			var window:LevelCompleteWindow = new LevelCompleteWindow (level, totalPoints, 
			function () {
				GoLevel (++level);
				FP.world.remove (window);
			},
			function () {
				Main (FP.engine).GoMenu ();
			});
			window.layer = -10000;
			this.add (window);
		}
		
		private function GoUpgradeState ():void {
			this.remove (this.getInstance ("pause"));
			
			state = GameWorld.UPGRADE;
			var blurb:UpgradeBlurb = new UpgradeBlurb (true, true, true, onUpgradeFire, onUpgradeLightning, onUpgradeEarth);
			blurb.layer = -10;
			blurb.name = "upgradeBlurb";
			this.add (blurb);
		}
		
		private function onUpgradeFire ():void {
			UpgradeZap (0);
		}
		
		private function onUpgradeLightning ():void {
			UpgradeZap (1);
		}
		
		private function onUpgradeEarth ():void {
			
			UpgradeZap (2);
		}
		
		private function UpgradeZap (type:int):void {
			this.remove (this.getInstance ("upgradeBlurb"));
			
			wizard.Upgrade ();
			
			if (type == 0) {  //fire
				fireCannon.Upgrade ();
				for (var i:int = 0; i < 5; i++) this.add (new UpgradeLightning (572, 113, fireCannon.left + Math.random () * fireCannon.width, fireCannon.top + Math.random () * fireCannon.height));
			} else if (type == 1) {  //lightning
				lightningCloud.Upgrade ();
				for (var i:int = 0; i < 5; i++) this.add (new UpgradeLightning (572, 113, lightningCloud.left + Math.random () * lightningCloud.width, lightningCloud.top + Math.random () * lightningCloud.height));
			} else if (type == 2) {  //earth
				earthquake.Upgrade ();
				for (var i:int = 0; i < 5; i++) this.add (new UpgradeLightning (572, 113, earthquake.left + Math.random () * earthquake.width, earthquake.top + Math.random () * earthquake.height));
			}
			
			var tween:Tween = new Tween (2, Tween.ONESHOT, function () {
				var lights:Array = [];
				FP.world.getType ("upgradeLightning", lights);
				for each (var light:UpgradeLightning in lights) FP.world.remove (light);
				LevelComplete ();
			});
			this.addTween (tween, true);
		}
		
		private function GoMenuState ():void {
			state = GameWorld.LEVEL_MENU;
			var levelMenuWindow:LevelMenuWindow = new LevelMenuWindow (
			function () {
				GoLevel (++level);
				FP.world.remove (levelMenuWindow);
			},
			function () {
				Main (FP.engine).GoMenu ();
			});
			this.add (levelMenuWindow);
		}
		
		private function Pause ():void {
			//state = GameWorld.PAUSE;
			Main (FP.engine).GoPause ();
		}
		
		private function DoPopup (text:String, y:Number):void {
			state = GameWorld.POPUP;
			showedPopup = true;
			popup = new Text (text, 0, y, {shadow:true, shadowColor:0x194239});
			popup.font = "Arial";
			popup.width = FP.width;
			popup.height = FP.height;
			popup.align = "center";
			popup.size = 20;
			
			this.addGraphic (popup, -1000);
		}
		
		private function Die ():void {
			state = GameWorld.DEATH;
			this.remove (this.getInstance ("pause"));
			
			deathText = new Text ("You failed to stop the invasion!", 0, 100, {shadow:true, shadowColor:0x194239});
			deathText.font = "Arial";
			deathText.width = FP.width;
			deathText.height = FP.height;
			deathText.align = "center";
			deathText.size = 20;
			
			this.addGraphic (deathText, -1000);
			
			deathText = new Text ("Total Points: " + totalPoints.toString (), 0, 150, {shadow:true, shadowColor:0x194239});
			deathText.font = "Arial";
			deathText.width = FP.width;
			deathText.height = FP.height;
			deathText.align = "center";
			deathText.size = 30;
			
			this.addGraphic (deathText, -1000);
			
			deathText = new Text ("Tap to continue", 0, 300, {shadow:true, shadowColor:0x194239});
			deathText.font = "Arial";
			deathText.width = FP.width;
			deathText.height = FP.height;
			deathText.align = "center";
			deathText.size = 20;
			
			this.addGraphic (deathText, -1000);
		}
	}
}