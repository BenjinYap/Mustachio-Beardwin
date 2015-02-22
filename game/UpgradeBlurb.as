package game 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	/**
	 * ...
	 * @author Benjin
	 */
	public class UpgradeBlurb extends Entity
	{
		private var blurb:TextBlurb;
		
		private var fire:Boolean;
		private var fireCallback:Function;
		private var fireBlurb:TextBlurb;
		
		private var lightning:Boolean;
		private var lightningCallback:Function;
		private var lightningBlurb:TextBlurb;
		
		private var earth:Boolean;
		private var earthCallback:Function;
		private var earthBlurb:TextBlurb;
		
		
		public function UpgradeBlurb(fire:Boolean, lightning:Boolean, earth:Boolean, fireCallback:Function, lightningCallback:Function, earthCallback:Function) 
		{
			this.layer = -10;
			
			this.fire = fire;
			this.fireCallback = fireCallback;
			this.lightning = lightning;
			this.lightningCallback = lightningCallback;
			this.earth = earth;
			this.earthCallback = earthCallback;
			
			blurb = new TextBlurb ("Pick an element to upgrade", 400, 50, 12);
			blurb.text.originX = 400;
			blurb.text.originY = 0;
			blurb.text.align = "right";
			blurb.text.size = 40;
			blurb.x = FP.width - 10;
			blurb.y = 15;
			blurb.layer = this.layer;
			FP.world.add (blurb);
			
			if (fire) {
				fireBlurb = new TextBlurb ("Fireball radius", 200, 50, 12, fireCallback);
				fireBlurb.centerOrigin ();
				fireBlurb.text.size = 40;
				fireBlurb.x = 505;
				fireBlurb.y = 235;
				fireBlurb.layer = this.layer;
				FP.world.add (fireBlurb);
			}
			
			if (lightning) {
				lightningBlurb = new TextBlurb ("Increase stun time", 250, 50, 12, lightningCallback);
				lightningBlurb.centerOrigin ();
				lightningBlurb.text.size = 40;
				lightningBlurb.x = 106;
				lightningBlurb.y = 58;
				lightningBlurb.layer = this.layer;
				FP.world.add (lightningBlurb );
			}
			
			if (earth) {
				earthBlurb = new TextBlurb ("Increase shakes", 200, 50, 12, earthCallback);
				earthBlurb.centerOrigin ();
				earthBlurb.text.size = 40;
				earthBlurb.x = 105;
				earthBlurb.y = 274;
				earthBlurb.layer = this.layer;
				FP.world.add (earthBlurb);
			}
		}
		
		public override function removed ():void {
			FP.world.remove (blurb);
			
			if (fire) FP.world.remove (fireBlurb);
			if (lightning) FP.world.remove (lightningBlurb);
			if (earth) FP.world.remove (earthBlurb);
		}
		
		public override function update ():void {
			//trace (Input.mouseX, Input.mouseY);
			//fireBlurb.x = Input.mouseX;
			//fireBlurb.y = Input.mouseY;
			
			//trace (Input.mouseX, Input.mouseY);
			//earthBlurb.x = Input.mouseX;
			//earthBlurb.y = Input.mouseY;
		}
	}

}