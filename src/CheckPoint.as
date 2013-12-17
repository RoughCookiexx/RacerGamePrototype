package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class CheckPoint extends FlxSprite
	{
		
		[Embed(source = "../data/checkpoint.png")] protected var ImgCheckpoint:Class;
		// hold onto the position where the checkpoint is for reloading from a checkpoint.
		public var startPosition:Number;
		
		public function CheckPoint(position:int) 
		{
			x = position;
			y = 100;
			loadGraphic(ImgCheckpoint, false, false, 2, 50, false);
			startPosition = x;
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