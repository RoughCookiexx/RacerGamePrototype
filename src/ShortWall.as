package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class ShortWall extends Wall
	{
		[Embed(source = "../data/sWall.png")] protected var ImgSWall:Class;
		public static const TOPLANE:int = 1;
		public static const BOTLANE:int = 2;
		public var dropping:Boolean;
		private var lane:int;
		
		
		override public function ShortWall(lane:int, xPosition:int) 
		{
			super(lane, xPosition);
			HIT_HEIGHT_TOP = 2;
			loadGraphic(ImgSWall, true, true, 6, 20, false);
			y += 7;
			dropping = false;
			this.lane = lane;
		}
		override public function update():void {
			super.update();
			if (dropping)
			{
				if (lane == TOPLANE
					&& y >= 100)
					dropping = false;
				else if (y >= 135)
					dropping = false;
				else y+=3;
			}
		}
			
	}

}