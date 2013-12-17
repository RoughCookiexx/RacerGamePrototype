package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	
	import mochi.Ads;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class TitleState extends FlxState
	{
		
		private var _newGameButton:FlxButton;
		public var	_titleText:FlxText;
		
		//[Embed(source = "../data/Drum N Bassa.mp3")] 	protected var toyFrogs:Class;
		override public function create():void
		{
			
			_newGameButton = new FlxButton(100, 100, "NEW GAME", startGame);
			_newGameButton.color = 0xffffff;
			_titleText = new FlxText(40, 40, 100, "RACER GAME BOOBY");
			_titleText.size = 14;
			
			//var ad:Ads = new Ads();
			
			add(_newGameButton);
			add(_titleText);
		//	FlxG.playMusic(toyFrogs, 1);
		}
		private function startGame():void {
			FlxG.switchState(new GameState());
		}
		
		public function TitleState() 
		{
			
		}
		
	}

}
