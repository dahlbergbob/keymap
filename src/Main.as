package 
{
	import com.boblu.keyboard.KeyboardMapper;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Bob Dahlberg
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event = null ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			var keyMap:KeyboardMapper = new KeyboardMapper( stage );
			keyMap.mapListener( AB, Keyboard.A, Keyboard.B );
			keyMap.mapListener( A, Keyboard.A );
			keyMap.mapListener( ctrlA, Keyboard.CONTROL, Keyboard.A );
			keyMap.mapListener( ctrl, Keyboard.CONTROL );
		}
		
		private function ctrl():void 
		{
			trace( "CTRL" );
		}
		
		private function ctrlA():void 
		{
			trace( "CTRL + A" );
		}
		
		private function A():void 
		{
			trace( "A" );
		}
		
		private function AB():void 
		{
			trace( "A + B" );
		}
	}
}