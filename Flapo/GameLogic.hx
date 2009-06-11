/**
 * ...
 * @author Bence Dobos
 */
//"$(ToolsDir)\swfmill\swfmill.exe" simple Res.xml Res.swf
//-swf-lib Res.swf -D debug -D fdb
package flapo;


//APIs
#if MochiBot
import apis.mochi.MochiBot;
#end

#if Kongregate
import apis.kongregate.CKongregate;
#end

#if ModPlayer
import modplay.ModPlayer;
#end



import flash.display.MovieClip;
import flash.filters.GlowFilter;
import flash.geom.ColorTransform;
import flash.text.TextFormat;
import gamelib2d.Def;
import gamelib2d.TileSetData;
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

import flapo.Player;
import flapo.Effect;
import flapo.RGBA;
import ScrollSnd;

//String
import flash.events.MouseEvent;
//import flash.events.Event;
import flash.text.TextField;
import flash.text.AntiAliasType;
/*
class Winback extends BitmapData
{
	public function new()
	{
		super(0,0);
	}
}*/

class GameLogic extends Sprite
{

#if ModPlayer
	static var mp: ModPlayer;
	static var mpprg: Int;
#end
	
#if Kongregate
	static var kg: CKongregate;
#end
	//static var lc : Main_loadConnector;
	
	static var screen: Sprite;
	static var frame: Int = -1;
	
	static var backgroundTiles: TileSet;
	static var backgroundLayer: Layer;
	
	static var foregroundTiles: TileSet;
	static var foregroundLayer: Layer;
	static var foregroundLayer2: Layer;
	static var level: Level;
	static var levelwinlose: Level;
	static var levelcontainer: LevelContainer;

	static var winloseX: Float = 0;
	static var winloseY: Float = 0;
	
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
		var mcText: Sprite;
        var szoveg:TextField;

        // the font to use for the letters
        var defaultFont:String;
		var tfZene: TextField;
		var tfBlocks: TextField;
		var tsBlocks: TextFormat;
		var tfMessage: TextField;
		var tfMessage2: TextField;
		static var msg2Timeout : Int = 0;
		var tfInfo: TextField;
		
		public static var allBlocks: Int;
		public static var curBlocks: Int;
		public static var mode: Int;
		
		public static var levelnum: Int = 0;
		public static var infomode: Bool = false;
		public static var infowin: Sprite;
		var tfInfowin: TextField;
		var tsInfowin: TextFormat;
		var tfInfowinWinner: TextField;
		var tsInfowinWinner: TextFormat;

		public static var playerColor: Int; //0 - white
		public static var playerColorTransform: ColorTransform;
		public static var playerColors: Array<RGBA>;
		
	public function new ()
	{
		super();
		// new should not use the stage
		screen = this;
		screen = new Sprite ();
		screen.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
//	private function doComplete()
//	{
//		flash.external.ExternalInterface.call("s = function(){document.getElementById('"+this.id+"').focus(); }");
//	}		

	function textInit()
	{
		mcText = screen;
		//Strings
		defaultFont="Times New Roman";
		//decompose_string("Anne-Laure & Fabrice");
		//apply_animation();
		var ts = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 12;
		ts.color = 0xaaaaff;
		szoveg = new flash.text.TextField();
		szoveg.height = 40;
		szoveg.appendText("dobosbence.extra.hu");
		//szoveg.appendText(" Click");
		szoveg.setTextFormat(ts);
		szoveg.x = Def.STAGE_W - 100;
		szoveg.y = Def.STAGE_H - 15;
		szoveg.filters = [
			new GlowFilter(0x6666ff, 0.5, 2, 2, 2, 3, false, false)
		];
		szoveg.addEventListener(MouseEvent.MOUSE_OVER,this.highlightFab);
		szoveg.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightFab);
		szoveg.addEventListener(flash.events.MouseEvent.CLICK,this.goToAnne);
		mcText.addChild(szoveg);
		
		ts = new flash.text.TextFormat();
		ts.font = defaultFont;
		ts.size = 30;
		ts.color = 0xaaaaff;
		tfZene = new TextField();
		tfZene.height = 40;
		tfZene.appendText("Music");
		tfZene.setTextFormat(ts);
		tfZene.x = Def.STAGE_W - 80;
		tfZene.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		tfZene.addEventListener(MouseEvent.MOUSE_OVER,this.highlightZene);
		tfZene.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightZene);
		tfZene.addEventListener(flash.events.MouseEvent.CLICK, this.togleZene);
		mcText.addChild(tfZene);

		ts = new flash.text.TextFormat();
		ts.font = defaultFont;
		ts.size = 30;
		ts.color = 0xaaaaff;
		tfInfo = new TextField();
		tfInfo.height = 40;
		tfInfo.appendText("Info");
		tfInfo.setTextFormat(ts);
		tfInfo.x = 0;
		tfInfo.y = Def.STAGE_H - 40;
		tfInfo.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		tfInfo.addEventListener(MouseEvent.MOUSE_OVER,this.highlightInfo);
		tfInfo.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightInfo);
		tfInfo.addEventListener(flash.events.MouseEvent.CLICK, this.togleInfo);
		mcText.addChild(tfInfo);		
		
		tsBlocks = new flash.text.TextFormat();
		tsBlocks.font=defaultFont;
		tsBlocks.size = 30;
		tsBlocks.color = 0xaaaaff;
		tfBlocks = new TextField();
		tfBlocks.height = 40;
		tfBlocks.appendText("n/a");
		tfBlocks.setTextFormat(tsBlocks);
		tfBlocks.x = Def.STAGE_W / 2 - 50;
		tfBlocks.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		mcText.addChild(tfBlocks);
		
		ts = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 30;
		ts.color = 0xaaaaff;
		tfMessage = new TextField();
		tfMessage.width = 150;
		tfMessage.height = 40;
		tfMessage.appendText("Continue");
		tfMessage.setTextFormat(ts);
		tfMessage.x = Def.STAGE_W / 2 - 50;
		tfMessage.y = Def.STAGE_H / 2 - 20;
		tfMessage.visible = false;
		tfMessage.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		tfMessage.addEventListener(MouseEvent.MOUSE_OVER,this.highlightMessage);
		tfMessage.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightMessage);
		tfMessage.addEventListener(flash.events.MouseEvent.CLICK, this.procMessage);
		mcText.addChild(tfMessage);

		ts = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		ts.color = 0xffffff;
		tfMessage2 = new TextField();
		tfMessage2.width = 400;
		tfMessage2.height = 40;
		tfMessage2.appendText("Destroy all bright tiles before enter the exit tile!");
		tfMessage2.setTextFormat(ts);
		tfMessage2.x = Def.STAGE_W / 2 - 190;
		tfMessage2.y = Def.STAGE_H / 2 - 70;
		tfMessage2.visible = false;
		tfMessage2.filters = [
			new GlowFilter(0xff6666, 1.0, 3, 3, 3, 3, false, false)
		];
		mcText.addChild(tfMessage2);
		
		infowin = new Sprite();
		var o:WinbackInfo = new WinbackInfo();
		var bitmap: Bitmap = o.getBitmap();
		infowin.addChild(bitmap);
		infowin.x = (Def.STAGE_W - o.width) / 2;
		infowin.y = (Def.STAGE_H - o.height) / 2;
		infowin.alpha = 0.7;
		infowin.visible = false;
		infowin.addEventListener(flash.events.MouseEvent.CLICK, this.togleInfowin);
		mcText.addChild(infowin);
		
		tsInfowin = new flash.text.TextFormat();
		tsInfowin.font=defaultFont;
		tsInfowin.size = 17;
		//tsInfowin.color = 0xaaaaff;
		tfInfowin = new TextField();
		tfInfowin.height = 250;
		tfInfowin.width = 250;
		tfInfowin.wordWrap = true;
		tfInfowin.multiline = true;
		tfInfowin.htmlText = "<font color='#FFFFFF'><p align='center'><b>Flapo</b></p></font><br>" +
			"<font color='#aaaaff'>Control the ball trough multilevel mazes. Destroy all bright tiles then enter the exit tile. Use jump pads to access higher levels<br><br>" +
			"Written by <a href='http://dobosbence.extra.hu'><font color='#ccccFF'>Bence Dobos</font></a><br>" +
			"Music by <a href='http://nicenice.net'><font color='#ccccFF'>Nice Nice</font></a><br>" +
			"Idea by Microshark/Damage<br>" +
			"Special thanks to Strato<br>" +
			"<p align='center'>copyright 2009</p></font>";
		//tfInfowin.appendText("n/a");
		tfInfowin.setTextFormat(tsInfowin);
		tfInfowin.x = 25;
		tfInfowin.y = 25;
		tfInfowin.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		infowin.addChild(tfInfowin);
		
		tsInfowinWinner = new flash.text.TextFormat();
		tsInfowinWinner.font=defaultFont;
		tsInfowinWinner.size = 20;
		tsInfowinWinner.color = 0xFFFFFF;
		tfInfowinWinner = new TextField();
		tfInfowinWinner.height = 250;
		tfInfowinWinner.width = 250;
		tfInfowinWinner.wordWrap = true;
		tfInfowinWinner.multiline = true;
		tfInfowinWinner.htmlText = "<p align='center'><b>You win!</b></p><br></center>You beat Flapo! Congratulation! I know the last level was killer, but you did it! Even I completed the last level only once!<br><br><p align='center'>Click to start over again.</p>";
		//tfInfowin.appendText("n/a");
		tfInfowinWinner.setTextFormat(tsInfowinWinner);
		tfInfowinWinner.x = 25;
		tfInfowinWinner.y = 25;
		tfInfowinWinner.visible = false;
		tfInfowinWinner.filters = [
			new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)
		];
		infowin.addChild(tfInfowinWinner);
	}
	
	function removeText()
	{
		if (mcText == null)
			return;
		mcText.removeChild(szoveg);
		mcText.removeChild(tfZene);
		mcText.removeChild(tfBlocks);
		mcText.removeChild(tfMessage);
		mcText.removeChild(tfMessage2);
		mcText.removeChild(tfInfo);
		mcText.removeChild(infowin);
		mcText = null;
	}
	
	function setTextMC(gmc: Sprite)
	{

		mcText = gmc;
		mcText.addChild(szoveg);
		mcText.addChild(tfZene);
		mcText.addChild(tfBlocks);
		mcText.addChild(tfMessage);
		mcText.addChild(tfMessage2);
		mcText.addChild(tfInfo);
		mcText.addChild(infowin);
	}
 
	function firstInit ()
	{
#if MochiBot
		try {
			/*this.createEmptyMovieClip("MochiBot",this.getNextHighestDepth());
			var mySound:Sound = new Sound(mcSounds);
			mySound.attachSound("sndFromLibrary");	*/		
			MochiBot.track(this, "17990a66");
		} catch (e:Dynamic) {
            trace (e);
        }
#end
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
		Keys.init ();
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, onKeyDown);
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_UP, onKeyUp);
		//sound
#if sound		
		ScrollSnd.init();
		ScrollSnd.enabled = true;
		ScrollSnd.play(ScrollSound.NiceNice);
#end
#if ModPlayer
		mp = new ModPlayer();
		mp.play("Test.mod");
		mp.onProgress = function(prg:Int) { setProgress(prg); }
#end
#if Kongregate
		kg = new CKongregate();
#end
		effectsClearTiles = new List<Effect>();
		effectsToRemove = new List<Effect>();
		textInit();
		playerColorTransform = new ColorTransform(1, 1, 1);
		playerColors = new Array<RGBA>();
		playerColors.push(new RGBA(1, 1, 1));
		playerColors.push(new RGBA(1, 0, 0));
		playerColors.push(new RGBA(0, 0, 1));
		playerColors.push(new RGBA(0, 1, 0));
		playerColors.push(new RGBA(1, 1, 0));
		playerColors.push(new RGBA(1, 0, 1));
		playerColors.push(new RGBA(0, 1, 1));
		playerColors.push(new RGBA(0.4, 0.4, 0.4));		
		//trace(playerColors[2]);
	}

	function deInit()
	{
		level.clear();
		level = null;
		levelwinlose.clear();
		levelwinlose = null;
		player.destroy();
		dbg.destroy();
		removeText();
		tfMessage.visible = false;
		tfMessage2.visible = false;
	}
	
	function init ()
	{
		initLevel(levelnum);
		levelwinlose = levelcontainer.getLevel( -1, screen, 1.0, 0);
		for (d in levelwinlose.Layers)
			d.layer.setVisible(false);
		//for (d in level.Layers)
		//	d.layer.setVisible(false);
		plX = 0;
		plY = 0;
		plZ = 0;
		plXscreen = Std.int(Def.STAGE_W/2);
		plYscreen = Std.int(Def.STAGE_H/2);
		//po = Utils.safeMod(plXscreen, level.Layers[level.Layers.length - 1].layer.ts.TileW);
		player = new Player(screen);
		playerColor = 0;
		player.clearEffects();
		player.setColorTransform(playerColorTransform);
		//flash the player for a second (30 frame)
		var rgba: RGBA = new RGBA(1.0, 1.0, 1.0, 0.0);
		player.setColorTransformRGBA(rgba);
		//rgba = new RGBA(2.0, 2.0, 2.0, 0.5);
		//player.changeColorTransform(rgba, 10, 2, 2);
		rgba = new RGBA(1.0, 1.0, 1.0, 1.0);
		player.changeColorTransform(rgba, 20, 11, 2);
		player.moveTo(plXscreen - po, plYscreen - po);
		if (z >= 0 && z < level.Layers.length)
			player.setDepth2(level.Layers[Std.int(z)].playerlayer);

		x -= plXscreen;
		y -= plYscreen;
		var spriteText : Sprite = new Sprite();
		removeText();
		setTextMC( spriteText );
		screen.addChild(spriteText);
		dbg = new Player(screen);
		dbg.moveTo(plXscreen + 60, plYscreen-po);
	} 
    
	public function nextLevel()
	{
		if (mode == 9)
		{
			levelnum++;
			if (levelnum > levelcontainer.maxLevel)
				levelnum = 0;
		}
		mode = 16; //nextlevel
	}
    
	// function to follow the link when clicking on the first zone
	public function goToAnne(e:flash.events.MouseEvent): Void {
			try {
					flash.Lib.getURL(new flash.net.URLRequest("http://dobosbence.extra.hu"),"_top");
			} catch (e:Dynamic) {
					trace (e);
			}
	}

#if ModPlayer
    static function setProgress(prg:Int)
    {
		mpprg = prg;
		trace(prg+"% loaded");
		trace("...............");
    }
#end
	
		
		public function togleZene(e:flash.events.MouseEvent): Void {
		#if sound
			if (ScrollSnd.snd_NiceNicePlaying)
				ScrollSnd.stop(ScrollSound.NiceNice);
			else
				ScrollSnd.play(ScrollSound.NiceNice);
		#end
		#if ModPlayer
			if (mpprg != -1 || mpprg < 100)
				mp.stop();
			else
				mp.play("Test.mod");
		#end
		}
		
		public function togleInfo(e:flash.events.MouseEvent): Void {
			if (infomode)
			{
				infomode = false;
				infowin.visible = false;
				tfInfowin.visible = true;
				tfInfowinWinner.visible = false;
			}
			else
			{
				infomode = true;
				infowin.visible = true;
			}
		}
        
		public function togleInfowin(e:flash.events.MouseEvent): Void {
			if (infomode)
			{
				infomode = false;
				infowin.visible = false;
				tfInfowin.visible = true;
				tfInfowinWinner.visible = false;
			}
			else
			{
				infomode = true;
				infowin.visible = true;
			}
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

        // function to highlight the letters 0 to 9
        public function highlightInfo(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xffffff;
                tfInfo.setTextFormat(ts);
        }
        
        // function to un-highlight the letters 0 to 9
        public function unhighlightInfo(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xaaaaff;
                tfInfo.setTextFormat(ts);
        }		
		
		        // function to highlight the letters 0 to 9
        public function highlightMessage(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xffffff;
                tfMessage.setTextFormat(ts);
        }
        
        // function to un-highlight the letters 0 to 9
        public function unhighlightMessage(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xaaaaff;
                tfMessage.setTextFormat(ts);
        }
	
		public function procMessage(e:MouseEvent) {
					nextLevel();
		}
	
	public function initLevel(levelnum:Int)
	{
		scalefactor = 0.2;
		scaleoffset = 1 - (4 -1) * scalefactor;		
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
				for (i in 0...9)
					allBlocks += d.layer.countMapCode(0x10 + i);
#if Vye
				if (d.isBackground)
					d.layer.setVisible(false);
#end
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
	public static var lastfps: Int;
	
#if debug
#if showfps
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
#end
	
	function calculateFps()
	{
		frame++;
		++realfps;
		//trace( -1);
		if (frame == 0)
		{
			//trace( -2);
			firstInit();
			init ();
		}

		var t: Int = Std.int (Date.now ().getTime () / 1000);
		if (t != lastT)
		{
			lastfps = fps;
			fps = 0;
			lastrealfps = realfps;
			if (lastrealfps > maxfps)
			{
				//trace("..");
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
		if (msg2Timeout > 0)
			{
				--msg2Timeout;
				if (msg2Timeout == 0)
					tfMessage2.visible = false;
			}
	}

	function checkSkipFrame(): Bool
	{
		if (skipframecumulative < 1)
			fps++;
		else
		{
			skipframecumulative--;
			return true;
		}
		skipframecumulative += skipframerate;
		return false;
	}
	
	function slowdownSpeeds()
	{
		if (Utils.rAbs(speedX) < slowdown) speedX = 0;
		else speedX += speedX>0?-slowdown:slowdown;
		if (Utils.rAbs(speedY) < slowdown) speedY = 0;
		else speedY += speedY > 0? -slowdown:slowdown;
		if (Utils.rAbs(speedZ) > slowdownZ)
			speedZ += speedZ>0?-slowdownZ:slowdownZ;		
	}

	function calculateSpeeds()
	{
		speedX += (Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT)) - Utils.boolToInt (Keys.keyIsDown (KEY_LEFT))) * accelerate;
		speedY += (Utils.boolToInt (Keys.keyIsDown (KEY_DOWN)) - Utils.boolToInt (Keys.keyIsDown (KEY_UP))) * accelerate;
	#if debug
		speedZ += -accelerateZ;// + Utils.boolToInt (Keys.keyIsDown (KEY_SPACE)) * accelerateZ * 2;
		if (Keys.keyIsDown (KEY_SPACE))
		{
			player.setColorTransform(playerColorTransform);
		}
	#else
		speedZ += -accelerateZ;
	#end
	}
	
	function checkSpeeds()
	{
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
		if (Utils.rAbs( speedZ ) > maxspeedZ)
			speedZ = speedZ > 0?maxspeedZ: -maxspeedZ;		
	}
	
	function getScale(level: Float)
	{
		return scalefactor * level + scaleoffset;
	}
	
	function calculateNewCoordinates()
	{
		x += speedX;
		y += speedY;
		plX = Std.int(x)+plXscreen;
		plY = Std.int(y)+plYscreen;		
	}
	
	function processLevel()
	{
		var i:Int = 0;
		for (d in level.Layers)
		{
			if (d.layer.getVisible())
			{
				if (level.isBackground(i) == false)
				{
					if (z < i)
						level.Layers[i].setAlpha( 0.5 );
					else
						level.Layers[i].setAlpha( 1.0 );
				}
				d.layer.update ();
				scale = scalefactor * i + scaleoffset;
				d.layer.moveTo ((x*scale - ( Def.STAGE_W/2 * (1 - scale) )), (y*scale - ( Def.STAGE_H/2 * (1 - scale) )));
				d.layer.draw ();
			}
			++i;
		}
		if (mode == 9 || mode == 8)
		{
			for (d in levelwinlose.Layers)
			{
				if (d.layer.getVisible())
				{
					d.layer.update ();
					d.layer.moveTo (winloseX, winloseY);
					d.layer.draw ();
				}
			}
		}
	}
	
	function ProcessEffectsClearTiles()
	{
		for (e in effectsClearTiles)
		{
			e.update();
			if (e.state == 0)
			{
				if (e.numLayer >= 0 && e.numLayer <= level.Layers.length - 1)
				{
					var layer: Layer = level.Layers[e.numLayer].layer;
					var curTile: Int;
					curTile = layer.ts.getAnimationFrame (3, e.timeCounter - e.changeState);
					//curSeq = (tile ^ gamelib2d.Def.TF_SEQUENCE) - 1;
					//t = curSeq;//playertiles.getAnimationFrame (curSeq, timeCounter);

					layer.writeMap(
						Utils.safeMod(e.x, level.Layers[e.numLayer].layer.mapW),
						Utils.safeMod(e.y, level.Layers[e.numLayer].layer.mapH),
						curTile);
				}
			}
			if (e.isEnd())
			{
				if (e.numLayer>=0 && e.numLayer<=level.Layers.length-1)
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
	}
	
	function calculateNewZAndContact(fromlayer: Int, tolayer: Int)
	{
		if ( fromlayer != tolayer )
		{
			var i: Int;
			i = fromlayer;
			var contact: Bool = false;
			var contact2: Bool = false;
			var curTile: Int = 0;
			var curSeq: Int = -1;
			var dist: Float;
			var mapX:Int;
			var mapY:Int;
			var mapX2:Int;
			var mapY2:Int;
			var e: MyLayer;
			//trace("from:" + fromlayer + "to:" + tolayer+" speedZ:"+speedZ);
			while (i != tolayer && i < 10 && i > -2)
			{
				if (level.isBackground(i) == false)
				{
					mapX = Utils.safeDiv (plX, 48);
					mapY = Utils.safeDiv (plY, 48);
					e = level.Layers[i];
					curTile = e.layer.getCurTile(mapX, mapY);
					//trace(i + " " + curTile);
					if (curTile != 0)
					{
						//contact!
						contact = true;
						//trace("contact");
						dist = z - i;
						//if (Utils.rAbs(dist) > Utils.rAbs(speedZ))
							//trace("rossz");
						//visszapattan
						speedZ = speedZ * 0.9;
						if (Utils.rAbs(dist) > Utils.rAbs(speedZ))
							z = speedZ>0?i-0.01:i;
						else if (Utils.rAbs(speedZ +  dist) < 1) //kovetkezo platformra ugrana
							z = i - (speedZ +  dist);
						else
						{
							z = i - (speedZ > 0?0.9: -0.9);
							//trace("nagy!!");
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
			{
				z += speedZ;
				if (z >= 0 && z < level.Layers.length)
					player.setDepth2(level.Layers[Std.int(z)].playerlayer);
			}
			if (contact && z >= 0 && z>=i)
			{
				var curCode: Int;
				mapX = Utils.safeDiv (plX, 48);
				mapY = Utils.safeDiv (plY, 48);
				e = level.Layers[i];
				mapX2 = Utils.safeMod(mapX, e.layer.mapW);
				mapY2 = Utils.safeMod(mapY, e.layer.mapH);
				curCode = e.layer.readBoundMap(mapX, mapY) >> 8;
				//trace("curTile: " + curTile + " curCode: " + curCode);
				if (curTile < 0)
					curSeq = -level.Layers[i].layer.mapData
						[mapY2]
						[mapX2]-1;
				if (curCode >= 0x10 && curCode < 0x20)
				{
					//rombolhato tile
					var c: Int = curCode - 0x10;
					if (c == playerColor)
					{
						//megkeresni
						var found: Effect = null;
						found = findEffectInXYZ(effectsClearTiles,
							mapX2,
							mapY2,
							i);
						if (found == null)
						{
							effect = new Effect(mapX2, mapY2,
								i, 0, 30);
							effect.setState(1, 0, 19);
							effectsClearTiles.add( effect );
							level.Layers[i].layer.writeMap(
								mapX2,
								mapY2,-2); 
							++curBlocks;
							if (curBlocks >= allBlocks)
								mode = 7; //cleared all blocks
						}
					}
				}
				if (curSeq == 4)
				{
					//jump
					speedZ += 1;
				}
				if (curSeq == 0)
				{
					//finish
					if (curBlocks >= allBlocks)
					{
						mode = 9;
					}
					else
						tfMessage2.visible = true;
						msg2Timeout = 60;
				}
				if (curCode >= 0x20 && curCode < 0x30)
				{
					var c: Int = curCode - 0x20;
					//effect here
					trace(c);
					playerColor = c;
					//player.surface.colorTransform(player.surface.rect, playerColorTransform);
					//playerColorTransform.greenMultiplier = c / 5;
	
					//player.setColorTransform(playerColorTransform);
					var rgba: RGBA = playerColors[c];
					player.changeColorTransform(rgba, 40);
				}
				//trace(curCode + " " + curTile);
			}

			//nekem a kod fog kelleni curtile >> 8
			//player.draw();
		}
		else
			z += speedZ;
	}
	
	function onEnterFrame (d: Dynamic)
	{
		//Log.setColor (0xffffff);
		//trace(0);
		calculateFps();
		var a : Bool = Keys.keyIsDown (KEY_SPACE);
		if (tfMessage.visible == true && a)
		{
			nextLevel();
		}
		else
		if (a)
		{
			var mapX: Int;
			var mapY: Int;
			var e: MyLayer;
			var mapX2: Int;
			var mapY2: Int;
			var found: Effect;
			var i: Int = 1;
			mapX = Utils.safeDiv (plX, 48);
			mapY = Utils.safeDiv (plY, 48);
			e = level.Layers[i];
			mapX2 = Utils.safeMod(mapX, e.layer.mapW);
			mapY2 = Utils.safeMod(mapY, e.layer.mapH);
			found = findEffectInXYZ(effectsClearTiles,
				mapX2,
				mapY2,
				i);
			if (found == null)
			{
				effect = new Effect(mapX2, mapY2,
					i, 0, 30);
				effect.setState(1, 0, 19);
				effectsClearTiles.add( effect );
				level.Layers[i].layer.writeMap(
					mapX2,
					mapY2,-2); 
				++curBlocks;
				if (curBlocks >= allBlocks)
					mode = 7; //cleared all blocks
			}
		}
	#if debug
	#if showfps
		showFPS ();
	#end
	#end
	//	if (checkSkipFrame())
	//		return;
		if (mode == 16)
		{
			deInit();
			init();
			mode = 1;
		}
		if (mode < 8)
		{
			calculateSpeeds();
		}
		slowdownSpeeds();		
		checkSpeeds();
//			trace("5");
		scale = getScale(z);
		if (mode == 9 || mode == 8)
		{
			if (player.mcPlayer.alpha == 0)
			{
				//trace (99999999);
				winloseX += maxspeed /3;
				winloseY += maxspeed /3;
			}
			else
			{
				if (player.mcPlayer.alpha <= 0.2)
				{
					player.mcPlayer.alpha = 0;
					if (mode == 8)
						levelwinlose.Layers[1].layer.setVisible(true);
					else
					{
						levelwinlose.Layers[0].layer.setVisible(true);
						if (levelnum >= levelcontainer.maxLevel)
						{
							infowin.visible = true;
							infomode = true;
							tfInfowin.visible = false;
							tfInfowinWinner.visible = true;
						}
					}
					tfMessage.visible = true;
				}
				else
					player.mcPlayer.alpha -= 0.1;
				/*var cx: Int = Utils.safeDiv (plX, 48) * 48 - 24;
				var cy: Int = Utils.safeDiv (plY, 48) * 48 - 24;
				if (cx - plX != 0)
					speedX += 0.5 * ((cx - plX) > 0?-1: 1);
				if (cy - plY != 0)
					speedY += 0.5 * ((cy - plY) > 0?-1: 1);	*/			
			}
		}
		calculateNewCoordinates();
		
		//var i:Int = 0;

		processLevel();
		//trace("oo");

		ProcessEffectsClearTiles();

		//trace("ooo");
		//Utils.gc(); //garbage collector
		player.update();
		player.draw();
	
		var fromlayer: Int = Std.int( z );
		var tolayer: Int = Std.int( z + speedZ );
		if (speedZ > 0)
		{
			//jump
			++fromlayer;
			//trace(fromlayer);
			++tolayer;
		}
		if (z < 0)
			--fromlayer;
		if (z + speedZ < 0)
			--tolayer;
		calculateNewZAndContact(fromlayer, tolayer);
		if (z < 1 && (mode != 9 && mode != 8))
		{
			//trace(1111);
			player.changeAlpha((1 + z) / 2);
			//if (mode != 9 && mode != 8)
			{
				mode = 8; //fallen
				//initLevel( -2);
				//levelwinlose.Layers[0].layer.setVisible(true);
			}
		}
		else if (mode != 9 && mode != 8)
		{
			player.changeAlpha(1.0);
		}
		if (z < -2)
			z = -2;

		var i:Int;
		i = Std.int(z);
		/*dbg.update();

		if (i >= 0 && i <= level.Layers.length - 1)
			dbg.draw(level.Layers[i].layer.getCurTile(Utils.safeDiv (plX,48), Utils.safeDiv (plY,48)));
		else
			dbg.draw(0);*/
		if (z >= -2)
		{
			scale = scalefactor * z + scaleoffset;
			player.changeScale(scale);
			if (i >= 0)
				player.moveTo(plXscreen - po * scale, plYscreen - po * scale);
		}

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