package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class Level 
	{
		public static const PIECE_WIDTH = 25;
		
		public var floor:FlxGroup;
		public var walls:FlxGroup;
		public var ramps:FlxGroup;
		public var robots:FlxGroup;
		public var checkpoints:FlxGroup;
		//public var checkpoint:CheckPoint;
		private var levelNumber:int;
		public var lastCheckpointPos:int;
		public var scoreMultipliers:FlxGroup;
		public var wallDroppers:FlxGroup;
		
		
		public function Level() 
		{
			levelNumber = 1;
			walls = new FlxGroup();
			ramps = new FlxGroup();
			floor = new FlxGroup();
			robots = new FlxGroup();
			checkpoints = new FlxGroup();
			scoreMultipliers = new FlxGroup();
			wallDroppers = new FlxGroup();
		}
		
		/***********************************************
		 * Creates a level. 
		 * Returns the checkpoint because I am having an issue with moving the checkpoint.
		 */
		/*public function loadLevel(levelNumber:int):int
		{
			switch(levelNumber)
			{
				case 1:
					loadLevel1();
					break;
				case 2:
					loadLevel2();
					break;
				case 3:
					loadLevel3();
					break;
			}
			return checkpoint.x;
		}*/
		
		
		
		/*******************************************************************
		 * This desperately needed a level loaded. I can't even read the current system. 
		 * Here is my stoned attempt at making that happen:
		
			 Run a loop to read every line. Every line represents the level using symbols for pieces. 
			 
			 
			 _ = empty floor
			 ' = high wall
			 . = low wall
			 = = short walls
			 < = ramp
			 ` = empty space
			 w = wall dropper
			 | = checkpoint
			 
			 */
			 
		public function loadLevel(levelString:String)
		{
			var P_LEN = 25; //piece length (the length of my floor image. I hope this is good 'nuff)
			
			walls = new FlxGroup();
			scoreMultipliers = new FlxGroup();
			
			var levelLength:int = levelString.length;
			
			for (var i = 0; i < levelLength; i++)
			{
				
				var xPos:int = i * P_LEN;
				var pieceChar = levelString.charAt(i);
				switch(pieceChar)
				{
					case "_":
						break;
					case "'":
						this.addWall(0,xPos);
						break;
					case ".":
						this.addWall(1,xPos);
						break;
					case "=":
						this.addShortWalls(xPos);
						break;
					case "<":
						this.addRamp(xPos);
						break;
					case "|":
						this.addCheckpoint(xPos);
						break;
					default:
						break;
				}
				if (pieceChar != "`")
					{
						this.addFloor(xPos);
					}
					
				
			}
		}
		
		private function addFloor(xPosition:int) 
		{ 
			
			var floorPiece:Floor = Floor.createFloorPiece(xPosition);
			floor.add(floorPiece);
			
		}
		
		private function addWall(low:Boolean, xPosition:int) 
		{ 
			var lane;
			if (low == 0)
				lane = Wall.TOPLANE;
			else lane = Wall.BOTLANE;
			var wall:Wall = new Wall(lane, xPosition);
			walls.add(wall);
		} // 0 for high, 1 for low
		
		private function addShortWalls(xPosition:int) 
		{ 
			var sWall:ShortWall = new ShortWall(Wall.TOPLANE, xPosition);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, xPosition);
			walls.add(sWall);
		}
		private function addRamp(xPosition:int) 
		{
			var ramp:Ramp = new Ramp(Wall.MIDLANE, xPosition);
			ramps.add(ramp);
		}
		private function addCheckpoint(xPosition:int) 
		{ 
			var checkpoint:CheckPoint = new CheckPoint(xPosition);
			checkpoints.add(checkpoint);
			trace(checkpoint);
		}
		
		/********************************************************************
		 * This is my cheesy way of creating levels. 
		 * There should be some sort of file loading system, I think.
		 */		
		/*private function loadLevel1():void
		{
			trace("LOADING LEVEL 1");
			
			var robot:Robot = new Robot(Robot.BOTLANE, 600);
			//robots.add(robot);
			
			walls = new FlxGroup();
			scoreMultipliers = new FlxGroup();
			var wall:Wall = new Wall(Wall.TOPLANE, 800);
			walls.add(wall);
			var scoreMultiplier:ScoreMultiplier = new ScoreMultiplier(Wall.TOPLANE, wall.x + 50);
			scoreMultipliers.add(scoreMultiplier);
			wall = new Wall(Wall.BOTLANE, wall.x + 400);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 400);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 400);
			walls.add(wall);
			
			wall= new Wall(Wall.TOPLANE, wall.x + 450);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 400);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 300);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 400);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 300);
			walls.add(wall);
			
			var sWall:ShortWall = new ShortWall(Wall.TOPLANE, wall.x + 400);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			
			wall = new Wall(Wall.BOTLANE, sWall.x + 300);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 300);
			walls.add(wall);
			
			sWall = new ShortWall(Wall.TOPLANE, wall.x +300);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			sWall = new ShortWall(Wall.TOPLANE, sWall.x +300);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			sWall = new ShortWall(Wall.TOPLANE, sWall.x +300);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			
			wall = new Wall(Wall.TOPLANE, sWall.x + 250);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 250);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 250);
			walls.add(wall);
			
			checkpoint = new CheckPoint(wall.x + 150);
			checkpoints.add(checkpoint);
			
			var ramp:Ramp = new Ramp(Wall.MIDLANE, checkpoint.x + 750);
			ramps.add(ramp);
			
			var floors:FlxGroup = Floor.createFloor(10, ramp.x + 50);
			floor.add(floors); // Not the best variable naming..
			
			sWall = new ShortWall(Wall.TOPLANE, ramp.x +700);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			ramp = new Ramp(Wall.MIDLANE, sWall.x + 200);
			ramps.add(ramp);
			
			floors = Floor.createFloor(sWall.x - 300, ramp.x + 25);
			floor.add(floors);
			
			// NEED VARIABLE TO GET START POSITION OF FLOOR - HOLD ONTO IT. PUT EVERYTHIGN ON FLOOR. 
			var floorStart:int = ramp.x + 450;
			
			sWall = new ShortWall(Wall.TOPLANE, ramp.x +700);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			sWall = new ShortWall(Wall.TOPLANE, sWall.x + 200);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			ramp = new Ramp(Wall.MIDLANE, sWall.x + 200);
			ramps.add(ramp);
			floors = Floor.createFloor(floorStart, ramp.x + 25);
			floor.add(floors);
			
			floorStart = ramp.x + 450;
			wall = new Wall(Wall.TOPLANE, floorStart + 200);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 200);
			walls.add(wall);
			ramp = new Ramp(Wall.MIDLANE, wall.x + 200);
			ramps.add(ramp);
			floors = Floor.createFloor(floorStart, ramp.x + 25);
			floor.add(floors);
			
			floorStart = ramp.x + 450;
			wall = new Wall(Wall.TOPLANE, floorStart + 200);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			ramp = new Ramp(Wall.MIDLANE, wall.x + 200);
			ramps.add(ramp);
			floors = Floor.createFloor(floorStart, ramp.x + 25);
			floor.add(floors);
			
			floorStart = ramp.x + 450;
			sWall = new ShortWall(Wall.TOPLANE, ramp.x +700);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			sWall = new ShortWall(Wall.TOPLANE, sWall.x + 200);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			checkpoint = new CheckPoint(sWall.x + 200);
			
			wall = new Wall(Wall.TOPLANE, checkpoint.x + 600);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 400);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.TOPLANE, wall.x + 200);
			walls.add(wall);
			wall = new Wall(Wall.BOTLANE, wall.x + 200);
			walls.add(wall);
			
			sWall = new ShortWall(Wall.TOPLANE, wall.x + 400);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			sWall = new ShortWall(Wall.TOPLANE, sWall.x + 300);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			sWall = new ShortWall(Wall.TOPLANE, sWall.x + 300);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall);
			var fWall:FloatingWall = new FloatingWall(Wall.TOPLANE, sWall.x + 600);		
			walls.add(fWall);
			fWall = new FloatingWall(Wall.BOTLANE, fWall.x);
			walls.add(fWall);											
			var fRamp:FloatingRamp = new FloatingRamp(Wall.MIDLANE, fWall.x + 200);
			ramps.add(fRamp); 								
			
			floors = Floor.createFloor(floorStart, fRamp.x + 25);
			floor.add(floors);

			floorStart = fRamp.x + 450;
			
			// Walls Dropped: Top, Bottom, short wall, bottom, top, bottom, floating ramp
			var wallDropper:WallDropper = new WallDropper(Wall.TOPLANE, fWall.x);
			wallDroppers.add(wallDropper);
			sWall = wallDropper.sWall;
			walls.add(sWall); // Top
			wallDropper = new WallDropper(Wall.BOTLANE, floorStart);
			wallDroppers.add(wallDropper);
			sWall = wallDropper.sWall; // Bot
			walls.add(sWall);
			wallDropper = new WallDropper(Wall.BOTLANE, sWall.x + 200);
			wallDroppers.add(wallDropper);
			sWall = wallDropper.sWall;
			walls.add(sWall);// Bot
			sWall = new ShortWall(Wall.TOPLANE, sWall.x + 400);
			walls.add(sWall);
			sWall = new ShortWall(Wall.BOTLANE, sWall.x);
			walls.add(sWall); // swall
			wallDropper = new WallDropper(Wall.TOPLANE, sWall.x + 200);
			wallDroppers.add(wallDropper);
			sWall = wallDropper.sWall;
			walls.add(sWall);// Top
			walls.add(sWall);wallDropper = new WallDropper(Wall.BOTLANE, sWall.x + 200);
			wallDroppers.add(wallDropper);
			sWall = wallDropper.sWall;
			walls.add(sWall);// Bot
			fRamp = new FloatingRamp(Wall.MIDLANE, sWall.x + 25);
			ramps.add(fRamp); 								
			
			floors = Floor.createFloor(floorStart, fRamp.x + 200);
			floor.add(floors);
			
			
			
			
		}*/
		
		
		public function resetToCheckpoint( checkpointPos:Number ):void 
		{
			// **** GAME BREAKER HERE ****
			// THIS WILL NO LONGER LOAD CHECKPOINTS!!!
			// ***************************************
			
			loadLevel(GameState.LEVEL_STRING);
			/*loadLevel("____________________________________________________'______________.______________'______________.______________'______________.____________.____________'____________'______________=_____________.______________'___________=_____________=____________=_____________'__________.__________'_________/n"
+"___________________________________________<````````______=______<````````______=______=______<``````````__'____.____'____<````````````___'___.___'___.___'___.____<``````````______=______=____!___/n"
+"__________________________'___.___'___.______'___.___'___.________=_____=____=_________!__________>``````````______________w________________v____=________v____________w________v____________>``````______=_____/n"
+"________<``````_<``````_<``````________=________=________/``````````````````________!______!______>``````````````````________x________x_____o______________x______________<``````__``````__``````__``````__``````__``````__________w___/n"
+"________'____.____'____.____'____.____'____.____'____.____'____.____'____.____'____.____'____.____'____.__________=__________=__________=__________/n"
+"_____;");*/
			//loadLevel(levelNumber);
			
		}
	}

}