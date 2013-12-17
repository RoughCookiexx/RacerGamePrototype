package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class ScoreMultiplier extends FlxSprite
	{
		
		[Embed(source = "../data/scoreMultiplier.png")] protected var ImgWall:Class;
		public static const TOPLANE:int = 1;
		public static const BOTLANE:int = 2;
		
		public function ScoreMultiplier(lane:int, xPosition:int) 
		{
			loadGraphic(ImgWall, true, true, 30, 30, false);
			x = xPosition;
			if (lane == 1)
				y = 100;
			else y = 135;
		}
		
		override public function update():void {
			if (GameState.resetToCheckpoint)
				x -= GameState.lastCheckpointPos;
			if(!GameState._dead)
			x -= GameState._xSpeed;
			super.update();
		}
				
		public function reAllign( position:Number):void
		{
			x -= position;
		}
		
	}

}
