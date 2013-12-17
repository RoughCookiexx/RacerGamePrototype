package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class Ramp extends FlxSprite
	{
		[Embed(source = "../data/ramp.png")] protected var ImgRamp:Class;
		public var HIT_HEIGHT_TOP:int = 25;
		public var HIT_HEIGHT_BOT:int = 0;
		
		public function Ramp(lane:int, xPosition:int) 
		{
			loadGraphic(ImgRamp, false, false, 18, 19, false);
			x = xPosition;
			if (lane == 1)
				y = 115;
			else if (lane == 2)
				y = 150;
			else y = 132;
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