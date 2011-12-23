/*
 * KeyboardMapper
 * Copyright (C) 2011 Bob Dahlberg
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.boblu.keyboard
{
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard; 
	
	/**
	 * A Keyboard Mapper class that handles the combination of keybaord presses for you.
	 * Map any combination of keys to a listener. When that combination of keys are pressed by the user, the listener is triggered.
	 * @author Bob Dahlberg
	 */
	public class KeyboardMapper 
	{
		private var _keyboardFocus:DisplayObject;
		private var _combination:Vector.<int>;
		private var _listeners:Vector.<KeyMap>;
		private var _keysDown:int;
		private var _combinationHit:Boolean;
		
		/**
		 * Creates a new keyboard mapper
		 * @param	focus	The DisplayObject on which to listen for the keyboard event on
		 */
		public function KeyboardMapper( focus:DisplayObject )
		{
			init( focus );
		}
		
		/**
		 * Initializes the KeyboardMapper and adds listeners to the it's focus-object.
		 * @param	focus	The DisplayObject on which to listen for the keyboard event on
		 */
		private function init( focus:DisplayObject ):void 
		{
			_keysDown		= 0;
			_combinationHit	= false;
			_listeners		= new Vector.<KeyMap>();
			_combination	= new Vector.<int>();
			_keyboardFocus 	= focus;
			_keyboardFocus.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, int.MAX_VALUE );
			_keyboardFocus.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, int.MAX_VALUE );
		}
		
		/**
		 * Handles whenever the any key is pressed down
		 * @param	e	The KeyboardEvent for the current pressed key
		 */
		private function onKeyDown( e:KeyboardEvent ):void 
		{
			if( _combination.indexOf( e.keyCode ) == -1 )
			{
				_keysDown++;
				_combinationHit = false;
				_combination.push( e.keyCode );
				_combination = _combination.sort( compareInt );
			}
		}
		
		/**
		 * Handles whenever the any key is released
		 * @param	e	The KeyboardEvent for the current released key
		 */
		private function onKeyUp( e:KeyboardEvent ):void
		{
			if( !_combinationHit )
				checkCombo();
			
			_keysDown--;
			var position:int = _combination.indexOf( e.keyCode );
			_combination.splice( position, 1 );
			
			if( _keysDown == 0 )
				_combinationHit = false;
		}
		
		/**
		 * Goes through the combinations that are mapped up at the moment for a hit.
		 */
		private function checkCombo():void 
		{
			var hits:Vector.<KeyMap> = _listeners.filter( onFilter );
			for each( var map:KeyMap in hits )
			{
				_combinationHit = true;
				map.execute();
			}
		}
		
		/**
		 * A filter function that compares the current key-combination with the sent in combination.
		 * @param	item	The combination to compare with the current key-combination
		 * @param	index	The index of the combination sent in
		 * @param	vector	The vector that makes the filtering
		 * @return			True if the combination sent in matches the current key-combination
		 */
		private function onFilter( item:KeyMap, index:int, vector:Vector.<KeyMap> ):Boolean
		{
			if( _combination.join() == item.toString() )
			{
				return true;
			}
			return false;
		}
		
		/**
		 * Map a listener to one or many keys
		 * @param	listener	The listener to be triggered when the combination of keys are pressed
		 * @param	... toKeys	Any number of keys to map togheter to a combination
		 */
		public function mapListener( listener:Function, ... toKeys ):void
		{
			var keys:Vector.<int> = new Vector.<int>( toKeys.length );
			for( var i:int = 0; i < keys.length; i++ )
			{
				keys[i] = toKeys[i];
			}
			keys = keys.sort( compareInt );
			
			_listeners.push( new KeyMap( listener, keys.join() ) );
		}
		
		/**
		 * Compares two different int's and returns which is the bigger.
		 * @param	first	int to compare
		 * @param	second	int to compare
		 * @return			1 if the first int is bigger than the second, -1 if the second int is bigger than the first, else 0 if they are equal.
		 */
		private function compareInt( first:int, second:int ):Number
		{
			if( first < second )
				return -1;
			else if( second < first )
				return 1;
			else
				return 0;
		}
		
		/**
		 * Destroys the KeyboardMapper, removes all internal references and listeners to be eligible for garbage collection
		 */
		public function destroy():void
		{
			_keyboardFocus.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			_keyboardFocus.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
			
			for each( var map:KeyMap in _listeners )
			{
				map.destroy();
			}
			
			// clears references
			_keyboardFocus 	= null;
			_combination 	= null;
			_listeners		= null;
		}
	}
}