package com.blitzagency.xray.logger;

import com.blitzagency.xray.logger.XrayLogger;

class Log
{
	private var message:String;
	private var dump:Dynamic;
	private var level:Int;
	
	public function new(p_message:String, p_dump:Dynamic, p_level:Int)
	{
		setMessage(p_message);
		setDump(p_dump);
		setLevel(p_level);
	}
	
	public function setMessage(p_message:String):Void
	{
		message = p_message;
	}
	
	public function setDump(p_dump:Dynamic):Void
	{
		dump = p_dump;
	}
	
	public function setLevel(p_level:Int):Void
	{
		level = p_level;
	}
	
	public function getMessage():String
	{
		return message;
	}
	
	public function getDump():Dynamic
	{
		return dump;
	}
	
	public function getLevel():Int
	{
		return level;
	}
}
