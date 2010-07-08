/**
 * ...
 * @author Bence Dobos
 */
//"$(ToolsDir)\swfmill\swfmill.exe" simple Res.xml Res.swf
//"$(ToolsDir)\swfmill\swfmill2\swfmill.exe" simple Res.xml Res.swf
//-swf-lib Res.swf -D debug -D ModPlayer -D MochiBot -D Kongregate -D showfps -D MonsterDebugger
//-swf-lib Res.swf -D debug -D fdb
//-swf-lib Res.swf -D debug -D ModPlayer -D sound -D MochiBot -D Kongregate -D MochiScores
//-swf-lib ResSameHaxe.swf --no-traces -D sound -D mp3Music -D MochiBot -D MochiScores -D Logo
//-D Kongregate
//-D MindJolt (de akkor nem kell MochiScores)

package flapo;

//APIs
#if MochiBot
import apis.mochi.MochiBot;
import flash.text.Font;
import flash.utils.Dictionary;
#end

#if MochiScores
import mochi.haxe.MochiScores;
#end

#if MochiScores2
import mochi.as3.MochiScores;
#end

#if MindJolt
import apis.mindjolt.MindJolt;
#end

import flapo.Score;

#if Kongregate
import apis.kongregate.CKongregate;
#end

#if ModPlayer
import modplay.ModPlayer;
import ModMusicData;
#end

#if MonsterDebugger
import nl.demonsters.debugger.MonsterDebugger;
#end

import flapo.LevelSelector;

import flash.filters.BlurFilter;
import flash.filters.GlowFilter;

import flapo.Savegame;
import flash.display.MovieClip;
import flash.geom.ColorTransform;
import flash.text.TextFormat;
import flapo.Dict;
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
#if sound
import ScrollSnd;
#end

//String
import flash.events.MouseEvent;
//import flash.events.Event;
import flash.text.TextField;
import flash.text.AntiAliasType;
import flapo.RotatedBall;
import flapo.TextObj;
import flapo.SiteLock;
/*
class Winback extends BitmapData
{
	public function new()
	{
		super(0,0);
	}
}*/
class ArialNarrow extends flash.text.Font { }
class ArialNarrowBold extends flash.text.Font { }


class GameLogic extends MovieClip //Sprite
{

#if ModPlayer
	static var mp: ModPlayer;
	static var mpprg: Int = 0;
	static var mpPlay: Bool = false;
#end
	
#if Kongregate
	static var kg: CKongregate;
#end

#if MindJolt
	static var mj: MindJolt;
#end

#if MonsterDebugger
		// Variable to hold the debugger
		// This is needed to explore your live application
		private var debugger:MonsterDebugger;
#end
	//static var lc : Main_loadConnector;
	public var testobj: Dynamic;
	static var dict: Dict;
	static var screen: Sprite;
	static var frame: Int = -1;
	
	static var backgroundTiles: TileSet;
	static var backgroundLayer: Layer;
	
	static var foregroundTiles: TileSet;
	static var foregroundLayer: Layer;
	static var foregroundLayer2: Layer;
	static var level: Level;
	//static var levelwinlose: Level;
	static var levelcontainer: LevelContainer;

	//static var winloseX: Float = 0;
	//static var winloseY: Float = 0;
	
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
	public static inline var KEY_ENTER  =  flash.ui.Keyboard.ENTER;
	public static inline var KEY_T  	=  84;
	public static inline var KEY_S  	=  83;
	public static inline var KEY_L  	=  76;
	public static inline var KEY_N		=  78;

	public var KeyTrepeat: Bool;
	public var KeyNrepeat: Bool;
	
	public var playerTileSet: TileSet;
	public var player: Player;
	//public var dbg: Player;
	public var plX: Int;
	public var plY: Int;
	public var plZ: Int;
	public var plXscreen: Int;
	public var plYscreen: Int;
	
	var slowdownMult: Float;
	var slowdownZMult: Float;
	var accelerateMult: Float;

	public inline static var accelerate  =  1.5;//1.8;
	public inline static var slowdown  =  0.5;//
	public inline static var maxspeed = 6;

	public inline static var accelerateZ  =  0.08;//0.11;
	public inline static var slowdownZ  =  0.05;//0.08;
	public inline static var maxspeedZ = 0.8;// 1.0;

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
		var texts: Array<TextObj>;

        // the font to use for the letters
        var defaultFont:String;
		var tfZene: TextField;
		var tfBlocks: TextField;
		var tsBlocks: TextFormat;
		var tfMessage: TextField;
		var tfMessage2: TextField;
		var tfBack: TextField;
		static var msg2Timeout : Int = 0;
		var tfInfo: TextField;
		
		public static var allBlocks: Int;
		public static var curBlocks: Int;
		public static var mode: Int;
		
		public static var levelnum: Int = 15;
		public static var infomode: Int = 0;
		public static var infowin: Sprite;
		var tfInfowin: TextField;
		var tsInfowin: TextFormat;
		var tfInfowinWinner: TextField;
		var tsInfowinWinner: TextFormat;
		public static var flag_hu: Sprite;
		public static var flag_en: Sprite;
		public static var background: Sprite;

		public static var levelSelector: LevelSelector;
		public static var islevelSelector: Bool;
		public static var textLevelSelector: Array<TextObj>;
		
		public static var playerColor: Int; //0 - white
		public static var playerColorTransform: ColorTransform;
		public static var playerColors: Array<RGBA>;
		
		public var balltexture: Int;
		
		public var savegame: Savegame;
		
		public var LevelStarted: Bool;
		public var timeStartLevel: Int;
		public var timeEndLevel: Int;
		
		public var MochiScoresStatus: Int;
		
		public var globalscale: Float;
		
		var levelTime: Int;
		var bestTime: Int;
		static var medalTimes = { gold: -1, silver: -1, bronze: -1 };
		static var moreTexturesUnlocked: Bool;
		
	public function new (back: Sprite)
	{
		super();
		testobj = null;
		// new should not use the stage
#if Kongregate
		kg = new CKongregate(null);
#end
#if MindJolt
		//mj = new MindJolt(null);
#end
		screen = this;
		screen = new Sprite ();
		//screen = new MovieClip();
		background = back;
		screen.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function setParent(gt: Dynamic)
	{
		trace("setparent");
		testobj = gt;
#if Kongregate
		if (kg==null || kg.loaded==false || kg.type<2)
			kg = new CKongregate(testobj);
#end		
#if MindJolt
		if (mj==null || mj.loaded==false || mj.type<2)
			mj = new MindJolt(testobj);
#end
	}
	
//	private function doComplete()
//	{
//		flash.external.ExternalInterface.call("s = function(){document.getElementById('"+this.id+"').focus(); }");
//	}		

    private function buildAscii( s_:String ):String
    {
        var ascii:  String  = '';
        var i:      Int     = 0;
        while( i < s_.length )
        {
            ascii += '&#' + s_.charCodeAt( i ) + ';'; 
            i++;   
        }
        return ascii;
    }

	function textInit()
	{
		mcText = screen;

		//Strings
		//defaultFont = "Times New Roman";
		//defaultFont="Arial Narrow Bold";
		defaultFont = "ArialNarrowBold";
	
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font = defaultFont;
		ts.size = 30;
		ts.color = 0xaaaaff;
		tfZene = new TextField();
		tfZene.selectable = false;
		tfZene.height = 40;
		tfZene.width = 200;
		tfZene.appendText(dict.get(1));
		tfZene.setTextFormat(ts);
		tfZene.embedFonts = true;
		tfZene.x = 80;
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
		tfInfo.selectable = false;
		tfInfo.embedFonts = true;
		tfInfo.height = 40;
		tfInfo.width = 70;
		tfInfo.appendText(dict.get(2));
		tfInfo.setTextFormat(ts);
		tfInfo.x = 0;
		tfInfo.y = 0;//Def.STAGE_H - 40;
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
		tfBlocks.selectable = false;
		tfBlocks.embedFonts = true;
		tfBlocks.height = 40;
		tfBlocks.width = 250;
		tfBlocks.appendText("");
		tfBlocks.setTextFormat(tsBlocks);
		tfBlocks.x = Def.STAGE_W / 2 - 70;
		tfBlocks.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		mcText.addChild(tfBlocks);
		
		szoveg = new flash.text.TextField();
		szoveg.selectable = false;
		szoveg.embedFonts = true;
		szoveg.width = 200;
		szoveg.height = 40;
		szoveg.htmlText = dict.get(22);
		szoveg.setTextFormat(ts);
		szoveg.x = Def.STAGE_W - 200;
		szoveg.y = 0;
		szoveg.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		szoveg.addEventListener(MouseEvent.MOUSE_OVER,this.highlightFab);
		szoveg.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightFab);
		szoveg.addEventListener(flash.events.MouseEvent.CLICK,this.goToAnne);
		mcText.addChild(szoveg);
		
		ts = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 30;
		ts.color = 0xaaaaff;
		tfMessage = new TextField();
		tfMessage.selectable = false;
		tfMessage.embedFonts = true;
		tfMessage.width = 150;
		tfMessage.height = 40;
		tfMessage.appendText(dict.get(3));
		tfMessage.setTextFormat(ts);
		tfMessage.x = Def.STAGE_W / 2 - 150;
		tfMessage.y = Def.STAGE_H / 2 - 20;
		tfMessage.visible = false;
		tfMessage.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		tfMessage.addEventListener(MouseEvent.MOUSE_OVER,this.highlightMessage);
		tfMessage.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightMessage);
		tfMessage.addEventListener(flash.events.MouseEvent.CLICK, this.procMessage);
		mcText.addChild(tfMessage);
		
		tfBack = new TextField();
		tfBack.selectable = false;
		tfBack.embedFonts = true;
		tfBack.width = 150;
		tfBack.height = 40;
		tfBack.appendText(dict.get(19));
		tfBack.setTextFormat(ts);
		tfBack.x = Def.STAGE_W / 2 + 50;
		tfBack.y = Def.STAGE_H / 2 - 20;
		tfBack.visible = false;
		tfBack.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		tfBack.addEventListener(MouseEvent.MOUSE_OVER,this.highlightBack);
		tfBack.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightBack);
		tfBack.addEventListener(flash.events.MouseEvent.CLICK, this.procBack);
		mcText.addChild(tfBack);

		ts = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		ts.color = 0xffffff;
		tfMessage2 = new TextField();
		tfMessage2.selectable = false;
		tfMessage2.embedFonts = true;
		tfMessage2.width = 420;
		tfMessage2.height = 40;
		//tfMessage2.appendText("Destroy all round tiles before entering the exit tile!");
		tfMessage2.appendText(dict.get(4));
		tfMessage2.setTextFormat(ts);
		tfMessage2.x = Def.STAGE_W / 2 - 200;
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
		tsInfowin.font = defaultFont;
		tsInfowin.leading = -2;
		tsInfowin.size = 17;
		//tsInfowin.color = 0xaaaaff;
		tfInfowin = new TextField();
		tfInfowin.selectable = false;
		tfInfowin.embedFonts = true;
		tfInfowin.height = 250;
		tfInfowin.width = 250;
		tfInfowin.wordWrap = true;
		tfInfowin.multiline = true;
		tfInfowin.htmlText = dict.get(5);
		tfInfowin.setTextFormat(tsInfowin);
		tfInfowin.x = 25;
		tfInfowin.y = 25;
		tfInfowin.filters = [
			new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false)
		];
		infowin.addChild(tfInfowin);
		
		tsInfowinWinner = new flash.text.TextFormat();
		tsInfowinWinner.font=defaultFont;
		tsInfowinWinner.size = 18;
		tsInfowinWinner.color = 0xFFFFFF;
		tfInfowinWinner = new TextField();
		tfInfowinWinner.selectable = false;
		tfInfowinWinner.embedFonts = true;
		tfInfowinWinner.height = 250;
		tfInfowinWinner.width = 250;
		tfInfowinWinner.wordWrap = true;
		tfInfowinWinner.multiline = true;
		tfInfowinWinner.htmlText = dict.get(6);
		tfInfowinWinner.setTextFormat(tsInfowinWinner);
		tfInfowinWinner.x = 25;
		tfInfowinWinner.y = 25;
		tfInfowinWinner.visible = false;
		tfInfowinWinner.filters = [
			new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)
		];
		infowin.addChild(tfInfowinWinner);
		
		textLevelSelector = new Array<TextObj>();
		var tfClearTable: TextObj = new TextObj(levelSelector.mc, dict, 18,
			Def.STAGE_W - 150, Def.STAGE_H - 30, 150, 100,
			ts, true, [new GlowFilter(0xFF6666, 0.8, 3, 3, 3, 3, false, false)]
		);
		tfClearTable.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.clearTableEvent);
		tfClearTable.tf.addEventListener(MouseEvent.MOUSE_OVER,this.clearTableOver);
		tfClearTable.tf.addEventListener(MouseEvent.MOUSE_OUT,this.clearTableOut);
		textLevelSelector.push(tfClearTable);
#if MindJolt
		ts.color = 0xaaaaff;
		var tfSubmitAllScore: TextObj = new TextObj(levelSelector.mc, dict, 25,
			100, Def.STAGE_H - 30, 150, 100,
			ts, true, [new GlowFilter(0x6666ff, 0.8, 3, 3, 3, 3, false, false)]
		);
		tfSubmitAllScore.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.submitScoreEvent);
		tfSubmitAllScore.tf.addEventListener(MouseEvent.MOUSE_OVER,this.submitScoreOver);
		tfSubmitAllScore.tf.addEventListener(MouseEvent.MOUSE_OUT,this.submitScoreOut);
		textLevelSelector.push(tfSubmitAllScore);
#end		
		
							var ts = new flash.text.TextFormat();
							ts.font=defaultFont;
							ts.size = 20;
							ts.color = 0xFFFFFF;
							var gf:GlowFilter = new GlowFilter(0x6666ff, 1.0, 3, 3, 3, 3, false, false);
							
							texts = new Array<TextObj>();
							var text: TextObj = new TextObj(infowin, dict, 8, 10, 30, 280, 40,
								ts, true, 
								[gf],
								false);
							texts.push(text);
							//high
							var text: TextObj = new TextObj(infowin, dict, 17, 10, 70, 280, 40,
								ts, true, 
								[gf],
								false);
							texts.push(text);
							//medal
							text = new TextObj(infowin, dict, 9,
								10, 110, 280, 30,
								ts, true,
								[gf],
								false); 
							texts.push(text);
						#if !MindJolt
							//send
							ts = new flash.text.TextFormat();
							ts.font=defaultFont;
							ts.size = 20;
							//ts.color = 0x804020;
							text = new TextObj(infowin, dict, 13, 10, 250, 140, 30,
								ts, true,
								[new GlowFilter(0xFFFFFF, 1.0, 3, 3, 3, 3, false, false)],
								false); //no visible
							text.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.submitScoreEvent);
							text.tf.addEventListener(MouseEvent.MOUSE_OVER,this.submitScoreOver);
							text.tf.addEventListener(MouseEvent.MOUSE_OUT,this.submitScoreOut);
							texts.push(text);
							//show
							text = new TextObj(infowin, dict, 14, 150, 250, 140, 30,
								ts, true,
								[new GlowFilter(0xFFFFFF, 1.0, 3, 3, 3, 3, false, false)],
								false); //no visible
							text.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.showScoreEvent);
							text.tf.addEventListener(MouseEvent.MOUSE_OVER,this.showScoreOver);
							text.tf.addEventListener(MouseEvent.MOUSE_OUT,this.showScoreOut);
							texts.push(text);
						#end
							
		flag_en = new Sprite();
		var oEng:Flag_en_Info = new Flag_en_Info();
		var bitmap: Bitmap = oEng.getBitmap();
		flag_en.addChild(bitmap);
		flag_en.x = 5;
		flag_en.y = (Def.STAGE_H) - 20;
		flag_en.addEventListener(flash.events.MouseEvent.CLICK, this.SwitchLangEng);
		mcText.addChild(flag_en);

		flag_hu = new Sprite();
		var oHun:Flag_hu_Info = new Flag_hu_Info();
		var bitmap: Bitmap = oHun.getBitmap();
		flag_hu.addChild(bitmap);
		flag_hu.x = 25;
		flag_hu.y = (Def.STAGE_H) - 20;
		flag_hu.addEventListener(flash.events.MouseEvent.CLICK, this.SwitchLangHun);
		mcText.addChild(flag_hu);
		

	}
	
	function removeText()
	{
		if (mcText == null)
			return;
		mcText.removeChild(tfZene);
		mcText.removeChild(tfBlocks);
		mcText.removeChild(szoveg);
		mcText.removeChild(tfMessage);
		mcText.removeChild(tfBack);
		mcText.removeChild(tfMessage2);
		mcText.removeChild(tfInfo);
		mcText.removeChild(infowin);
		mcText.removeChild(flag_en);
		mcText.removeChild(flag_hu);
		//screen.removeChild(mcText);
		mcText = null;
	}
	
	function setTextMC(gmc: Sprite)
	{

		mcText = gmc;
		mcText.addChild(tfZene);
		mcText.addChild(tfBlocks);
		mcText.addChild(szoveg);
		mcText.addChild(tfMessage);
		mcText.addChild(tfBack);
		mcText.addChild(tfMessage2);
		mcText.addChild(tfInfo);
		mcText.addChild(infowin);
		mcText.addChild(flag_hu);
		mcText.addChild(flag_en);
	}
 
	function firstInit ()
	{		
		nodeinit = false;
		trace("firstinit");
#if MonsterDebugger
		// Init the debugger
		debugger = new MonsterDebugger(this);
		// Send a simple trace
		MonsterDebugger.trace(this, "Hello World!");
#end
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
		MochiScoresStatus = 0;
#if MochiScores
		MochiScoresStatus = 1;
		mochi.haxe.MochiServices.connect("c47c13357bc92452", flash.Lib.current, MochiError);
#end
#if MochiScores2
		mochi.as3.MochiServices.connect("c47c13357bc92452",  flash.Lib.current);
#end
		//doComplete();
		flash.Lib.current.addChild (screen);
		Def.STAGE_W = 550;
		Def.STAGE_H = 400;
		var w:Int = screen.stage.stageWidth;
		var h:Int = screen.stage.stageHeight;
		globalscale = 1;
		if (Def.STAGE_W != w && Def.STAGE_H != h)
		{
			var ratio: Float = h / w;
			globalscale = w / Def.STAGE_W;
			Def.STAGE_H = Std.int(ratio * Def.STAGE_W);
			screen.scaleX = globalscale;
			screen.scaleY = globalscale;
		}

		//screen.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

		var lang = null;
		
		var glang:String = flapo.SiteLock.getBrowserLanguage();
		if (glang != null)
		{
			if (glang == "hu")
				lang = DICT_HUN;
			if (glang == "en")
				lang = DICT_ENG;
		}
		
		var domain:String = flapo.SiteLock.getDomain();
		if (domain != null && lang == null)
		{
			var LastDot:Int = domain.lastIndexOf(".")+1;
			var domEnd:Int = domain.lastIndexOf(".", LastDot)+1;
			var countrycode = domain.substr(LastDot);
			if (countrycode != null)
			{
				if (countrycode == "hu")
					lang = DICT_HUN;
			}
		}

		dict = new Dict(lang);
		/*
		if (SiteLock.check() == false)
		{
			//SiteLock check failed, game is stolen
			mode = -999;
			pleasewait = new Sprite();
			pleasewait.graphics.beginFill(0x00007b);
			pleasewait.graphics.drawRoundRect(Def.STAGE_W / 2 - 200, Def.STAGE_H / 2 - 20, 400, 40, 25, 25);
			pleasewait.graphics.endFill();
			pleasewait.alpha = 0.5;
			defaultFont="ArialNarrowBold";
			var ts: TextFormat = new flash.text.TextFormat();
			ts.font = defaultFont;
			ts.size = 23;
			ts.color = 0x6BECE9;
			var to: TextObj = new TextObj(pleasewait, dict, 21, Def.STAGE_W / 2 - 200, Def.STAGE_H / 2 - 15, 400, 40, ts, true);
			screen.addChild(pleasewait);
			screen.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			return;
		}
		*/	
		levelcontainer = new LevelContainer();
		Keys.init ();
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, onKeyDown);
		flash.Lib.current.stage.addEventListener (KeyboardEvent.KEY_UP, onKeyUp);
		//sound

		effectsClearTiles = new List<Effect>();
		effectsToRemove = new List<Effect>();
		playerTileSet = new TileSet(screen);
		playerTileSet.init (new BallInfo ());
		levelSelector = new LevelSelector(screen, playerTileSet, dict);
		islevelSelector = false;
		levelSelector.hide();
		textInit();
		playerColorTransform = new ColorTransform(1, 1, 1);
		playerColors = new Array<RGBA>();
		playerColors.push(new RGBA(1, 1, 1));
		playerColors.push(new RGBA(1.0, 0.5, 0.5));
		playerColors.push(new RGBA(0.5, 1.0, 0.5));
		playerColors.push(new RGBA(0.5, 0.5, 1.0));
		playerColors.push(new RGBA(1.0, 1.0, 0.5));
		playerColors.push(new RGBA(1.0, 0.5, 1.0));
		playerColors.push(new RGBA(0.5, 1.0, 1.0));
		playerColors.push(new RGBA(0.5, 0.5, 0.5));		
		balltexture = 1;
		moreTexturesUnlocked = false;
		savegame = new Savegame();
#if sound		
		ScrollSnd.init();
		ScrollSnd.enabled = true;
#if mp3Music
		ScrollSnd.play(ScrollSound.Peace);
#end
#end
#if ModPlayer
		mp = new ModPlayer();
	#if MochiScores
	#else
		mp.playBytes(ModMusicData.getByteArray());
	#end
#end
/*
		//blurtest
		var blur:BlurFilter = new BlurFilter(10, 10, 2);
		screen.addEventListener(MouseEvent.MOUSE_MOVE, function(event:flash.events.MouseEvent) {
				// Moving the pointer to the center of the Stage sets the blurX and blurY properties to 0%. 
				blur.blurX = Math.abs(screen.stage.mouseX - (Def.STAGE_W/2)) / Def.STAGE_W * 2 * 100;
				blur.blurY = Math.abs(screen.stage.mouseY - (Def.STAGE_H/2)) / Def.STAGE_H * 2 * 100;
				screen.filters = [blur];
			});
			*/
	}

	function MochiError(errorCode:String):Void
	{
		trace(errorCode);
		MochiScoresStatus = -1;
//		mochi.haxe.MochiServices.connect("c47c13357bc92452", flash.Lib.current, MochiError);
	}
	
	function deInit()
	{
		if (level != null)
		{
			level.clear();
			level = null;
		}
		//levelwinlose.clear();
		//levelwinlose = null;
		player.destroy();
		//dbg.destroy();
		removeText();
		tfMessage.visible = false;
		tfBack.visible = false;
		tfMessage2.visible = false;
		effectsClearTiles.clear();
		for (t in texts)
		{
			t.tf.visible = false;
		}
		infowin.visible = false;
		infomode = 0;
		if (ScrollSnd.channelTicktack != null)
			ScrollSnd.channelTicktack.stop();		
	}
	
	function initLevelSelector()
	{
		trace("initLevelSelector");
		var mc: Sprite = new Sprite();
		mc.addEventListener( MouseEvent.MOUSE_DOWN, levelselectorMouseDown );
		levelSelector.changeMC(mc);
		levelSelector.show();
		islevelSelector = true;
		for (text in textLevelSelector)
		{
			text.setMC(mc);
		}
		var spriteText : Sprite = new Sprite();
		removeText();
		setTextMC( spriteText );
		screen.addChild(spriteText);
		setTextMC( levelSelector.mc);
		tfBlocks.text = "";
		tfBlocks.setTextFormat(tsBlocks);
	}
	
	function deinitLevelSelector()
	{
		trace("deinitLevelSelector");
		levelSelector.hide();
		screen.removeEventListener( MouseEvent.MOUSE_DOWN, levelselectorMouseDown );
		islevelSelector = false;
		for (text in textLevelSelector)
		{
			text.removeMC();
		}
		removeText();
	}
	
	function levelselectorMouseDown(e:flash.events.MouseEvent): Void
	{
		var rv: Int =
			levelSelector.down(Std.int(screen.stage.mouseX*globalscale),
							Std.int(screen.stage.mouseY*globalscale));
		if (rv != -1)
		{
			levelnum = rv;
			trace("selected level: " + rv);
			curBlocks = allBlocks;
			mode = 8;
			nextLevel();
		}
	}
	
	function init ()
	{
		trace(levelnum);
		initLevel(levelnum);
		//levelwinlose = levelcontainer.getLevel( -1, screen, 1.0, 0);
		//for (d in levelwinlose.Layers)
		//	d.layer.setVisible(false);
		//for (d in level.Layers)
		//	d.layer.setVisible(false);
		plX = 0;
		plY = 0;
		plZ = 0;
		speedZ = 0;
		plXscreen = Std.int(Def.STAGE_W/2);
		plYscreen = Std.int(Def.STAGE_H/2);
		//po = Utils.safeMod(plXscreen, level.Layers[level.Layers.length - 1].layer.ts.TileW);
		player = new Player(screen, playerTileSet);
		playerColor = 0;
		player.clearEffects();
		player.setColorTransform(playerColorTransform);
		//flash the player for a second (30 frame)
		var rgba: RGBA = new RGBA(1.0, 1.0, 1.0, 1.0);
		player.setColorTransformRGBA(rgba);
		//rgba = new RGBA(2.0, 2.0, 2.0, 0.5);
		//player.changeColorTransform(rgba, 10, 2, 2);
		rgba = new RGBA(1.0, 1.0, 1.0, 1.0);
		player.changeColorTransform(rgba, 20, 11, 2);
		player.moveTo(plXscreen - po, plYscreen - po);
		player.moveToShadow(plXscreen - po, plYscreen - po);
		//dbg = new Player(screen);
//		dbg.moveTo(plXscreen - po, plYscreen - po);
		//dbg.draw(6);
		//dbg.changeAlpha(0.4);

		if (z >= 0 && z < level.Layers.length)
		{
			player.setDepth2(level.Layers[Std.int(z)].playerlayer);
			player.changeScaleShadow(scalefactor * Std.int(z) + scaleoffset);
			//dbg.setDepth2(level.Layers[Std.int(z)].playerlayer);
		}
		player.drawBall(balltexture);
		x -= plXscreen;
		y -= plYscreen;
		var spriteText : Sprite = new Sprite();
		removeText();
		setTextMC( spriteText );
		screen.addChild(spriteText);
		slowdownMult = 1;
		slowdownZMult = 1;
		accelerateMult = 1;
		timeStartLevel = -1;
		LevelStarted = false;
		//timeStartLevel = Std.int (Date.now().getTime());
		for (t in texts)
		{
			t.tf.visible = false;
		}
		infowin.visible = false;
		infomode = 0;
	} 
    
	public function allTextRenew()
	{
		for (t in texts)
		{
			t.renewText();
		}

		texts[0].setText(dict.get(8) + flapo.Score.convertTime(levelTime, true), true);
		texts[1].setText(dict.get(17) +
			flapo.Score.convertTime(
				levelSelector.players[levelnum].state.score, true),
			true);
		//medal
		texts[2].setText(dict.get(9 + levelSelector.players[levelnum].state.medal),
			true); 		
		
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font = defaultFont;
		ts.size = 30;
		ts.color = 0xaaaaff;
		tfZene.text = dict.get(1);
		tfZene.setTextFormat(ts);

		tfInfo.text = dict.get(2);
		tfInfo.setTextFormat(ts);
		
		szoveg.htmlText = dict.get(22);
		szoveg.setTextFormat(ts);
		if (mode == 108)
			tfMessage.text = dict.get(23);
		else
			tfMessage.text = dict.get(3);
		tfMessage.setTextFormat(ts);

		tfBack.text = dict.get(19);
		tfBack.setTextFormat(ts);
		
		ts = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		ts.color = 0xffffff;
		tfMessage2.text = dict.get(4);
		tfMessage2.setTextFormat(ts);
		
		tfInfowin.htmlText = dict.get(5);
		tfInfowin.setTextFormat(tsInfowin);
		
		tfInfowinWinner.htmlText = dict.get(6);
		tfInfowinWinner.setTextFormat(tsInfowinWinner);
		
		textLevelSelector[0].renewText();
#if MindJolt		
		textLevelSelector[1].renewText();
#end
		levelSelector.initBubbles();
		levelSelector.submitScoreOut(null); //renew text: submit
		levelSelector.showScoreOut(null); //renew text: show
	}
	
	public function nextLevel()
	{
		if (mode == 109)
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
					flash.Lib.getURL(new flash.net.URLRequest("http://internetjatek.hu"),"_blank");
			} catch (e:Dynamic) {
					trace (e);
			}
	}

#if ModPlayer
    static function setProgress(prg:Int)
    {
		mpprg = prg;
		//if (mpprg == 100)
		//	mpPlay = true;
		trace(prg+"% loaded");
	//	trace("...............");
    }
#end

		public function SwitchLangEng(e:flash.events.MouseEvent): Void {
			dict.change(DICT_ENG);
			allTextRenew();
		}


		public function SwitchLangHun(e:flash.events.MouseEvent): Void {
			dict.change(DICT_HUN);
			allTextRenew();
		}
		
		public function togleZene(e:flash.events.MouseEvent): Void {
		#if sound
		#if mp3Music
			if (ScrollSnd.snd_PeacePlaying)
				ScrollSnd.stop(ScrollSound.Peace);
			else
				ScrollSnd.play(ScrollSound.Peace);
			//ScrollSnd.enabled = !ScrollSnd.enabled;
		#end
		#end
		#if ModPlayer
			if (mpprg == -1)
			{
				//nem sikerult a betoltes
				mp.play("Test.mod");
			}
			else if (mpPlay)
			{
				mp.stop();
				mpPlay = false;
			}
			else
			{
				mp.play("Test.mod");
				mpPlay = true;
			}
		#end
		}
		
		public function togleInfo(e:flash.events.MouseEvent): Void {
			if (infomode == 1)
			{
				infomode = 0;
				infowin.visible = false;
				tfInfowin.visible = true;
				tfInfowinWinner.visible = false;
			}
			else if (infomode == 0)
			{
				infomode = 1;
				infowin.visible = true;
				tfInfowin.visible = true;				
				tfInfowinWinner.visible = false;
				for (t in texts)
				{
					t.tf.visible = false;
				}	
			}
		}
        
		public function togleInfowin(e:flash.events.MouseEvent): Void {
			if (infomode == 2)
			{
				infomode = 3;
				tfInfowinWinner.visible = false;
				for (t in texts)
				{
					t.tf.visible = true;
				}
			}
			else
			if (infomode == 1)
			{
				infomode = 0;
				infowin.visible = false;
				tfInfowin.visible = true;
				tfInfowinWinner.visible = false;
				for (t in texts)
				{
					t.tf.visible = false;
				}				
			}
		}
		
        // function to highlight the letters 13 to 19
        public function highlightFab(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xffffff;
                var i=0;
                szoveg.setTextFormat(ts);
        }
        // function to un-highlight the letters 13 to 19
        public function unhighlightFab(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
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

        public function highlightInfo(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xffffff;
                tfInfo.setTextFormat(ts);
        }
        
        public function unhighlightInfo(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xaaaaff;
                tfInfo.setTextFormat(ts);
        }		
		
        public function highlightMessage(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xffffff;
                tfMessage.setTextFormat(ts);
        }
        
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

        public function highlightBack(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xffffff;
                tfBack.setTextFormat(ts);
        }
        
        public function unhighlightBack(e:MouseEvent) {
                var ts = new flash.text.TextFormat();
                ts.font=defaultFont;
                ts.size = 30;
                ts.color=0xaaaaff;
                tfBack.setTextFormat(ts);
        }		

		public function procBack(e:MouseEvent) {
			mode = -2;
		}		
		
	public function initLevel(levelnum:Int)
	{
		scalefactor = 0.2;
		scaleoffset = 1 - (4 -1) * scalefactor;		
		level = levelcontainer.getLevel(levelnum, screen, scalefactor, scaleoffset);
		speedX = 0;
		speedY = 0;
		speedZ = 0;

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
				for (i in 0...9)
					allBlocks += d.layer.countMapCode(0x50 + i);
#if Vye
				if (d.isBackground)
					d.layer.setVisible(false);
#end
			}
		}
		levelSelector.getMedalTimes(levelnum, medalTimes);
	}

	static var lastrealfps: Int = 0;
	static var realfps: Int = 0;
	static var fps: Int = 0;
	static var lastT: Int = 0;
	static var skipframerate: Float = 0;
	static var skipframecumulative: Float = 0;
	public inline static var maxfps = 27;
	public static var lastfps: Int;
	private var nodeinit: Bool;
	private var pleasewait: Sprite;
	private static var waitingformusicloading: Bool = false;
	
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
			if (mode == -999)
				return;
			mode = -6;
			//if (mode == -2)
			//{
				//LOAD STATE
				var arr: Array<Dynamic> = savegame.loadArray();
				var casting: Array<LevelState> = new Array<LevelState>();
				if (arr != null)
				{
					for (i in 0 ... arr.length)
					{
						var casting2: LevelState = new LevelState();
						casting2.convert(arr[i]);
						casting.push(casting2);
					}
					levelSelector.setStates(casting);
				}
				moreTexturesUnlocked = savegame.loadMoreTexture(false);
			//	initLevelSelector();
			//	mode = -1;
			//}
			//else
			//	init ();
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
		var actslowdown:Float = slowdown * slowdownMult;
		var actslowdownZ:Float = slowdownZ * slowdownZMult;
		if (Utils.rAbs(speedX) < actslowdown) speedX = 0;
		else speedX += speedX > 0? -actslowdown:actslowdown;
		if (Utils.rAbs(speedY) < actslowdown) speedY = 0;
		else speedY += speedY > 0? -actslowdown:actslowdown;
		if (Utils.rAbs(speedZ) < actslowdownZ)
		{
			if (mode > 100) //win or lose
				speedZ = 0;
		}
		else
			speedZ += speedZ > 0? -actslowdownZ:actslowdownZ;
	}

	function calculateSpeeds()
	{
		speedX += (Utils.boolToInt (Keys.keyIsDown (KEY_RIGHT)) - Utils.boolToInt (Keys.keyIsDown (KEY_LEFT))) * accelerate;
		speedY += (Utils.boolToInt (Keys.keyIsDown (KEY_DOWN)) - Utils.boolToInt (Keys.keyIsDown (KEY_UP))) * accelerate;
		if (LevelStarted == false && (speedX != 0 || speedY != 0))
		{
			trace("START");
			timeStartLevel = Std.int (Date.now().getTime());
			LevelStarted = true;
			trace(timeStartLevel);
		}
	#if debug
		speedZ += -accelerateZ;// + Utils.boolToInt (Keys.keyIsDown (KEY_SPACE)) * accelerateZ * 2;
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
	
	function calculateNewCoordinates(div : Int)
	{
		x += speedX / div;
		y += speedY / div;
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
						if (i-z>2.5)
							level.Layers[i].setAlpha( 0.1 );
						else
						if (i-z>1.5)
							level.Layers[i].setAlpha( 0.2 );
						else
							level.Layers[i].setAlpha( 0.35 );
					else
						level.Layers[i].setAlpha( 1.0 );
				}
				d.layer.update ();
				scale = scalefactor * i + scaleoffset;
				var newx:Float = x * scale - ( Def.STAGE_W / 2 * (1 - scale) );
				var newy:Float = y * scale - ( Def.STAGE_H / 2 * (1 - scale) );
				if (level.isBackground(i))
				{
					newx += level.Layers[i].xscroll * frame * scale;
					newy += level.Layers[i].yscroll * frame * scale;
				}
				d.layer.moveTo (newx, newy);

				d.layer.draw ();
			}
			++i;
		}
		/*
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
		}*/
	}
	
	function ProcessEffectsClearTiles()
	{
		for (e in effectsClearTiles)
		{
			e.update();
				if (e.numLayer >= 0 && e.numLayer <= level.Layers.length - 1)
				{
					#if sound
					if (e.isChange())
						ScrollSnd.play(ScrollSound.Block_disappear, 0.2);
					#end
					var layer: Layer = level.Layers[e.numLayer].layer;
					var curTile: Int;
					curTile = layer.ts.getAnimationFrame (3, e.timeCounter - e.changeState)+1;
					switch (e.type)
					{
					case 0:
						if (e.state == 0)
						{
							layer.writeEffectMap(
								Utils.safeMod(e.x, layer.mapW),
								Utils.safeMod(e.y, layer.mapH),
								curTile);
						}
						//break;
					case 1:
						if (e.state != 0)
						{
							var curTile: Int;
							layer.writeEffectMap(
								Utils.safeMod(e.x, layer.mapW),
								Utils.safeMod(e.y, layer.mapH),
								-1, Std.int(e.timeCounter*30/(e.changeState-1)));
						}
						else
						{
							layer.writeEffectMap(
								Utils.safeMod(e.x, level.Layers[e.numLayer].layer.mapW),
								Utils.safeMod(e.y, level.Layers[e.numLayer].layer.mapH),
								curTile);
						}
					}
				}
			//}		
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
	
	function calculateNewZAndContact(fromlayer: Int, tolayer: Int, div: Int)
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
			var actslowdownZ = slowdownZ * slowdownMult;
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
						speedZ = speedZ * 0.8;
						#if sound
						if (Utils.rAbs(speedZ) > slowdownZ)
						{
							ScrollSnd.play(ScrollSound.Bump, Utils.rAbs(speedZ));
							//trace(Utils.rAbs(speedZ));
						}
						#end
						if (Utils.rAbs(dist) > Utils.rAbs(speedZ / div))
							z = speedZ>0?i-0.01:i;
						else if (Utils.rAbs(speedZ/div +  dist) < 1) //meg nem ugrana a kovetkezo platformra
							z = i - (speedZ / div +  dist);
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
						if (z < i)
							speedZ = speedZ * 0.1;
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
				z += speedZ / div;
				if (z >= 0 && z < level.Layers.length)
					player.setDepth2(level.Layers[Std.int(z)].playerlayer);
				{
					player.changeScaleShadow(scalefactor * Std.int(z) + scaleoffset);
					//dbg.setDepth2(level.Layers[Std.int(z)].playerlayer);
				}
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
							effect.setState(1, 0, 20);
							effectsClearTiles.add( effect );
							++curBlocks;
							if (curBlocks >= allBlocks)
								mode = 7; //cleared all blocks
						}
					}
				}
				if (curCode >= 0x50 && curCode < 0x60)
				{
					//rombolhato tile, idore eltuno
					var c: Int = curCode - 0x50;
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
								i, 1, 120);
							effect.setState(1, 0, 110);
							effectsClearTiles.add( effect );
						#if sound
							ScrollSnd.play(ScrollSound.Ticktack, 0.4);
						#end
							++curBlocks;
							if (curBlocks >= allBlocks)
								mode = 7; //cleared all blocks
						}
					}
				}

				if (curSeq == 4)
				{
					//jump
					speedZ += 0.8;
					#if sound
					ScrollSnd.play(ScrollSound.Jump_platform);
					#end
				}
				if (curSeq == 0)
				{
					//finish
					if (curBlocks >= allBlocks)
					{
						mode = 9;
						timeEndLevel = Std.int (Date.now ().getTime ());
						levelTime = timeEndLevel - timeStartLevel;
					}
					else
					{
						#if sound
						if (msg2Timeout < 30)
							ScrollSnd.play(ScrollSound.False_win);
						#end

						tfMessage2.visible = true;
						msg2Timeout = 60;
					}
				}
				if (curCode >= 0x20 && curCode < 0x30)
				{
					var c: Int = curCode - 0x20;
					if (playerColor != c)
					{
						playerColor = c;
						var rgba: RGBA = playerColors[c];
						player.changeColorTransform(rgba, 40);
						#if sound
						ScrollSnd.play(ScrollSound.Color_change, 0.3);
						#end
					}
				}
				if (curCode >= 0x40 && curCode < 0x50)
				{
					slowdownMult = 0.1;
				}
				else
					slowdownMult = 1.0;
				//trace(curCode + " " + curTile);
			}

			//nekem a kod fog kelleni curtile >> 8
			//player.draw();
		}
		else
			z += speedZ / div;
	}
	
	function onEnterFrame (d: Dynamic)
	{
		//Log.setColor (0xffffff);
		//trace(0);
		calculateFps();
		if (mode == -999)
			return;
#if ModPlayer
	if (mpprg == 0)
	{
	#if MochiScores
			if (MochiScoresStatus > 0 && !mochi.haxe.MochiServices.connected)
			{
				waitingformusicloading = true;
			}
			else if (mpPlay == false)
			{
				//mp.play("Test.mod");
				mp.playBytes(ModMusicData.getByteArray());
				mp.onProgress = setProgress;
				mpPlay = true;
				waitingformusicloading = true;
			}
	#end
	}
#end
		if (mode == -10)
		{
			//logo
		}
		if (mode == -6)
		{
			//title screen init
			nodeinit = true;
#if ModPlayer
			pleasewait = new Sprite();
			pleasewait.graphics.beginFill(0x00007b);
			pleasewait.graphics.drawRoundRect(Def.STAGE_W / 2 - 100, Def.STAGE_H / 2 - 20, 200, 40, 25, 25);
			pleasewait.graphics.endFill();
			pleasewait.alpha = 0.5;
			defaultFont="ArialNarrowBold";
			var ts: TextFormat = new flash.text.TextFormat();
			ts.font = defaultFont;
			ts.size = 30;
			ts.color = 0x6BECE9;
			var to: TextObj = new TextObj(pleasewait, dict, 20, Def.STAGE_W / 2 - 100, Def.STAGE_H / 2 - 20, 200, 40, ts, true);
			screen.addChild(pleasewait);
			mode = -5;
		}
		if (mode == -5)
		{
			
			//title screen
			if (waitingformusicloading && (mpprg > 99 || mpprg < 0))
			{
				waitingformusicloading = false;
				screen.removeChild(pleasewait);
				pleasewait = null;
				mode = -4;
			}
			else
			{
				pleasewait.graphics.beginFill(0x0000FF);
				pleasewait.graphics.drawRect(Def.STAGE_W / 2 -  70, Def.STAGE_H / 2 + 15, mpprg * 1.4, 5);
				pleasewait.graphics.endFill();
				return;
			}
		}
#else
			mode = -4;
		}
#end
		if (mode == -4)
		{
			//title screen deinit
			background.alpha -= 0.01;
			if (background.alpha <= 0.3)
				mode = -2;
			return;
		}
	#if ModPlayer
		if (!(mpprg == 100 || mpprg <= 0) && mpPlay)
		{
			tfBlocks.text = dict.get(1)+ ": " + Std.string(mpprg) + "%";
			tfBlocks.setTextFormat(tsBlocks);
		}
		else if (mode <= 0)
		{
			tfBlocks.text = "";
		}
	#end
		
		if (mode == -2)
		{
			if (nodeinit == false)
				deInit();
			else nodeinit = false;
			initLevelSelector();
			mode = -1;
		}
		if (mode == -1)
		{

			levelSelector.hover(
				Std.int(screen.stage.mouseX*globalscale),
				Std.int(screen.stage.mouseY*globalscale));
			levelSelector.process();				
			levelSelector.draw();
#if debug
			var a : Bool = Keys.keyIsDown (KEY_S);
			if (a)
			{
				savegame.saveArray(levelSelector.getStates());
			}

			a = Keys.keyIsDown (KEY_L);
			if (a)
			{
				var arr: Array<Dynamic> = savegame.loadArray();
				var casting: Array<LevelState> = new Array<LevelState>();
				for (i in 0 ... arr.length)
				{
					var casting2: LevelState = new LevelState();
					casting2.convert(arr[i]);
					casting.push(casting2);
				}
				levelSelector.setStates(casting);
			}
			else
			a = Keys.keyIsDown (KEY_N);
			if (a)
			{
				var arr: LevelState = new LevelState();
				savegame.saveState(arr);
			}
			a = Keys.keyIsDown (KEY_SPACE);
			if (a)
			{

				flapo.Score.submitScore(0);
			}
#end

			return;
		}
		var a : Bool = Keys.keyIsDown (KEY_SPACE);
		a = a || Keys.keyIsDown (KEY_ENTER);
		if (tfMessage.visible == true && a)
		{
			nextLevel();
		}
#if debug
		a = Keys.keyIsDown (KEY_N);
		if (a && !KeyNrepeat)
		{
			curBlocks = allBlocks;
			mode = 109;
			nextLevel();
			KeyNrepeat = true;
		}
		else
			KeyNrepeat = false;
		if (Keys.keyIsDown (KEY_S))
		{
			trace("Saving game");
			savegame.saveScore(curBlocks);
			trace("Game saved");
		}
		if (Keys.keyIsDown (KEY_L))
		{
			trace("Loading game");
			curBlocks = savegame.loadScore(0);
			trace("Game loaded");
		}
#end
		if (moreTexturesUnlocked)
		{
			var b : Bool = Keys.keyIsDown (KEY_T);
			if (b && !KeyTrepeat)
			{
				++balltexture;
				balltexture = balltexture % 3+1;
				KeyTrepeat = true;
			}
			else
				KeyTrepeat = false;
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
			if (islevelSelector)
				deinitLevelSelector();
			else
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
				/*
				//trace (99999999);
				winloseX += maxspeed /3;
				winloseY += maxspeed /3;
				*/
			}
			else
			{
				if (player.mcPlayer.alpha <= 0.2)
				{
					player.mcPlayer.alpha = 0;
					mode += 100;
					var ts: TextFormat = new flash.text.TextFormat();
					ts.font = defaultFont;
					ts.size = 30;
					ts.color = 0xaaaaff;
					if (mode == 108)
					{
						tfMessage.text = dict.get(23);
						tfMessage.setTextFormat(ts);
						tfMessage.y = Def.STAGE_H / 2 - 20;
						tfBack.y = Def.STAGE_H / 2- 20;
					}
						//levelwinlose.Layers[1].layer.setVisible(true);
					else
					{
						//levelwinlose.Layers[0].layer.setVisible(true);

//						else
//						{
							levelSelector.unlock(levelnum); //debug leptetesnel elofordul, hogy nincs meg nyitva
							bestTime = levelSelector.players[levelnum].state.score;
							if (bestTime == 0 || bestTime > levelTime) 
								levelSelector.setCompleted(levelnum, levelTime);
							levelSelector.unlock(levelnum + 1);
							savegame.saveArray(levelSelector.getStates());
						#if Kongregate
							if (kg != null) kg.SubmitStat("LevelCompleted", levelnum);
							if (levelnum==8)
								if (kg != null) kg.SubmitStat("First10LevelCompleted", 1);
							if (levelnum==18)
								if (kg != null) kg.SubmitStat("Second10LevelCompleted", 1);
						#end
							tfMessage.text = dict.get(3);
							tfMessage.setTextFormat(ts);
							tfMessage.y = Def.STAGE_H - 40;
							tfBack.y = Def.STAGE_H - 40;
							infowin.visible = true;
							tfInfowin.visible = false;
							tfInfowinWinner.visible = false;
							
							texts[0].setText(dict.get(8) + flapo.Score.convertTime(levelTime, true), true);
							texts[1].setText(dict.get(17) +
								flapo.Score.convertTime(
									levelSelector.players[levelnum].state.score, true),
								true);
							//medal
							texts[2].setText(dict.get(9 + levelSelector.players[levelnum].state.medal),
								true); 
//						}
						if (levelnum >= levelcontainer.maxLevel && infomode == 0)
						{
							//infowin.visible = true;
							infomode = 2;
							tfInfowin.visible = false;
							tfInfowinWinner.visible = true;
							moreTexturesUnlocked = true;
							savegame.saveMoreTexture(moreTexturesUnlocked);
						#if Kongregate
							if (kg!=null) kg.SubmitStat("LastLevelCompleted", 1);
						#end
						}
						else
						{
							infomode = 3;
							for (t in texts)
							{
								t.tf.visible = true;
							}
						}
						#if sound
						ScrollSnd.play(ScrollSound.Win);
						#end
					}
					tfMessage.visible = true;
					tfBack.visible = true;
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
		var div: Int = 2;
		for (i in 0 ... div)
		{
		//calculate new coordinates
		calculateNewCoordinates(div);
		var fromlayer: Int = Std.int( z );
		var tolayer: Int = Std.int( z + speedZ / div );
		if (speedZ > 0)
		{
			//jump
			++fromlayer;
			++tolayer;
		}
		if (z < 0) --fromlayer;
		if (z + speedZ / div < 0) --tolayer;
		calculateNewZAndContact(fromlayer, tolayer, div);
		}
		//var i:Int = 0;

		processLevel();
		//trace("oo");

		ProcessEffectsClearTiles();

		//trace("ooo");
		//Utils.gc(); //garbage collector
		player.update();
		player.changexyz(plX, plY, z); // for shadow
		player.changerollxy(plX, plY); // for rotating ball
		player.drawBall(balltexture);
		var bd:BitmapData = new BitmapData(6 * 48, 6 * 48);
		var i:Int = Std.int(z);
		if (i >= 0 && i < level.Layers.length && level.isBackground(i) == false)
		{
			var offset: Int = Std.int((z - i) * 48);
			level.Layers[i].layer.getBitmapDataAtXY
				(bd, plX - 24 + offset + 5 + 4, plY - 24 + offset + 5 + 4);
				//trace(plX - 24 + offset + 5 + 4);
			player.drawShadow(bd);
		}
		else 
			player.clearShadow();
		
		if (z < 1 && mode < 8)
		{
			player.changeAlpha((1 + z) / 2);
			{
				mode = 8; //fallen
				#if sound
				ScrollSnd.play(ScrollSound.Falling);
				#end
				timeEndLevel = Std.int (Date.now ().getTime ());
				levelTime = timeEndLevel - timeStartLevel;
				//levelwinlose.Layers[0].layer.setVisible(true);
			}
		}
		else if (mode < 8)
		{
			player.changeAlpha(1.0);
			//dbg.changeAlpha(0.4);			
		}
		if (z < -2)
			z = -2;

		var i:Int;
		i = Std.int(z);
		//dbg.update();
/*
		if (i >= 0 && i <= level.Layers.length - 1)
			//dbg.draw(level.Layers[i].layer.getCurTile(Utils.safeDiv (plX,48), Utils.safeDiv (plY,48)));
			dbg.draw(level.Layers[i].layer.effectMapData[Utils.safeDiv (plY,48)][Utils.safeDiv (plX,48)] >> 8);
		else
			dbg.draw(0);
MonsterDebugger.inspect(level.Layers[i].layer.effectMapData[Utils.safeDiv (plY,48)][Utils.safeDiv (plX,48)] >> 8);
*/
//MonsterDebugger.inspect(level.Layers[2].layer.effectMapData[1][10] >> 8);
//MonsterDebugger.inspect(level.Layers[1].layer.effectMapData[2][10] >> 8);

		if (z >= -2)
		{
			scale = scalefactor * z + scaleoffset;
			var scaleShadow:Float = scalefactor * Std.int(z) + scaleoffset;
			player.changeScale(scale);
			player.setCTmult(new RGBA(scale, scale, scale, 1));
			//dbg.changeScale(scale);
			if (i >= 0)
			{
				player.moveTo(plXscreen - po * scale, plYscreen - po * scale);
				
				player.moveToShadow(plXscreen - po * scaleShadow, plYscreen - po * scaleShadow);
				//dbg.moveTo(plXscreen - po * scale, plYscreen - po * scale);
			}
		}

#if ModPlayer
		if (!(mpprg == 100 || mpprg <= 0) && mpPlay)
		{
		}
		else
#end
		{
			var score: Int;

			if (mode < 8)
				score = Std.int (Date.now().getTime()) - timeStartLevel;
			else
				score = levelTime;
			
			if (LevelStarted == false)
			{
				score = 0;
				if (Utils.safeMod(frame, 300) < 250)
				{
					tfBlocks.text = Std.string(curBlocks) + "/" + Std.string(allBlocks) +
						"   " +
						flapo.Score.convertTime( score );
				}
				else
				{
					tfBlocks.text = dict.get(24);
				}
			}
			else
				tfBlocks.text = Std.string(curBlocks) + "/" + Std.string(allBlocks) +
					"   " +
					flapo.Score.convertTime( score );

			var medal;
			if (score <= medalTimes.gold)
				medal = 3;
			else if (score <= medalTimes.silver)
				medal = 2;
			else if (score <= medalTimes.bronze)
				medal = 1;
			else
				medal = 0;
			switch (medal)
			{
				case 0:
					tsBlocks.color = 0xAAAAFF; //  0.5, 0.5, 1.0));
			//		tsBlocks.color = 0x44FF44; //0.3, 1.0, 0.3));
				case 1:
					tsBlocks.color = 0xFF9999; //1.0, 0.7, 0.7));
				case 2:
					tsBlocks.color = 0xDDDDDD; //0.8, 0.8, 0.8));
				case 3:
					tsBlocks.color = 0xFFFF77; //1, 1, 0.5));
			}
			tfBlocks.setTextFormat(tsBlocks);
		}

	}
	
	
	function onKeyDown (event: KeyboardEvent)
	{
		var repeat: Bool = Keys.keyIsDown (event.keyCode);
		if (! repeat)
		{
			//trace("Keycode: " + event.keyCode);
			Keys.setKeyStatus (event.keyCode, true);
		}
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
	public function submitScoreEvent(e:MouseEvent) {
#if MindJolt
		Score.submitScore(levelnum, levelSelector.OveralScore());
#else
		Score.submitScore(levelnum, levelSelector.players[levelnum].state.score);
#end
	}
	public function showScoreEvent(e:MouseEvent) {
		Score.submitScore(levelnum);
	}
	public function clearTableEvent(e:MouseEvent) {
		levelSelector.reset();
		moreTexturesUnlocked = false;
		savegame.saveMoreTexture(moreTexturesUnlocked);
	}
	
	public function submitScoreOver(e:MouseEvent) {
#if MindJolt
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		ts.color = 0xffffff;
		textLevelSelector[1].tf.setTextFormat(ts);
#else
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		//ts.color = 0x5090F0;
		texts[3].tf.htmlText = dict.get(15);
		texts[3].tf.setTextFormat(ts);
#end
		}	
	public function submitScoreOut(e:MouseEvent) {
#if MindJolt
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		ts.color = 0xaaaaff;
		textLevelSelector[1].tf.setTextFormat(ts);
#else
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		//ts.color = 0x804020;
		texts[3].tf.htmlText = dict.get(13);
		texts[3].tf.setTextFormat(ts);
#end
	}	
	public function showScoreOver(e:MouseEvent) {
#if !MindJolt
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		//ts.color = 0x5090F0;
		texts[4].tf.htmlText = dict.get(16);
		texts[4].tf.setTextFormat(ts);
#end		
	}
	
	public function showScoreOut(e:MouseEvent) {
#if !MindJolt		
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		//ts.color = 0x804020;
		texts[4].tf.htmlText = dict.get(14);
		texts[4].tf.setTextFormat(ts);
#end		
	}	
	public function clearTableOver(e:MouseEvent) {
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		ts.color = 0xff8888;
		textLevelSelector[0].tf.setTextFormat(ts);
	}
	
	public function clearTableOut(e:MouseEvent) {
		var ts: TextFormat = new flash.text.TextFormat();
		ts.font=defaultFont;
		ts.size = 20;
		ts.color = 0xFFFFFF;
		textLevelSelector[0].tf.setTextFormat(ts);
	}	

}
