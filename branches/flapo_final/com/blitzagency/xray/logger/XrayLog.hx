package com.blitzagency.xray.logger;

import com.blitzagency.xray.logger.XrayLogger;
import com.blitzagency.xray.logger.Log;

class /*com.blitzagency.xray.logger.*/XrayLog
{
	function XrayLog()
	{
		// CONSTRUCT
	}
	
	public function debug(message:String, dump:Dynamic):Dynamic
	{
		//dump = __arguments__.length == 2 ? dump : XrayLogger.XRAYNODUMP;
		return new Log(message, dump, XrayLogger.DEBUG);
	}
	
	public function info(message:String, dump:Dynamic):Log
	{
		//dump = __arguments__.length == 2 ? dump : XrayLogger.XRAYNODUMP;
		return new Log(message, dump, XrayLogger.INFO);
	}
	
	public function warn(message:String, dump:Dynamic):Log
	{
		//dump = __arguments__.length == 2 ? dump : XrayLogger.XRAYNODUMP;
		return new Log(message, dump, XrayLogger.WARN);
	}
	
	public function error(message:String, dump:Dynamic):Log
	{
		//dump = __arguments__.length == 2 ? dump : XrayLogger.XRAYNODUMP;
		return new Log(message, dump, XrayLogger.ERROR);
	}
	
	public function fatal(message:String, dump:Dynamic):Log
	{
		//dump = __arguments__.length == 2 ? dump : XrayLogger.XRAYNODUMP;
		return new Log(message, dump, XrayLogger.FATAL);
	}
}
