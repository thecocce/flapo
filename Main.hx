﻿//pre-build
//"$(ToolsDir)\swfmill\swfmill.exe" simple Res.xml Res.swf
//define
//-D inverse


// add the folder containing gamelib2d to the projects classpaths
/*import flash.geom.ColorTransform;

import flash.events.ContextMenuEvent;
import haxe.Log;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.display.Sprite;*/

//import com.blitzagency.Main_loadConnector;
//import com.blitzagency.xray.logger.XrayLog;

import flapo.GameLogic;
import flapo.Menu;

class Main
{
	
	static var game : GameLogic;
	static var menu : Menu;
	
	public static function main ()
	{
		//var connect:com.blitzagency.xray.util.XrayConnect = com.blitzagency.xray.util.XrayConnect.getInstance(_root, true);		
		//flash.Lib.getURL(new flash.net.URLRequest("javascript:me.focus( );void 0;"));
		//doComplete();
		game = new GameLogic();
		//new Main ();
	}
}