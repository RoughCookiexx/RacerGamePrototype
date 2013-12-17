package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author ...
	 */
	public class WallDropper extends FlxSprite
	{
		
		[Embed(source = "../data/wallDropper.png")] protected var ImgWallDropper:Class;
		public var launched:Boolean = false;
		public var dropped:Boolean = false;
		private var lane:int;
		public var sWall:ShortWall;
		public function WallDropper(row:int, xPosition:int) 
		{
			loadGraphic(ImgWallDropper, true, true, 45, 120, false);
			alpha = 1;
			x = xPosition;
			y = 20;
			lane = row;
			sWall = new ShortWall(lane, x);
			sWall.kill();
			
		}
		
		
		override public function update():void {
			if (GameState.resetToCheckpoint)
			{
				x -= GameState.lastCheckpointPos;
				launched = false;
			}
				
			if (!GameState._dead)
				x -= GameState._xSpeed;
			if (launched)
			{
				x += 10;
				if (x > 290 && !dropped)
				{
					dropTheWall();
					dropped = true;
				}
			}
			super.update();
		}
		
		public function launch():void
		{
			if (!launched)
			{
				launched = true;
				alpha = 1;
				x = -50;
				if (lane == 1)
					y = 0;
				else y = 35;
			}
		}
		
		private function dropTheWall():void
		{
			trace(this.x);
			sWall.revive();
			sWall.dropping = true;
			sWall.x = this.x;
			sWall.y = this.y+this.height;
		}
	}

}