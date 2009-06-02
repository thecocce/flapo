package com.blitzagency.xray.logger;

import com.blitzagency.xray.logger.Debug;
import com.blitzagency.xray.logger.Logger;
import flash.Lib; //gettime
import flash.Boot;
import flash.display.MovieClip;
/**
 * @author John Grden
 */
class XrayLogger implements Logger
{
	public static var CLASS_REF = com.blitzagency.xray.logger.XrayLogger;
	
	public static var DEBUG:Int = 0;
	
	public static var INFO:Int = 1;
	
	public static var WARN:Int = 2;
	
	public static var ERROR:Int = 3;
	
	public static var FATAL:Int = 4;
	
	public static var NONE:Int = 5;
	
	public static var XRAYNODUMP:String = "noDump";
	
	public static function resolveLevelAsName(p_level:Int):String
	{
		switch(p_level)
		{
			case 0:
				return "debug";
			
			case 1:
				return "info";
			
			case 2:
				return "warn";
			
			case 3:
				return "error";
			
			case 4:
				return "fatal";
			
			default:
				return "debug";
		}
	}
	
	private var level:Int; // set to DEBUG by default
	private var movieClipRecursionDepth:Int ;
	private var objectRecursionDepth:Int;
	private var indentation:Int;
	
	function XrayLogger()
	{
		level = 0; // set to DEBUG by default
		movieClipRecursionDepth = 2;
		objectRecursionDepth = 4;
		indentation = 0;
	}

	public function setMovieClipRecursionDepth(p_recursionDepth:Int):Void
	{
		movieClipRecursionDepth = p_recursionDepth;
	}
	
	public function setObjectRecursionDepth(p_recursionDepth:Int):Void
	{
		objectRecursionDepth = p_recursionDepth;
	}
	
	public function setIndentation(p_indentation:Int):Void
	{
		indentation = p_indentation;
	}
	
	public function setLevel(p_level:Int):Void
	{
		if(level != null)
		{
			level = p_level;
		}
	}
	
	public function debug(message:String, dump:Dynamic, package1:String):Void
	{
		if(level > /*XrayLogger.*/DEBUG) return;
		if(package1 == null/*undefined*/) package1 = "";
		log(message, dump, package1, 0);
	}
	
	public function info(message:String, dump:Dynamic, package1:String):Void
	{
		if(level > /*XrayLogger.*/INFO) return;
		if(package1 == null/*undefined*/) package1 = "";
		log(message, dump, package1, 1);
	}
	
	public function warn(message:String, dump:Dynamic, package1:String):Void
	{
		if(level > /*XrayLogger.*/WARN) return;
		if(package1 == null/*undefined*/) package1 = "";
		log(message, dump, package1, 2);
	}
	
	public function error(message:String, dump:Dynamic, package1:String):Void
	{
		if(level > /*XrayLogger.*/ERROR) return;
		if(package1 == null/*undefined*/) package1 = "";
		log(message, dump, package1, 3);
	}
	
	public function fatal(message:String, dump:Dynamic, package1:String):Void
	{
		if(level > /*XrayLogger.*/FATAL) return;
		if(package1 == null/*undefined*/) package1 = "";
		log(message, dump, package1, 4);
	}
	
	/**
	 * Logs the {@code message} using the {@code Debug.trace} method if
	 * {@code traceObject} is turned off or if the {@code message} is of type
	 * {@code "string"}, {@code "number"}, {@code "boolean"}, {@code "undefined"} or
	 * {@code "null"} and using the {@code Debug.traceObject} method if neither of the
	 * above cases holds {@code true}.
	 *
	 * @param message the message to log
	 */
	public function log(message:String, dump:Dynamic, package1:String, level:Int):Void 
	{		
		// add time stamp
		message = "\n(" + Lib.getTimer() + ") " + message;

		Debug.trace(message, package1, level);
		
		if(dump == /*XrayLogger.*/XRAYNODUMP) return;		
		
		// check to see if dump is an Dynamic or not
		var type:String = Std.string(Type.typeof(dump));
	
		//Debug.trace("typeof? " + (dump instanceof MovieClip), package1, level);
		if (type == "string" || type == "Int" || type == "boolean" || type == "undefined" || type == "null") 
		{
			if(dump == null/*undefined*/) 
			{
				dump = "undefined";
			}
			Debug.trace(dump, package1, level);
		}else if(Boot.__instanceof(dump, MovieClip))
		{
			var str:String = "[MovieClip]" + Lib.eval(dump._target);
			str += ", _x:" + dump._x;
			str += ", _y:" + dump._y;
			str += ", _visible:" + dump._visible;
			str += ", _alpha:" + dump._alpha;
			str += ", _width:" + dump._width;
			str += ", height:" + dump._height;
			Debug.trace(str, package1, level);
		}else
		{
			Debug.traceObject(dump, resolveDepth(dump), indentation, package1, level);
		}
	}
	
	private function resolveDepth(obj:Dynamic):Int
	{
		switch(Std.string(Type.typeof(obj)))
		{
			case "movieclip":
				return movieClipRecursionDepth;
			
			case "Dynamic":
				return objectRecursionDepth;
			
			default:
				return objectRecursionDepth;
		}
	}
}
