package 
{
	
	import org.flixel.*;
	import mochi.Ads;
	
		[SWF(width="640", height="400", backgroundColor="#FFFFFF")]
	[Frame(factoryClass="Preloader")]
	/**
	 * This is the entry point for the game. Hopefully this will turn into my first FULL game. 
	 * 		Any ladies reading this, I am sorry for I call the player "he" and "him" a lot in my comments.
	 * 		It is unintentional and I do not mean to disrespect you as gamers. 
	 * 
	 * Obviously the comments are informal. If you need anything explained, have suggestions or want to
	 * 		be an official fan, please write me at roughcookie@gmail.com. I will be happy to hear from you.
	 * 
	 * @author Tom Grasman
	 */
	public class RacerGame extends FlxGame
	{
		public function RacerGame():void
		{
			super(320,200,TitleState,2,50,50, false);
			forceDebugger = true;
			FlxG.mouse.show();
		}
	}
}