/**
 * ...
 * @author Bence Dobos
 */

package flapo;

// add the folder containing gamelib2d to the projects classpaths
import flash.display.MovieClip;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.text.TextFormat;
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
import flapo.Effect;
import ScrollSnd;

//String
import flash.events.MouseEvent;
//import flash.events.Event;
import flash.text.TextField;
import flash.text.AntiAliasType;

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
	static var speedX: Float = 0;
	static var speedY: Float = 0;
	static var speedZ: Float = 0;
	
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
	public inline static var maxspeed = 6;

	public inline static var accelerateZ  =  0.1;
	public inline static var slowdownZ  =  0.07;
	public inline static var maxspeedZ = 1.0;

	var scale: Float;
	var scalefactor: Float;
	var scaleoffset: Float;
	static var po: Int = 21;
	public var effect: Effect;

	//effects
	public var effectsClearTiles: List<Effect>;
	public var effectsToRemove: List<Effect>;

	//String
        var szoveg:TextField;

        // the font to use for the letters
        var defaultFont:String;
		var tfZene: TextField;
		var tfBlocks: TextField;
		var tsBlocks: TextFormat;
		
		public static var allBlocks: Int;
		public static var curBlocks: Int;
		public static var mode: Int;
	
	public function new ()
	{
		// new should not use the stage
		screen = new Sprite ();
		screen.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
//	private function doComplete()
//	{
//		flash.external.ExternalInterface.call("s = function(){document.getElementById('"+this.id+"').focus(); }");
//	}		
	
	function init ()
	{
		//doComplete();
		flash.Lib.current.addChild (screen);

		//Def.STAGE_W = 480;
		//Def.STAGE_H = 360;
		Def.STAGE_W = screen.stage.stageWidth;
		Def.STAGE_H = screen.stage.stageHeight;
		screen.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

		levelcontainer = new LevelContainer();

		ct100 = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
		ct50 = new ColorTransform(1, 1, 1, 0.5, 0, 0, 0, 0);


		initLevel(1);
		Keys.init ();
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, onKeyDown);
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_UP, onKeyUp);
		
		player = new Player(screen);

		plX = 0;
		plY = 0;
		plZ = 0;
		plXscreen = Std.int(Def.STAGE_W/2);
		plYscreen = Std.int(Def.STAGE_H/2);
		//po = Utils.safeMod(plXscreen, level.Layers[level.Layers.length - 1].layer.ts.TileW);
		player.moveTo(plXscreen-po, plYscreen-po);
		x -= plXscreen;
		y -= plYscreen;
		dbg = new Player(screen);
		dbg.moveTo(plXscreen + 60, plYscreen-po);
		//sound
		ScrollSnd.init();
		ScrollSnd.enabled = true;
		ScrollSnd.play(ScrollSound.NiceNice);
		effectsClearTiles = new List<Effect>();
		effectsToRemove = new List<Effect>();
		
		//Strings
                defaultFont="Times New Roman";
                //decompose_string("Anne-Laure & Fabrice");
                //apply_animation();
                        szoveg = new flash.text.TextField();
                        var ts = new flash.text.TextFormat();
                        ts.font=defaultFont;
                        ts.size = 12;
                        ts.color = 0xaaaaff;
                        szoveg.appendText("dobosbence.extra.hu");
						//szoveg.appendText(" Click");
                        szoveg.setTextFormat(ts);
						szoveg.x = Def.STAGE_W - 100;
						szoveg.y = Def.STAGE_H - 15;
						szoveg.filters = [
							new GlowFilter(0x6666ff, 0.5, 2, 2, 2, 3, false, false)
						];
						screen.addChild(szoveg);
						
                        ts = new flash.text.TextFormat();
                        ts.font = defaultFont;
                        ts.size = 30;
                        ts.color = 0xaaaaff;
						tfZene = new TextField();
						tfZene.appendText("Zene");
						tfZene.setTextFormat(ts);
						tfZene.x = Def.STAGE_W - 100;
						tfZene.filters = [
							new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
						];
						screen.addChild(tfZene);

                        tsBlocks = new flash.text.TextFormat();
                        tsBlocks.font=defaultFont;
                        tsBlocks.size = 30;
                        tsBlocks.color = 0xaaaaff;
						tfBlocks = new TextField();
						tfBlocks.appendText("n/a");
						tfBlocks.setTextFormat(tsBlocks);
						tfBlocks.x = Def.STAGE_W / 2 - 50;
						tfBlocks.filters = [
							new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
						];
						screen.addChild(tfBlocks);

				// sets the first click zone
                var background:Sprite = new Sprite ();
                background.graphics.beginFill(0xffaaaa);
                background.graphics.drawRect(Def.STAGE_W-100,Def.STAGE_H-15,100,15);
                screen.addChild(background);
                background.alpha=0;
                background.addEventListener(MouseEvent.MOUSE_OVER,this.highlightFab);
                background.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightFab);
                background.addEventListener(flash.events.MouseEvent.CLICK,this.goToAnne);
                background = new Sprite ();
                background.graphics.beginFill(0xffaaaa);
                background.graphics.drawRect(Def.STAGE_W-100,0,100,40);
                screen.addChild(background);
                background.alpha=0;
                background.addEventListener(MouseEvent.MOUSE_OVER,this.highlightZene);
                background.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightZene);
                background.addEventListener(flash.events.MouseEvent.CLICK,this.togleZene);

		}
        
        // function to follow the link when clicking on the first zone
        public function goToAnne(e:flash.events.MouseEvent): Void {
                try {
                        flash.Lib.getURL(new flash.net.URLRequest("http://dobosbence.extra.hu"),"_top");
                } catch (e:Dynamic) {
                        trace (e);
                }
        }

		public function togleZene(e:flash.events.MouseEvent): Void {
			if (ScrollSnd.snd_NiceNicePlaying)
				ScrollSnd.stop(ScrollSound.NiceNice);
			else
				ScrollSnd.play(ScrollSound.NiceNice);
		}
        
        // function to highlight the letters 13 to 19
        public function highlightFab(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 12;
                ts.color=0xffffff;
                var i=0;
                szoveg.setTextFormat(ts);
        }
        // function to un-highlight the letters 13 to 19
        public function unhighlightFab(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 12;
                ts.color=0xaaaaff;
                szoveg.setTextFormat(ts);
        }
        
        // function to highlight the letters 0 to 9
        public function highlightZene(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xffffff;
                tfZene.setTextFormat(ts);
        }
        
        // function to un-highlight the letters 0 to 9
        public function unhighlightZene(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xaaaaff;
                tfZene.setTextFormat(ts);
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
				x = (level.startposx+0.5) * level.Layers[level.startposz].layer.ts.tileW;
				y = (level.startposy+0.5) * level.Layers[level.startposz].layer.ts.tileH;
				z = level.startposz;
			}
			allBlocks = 0;
			curBlocks = 0;
			for (d in level.Layers)
			{
				allBlocks += d.layer.countMapCode(0x10);
			}
		}	
	}

	static var lastrealfps: Int = 0;
	static var realfps: Int = 0;
	static var fps: Int = 0;
	static var lastT: Int = 0;
	static var skipframerate: Float = 0;
	static var skipframecumulative: Float = 0;
	public inline static var maxfps = 27;

#if debug
	public static var lastfps: Int;
	// compile with -D debug to see this
	function showFPS ()
	{
		//if (t != lastT)
		{
			Log.clear ();
#if inverse
			Log.setColor (0x000000);
#else
			Log.setColor (0xffffff);
#end
			trace (lastrealfps + " realfps");
			trace (lastfps + " fps");
			trace (maxfps + " maxfps");
			trace (skipframerate + " skipfps");
			trace (Std.int (flash.system.System.totalMemory / (1024 * 1024) * 10) / 10 + " mb");
			//trace (curBlocks + " / " + allBlocks);
			//if (z>1.9 && z<2.2)
			trace("x:" + Utils.safeDiv (plX, 48) +
				" y:" + Utils.safeDiv (plY, 48) +
				" z:" + z +
				" > " + speedZ
			);
			trace("start x:" + level.startposx +
				" y:" + level.startposy +
				" z:" + level.startposz);
		}
	}
#end
	
	function onEnterFrame (d: Dynamic)
	{
		frame++;
		if (frame == 0)
			init ();
		++realfps;
		var t: Int = Std.int (Date.now ().getTime () / 1000);
		if (t != lastT)
		{
			lastfps = fps;
			fps = 0;
			lastrealfps = realfps;
			if (lastrealfps > maxfps)
			{
				trace("..");
				skipframerate = (realfps - maxfps) / maxfps;
			}
			else
			{
				skipframerate = 0;
			}
			realfps = 0;
			lastT = t;
			//skipframecumulative = 0;
		}
	#if debug
		showFPS ();
	#end
		if (skipframecumulative < 1)
			fps++;
		else
		{
			skipframecumulative--;
			return;
		}
		skipframecumulative += skipframerate;
/*		if (x + speedX < 0 || x + speedX >= foregroundLayer.width () - Def.STAGE_W)
			speedX = -speedX;
		if (y + speedY < 0 || y + speedY >= foregroundLayer.height () - Def.STAGE_H)
			speedY = -speedY;
*/
		//trace("2");
		var foregroundLayer: Layer;
		//foregroundLayer = level.Layers[2].layer;

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
	/*	if (x + speedX < 0)
			speedX = Utils.rAbs( speedX );
		if (x + speedX >= foregroundLayer.width () - Def.STAGE_W)
			speedX = -Utils.rAbs( speedX );
		if (y + speedY < 0)
			speedY = Utils.rAbs( speedY );
		if (y + speedY >= foregroundLayer.height () - Def.STAGE_H)
			speedY = -Utils.rAbs( speedY );		*/
//		trace("4.5");
		if (Utils.rAbs( speedX ) > maxspeed)
			speedX = speedX > 0?maxspeed: -maxspeed;
		if (Utils.rAbs( speedY ) > maxspeed)
			speedY = speedY > 0?maxspeed: -maxspeed;

//			trace("5");
		scale = scalefactor * z + scaleoffset;
		x += speedX;
		y += speedY;
		
		plX = Std.int(x)+plXscreen;
		plY = Std.int(y)+plYscreen;

		player.draw();
		
		var i:Int = 0;
	//	trace("update");
//ct100.redMultiplier = 0.5;
		//trace(scaleoffset);
				//level.Layers[1].colort.redMultiplier = 0.5;
				//ct

		for (d in level.Layers)
		{			
			if (z < i)
				level.Layers[i].setAlpha( 0.5 );
			else
				level.Layers[i].setAlpha( 1.0 );
			d.layer.update ();
			scale = scalefactor * i + scaleoffset;
			//trace(scale);
			d.layer.moveTo ((x - ( Def.STAGE_W/2 * (1 - scale) ))*scale, (y - ( Def.STAGE_W/2 * (1 - scale) ))*scale);
			//d.layer.moveTo (x, y);
			d.layer.draw ();
			++i;
		}
		//trace("oo");

		for (e in effectsClearTiles)
		{
			e.update();
			if (e.timeCounter >= e.length)
			{
				level.Layers[e.numLayer].layer.writeMap(
					Utils.safeMod(e.x, level.Layers[e.numLayer].layer.mapW),
					Utils.safeMod(e.y, level.Layers[e.numLayer].layer.mapH),
					0);
				//effectsClearTiles.remove(e);
				effectsToRemove.add(e);
				//continue;
			}
		}
		for (e in effectsToRemove)
		{
			effectsClearTiles.remove(e);
		}
		effectsToRemove.clear();
		//trace("ooo");
		//Utils.gc(); //garbage collector
		player.update();
		//player.moveTo(plX, plY);
		//player.changeDepth(plX);
#if debug
		speedZ += -accelerateZ + Utils.boolToInt (Keys.keyIsDown (KEY_SPACE)) * accelerateZ * 2;
#else
		speedZ += -accelerateZ;
#end
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
			var contact2: Bool = false;
			var curTile: Int = 0;
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
						if (Utils.rAbs(dist) > Utils.rAbs(speedZ))
							z = speedZ>0?i-0.01:i;
						else if (Utils.rAbs(speedZ +  dist) < 1) //kovetkezo platformra ugrana
							z = i - (speedZ +  dist);
						else
						{
							z = i - (speedZ > 0?0.9: -0.9);
							trace("nagy!!");
						}
						speedZ = - speedZ ;
						if (z > i && z - i < slowdownZ && Utils.rAbs(speedZ) < slowdownZ) 
						{
							speedZ = 0;
							z = i;
							contact2 = true;
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
			if (contact && z >= i)
			{
				var curCode: Int;
				curCode = level.Layers[i].layer.readBoundMap(Utils.safeDiv (plX, 48), Utils.safeDiv (plY, 48)) >> 8;
				//trace("curTile: " + curTile + " curCode: " + curCode);
				if (curCode >= 0x10 && curCode <= 0x60)
				{
					//rombolhato tile
					//megkeresni
					var found: Effect = null;
					found = findEffectInXYZ(effectsClearTiles,
						Utils.safeDiv (plX, 48),
						Utils.safeDiv (plY, 48),
						i);
					if (found == null)
					{
						effect = new Effect(Utils.safeDiv (plX, 48),
							Utils.safeDiv (plY, 48),
							i, 0, 30);
						effect.setState(1, 0, 10);
						effectsClearTiles.add( effect );
						++curBlocks;
						if (curBlocks >= allBlocks)
							mode = 9; //win
					}
				}
				if (curCode == 0x80)
				{
					//jump
					speedZ += 1;
				}
			}

			//nekem a kod fog kelleni curtile >> 8
			//player.draw();
		}
		else
			z += speedZ;
		if (z < 0)
		{
			player.changeAlpha((2 + z) / 2);
			if (mode != 9)
				mode = 8; //fallen
		}
		else if (mode != 9)
		{
			player.changeAlpha(1.0);
		}
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
				player.moveTo(plXscreen - po * scale, plYscreen - po * scale);
		}
		//dbg.draw(level.Layers[2].layer.mapScreenTiles[Utils.safeDiv (plY, 48)][ Utils.safeDiv (plX, 48)]);
		//dbg.draw(level.Layers[2].layer.getCurTile(Utils.safeDiv(plX,48),0));
		tfBlocks.text = Std.string(curBlocks) + "/" + Std.string(allBlocks);
		tfBlocks.setTextFormat(tsBlocks);
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
	
	function findEffectInXYZ(effects: List<Effect>, x: Int, y: Int, z: Int)
	{
		var res : Effect = null;
		for (e in effects)
		{
			if ((e.x == x) && (e.y == y) && (e.numLayer == z))
			{
				res = e;
				return e;
			}	
		}
		return null;
	}
}

/*
map amiben a tile-ok kodjai vannak
egy fv, amimplements a kodot rarakja a tileokra (write code)
de jobb lenne nelkule a tutorial szovegek miatt
*/