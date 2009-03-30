package com.blitzagency.xray.logger;
/**
 * @author John Grden
 */
interface Logger 
{	
	public function debug(message:String, dump:Dynamic, package1:String):Void;
	public function info(message:String, dump:Dynamic, package1:String):Void;
	public function warn(message:String, dump:Dynamic, package1:String):Void;
	public function error(message:String, dump:Dynamic, package1:String):Void;
	public function fatal(message:String, dump:Dynamic, package1:String):Void;
	public function log(message:String, dump:Dynamic, package1:String, level:Int):Void;
	
}