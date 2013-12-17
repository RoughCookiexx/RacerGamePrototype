package  
{
	import org.flixel.*;
	/**
	 * This is the heart of the game. Start here to see where all the magic happens.
	 * @author Tom Grasman
	 */
	public class GameState extends FlxState
	{	
		// ************ CONSTANTS ***************
		// Height of a "lane" There are two lanes that object and obstacles will be placed in.
		// Things can be placed in the middle by starting in lane 1 then adding half the lane height.
		public static const LANE_HEIGHT:uint = 50;
		// Level number.
		public static var _levelNumber:int = 1;
		
		// Limit the player's movement:
		private static const LIMIT_LEFT:uint = 25;
		private static const LIMIT_RIGHT:uint = 100;
		private static const LIMIT_TOP:uint = 100;
		private static const LIMIT_BOTTOM:uint = 145;
		// How high the player can jump and how high he goes on a ramp:
		private static const MAX_JUMP_HEIGHT:uint = 35;
		private static const MAX_RAMP_HEIGHT:uint = 70;
		// How fast the player jumps and how fast objects move toward him:
		private static const JUMP_SPEED:Number = 3.5;
		private static const Y_SPEED:Number = 2;
		private static const X_TOP_SPEED:Number = 7;
		private static const ACCELLERATION_RATE:Number = 0.02;
		
		// CHEATS:
		private static const CHEAT_MODE:Boolean = true;
		private static const DEBUG_TEXT:Boolean = true;
		private static var godMode:Boolean;
		
		
		// ************ PUBLIC VARIABLES ***************
		// How high the player has jumped this current frame (and how high he is as a result of a ramp):
		public static var _jumpHeight:Number;
		public static var _rampHeight:Number;
		public static var resetToCheckpoint:Boolean;
		public static var lastCheckpointPos:Number;
		
		
		
		// ************ PRIVATE VARIABLES ***************
		// Background image. Not in use yet.
		private var _bg:FlxSprite;
		
		// Some debug text to be displayed on the screen:
		private var _xPositionText:FlxText;
		private var _aliveText:FlxText;
		private var _jumpingText:FlxText;
		private var _distanceFallenText:FlxText;
		private var _onGroundText:FlxText;
		private var _numLivesRemainingText:FlxText;
		private var _framesPerSecondText:FlxText;
		
		// Score:
		private var _scoreText:FlxText;
		private var _score:Number;
		private var _scoreMultiplierText:FlxText;
		private var _scoreMultiplier:Number;
		
	
		
		// Our hero's sprite:
		private var _racer:FlxSprite;
		//Is the hero jumping?
		private var _jumping:Boolean;
		// Has the jump reached its max height before this frame?
		private var _jumpPeeked:Boolean;
		// Has the hero hit a ramp before he last landed?
		private var _hitRamp:Boolean;
		// Has the hero reached his max height before coming to the ground?
		private var _rampPeeked:Boolean;
		// The level the player is on. Keeps track of obstacles and ramps and such.
		private var _level:Level;
		// Position of the player.
		private var _xPosition:Number; 
		// Distance player has fallen since he fell off the level. He is going to die.
		private var _distanceFallen:Number;
		// If the player is still on the ground. Switched to false at end of frame then checked again.
		private var _onGround:Boolean;
		// how fast the hero is moving:
		public static var _xSpeed:Number;
		
		public static var _dead:Boolean;
		private var _numLivesRemaining:Number = 3;
		
	
		
		[Embed(source = "../data/bg.png")] protected var ImgBG:Class;
		[Embed(source = "../data/ToyFrogs.mp3")] 	protected var toyFrogs:Class;
		
		
		/*
		 * Called when this is created. Loads assets and sets up the game.
		 */
		override public function create():void
		{
			_level = new Level();
			//_level.loadLevel(_levelNumber);
			_level.loadLevel("____________________________________________________'______________.______________'______________.______________'______________.____________.____________'____________'______________=_____________.______________'___________=_____________=____________=_____________'__________.__________'_________/n"
+"______________________________________________________________________________________<````````````````____________=____________<````````````````____________=____________=____________<``````````````````_____'__________.__________'__________<```````````````````______'______.______'______.______'______._______<``````````````````____________=____________=__________!_________/n"
+"____________________________________________________'______.______'______.____________'______.______'______.________________=__________=________=__________________!___________________>``````````____________________________w________________________________v________=________________v________________________w________________v________________________>``````____________=__________/n"
+"________________<````````````````````````````___<````````````````````````````___<````````````````````````````________________________________=________________=________________/``````````````````````````________________!________________!____________>``````````````````````````________________x________________x__________o____________________________x____________________________<`````````____`````````____`````````____`````````____`````````____`````````____________________w___/n"
+"________'____.____'____.____'____.____'____.____'____.____'____.____'____.____'____.____'____.____'____.__________=__________=__________=__________/n"
+"__________;");
			add(_level.floor);
			
			_bg = new FlxSprite;
			_bg.loadGraphic(ImgBG, true, true, 0, 0, false);
			//add(_bg);
			
			_racer = new Racer();
			_racer.x = 20;
			_racer.y = 130;
			add(_racer);
			
			_jumpHeight = 0;
			_jumping = false;
			_jumpPeeked = false;
			
			_rampHeight = 0;
			_hitRamp = false;
			_rampPeeked = false;
			
			_distanceFallen = 0;
			_onGround = true;
			
			
			//*************************
			//  	DEBUG TEXT
			//*************************
			if (DEBUG_TEXT)
			{
				_xPositionText = new FlxText(0, 0,400,"X: "+ _xPosition);
				_xPositionText.size = 8;
				_xPositionText.color = 0x3a5c39;
				_xPositionText.antialiasing = true;
				add(_xPositionText);
				_aliveText = new FlxText(0, 15,400,"Alive: "+ !_dead);
				_aliveText.size = 8;
				_aliveText.color = 0x3a5c39;
				_aliveText.antialiasing = true;
				add(_aliveText);
				_jumpingText = new FlxText(0, 30,400,"Jumping: "+ _jumping);
				_jumpingText.size = 8;
				_jumpingText.color = 0x3a5c39;
				_jumpingText.antialiasing = true;
				add(_jumpingText);
				_distanceFallenText = new FlxText(0, 45,400,"Distance Fallen: "+ _distanceFallen);
				_distanceFallenText.size = 8;
				_distanceFallenText.color = 0x3a5c39;
				_distanceFallenText.antialiasing = true;
				add(_distanceFallenText);
				_onGroundText = new FlxText(0, 60,400,"On Ground: "+ _onGround);
				_onGroundText.size = 8;
				_onGroundText.color = 0x3a5c39;
				_onGroundText.antialiasing = true;
				add(_onGroundText);
				_framesPerSecondText = new FlxText(200, 0,400,"FPS: "+ FlxG.framerate);
				_framesPerSecondText.size = 8;
				_framesPerSecondText.color = 0x3a5c39;
				_framesPerSecondText.antialiasing = true;
				add(_framesPerSecondText);
				add(_aliveText);
			}
			
			_scoreText = new FlxText(100, 10,400,"Score: "+ _score);
			_scoreText.size = 8;
			_scoreText.color = 0x3a5c39;
			_scoreText.antialiasing = true;
			add(_scoreText);
			_scoreMultiplierText = new FlxText(100, 30,400,"Score Multiplier: "+ _scoreMultiplier);
			_scoreMultiplierText.size = 8;
			_scoreMultiplierText.color = 0x3a5c39;
			_scoreMultiplierText.antialiasing = true;
			add(_scoreMultiplierText);
				_numLivesRemainingText = new FlxText(0, 75,400,"Lives: "+ _numLivesRemainingText);
				_numLivesRemainingText.size = 8;
				_numLivesRemainingText.color = 0x3a5c39;
				_numLivesRemainingText.antialiasing = true;
				add(_numLivesRemainingText);
			
			
			// Can I just make a FlxGroup of FlxGroups, return it as a level and only add one object? - probably
			add(_level.walls);
			add(_level.ramps);
			add(_level.checkpoint);
			add(_level.robots);
			add(_level.scoreMultipliers);
			add(_level.wallDroppers);
			
			if (_levelNumber > 1)
				_racer.x += lastCheckpointPos;
				
			_xPosition = 0;
			_xSpeed = 0;
			_dead = false;
			resetToCheckpoint = false;
			lastCheckpointPos = 0;
			_score = 0;
			_scoreMultiplier = 1;
			godMode = false;
			//FlxG.playMusic(toyFrogs, 1);
		}
		
		// ** Called once a frame when the player is jumping until he is done.
		private function doJump():void
		{
			// If the player reaches the top, flip the switch to move downwards
			if (_jumpHeight >= MAX_JUMP_HEIGHT)
				_jumpPeeked = true;
			
			// The first half of the jump moving upwards.
			if (!_jumpPeeked)
			{
				_racer.y -= JUMP_SPEED;
				_jumpHeight += JUMP_SPEED;
			}
			
			// After they reached the top of their jump, start moving down.
			else if(_jumpHeight > 0)
			{
				_racer.y += JUMP_SPEED/1.75;
				_jumpHeight -= JUMP_SPEED/1.75;
			}
			
			// Once the jump is over, flip switches to stop the jump.
			else if(_onGround)
			{
				_jumping = false;
				_jumpPeeked = false;
			}
			else fallToDeath();
		}
		
		private function hitRamp(Sprite1:FlxSprite, Sprite:FlxSprite):void
		{
			var collided:Boolean = false;
			//var wall:Wall = Sprite(Wall);
			var ramp1:Ramp = Sprite1 as Ramp;
			// first check if the player managed to clear the obstacal vertically.
			
			if (_jumping)
			{
				if (_jumpHeight <= ramp1.HIT_HEIGHT_TOP
				&& _jumpHeight >= ramp1.HIT_HEIGHT_BOT)
					collided = true;
			}
			else if (_hitRamp)
			{
			}
			else if (ramp1.HIT_HEIGHT_BOT < 1)
				collided = true;
			if (collided)
				{
					_rampHeight = _jumpHeight;
					_jumping = false;
					_jumpHeight = 0;
						_hitRamp = true;
						trace ("he'e");
				}
				else trace("jump height: " +_jumpHeight + " || RampBot: " + ramp1.HIT_HEIGHT_BOT + " || RampTop: " + ramp1.HIT_HEIGHT_TOP);
		}
		
		/**************************************
		 * Does the same thing as jump, just higher.
		 * This should not be done this way. For now, it's ugly but working.
		 */
		private function rampLaunch():void
		{
			if (_rampHeight >= MAX_RAMP_HEIGHT)
				_rampPeeked = true;
			if (!_rampPeeked)
			{
				_racer.y -= JUMP_SPEED;
				_rampHeight += JUMP_SPEED;
			}
			else if (_rampHeight > 0)
			{
				_racer.y += JUMP_SPEED / 2;
				_rampHeight -= JUMP_SPEED / 2;
			}
			else if (_onGround)
			{
				_hitRamp = false;
				_rampPeeked = false;
			}
			else fallToDeath();
		}
		
		
		private function fallToDeath():void
		{
			if (!godMode)
			{
				if (_distanceFallen >= 50)
				{
					_dead = true;
					_onGround = true;
								trace("Fell to death");
				}
				else
				{
					_racer.y++;
					_distanceFallen++;
				}
			}
		}
		
		/*************************
		 * Respond to key pressed.
		 */
		private function handleKeys():void 
		{
			
				// MOVE UP
				if ((FlxG.keys.pressed("W")
					||FlxG.keys.pressed("UP"))
					&&_racer.y - _distanceFallen >= LIMIT_TOP )
				{
					_racer.y -= Y_SPEED;
				}
				// MOVE DOWN
				else if ((FlxG.keys.pressed("S")
					||FlxG.keys.pressed("DOWN"))
					&&_racer.y + _jumpHeight <= LIMIT_BOTTOM )
				{
					_racer.y += Y_SPEED;
				}
				// MOVE LEFT
				if  ((FlxG.keys.pressed("A")
					||FlxG.keys.pressed("LEFT"))
					&&_racer.x >= LIMIT_LEFT )
				{
					_racer.x -= _xSpeed/2;
				}
				// MOVE RIGHT
				else if ((FlxG.keys.pressed("D")
					||FlxG.keys.pressed("RIGHT"))
					&&_racer.x <= LIMIT_RIGHT )
				{
					_racer.x += _xSpeed/3;
				}
				// JUMP
				if  (FlxG.keys.pressed("SPACE"))
				{
					_jumping = true;
				}
				if (CHEAT_MODE)
				{
					if (FlxG.keys.pressed("PERIOD")
					&& _xSpeed < 50)
						_xSpeed+= 10;
					if (FlxG.keys.pressed("COMMA")
					&& _xSpeed > -50)
						_xSpeed -= 10;
					if (FlxG.keys.pressed("SHIFT"))
					{
						_xSpeed = 2;
					}
					if (FlxG.keys.pressed("M"))
					{
						godMode = false;
					}
					if (FlxG.keys.pressed("N"))
						godMode = true;
					if (FlxG.keys.pressed("L"))
						_numLivesRemaining++;
						
				}
		}
		
		private function accellerateToTopSpeed():void
		{
			if ( _xSpeed < X_TOP_SPEED)
				_xSpeed += ACCELLERATION_RATE;
		}
		
		/*****************************
		 * This updates every frame during the game. 
		 */
		override public function update():void
		{
			
			super.update();
			resetToCheckpoint = false;
			
			if (DEBUG_TEXT)
			{
				_xPositionText.text = "X: " + _xPosition.toPrecision(6);
				_aliveText.text = "Alive: " + !_dead;
				_jumpingText.text = "Jumping: " + _jumping;
				_distanceFallenText.text = "Distance Fallen: " + _distanceFallen;
				_onGroundText.text = "On Ground: " + _onGround;
				_framesPerSecondText.text = "FPS: " + FlxG.framerate;
			}
			_scoreText.text = "Score: " +_score;
			_scoreMultiplierText.text = "Score Multiplier: " + _scoreMultiplier;
			_numLivesRemainingText.text = "Lives: " + _numLivesRemaining;
			
			if (!_dead)
			{
				_score += (int)(_xSpeed * _scoreMultiplier);
			
				accellerateToTopSpeed();
				
				// Add to the xPosition of the racer. This is needed to keep track if he is on the ground.
				_xPosition += _xSpeed;
				
				// Handle input.
				handleKeys();
				
				// If the player is not on the ground, jumping or hit a ramp. Fall to death.
				if (!_onGround
					&& !_jumping
					&& !_hitRamp)
						fallToDeath();
				else
				{
					_onGround = false;
					// Check to see if the player is on the ground.
					if (FlxG.overlap(_level.floor, _racer))
					{	
						_distanceFallen = 0;
						_onGround = true;
					}
					
					// If the player hit space, deal with it. Normally this is handled using gravity acting against
					// 		some velocity set by the jump. But I made it a little different.
					if(_jumping)
						doJump();
					  // can't jump and hit ramp at the same time.
					else if (_hitRamp)
						rampLaunch();
						
						
					// This part is a little confusing. Since I don't have a z-coordinate,
					// 		I take away from the y position. That was simply used to emulate a vertical jump visually.
					// 		Now that we want to check for collisions, we need to know if our racer is heading to a wall.
					_racer.y += _jumpHeight; 	
					_racer.y += _rampHeight;	// Take away any height the racer is off the ground before checking.
					FlxG.overlap(_level.walls, _racer, crash);
					FlxG.overlap(_level.robots, _racer, crash);
					FlxG.overlap(_level.scoreMultipliers, _racer, upTheAnti);
					FlxG.overlap(_level.ramps, _racer, hitRamp);
					FlxG.overlap(_level.wallDroppers, _racer, startWallDropper);
					
					/******************************************
					// i have no idea why this isn't working
					/***************FIX ME******************
					//FlxG.overlap(_level.checkpoint, _racer, nextLevel);
					*******************************************/
					
					_racer.y -= _rampHeight;
					_racer.y -= _jumpHeight;	// Then add back the y position for rendering next frame.
					
					// Check when the player beats a level.
					
				}
			}
			else {
				if (_racer.x < 1000
				&& _racer.y < 300)
				{
					_racer.x += _xSpeed;
					_racer.y++;
				}
				else if(_numLivesRemaining >1)
				{
					_numLivesRemaining--;
					gotoCheckpoint();
				}
				else FlxG.switchState(new EndGameState());
			}
		}
		
		private function startWallDropper(Sprite1:FlxSprite, Sprite:FlxSprite):void
		{
			var wallDropper:WallDropper = Sprite1 as WallDropper;
				wallDropper.launch();
		}
		
		private function upTheAnti(Sprite1:FlxSprite, Sprite:FlxSprite):void
		{
			Sprite1.active = false;
			Sprite1.visible = false;
			Sprite1.kill();
			_scoreMultiplier++;
		}
		
		private function gotoCheckpoint():void
		{
			resetToCheckpoint = true;
			
			_racer.x = 20;
			_racer.y = 130;
			_xPosition = lastCheckpointPos;
			_xSpeed = 0;
			_dead = false;
			_onGround = true;
			_distanceFallen = 0;
			
			// Clear out all the assets then load them again. Can I just move them for efficiency?
			// Does it matter? Probably not. 
			remove(_level.walls);
			remove(_level.ramps);
			remove(_level.checkpoint);
			remove(_level.robots);
			remove(_level.floor);
			remove(_level.scoreMultipliers);
			remove(_racer);
			remove(_level.wallDroppers);
			
			_level = new Level(); // very bad practice. 
			//_level.loadLevel(_levelNumber);
			_level.resetToCheckpoint(lastCheckpointPos);
			add(_level.floor);
			add(_level.walls);
			add(_level.ramps);
			add(_level.checkpoint);
			add(_level.robots);
			add(_level.scoreMultipliers);
			add(_level.wallDroppers);
			add(_racer);
		}
		
		/******************
		 * After a player crosses a checkpoint, go to the next level.
		 * 		It will be loaded imediately and the player will never stop moving.
		 * 		There should probably be some unload function as well. We'll worry about it later.
		 */
		private function nextLevel(Sprite1:FlxSprite, Sprite:FlxSprite):void
		{
			var cp:CheckPoint = new CheckPoint(0);
			cp = CheckPoint(Sprite1);
			lastCheckpointPos = cp.startPosition;
			trace(lastCheckpointPos);
			
			// *******************************
			// DON'T DO ANY OF THIS BS ANYMORE:
			
			// Keep track of which level you're on.
			// 		Sometimes this bugs out and add twice. Not sure why when it should move as 
			// 		soon as this is triggered.
			//_levelNumber++;
			
			//	Load the next level.
			//var checkpointPosition:int = _level.loadLevel(_levelNumber);
			// make sure the checkpoint moves. This was an attempt to clear up the bug previously mentioned
			// 		Clearly it didn't work or I wouldn't be writing about it..
			//_level.checkpoint.x = checkpointPosition;
			
			// 	Add the new walls into the game (should be called something else) 
			//add(_level.walls);
		}
		
		/*****************
		 * Crash into a wall or an enemy.
		 * For now, it simpy goes to the end game screen. I would like for it to do something a little
		 * 		more interesting. Display some animation, play some humiliating sound effect then go.
		 */
		private function crash(Sprite1:FlxSprite, Sprite:FlxSprite):void 
		{
			var crashed:Boolean = false;
			//var wall:Wall = Sprite(Wall);
			var wall1:Wall = Sprite1 as Wall;
			// first check if the player managed to clear the obstacal vertically.
			
			if (_jumping)
			{
				if (_jumpHeight <= wall1.HIT_HEIGHT_TOP
				&& _jumpHeight >= wall1.HIT_HEIGHT_BOT)
					crashed = true;
			}
			else if (_hitRamp)
			{
				if (_rampHeight <= wall1.HIT_HEIGHT_TOP
				&& _rampHeight >= wall1.HIT_HEIGHT_BOT)
					crashed = true;
			}
			else if (wall1.HIT_HEIGHT_BOT < 1)
				crashed = true;
			if (crashed
				&& !godMode)
				{
				// then kill them.
						_dead = true;
						_scoreMultiplier = 1;
						trace("Crashed");
				}
			
		}
	}
}