package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class Robot extends FlxSprite
	{
		private static const BOTTOM_LIMIT:int = 150;
		private static const TOP_LIMIT:int = 100;
		
		[Embed(source = "../data/robot.png")] protected var ImgRobot:Class;
		public static const TOPLANE:int = 1;
		public static const BOTLANE:int = 2;
		
		private var direction:Boolean; // true = up. down = false.
		
		public function Robot(lane:int, xPosition:int) 
		{
			loadGraphic(ImgRobot, true, true, 15, 15, false);
			x = xPosition;
			if (lane == 1)
			{
				y = 100;
				direction = false;
			}
			else 
			{
				y = 135;	
				direction = true;
			}
		}
		
		
		override public function update():void 
		{
			if (GameState.resetToCheckpoint)
				x -= GameState.lastCheckpointPos;
			x -= GameState._xSpeed/2;
			if (direction)
			{
				y++;
				if (y >= BOTTOM_LIMIT)
					direction = false;
			}
			else
			{
				y--;
				if (y <= TOP_LIMIT)
					direction = true;
			}
		}
				
		public function reAllign( position:Number):void
		{
			x -= position;
		}
		
		
	}

}