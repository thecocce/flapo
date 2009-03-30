package com.blitzagency.xray.logger;
/*
    Debug class for use with bit-101 Flash Debug Panel
    See www.bit-101.com/DebugPanel
    This work is licensed under a Creative Commons Attribution 2.5 License.
    See http://creativecommons.org/licenses/by/2.5/
    
    Authors: Keith Peters and Tim Walling
    www.bit-101.com
    www.timwalling.com
	
	Modified for Xray:
	John Grden
	neoRiley@gmail.com
	www.osflash.org/xray
*/
#if flash9
	import flash.net.LocalConnection;
#end
import flash.Lib;
import flash.Boot;

class Debug
{    
	private static var xrayLC:LocalConnection;
	private static var connected:Bool=false;
    
	
	private static function makeConnection():Void
	{
		xrayLC = new LocalConnection();
		try {
			xrayLC.connect("_xray_standAlone_debug");
			connected = true;
		}
		catch (e: Dynamic)
		{
			connected = false;
		}
	}
	
	/**
     *	Traces any value to the debug panel, with an optional message level.
     *	@param pMsg The value to trace.
     *	@param pLvl Optional. The level for this message. Values are 0 through 4, or Debug.Debug, Debug.INFO, Debug.WARN, Debug.ERROR, Debug.FATAL.
     */
    public static function trace(pMsg:Dynamic, pPackage:String, pLevel:Int):Void 
	{	
		//_global.tt(8);
		// trace to the Flash IDE output window
		//_global["trace"](pMsg);
		trace(pMsg);
		// if xray connector exists, pass the love along via xray's localconnection
		if(/*_global.*/class_exists ( com.blitzagency.xray.Xray.lc_info) )
		{
			_global.com.blitzagency.xray.Xray.lc_info.setTrace({trace:pMsg, level:pLevel, package1:pPackage});
		}
		else
		{
			if(xrayLC == undefined) 
			{
				makeConnection();
			}

			if(connected)
			{
				var sent:Boolean = xrayLC.send("_xray_view_conn", "setTrace", pMsg, pLevel, pPackage);
			}
		}
    }

	/**
	 *	Recursively traces an object's value to the debug panel.
	 *	@param o The object to trace.
	 *	@param pRecurseDepth Optional. How many levels deep to recursively trace. Defaults to 0, which traces only the top level value.
     *	@param pIndent Optional. Number of spaces to indent each new level of recursion.
	 * 	@param pPackage - passed in via XrayLogger.  Package info sent along to Xray's interface for package filtering
     */
	public static function traceObject(o:Dynamic, pRecurseDepth:Int, pIndent:Int, pPackage:String, pLevel:Int):Void 
	{
		var recurseDepth:Int;
		var indent:Int;
		
		if (pRecurseDepth == null) 
		{
			recurseDepth = 0;
		} 
		else 
		{
			recurseDepth = pRecurseDepth;
		}
		
		if (pIndent == null) 
		{
			indent = 0;
		} 
		else 
		{
			indent = pIndent;
		}
		
		if(getLength(o) == 0)
		{
			var lead:String = "";
			var i:Int;
			for (i in 0...indent) 
			{
				lead += "    ";
			}
			var obj:String = o.toString();
			if (Boot.__instanceof(o, Array)) 
			{
			    obj = "[Array]";
			}
			if (obj == "[object Object]") 
			{
    			obj = "[Object]";
    		}    		
    		if (obj == "[type Function]") 
			{
    			obj = "[Function]";
    		}
			Debug.trace(lead + obj, pPackage, pLevel);
			
			return;
		}
		var prop:String;
		var a : Array<Dynamic> = o;
		for (prop in a)
		{
			var lead:String = "";
			var i:Int;
			for (i in 0...indent) 
			{
				lead += "    ";
			}
			var obj:String = o[prop].toString();
			if (Boot.__instanceof(o[prop], Array)) 
			{
			    obj = "[Array]";
			}
			if (obj == "[object Object]") 
			{
    			obj = "[Object]";
    		}
			if (obj == "[type Function]") 
			{
    			obj = "[Function]";
    		}
			Debug.trace(lead + prop + ": " + obj, pPackage, pLevel);
			if (recurseDepth > 0) 
			{
				traceObject(o[prop], recurseDepth-1, indent+1, pPackage, pLevel);
			}
		}
	}
	
	private static function getLength(o:Dynamic):Int
	{
		var count:Int = 0;
		var items:String;
		var a: Array<Dynamic> = o;
		for(items in a) count++;
		return count;
	}
}
