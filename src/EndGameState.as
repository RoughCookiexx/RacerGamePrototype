package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class EndGameState extends FlxState
	{
		private var _replayButton:FlxButton;
		public var	_gameOverText:FlxText;
		
		public function EndGameState() 
		{
			_replayButton = new FlxButton(20, 40, "REPLAY", restart);
			_replayButton.color = 0xffffff;
			_gameOverText = new FlxText(10, 10, 100, "GAME OVER");
			_gameOverText.size = 8;
			
			add(_gameOverText);
			add(_replayButton);
		}
		
		private function restart():void
		{
			_replayButton.destroy();
			FlxG.switchState(new GameState());
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}