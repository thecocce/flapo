/**
 * ...
 * @author Bence Dobos
 */

package flapo;

// add the folder containing gamelib2d to the projects classpaths
import flash.display.MovieClip;
import flash.geom.ColorTransform;
import gamelib2d.Def;
import gamelib2d.Utils;
import gamelib2d.TileSet;
import gamelib2d.Layer;
import gamelib2d.Keys;
import gamelib2d.Utils;

import haxe.Log;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.display.Sprite;

import flapo.LevelContainer;
import flapo.LevelData;
//import flash.display.Bitmap;
//import flash.display.BitmapData;
//import com.blitzagency.Main_loadConnector;
//import com.blitzagency.xray.logger.XrayLog;

import flapo.Player;
import ScrollSnd;



class GameLogic 
{

	//static var lc : Main_loadConnector;
	
	static var screen: Sprite;
	static var frame: Int = -1;
	
	static var backgroundTiles: TileSet;
	static var backgroundLayer: Layer;
	
	static var foregroundTiles: TileSet;
	static var foregroundLayer: Layer;
	static var foregroundLayer2: Layer;
	static var level: Level;
	static var levelcontainer: LevelContainer;
	
	static var x: Float = 0;
	static var y: Float = 0;
	static var speedX: Float = 1.0;
	static var speedY: Float = 1.0;

	public static inline var KEY_LEFT   =  flash.ui.Keyboard.LEFT;
	public static inline var KEY_RIGHT  =  flash.ui.Keyboard.RIGHT;
	public static inline var KEY_UP     =  flash.ui.Keyboard.UP;
	public static inline var KEY_DOWN   =  flash.ui.Keyboard.DOWN;
	public static inline var KEY_SPACE  =  flash.ui.Keyboard.SPACE;	
	
	public var player: Player;
	public var dbg: Player;
	public var plX: Int;
	public var plY: Int;
	public var plZ: Int;
	public var plXscreen: Int;
	public var plYscreen: Int;
	
	var ct100: ColorTransform;
	var ct50: ColorTransform;
	public var snd: ScrollSnd;
	
	public inline static var accelerate  =  1.5;
	public inline static var slowdown  =  1;

	
	public function new ()
	{
		// new should not use the stage
		screen = new Sprite ();
		screen.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	
	function init ()
	{
		flash.Lib.current.addChild (screen);

		//Def.STAGE_W = 480;
		//Def.STAGE_H = 360;
		Def.STAGE_W = screen.stage.stageWidth;
		Def.STAGE_H = screen.stage.stageHeight;
		screen.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

		levelcontainer = new LevelContainer();

		ct100 = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
		ct50 = new ColorTransform(1, 1, 1, 0.5, 0, 0, 0, 0);


		initLevel(0);
		Keys.init ();
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, onKeyDown);
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_UP, onKeyUp);
		
		player = new Player(screen);

		plX = 0;
		plY = 0;
		plZ = 0;
		plXscreen = Std.int(Def.STAGE_W/2);
		plYscreen = Std.int(Def.STAGE_H/2);
		player.moveTo(plXscreen-21, plYscreen-21);
		
		dbg = new Player(screen);
		dbg.moveTo(plXscreen + 60, plYscreen-21);
		//sound
		ScrollSnd.init();
		ScrollSnd.enabled = true;
		ScrollSnd.play(ScrollSound.NiceNice);
	
	}
	
	public function initLevel(levelnum:Int)
	{
		level = levelcontainer.getLevel(levelnum, screen);
		if (level != null)
		{
			//for (leveldata.
		}
		level.findStartPos();
		x = level.startposx * level.Layers[level.startposz].layer.ts.tileW;
		y = level.startposy * level.Layers[level.startposz].layer.ts.tileH;
	}
	
	static var fps: Int = 0;
	static var lastT: Int = 0;

#if debug
	// compile with -D debug to see this
	function showFPS ()
	{
		fps++;
		var t: Int = Std.int (Date.now ().getTime () / 1000);
		if (t != lastT)
		{
			Log.clear ();
			Log.setColor (0xFFFFFF);
			trace (fps + " fps");
			trace (Std.int (flash.system.System.totalMemory / (1024 * 1024) * 10) / 10 + " mb");
			fps = 0;
			trace(level.Layers[2].layer.getCurTile(0, 0));
			trace(level.Layers[2].layer.getCurTile(1, 0));
			trace(level.Layers[2].layer.getCurTile(2, 0));
			trace(level.Layers[2].layer.getCurTile(3, 0));
			trace(level.Layers[2].layer.getCurTile(0, 1));
			trace(level.Layers[2].layer.getCurTile(1, 1));
			trace(level.Layers[2].layer.getCurTile(2, 1));
			trace(level.Layers[2].layer.getCurTile(3, 1));
			trace("x:" + Utils.safeDiv (plX, 48) +
				" y:" + Utils.safeDiv (plY, 48) +
				" > " + level.Layers[2].layer.getCurTile
				(Utils.safeDiv (plX, 48), Utils.safeDiv (plY, 48))
			);
		}
		lastT = t;
	}
#end
	
	function onEnterFrame (d: Dynamic)
	{
		frame++;
		if (frame == 0)
			init ();
			
	#if debug
		showFPS ();
	#end

/*		if (x + speedX < 0 || x + speedX >= foregroundLayer.width () - Def.STAGE_W)
			speedX = -speedX;
		if (y + speedY < 0 || y + speedY >= foregroundLayer.height () - Def.STAGE_H)
			speedY = -speedY;
*/
		//trace("2");
		var foregroundLayer: Layer;
		foregroundLayer = level.Layers[2].layer;

		if (Utils.rAbs(speedX) < slowdown) speedX = 0;
		else speedX += speedX>0?-slowdown:slowdown;
		if (Utils.rAbs(speedY) < slowdown) speedY = 0;
		else speedY += speedY>0?-slowdown:slowdown;
		
		//trace("4");
		speedX += (Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT)) - Utils.boolToInt (Keys.keyIsDown (KEY_LEFT))) *accelerate;
		speedY += (Utils.boolToInt (Keys.keyIsDown (KEY_DOWN)) - Utils.boolToInt (Keys.keyIsDown (KEY_UP))) * accelerate;

		if (x + speedX < 0)
			speedX = Utils.rAbs( speedX );
		if (x + speedX >= foregroundLayer.width () - Def.STAGE_W)
			speedX = -Utils.rAbs( speedX );
		if (y + speedY < 0)
			speedY = Utils.rAbs( speedY );
		if (y + speedY >= foregroundLayer.height () - Def.STAGE_H)
			speedY = -Utils.rAbs( speedY );		
		
		x += speedX;
		y += speedY;
		
		plX = Std.int(x)+plXscreen;
		plY = Std.int(y)+plYscreen;
		
//	level.Layers[2].layer.changeScale(1.0+Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT))*0.1, 1.0);
		//level.Layers[2].layer.changeScale(speedX, 1.0);
		
		//colortransform = new ColorTransform(1, 1, 1, plX/10, 0, 0, 0, 0);
	/*	if (plX < 10) 
			level.Layers[2].layer.setColorTransform(ct100);
		else
			level.Layers[2].layer.setColorTransform(ct50);
*/
		//delete colortransform;
	//	player.changeScale( x / 21);
		player.draw();
		
		var i:Int = 0;
		
		for (d in level.Layers)
		{
//			d.layer.changeScale(1.0+Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT))*0.1, 1.0);
//			d.layer.changeScale( Utils.rAbs (speedX*(i+1)/6)+0.2, Utils.rAbs(speedY*(i+1)/6)+0.2);

			d.layer.update ();
			d.layer.moveTo (x * d.xscroll, y * d.yscroll);
			d.layer.draw ();
			++i;
		}
		//trace("oo");
		//playertiles.drawTile(surface, 0, 0, 7, 0);
		//plX += Std.int ((Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT)) - Utils.boolToInt (Keys.keyIsDown (KEY_LEFT)))) * 4;
		//plY += Std.int ((Utils.boolToInt (Keys.keyIsDown (KEY_DOWN)) - Utils.boolToInt (Keys.keyIsDown (KEY_UP)))) * 4;

		player.update();
		//player.moveTo(plX, plY);
		//player.changeDepth(plX);
		//ha atlep egy 
/*		if (Utils.iAbs(speedz) < 0.2 && true )
		{
			var curTile = level.Layers[2].layer.getCurTile(Utils.safeDiv (plX, 48), Utils.safeDiv (plY, 48));
			
			//nekem a kod fog kelleni curtile >> 8
			//player.draw();
		}*/
		dbg.update();
		dbg.draw(level.Layers[2].layer.getCurTile(Utils.safeDiv (plX,48), Utils.safeDiv (plY,48)));
		//dbg.draw(level.Layers[2].layer.mapScreenTiles[Utils.safeDiv (plY, 48)][ Utils.safeDiv (plX, 48)]);
		//dbg.draw(level.Layers[2].layer.getCurTile(Utils.safeDiv(plX,48),0));
		
	}
	
	
	function onKeyDown (event: KeyboardEvent)
	{
		var repeat: Bool = Keys.keyIsDown (event.keyCode);
		if (! repeat)
			Keys.setKeyStatus (event.keyCode, true);
	}
	
	
	function onKeyUp (event: KeyboardEvent)
	{
		Keys.setKeyStatus (event.keyCode, false);
	}
	
}