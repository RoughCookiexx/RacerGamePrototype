package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class FloatingWall extends ShortWall
	{
		
		public function FloatingWall(lane:int, xPosition:int) 
		{
			super(lane, xPosition);
			HIT_HEIGHT_BOT = 25;
			HIT_HEIGHT_TOP = 50;
			y -= 25;
		}
		
	}

}