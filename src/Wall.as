package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class Wall extends FlxSprite
	{
		[Embed(source = "../data/wall.png")] protected var ImgWall:Class;
		public static const TOPLANE:int = 1;
		public static const BOTLANE:int = 2;
		public static const MIDLANE:int = 3;
		public var HIT_HEIGHT_TOP:int = 25;
		public var HIT_HEIGHT_BOT:int = 0;
		
		
		override public function Wall(lane:int, xPosition:int) 
		{
			loadGraphic(ImgWall, true, true, 6, 25, false);
			x = xPosition;
			if (lane == 1)
				y = 100;
			else y = 135;
			//scale = new FlxPoint(4, 4);
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