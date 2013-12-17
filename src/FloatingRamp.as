package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class FloatingRamp extends Ramp
	{
		
		public function FloatingRamp(lane:int, xPosition:int) 
		{
			super(lane, xPosition);
			
			HIT_HEIGHT_BOT = 25;
			HIT_HEIGHT_TOP = 50;
			y -= 25;
		}
		
	}

}