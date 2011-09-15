package 
{
	import com.boblu.keyboard.KeyboardMapper;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Bob Dahlberg
	 */
	public class Main extends Sprite 
	{
		private var _text:TextField;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event = null ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			_text = new TextField();
			_text.autoSize = TextFieldAutoSize.LEFT;
			addChild( _text );
			
			var keyMap:KeyboardMapper = new KeyboardMapper( stage );
			keyMap.mapListener( AB, Keyboard.A, Keyboard.B );
			keyMap.mapListener( AC, Keyboard.A, Keyboard.C );
			keyMap.mapListener( A, Keyboard.A );
			keyMap.mapListener( ctrl, Keyboard.CONTROL );
			keyMap.mapListener( ctrlA, Keyboard.CONTROL, Keyboard.A );	// Only works in browser
		}
		
		private function ctrl():void 
		{
			log( "CTRL" );
		}
		
		private function ctrlA():void 
		{
			log( "CTRL + A" );
		}
		
		private function A():void 
		{
			log( "A" );
		}
		
		private function AB():void 
		{
			log( "AB" );
		}
		
		private function AC():void 
		{
			log( "AC" );
		}
		
		private function log( message:String ):void
		{
			_text.appendText( message +"\n" );
		}
	}
}