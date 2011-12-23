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