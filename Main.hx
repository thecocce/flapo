//pre-build
//"$(ToolsDir)\swfmill\swfmill.exe" simple Res.xml Res.swf
//define
//-D inverse

// add the folder containing gamelib2d to the projects classpaths

//import com.blitzagency.Main_loadConnector;
//import com.blitzagency.xray.logger.XrayLog;
#if MDebugger
import flash.display.Sprite;
import flash.events.Event;
import nl.demonsters.debugger.MonsterDebugger;
#end
import flapo.GameLogic;
//import flapo.Menu;
import flash.Lib;
import haxe.Log;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.Bitmap;
#if Logo
import hu.internetjatek.IJLogo;
#end

class Main extends Sprite {
#if MDebugger
	// Variable to hold the debugger
	// This is needed to explore your live application
	private var debugger:MonsterDebugger;
#end
	private static var bg: Sprite;
	private static var background: Sprite;
	private static var game : GameLogic;
#if Logo
	private static var logo: IJLogo;
	private static var counter: Int;
#end
	public var testobj: Dynamic;

	public static function main ()
	{
		new Main();
	}
	
	public function new ()
	{
		super();
		//var connect:com.blitzagency.xray.util.XrayConnect = com.blitzagency.xray.util.XrayConnect.getInstance(_root, true);		
		flash.Lib.current.addChild (this);
		Log.setColor (0xFFFFFF);
		testobj = null;
		trace("Loaded");
#if MDebugger
		// Init the debugger
		debugger = new MonsterDebugger(this);
		// Send a simple trace
		MonsterDebugger.trace(this, "Hello World!");
#end
		/*
		  We have to delay initialization, because the Haxe Boot object may not be added to the Display list yet.
		  We can now that we are on the Display chain when we receive an ADDED_TO_STAGE or an ENTER_FRAME event for example.
		*/
		bg = new Sprite();
		bg.visible = false;
		bg.graphics.beginFill(0x0000FF);
		bg.graphics.drawRect(0, 0, 550, 400);
		addChild(bg);
		
		background = new Sprite();
		//background.visible = false;
		var oBackground:Background_Info = new Background_Info();
		var bitmap: Bitmap = oBackground.getBitmap();
		background.addChild(bitmap);
		background.visible = false;
		background.x = 0;
		background.y = 0;
		addChild(background);
		
	#if Logo		
		logo = new IJLogo(Lib.current.stage);
		addChild(logo);
		trace("Logo is created and added to stage");
		counter = 0;
		addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
	#else
		bg.visible = true;
		background.visible = true;

		game = new GameLogic(background);
	#end
		addEventListener(Event.ADDED_TO_STAGE, init);
	}


#if Logo
	private function onEnterFrameHandler(event:Event):Void
	{
		counter++;
		//to avoid the background showing before the Logo starts
		if (counter == 10)
		{
			bg.visible = true;
			background.visible = true;
		}
		if (logo != null)
		{
			if (logo.isDone() == false)
				return;
			removeChild(logo);
			logo = null;
			trace("Logo is done and removed from stage");
		}
		game = new GameLogic(background);
		game.setParent(testobj);
		removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
	}
#end
	
	function init(e) {
		/*
		Call a function in the Test object.

		This may be required if we use an external library function which searches FlashVars in the first LoaderInfo.
		Because the @Embed tag loads the the haxe swf with a Loader, this is the first loader if the external function (which checks the loaderInfo) 
		is called from a wrapped Haxe object. (Such is the MindJolt API for example).

		To circumvent this, calls to such APIs should happen from the wrapper (now the Test object), so all necessary data should be passed back
		to the Test object with a function call, and the Test object will call the API (loaderInfo will be the outermost then).

		Now we call a test function, which will call back to htrace().

		Object hierarchy: Test object -> HxInst object -> Loader object -> Haxe Boot object -> First child added to Boot (will be Main now).
		Maybe this could be done in a more elegant way.
		*/
		try {
			testobj = untyped parent.parent.parent.parent;
			testobj.traceCallback();
		}
		catch (e : flash.Error) {
			trace("Could not call parent...traceCallback() from Haxe. Maybe not preloaded?");
			trace("Error was: " + e.message);
		}

		//trace("Example brought to you by Mindless Labs");
#if Logo
#else
		game.setParent(testobj);
#end
	}

   /* Will be called from the wrapper. */
	public function htrace(s : String) {
		trace("Trace from Haxe: " + s);
	}	
}