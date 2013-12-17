package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class Racer extends FlxSprite
	{
		
		[Embed(source = "../data/racer.png")] protected var ImgRacer:Class;
		public static var jumpHeight:int;
		
		public function Racer() 
		{
			jumpHeight = 0;
			loadGraphic(ImgRacer, true, true, 40, 16, false);
			//scale = new FlxPoint(6, 6);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function getJumpHeight():int
		{
			return jumpHeight;
		}
		
	}

}