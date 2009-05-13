﻿/**
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
import flash.display.Bitmap;
import flash.display.BitmapData;
//import com.blitzagency.Main_loadConnector;
//import com.blitzagency.xray.logger.XrayLog;
import BlocksInfo;

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

	//player
	public var surface: BitmapData;
	#if flash9
		private var mcContainer: Sprite;
		private var mcPlayer: Sprite;
	#elseif flash8
		private var mcContainer: MovieClip;
		private var mcPlayer: MovieClip;
	#end
	public var surfPlayer: BitmapData;
	public var playertiles: TileSet;
	public var plX: Int;
	public var plY: Int;
	
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
		/*
		backgroundTiles = new TileSet (screen);
		backgroundTiles.init (new BackgroundInfo ());  // BackgroundInfo.hx is generated by Tile Studio
		backgroundLayer = new Layer (screen);
		backgroundLayer.init (backgroundTiles, new BackgroundMap1Info (), false, 1.0, 1.0, mrp_tile, mrp_tile, true, true);

		foregroundTiles = new TileSet (screen);
		foregroundTiles.init (new BlocksInfo ());		
		
		foregroundLayer2 = new Layer (screen);
		foregroundLayer2.init (foregroundTiles, new BlocksBlocks2Info (), true, 0.9, 0.9, mrp_tile, mrp_tile, true, true );
		var colortransform : ColorTransform;
		colortransform = new ColorTransform(0.6, 0.6, 0.6, 1, 0, 0, 0, 0);
		foregroundLayer2.setColorTransform(colortransform);
		
		foregroundLayer = new Layer (screen);
		foregroundLayer.init (foregroundTiles, new BlocksMap1Info (), true, 1.0, 1.0, mrp_tile, mrp_tile, true, true);
		//delete colortransform;
		//colortransform = new ColorTransform(1, 1, 1, 0.6, 0, 0, 0, 0);
		//foregroundLayer.setColorTransform(colortransform);
		//flash.Lib.current.stage.addEventListener (MouseEvent.CLICK, onClick);
	    */
		initLevel(0);
		Keys.init ();
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, onKeyDown);
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_UP, onKeyUp);
		//player init
		playertiles = new TileSet (screen);
		playertiles.init (new BlocksInfo ());
		mcContainer = screen;
		surface = new BitmapData (100, 100, true, 0x0);

		#if flash9
			mcPlayer = new Sprite ();
			mcPlayer.addChild (new Bitmap (surface));
			mcContainer.addChild (mcPlayer);
		#elseif flash8
			var Depth = flash.Lib._root.getNextHighestDepth ();
			mcplayer = mcContainer.createEmptyMovieClip ("player", 99);
			mcplayer.attachBitmap (surface, 99);
		#end

	}
	
	public function initLevel(levelnum:Int)
	{
		level = levelcontainer.getLevel(levelnum, screen);
		if (level != null)
		{
			//for (leveldata.
		}
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
		foregroundLayer = level.Layers[0].layer;
		//trace("3");
		if (x + speedX < 0 || x + speedX >= foregroundLayer.width () - Def.STAGE_W)
			speedX = -speedX;
		if (y + speedY < 0 || y + speedY >= foregroundLayer.height () - Def.STAGE_H)
			speedY = -speedY;
		//trace("4");
		speedX += (Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT)) - Utils.boolToInt (Keys.keyIsDown (KEY_LEFT))) / 4;
		speedY += (Utils.boolToInt (Keys.keyIsDown (KEY_DOWN)) - Utils.boolToInt (Keys.keyIsDown (KEY_UP))) / 4;
			
		//x += speedX;
		//y += speedY;
/*
		backgroundLayer.update ();
		foregroundLayer.update ();
		foregroundLayer2.update ();
		backgroundLayer.moveTo (x / 2, y / 2);
		foregroundLayer.moveTo (x, y);
		foregroundLayer2.moveTo (x * 2 / 3, y * 2 / 3);
		foregroundLayer2.draw ();
		backgroundLayer.draw ();
		foregroundLayer.draw ();
		*/
//		level.Layers[2].layer.changeScale(1.0+Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT))*0.1, 1.0);
//		level.Layers[2].layer.changeScale(speedX, 1.0);

		for (d in level.Layers)
		{
//			d.layer.changeScale(1.0+Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT))*0.1, 1.0);
			d.layer.update ();
			d.layer.moveTo (x * d.xscroll, y * d.yscroll);
			d.layer.draw ();
		}
		//trace("oo");
		playertiles.drawTile(surface, 0, 0, 7, 0);
		plX += Std.int ((Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT)) - Utils.boolToInt (Keys.keyIsDown (KEY_LEFT))));
		plY += Std.int ((Utils.boolToInt (Keys.keyIsDown (KEY_DOWN)) - Utils.boolToInt (Keys.keyIsDown (KEY_UP))));

		#if flash8
			mcPlayer._x = plX;
			mcPlayer._y = plY;
		#elseif flash9
			mcPlayer.x = plX;
			mcPlayer.y = plY;
//			mcPlayer.scaleX = plX;
//			mcPlayer.scaleY = plY;
		#end
		//trace("ff");
		
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