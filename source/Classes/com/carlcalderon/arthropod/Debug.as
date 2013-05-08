/**
* Debug
* Designed for version 0.81 to 0.95.2 of the Arthropod Debugger.
* 
* USE AT YOUR OWN RISK!
* Any trace that is made with arthropod may be viewed by others.
* The main purpose of arthropod and this debug class is to debug
* unpublished AIR applications or sites in their real 
* environment (such as a web-browser). Future versions of
* Arthropod may change the trace-engine pattern and may cause
* traces for older versions not work properly.
* 
* A big thanks goes out to:
* Stockholm Post Production - www.stopp.se
* Lee Brimelow - www.theflashblog.com 
* 
* @author Carl Calderon 2008
* @version 0.69
* @link http.//www.carlcalderon.com/
* @since 0.61
*/

package com.carlcalderon.arthropod {
	
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;

	public class Debug {
		
		/**
		 * Version control
		 */
		public static const NAME		:String = 'Debug';
		public static const VERSION		:String = '0.69';
		
		/**
		 * Predefined colors
		 */
		public static var RED			:uint = 0xCC0000;
		public static var GREEN			:uint = 0x00CC00;
		public static var BLUE			:uint = 0x6666CC;
		public static var PINK			:uint = 0xCC00CC;
		public static var YELLOW		:uint = 0xCCCC00;
		public static var LIGHT_BLUE	:uint = 0x00CCCC;
		
		/**
		 * Status event
		 * If false, arthropod will trace error messages.
		 */
		public static var ignoreStatus		:Boolean = true;
		
		/**
		 * Security (not tested)
		 * If secure is true, only the <code>secureDomain</code> will be accepted.
		 */
		public static var secure			:Boolean = false;
		
		/**
		 * A single domain to be used as the secure domain. (not tested)
		 */
		public static var secureDomain		:String	 = '*';
		
		private static const DOMAIN			:String = 'com.carlcalderon.Arthropod';
		private static const CHECK			:String = '.161E714B6C1A76DE7B9865F88B32FCCE8FABA7B5.1';
		private static const TYPE			:String = 'app';
		private static const CONNECTION		:String = 'arthropod';
		private static const SECURITY		:String = 'CDC309AF';
		
		private static const LOG_OPERATION		:String = 'debug';
		private static const ERROR_OPERATION	:String = 'debugError';
		private static const WARNING_OPERATION	:String = 'debugWarning';
		
		private static var lc					:LocalConnection 	= new LocalConnection();
		private static var hasEventListeners	:Boolean 			= false;
		
		/**
		 * Traces a message to Arthropod
		 * 
		 * @param	message		Message to be traced
		 * @param	color		opt. Color of the message
		 */
		public static function log(message:String,color:uint=0xFEFEFE):void {
			send(LOG_OPERATION, message,color);
		}
		
		/**
		 * Traces a warning to Arthropod.
		 * The message will be displayed in yellow.
		 * 
		 * @param	message		Message to be traced
		 */
		public static function error(message:String):void {
			send(ERROR_OPERATION, message,0xCC0000);
		}
		
		/**
		 * Traces an error to Arthropod.
		 * The message will be displayed in red.
		 * 
		 * @param	message		Message to be traced
		 */
		public static function warning(message:String):void {
			send(WARNING_OPERATION, message,0xCCCC00);
		}
		
		/**
		 * [internal-use]
		 * Sends the message
		 * 
		 * @param	operation	Operation name
		 * @param	value		Value to send
		 * @param	color		opt. Color of the message
		 */
		private static function send(operation:String, value:*,color:uint=0xFEFEFE):Boolean {
			if (!secure) 	lc.allowInsecureDomain('*');
			else 			lc.allowDomain(secureDomain);
			if (!hasEventListeners) {
				if ( ignoreStatus ) lc.addEventListener(StatusEvent.STATUS, ignore);
				else 				lc.addEventListener(StatusEvent.STATUS, status);
				hasEventListeners = true;
			}
			try {
				lc.send(TYPE + '#' + DOMAIN + CHECK + ':' + CONNECTION , operation,SECURITY, value, color);
			} catch (e:ArgumentError) {
				return false;
			}
			return true;
		}
		
		private static function status(e:StatusEvent):void {
			trace( 'Arthropod status: ' + e.toString() );
		}
		
		private static function ignore(e:StatusEvent):void { }
		
	}
	
}
