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
	static var z: Float = 0;
	static var speedX: Float = 1.0;
	static var speedY: Float = 1.0;
	static var speedZ: Float = 1.0;
	
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
	
	public inline static var accelerate  =  1.8;
	public inline static var slowdown  =  1.3;
	public inline static var maxspeed = 7;

	public inline static var accelerateZ  =  0.1;
	public inline static var slowdownZ  =  0.07;
	public inline static var maxspeedZ = 1.0;

	var scale: Float;
	var scalefactor: Float;
	var scaleoffset: Float;

	
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
		scalefactor = 0.2;
		scaleoffset = 1 - (3 -1) * scalefactor;		
		level = levelcontainer.getLevel(levelnum, screen, scalefactor, scaleoffset);

		if (level != null)
		{
			level.findStartPos();
			if (level.startposz != -1)
			{
				x = level.startposx * level.Layers[level.startposz].layer.ts.tileW;
				y = level.startposy * level.Layers[level.startposz].layer.ts.tileH;
				z = level.Layers.length - 1; //2
			}
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
		//if (t != lastT)
		{
			//Log.clear ();
#if inverse
			Log.setColor (0x000000);
#else
			Log.setColor (0xffffff);
#end
			//trace (fps + " fps");
			//trace (Std.int (flash.system.System.totalMemory / (1024 * 1024) * 10) / 10 + " mb");
			//if (t != lastT)
				fps = 0;
			if (z>1.9 && z<2.2)
			trace("x:" + Utils.safeDiv (plX, 48) +
				" y:" + Utils.safeDiv (plY, 48) +
				" z:" + z +
				" > " + speedZ
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
		//if (Utils.rAbs(speedZ) < slowdownZ) speedZ = 0;
		//else
	
		
	//	trace("4");
		speedX += (Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT)) - Utils.boolToInt (Keys.keyIsDown (KEY_LEFT))) * accelerate;
		speedY += (Utils.boolToInt (Keys.keyIsDown (KEY_DOWN)) - Utils.boolToInt (Keys.keyIsDown (KEY_UP))) * accelerate;
//trace("4.2");
		if (x + speedX < 0)
			speedX = Utils.rAbs( speedX );
		if (x + speedX >= foregroundLayer.width () - Def.STAGE_W)
			speedX = -Utils.rAbs( speedX );
		if (y + speedY < 0)
			speedY = Utils.rAbs( speedY );
		if (y + speedY >= foregroundLayer.height () - Def.STAGE_H)
			speedY = -Utils.rAbs( speedY );		
//		trace("4.5");
		if (Utils.rAbs( speedX ) > maxspeed)
			speedX = speedX > 0?maxspeed: -maxspeed;
		if (Utils.rAbs( speedY ) > maxspeed)
			speedY = speedY > 0?maxspeed: -maxspeed;

//			trace("5");
		scale = scalefactor * z + scaleoffset;
		x += speedX * scale;
		y += speedY * scale;
		
		plX = Std.int(x)+plXscreen;
		plY = Std.int(y)+plYscreen;
//		trace("6");
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
	//	trace("update");

		//trace(scaleoffset);
		for (d in level.Layers)
		{
//			d.layer.changeScale(1.0+Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT))*0.1, 1.0);
//			d.layer.changeScale( Utils.rAbs (speedX*(i+1)/6)+0.2, Utils.rAbs(speedY*(i+1)/6)+0.2);
			//d.layer.changeScale(1.0, 1.0);
			d.layer.update ();
			scale = scalefactor * i + scaleoffset;
			trace(scale);
			d.layer.moveTo ((x - ( Def.STAGE_W/2 * (1 - scale) ))*scale, (y - ( Def.STAGE_W/2 * (1 - scale) ))*scale);
			//d.layer.moveTo (x, y);
			d.layer.draw ();
			++i;
		}
		//trace("oo");
		//playertiles.drawTile(surface, 0, 0, 7, 0);

		player.update();
		//player.moveTo(plX, plY);
		//player.changeDepth(plX);
		speedZ += -accelerateZ + Utils.boolToInt (Keys.keyIsDown (KEY_SPACE))*accelerateZ*2;
		if (Utils.rAbs(speedZ) > slowdownZ)
			speedZ += speedZ>0?-slowdownZ:slowdownZ;
		if (Utils.rAbs( speedZ ) > maxspeedZ)
			speedZ = speedZ > 0?maxspeedZ: -maxspeedZ;		

			var fromlayer: Int;
			var tolayer: Int;
			if (speedZ > 0)
			{
				//jump
				fromlayer = Std.int( z ) + 1;
				//trace(fromlayer);
				tolayer = Std.int( z + speedZ ) + 1;
			}
			else
			{
				//fall
				fromlayer = Std.int( z );
				tolayer = Std.int( z + speedZ );
			}
			if (z < 0)
				--fromlayer;
			if (z + speedZ < 0)
				--tolayer;

		if ( fromlayer != tolayer )
		{
			i = fromlayer;
			var contact: Bool = false;
			var curTile: Int;
			var dist: Float;
			//trace("from:" + fromlayer + "to:" + tolayer+" speedZ:"+speedZ);
			while (i != tolayer && i < 10 && i > -2)
			{
				if (i >= 1 && i <= level.Layers.length - 1)
				{

					curTile = level.Layers[i].layer.getCurTile(Utils.safeDiv (plX, 48), Utils.safeDiv (plY, 48));
					//trace(i + " " + curTile);
					if (curTile != 0)
					{
						//contact!
						contact = true;
						//trace("contact");
						dist = z - i;
						if (Utils.rAbs(dist) > Utils.rAbs(speedZ))
							trace("rossz");
						//visszapattan
						speedZ = speedZ * 0.9;
						if (Utils.rAbs(speedZ +  dist) < 1) //kovetkezo platformra ugrana
							z = i - (speedZ +  dist);
						else
						{
							z = i - (speedZ > 0?0.9: -0.9);
							trace("nagy!!");
						}
						speedZ = - speedZ;
						if (z > i && z - i < slowdownZ && Utils.rAbs(speedZ) < slowdownZ) 
						{
							speedZ = 0;
							z = i;
						}
						//z = platform szintje - maradek mozgas (speed - dist)
						break;
					}
				}
				if (speedZ > 0)
					++i;
				else
					--i;
			}
			//kulonben z+=speedZ
			if (contact == false)
				z += speedZ;
			//nekem a kod fog kelleni curtile >> 8
			//player.draw();
		}
		else
			z += speedZ;
		if (z < -2)
			z = -2;
		//if (i<=-2 || i>=10)
			//trace("dbg");

		dbg.update();
		var i:Int;
		i = Std.int(z);
		if (i >= 0 && i <= level.Layers.length - 1)
			dbg.draw(level.Layers[i].layer.getCurTile(Utils.safeDiv (plX,48), Utils.safeDiv (plY,48)));
		else
			dbg.draw(0);
		if (z >= -2)
		{
			scale = scalefactor * z + scaleoffset;
			player.changeScale(scale);
			if (i >= 0)
				player.moveTo(plXscreen - 21 * scale, plYscreen - 21 * scale);
		}
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

/*
map amiben a tile-ok kodjai vannak
egy fv, amimplements a kodot rarakja a tileokra (write code)
de jobb lenne nelkule a tutorial szovegek miatt
*/