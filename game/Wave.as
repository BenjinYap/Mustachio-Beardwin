package game 
{
	
	/**
	 * ...
	 * @author Benjin
	 */
	public class Wave 
	{
		public var enemy:Class;
		public var count:int;
		public var delay:Number;
		public var duration:Number;
		
		public function Wave(enemy:Class, count:int, delay:Number, duration:Number) 
		{
			this.enemy = enemy;
			this.count = count;
			this.delay = delay;
			this.duration = duration;
		}
		
		public function Clone ():Wave {
			var wave:Wave = new Wave (enemy, count, delay, duration);
			return wave;
		}
	}

}