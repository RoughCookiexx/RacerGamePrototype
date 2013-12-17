package mochi 
{
	import flash.display.MovieClip;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author Tom Assman
	 */
	public class Ads extends MovieClip
	{
		
		public function Ads() 
		{
			
			var mochiConnectClip:MovieClip = new MovieClip();
			addChild(mochiConnectClip);
			//MochiServices.connect("edaef9f112e1e658",mochiConnectClip);
			MochiAd.showPreGameAd({clip:mochiConnectClip, id:"edaef9f112e1e658", res:"640x400"});
		}
		
	}

}