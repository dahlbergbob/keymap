package com.boblu.keyboard 
{
	/**
	 * A class that maps togheter one listener (function) to one combination (string) for ease of mapping.
	 * @author Bob Dahlberg
	 */
	public class KeyMap 
	{
		private var _listener:Function;
		private var _combination:String;
		
		/**
		 * Creates a new KeyMap that maps one combination to one listener.
		 * @param	listener		The listener to be executed when the key-combination mapped is hit
		 * @param	combination		The combination to be mapped against the listener
		 */
		public function KeyMap( listener:Function, combination:String )
		{
			init( listener, combination );
		}
		
		/**
		 * Initiates the new KeyMap that maps one combination to one listener.
		 * @param	listener		The listener to be executed when the key-combination mapped is hit
		 * @param	combination		The combination to be mapped against the listener
		 */
		private function init( listener:Function, combination:String ):void 
		{
			_listener = listener;
			_combination = combination;
		}
		
		/**
		 * Compares this instance to an other instance to see if they are equal
		 * @param	other	An other instance of a KeyMap to compare against
		 * @return			true if the two objects are equal, else false.
		 */
		public function equals( other:KeyMap ):Boolean
		{
			return ( other._listener == _listener && other._combination == _combination );
		}
		
		/** Executes the listener */
		public function execute():void
		{
			_listener();
		}
		
		/**
		 * Returns the combination as a string
		 * @return	The combination
		 */
		public function toString():String
		{
			return _combination;
		}
		
		/** Releases all references stored in the instance */
		public function destroy():void 
		{
			_listener = null;
		}
	}
}