//pre-build
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
	
	static function main ()
	{
		//var connect:com.blitzagency.xray.util.XrayConnect = com.blitzagency.xray.util.XrayConnect.getInstance(_root, true);		

		game = new GameLogic();
		//new Main ();
	}
}