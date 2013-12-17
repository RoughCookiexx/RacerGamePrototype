package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class Floor extends FlxSprite
	{
		private static const FLOOR_WIDTH:int = 25;
		//public var startPosition:int;
		//public var endPosition:int;
		
		[Embed(source = "../data/floor.png")] protected var ImgFloor:Class;
		
		/***********************
		 * A floor object is actually a piece of a floor. 
		 * They are strung together to create the ground.
		 */ 
		public function Floor() 
		{
		//	this.startPosition = startPosition;
		//	this.endPosition = endPosition;
			loadGraphic(ImgFloor, false, false, 25, 65, false);
		}
		
		override public function update():void {
			if (GameState.resetToCheckpoint)
				x -= GameState.lastCheckpointPos;
			if(!GameState._dead)
			x -= GameState._xSpeed;
			super.update();
		}
		
		public static function createFloorPiece(startPosition:int):Floor
		{
			var floor:Floor = new Floor();
			floor.x = startPosition;
			floor.y = 105;
			
			return floor;
		}
		
		// Now I'm thinking this can be done with some boolean operations since it's either on or off.
		public static function createFloor(startPostion:int, endPosition:int):FlxGroup 
		{
			// Round to the nearest width of a floor piece. 
			startPostion = startPostion - (startPostion % 25);
			endPosition = endPosition - (endPosition % 25); 
			
			var floors:FlxGroup = new FlxGroup();
			for (var i:int = startPostion; i < endPosition; i += 25)
			{
				var floor:Floor = new Floor();
				floor.x = i;
				floor.y = 105;
				floors.add(floor);
			}
			return floors;
		}
				
		public function reAllign( position:Number):void
		{
			x -= position;
		}
		
	}

}