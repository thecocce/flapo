package gamelib2d;

import gamelib2d.Def;
import gamelib2d.TileSet;
import gamelib2d.Layer;
import gamelib2d.Utils;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BlendMode;

import flash.geom.Rectangle;
import flash.geom.Point;
import flash.geom.Matrix;
import flash.geom.Transform;
import flash.geom.ColorTransform;


typedef ObjectFlags =
{
	autoMirrorLeftRight: Bool,
	autoMirrorUpDown: Bool,
}


enum MsgTarget
{
	mtAll;
	mtSelf;
	mtPar (i: Int);
	mtCode (i: Int);
	mtCodeC (i: Int, mt: MsgTarget);
	mtName (s: String);
	mtNameC (s: String, mt: MsgTarget);
	mtGroup (i: Int);
	mtGroupC (i: Int, mt: Ms
	gTarget);
}

typedef Msg =
{
	var msg: String;
	var par1: Float;
	var par2: Float;
	var source: GameObject;
	var target: MsgTarget;
	var time: Int;
}


typedef FocusInfo =
{
	objInFocus: GameObject,
	startScrollLeft: Int,
	startScrollUp: Int,
	startScrollRight: Int,
	startScrollDown: Int,
	maxScrollSpeedX: Float,
	maxScrollSpeedY: Float,
	repositionScreen: Bool
}


typedef CollisionInfo =
{
	obj1: GameObject,
	obj2: GameObject,
	bounds: Int
}


class GameObject
{
	private static inline var MARGIN = 0.0001;

	private static var objlist: List<GameObject> = new List ();
	public static var msglist: List<Msg> = new List ();
	private static var focus: FocusInfo = null;
	
	public var mcContainer: Sprite;
	public var surface: BitmapData;
	public var bitmap: Bitmap;
	
	public var active: Bool;
	public var objName: String;
	public var objCode: Int;
	public var objPar: Int;
	public var x: Float;
	public var y: Float;
	public var oldX: Float;
	public var oldY: Float;
	public var sizeX: Int;
	public var sizeY: Int;
	public var tileset: TileSet;
	public var animation: Int;
	public var animationFlags: Int;
	public var frameCounter: Int;
	public var layer: Layer;
	public var objFlags: ObjectFlags;
	public var group: Int;
	public var bounceGroup: Int;
	public var collideGroup: Int;
	public var speedX: Float;
	public var speedY: Float;
	public var accX: Float;
	public var accY: Float;
	public var maxSpeedX: Float;
	public var maxSpeedY: Float;
	public var bounceX: Float;
	public var bounceY: Float;
	public var slowDownX: Float;
	public var slowDownY: Float;
	public var curHDir: Int;
	public var curVDir: Int;
	public var lastHDir: Int;
	public var lastVDir: Int;
	public var alpha: Float;
	public var offsetX: Int;
	public var offsetY: Int;
	public var skipFrameEvent: Int;
	public var levelBounds: DirectionSet;
	public var mirrorLeftRight: Bool;
	public var mirrorUpDown: Bool;
	public var lastDirectionUp: Bool;
	public var lastDirectionLeft: Bool;
	public var ignoreLevelBounds: Bool;
	public var checkKeyboard: Bool;
	public var framesToLive: Int;
	public var simple: Bool;
	
	
	public function onNewDirectionX () { }
	public function onNewDirectionY () { }
	
	public function onKeyDown (key: Int) { }
	public function onKeyUp (key: Int) { }
	
	public function onFrame () { } 

	public function onCollide (ds: DirectionSet, obj: GameObject) { } 
	public function onBounce (ds: DirectionSet, ?obj: GameObject) { } 
	
	public function onMessage (msg: String, par1: Float, par2: Float) { }
	
	
	public function new (mc: Sprite)
	{
		mcContainer = mc;
		objlist.add (this);
	}

	public function init (name: String, code: Int, par: Int, mapx: Int, mapy: Int, xp: Float, yp: Float, ts: TileSet, anim: Int, animflags: Int,
							?lyr: Layer, ?flags: ObjectFlags)
	{
		active = true;
		objName = name;
		objCode = code;
		objPar = par;
		x = xp;
		y = yp;
		tileset = ts;
		sizeX = ts.tileW;
		sizeY = ts.tileH;
		animation = anim;
		animationFlags = animflags;
		layer = lyr;
		if (layer != null)
		{
			x += mapx * layer.ts.tileW;
			y += mapy * layer.ts.tileH;
			sizeX = layer.ts.tileW;
			sizeY = layer.ts.tileH;
		}
		objFlags = flags;
		if (objFlags == null)
			objFlags =
				{
					autoMirrorLeftRight: true,
					autoMirrorUpDown: true,
				}
		speedX = 0;
		speedY = 0;
		accX = 0;
		accY = 0;
		bounceX = 0;
		bounceY = 0;
		slowDownX = 0;
		slowDownY = 0;
		maxSpeedX = 0;
		maxSpeedY = 0;
				
		curHDir = 0;
		curVDir = 0;
		lastHDir = 0;
		lastVDir = 0;
		alpha = 1.0;
		frameCounter = 0;
		
		surface = new BitmapData (tileset.tileW, tileset.tileH, true, 0);
		bitmap = new Bitmap (surface);
		bitmap.visible = false;
		bitmap.cacheAsBitmap = true;
		mcContainer.addChild (bitmap);

		levelBounds = { top: true, left: true, right: true, bottom: true };
		ignoreLevelBounds = false;
		
		skipFrameEvent = 0;
		lastDirectionUp = false;
		lastDirectionLeft = false;
		oldX = x;
		oldY = y;
		
		checkKeyboard = false;
		framesToLive = -1;
		simple = false;
	}
	
	
	public static function clearAll ()
	{
		clearObjectFocus ();
		for (obj in objlist)
			if (obj != null)
			{
				obj.surface = null;
				if (obj.bitmap != null) 
					obj.mcContainer.removeChild (obj.bitmap);
				if (obj.layer != null)
				{
					obj.layer.clear ();
					obj.layer = null;
				}
				if (obj.tileset != null)
				{
					obj.tileset.clear ();
					obj.tileset = null;
				}
				obj = null;
			}
		objlist = new List ();
	}
	

	public function clearMessages ()
	{
		msglist = new List ();
	}
  
	public function broadcastMessage (msg: String, p1: Float, p2: Float, t: MsgTarget, time: Int)
	{
		msglist.add ({ msg: msg, par1: p1, par2: p2, source: this, target: t, time: time });
	}


	function checkMsgTarget (mt: MsgTarget, src: GameObject): Bool
	{
		return switch (mt)
		{
			case mtAll: 			true;
			case mtSelf: 			src == this;
			case mtPar (i): 		objPar == i;
			case mtCode (i): 		(objCode == i);
			case mtCodeC (i, t):	(objCode == i) && checkMsgTarget (t, src);
			case mtName (s): 		(objName == s);
			case mtNameC (s, t):	(objName == s) && checkMsgTarget (t, src);
			case mtGroup (i): 		(group & i != 0);
			case mtGroupC (i, t):	(group & i != 0) && checkMsgTarget (t, src);
		}
	}

	
	public static function runMessages ()
	{
		for (msg in msglist)
		{
			if (--msg.time <= 0)
			{
				var found: Bool = false;
				for (obj in objlist)
					if (obj.checkMsgTarget (msg.target, msg.source))
					{
						obj.onMessage (msg.msg, msg.par1, msg.par2);
						found = true;
					}
				
				//if (! found) trace ("target not found!");
				
				msglist.remove (msg);
			}	
		}
	}


	function checkDirection ()
	{
		if (active && (! simple))
		{
			lastHDir = curHDir;
			lastVDir = curVDir;

			curHDir = 0;
			if (x < oldX - MARGIN)
			{
				curHDir = -1;
				lastDirectionLeft = true;
			}
			if (x > oldX + MARGIN)
			{
				curHDir = 1;
				lastDirectionLeft = false;
			}

			curVDir = 0;
			if (y < oldY - MARGIN)
			{
				curVDir = -1;
				lastDirectionUp = true;
			}
			if (y > oldY + MARGIN)
			{
				curVDir = 1;
				lastDirectionUp = false;
			}
			
			if (curHDir != lastHDir) onNewDirectionX ();
			if (curVDir != lastVDir) onNewDirectionY ();
		}
	}

	
	public function setDepth (newContainer: Sprite)
	{
		mcContainer.removeChild (bitmap);
		mcContainer = newContainer;
		mcContainer.addChild (bitmap);
	}
	
	
	public function createObjectFocus (left: Int, up: Int, right: Int, down: Int, ?maxxv: Float = 0.0, ?maxyv: Float = 0.0, ?move: Bool = false)
	{
		focus = 
		{
			objInFocus: this,
			startScrollLeft: left,
			startScrollUp: up,
			startScrollRight: right,
			startScrollDown: down,
			maxScrollSpeedX: maxxv,
			maxScrollSpeedY: maxyv,
			repositionScreen: move
		}
	}
	
	
	public static function clearObjectFocus ()
	{
		focus = null;
	}
	
	
	public static function checkObjectFocus (p: Point): Point
	{
		if (focus != null)
		{
			var oldp: Point = p;
			var obj: GameObject = focus.objInFocus;
			var xp: Float = obj.x + obj.sizeX / 2;
			var yp: Float = obj.y + obj.sizeY / 2;
			if (xp + focus.startScrollRight > p.x + Def.STAGE_W) p.x = xp + focus.startScrollRight - Def.STAGE_W;
			if (yp + focus.startScrollDown > p.y + Def.STAGE_H) p.y = yp + focus.startScrollDown - Def.STAGE_H;
			if (xp - focus.startScrollLeft < p.x) p.x = xp - focus.startScrollLeft;
			if (yp - focus.startScrollUp < p.y) p.y = yp - focus.startScrollUp;
			var dx: Float = p.x - oldp.x;
			var dy: Float = p.y - oldp.y;
			if (! focus.repositionScreen)
			{
				if (dx > focus.maxScrollSpeedX) dx = focus.maxScrollSpeedX;
				if (dy > focus.maxScrollSpeedY) dy = focus.maxScrollSpeedY;
				if (dx < -focus.maxScrollSpeedX) dx = -focus.maxScrollSpeedX;
				if (dy < -focus.maxScrollSpeedY) dy = -focus.maxScrollSpeedY;
				p.x = oldp.x + dx;
				p.y = oldp.y + dy;
				if (p.x + Def.STAGE_W > obj.layer.width ()) p.x = obj.layer.width () - Def.STAGE_W;
				if (p.y + Def.STAGE_H > obj.layer.height ()) p.y = obj.layer.height () - Def.STAGE_H;
				if (p.x < 0) p.x = 0;
				if (p.y < 0) p.y = 0;
			}
			focus.repositionScreen = false;
		}
		return p;
	}
	
	
	public function bounce (ds: DirectionSet, spaceX: Float, spaceY: Float, ?obj: GameObject)
	{
		var xb: Float = bounceX;
		var yb: Float = bounceY;
		if (xb < 0) xb = Math.abs (xb * speedX);
		if (yb < 0) yb = Math.abs (yb * speedY);
		onBounce (ds, obj);
		if (ds.top)    { speedY = -yb; y = oldY + spaceY; }
		if (ds.left)   { speedX = -xb; x = oldX + spaceX; }
		if (ds.bottom) { speedY =  yb; y = oldY - spaceY; }
		if (ds.right)  { speedX =  xb; x = oldX - spaceX; }
	}
	
	
	public function checkMapBounds ()
	{
		if (active && (layer != null) && (! simple))
		{
			var w: Int = layer.ts.tileW;
			var h: Int = layer.ts.tileH;
			
			var oldX1: Float = x;				var oldMapX1 = Std.int (oldX1 / w);
			var oldY1: Float = y;				var oldMapY1 = Std.int (oldY1 / h);
			var oldX2: Float = x + sizeX;		var oldMapX2 = Std.int (oldX2 / w);
			var oldY2: Float = y + sizeY;		var oldMapY2 = Std.int (oldY2 / h);
			var X1: Float = oldX1 + speedX;		var mapX1 = Std.int (X1 / w);
			var Y1: Float = oldY1 + speedY;		var mapY1 = Std.int (Y1 / h);
			var X2: Float = oldX2 + speedX;		var mapX2 = Std.int (X2 / w);
			var Y2: Float = oldY2 + speedY;		var mapY2 = Std.int (Y2 / h);

			var xblock: Bool = false;
			var yblock: Bool = false;
			var newx: Int = 0;
			var newy: Int = 0;
			var xbnd: Int = 0;
			var ybnd: Int = 0;
			var spacex: Float = 0;
			var spacey: Float = 0;
			
			if (mapX1 < oldMapX1) { xblock = true; newx = mapX1; xbnd = Def.RIGHT_BOUND; spacex = oldX1 - oldMapX1 * w; }
			if (mapY1 < oldMapY1) { yblock = true; newy = mapY1; ybnd = Def.LOWER_BOUND; spacey = oldY1 - oldMapY1 * h; }
			if (mapX2 > oldMapX2) { xblock = true; newx = mapX2; xbnd = Def.LEFT_BOUND;  spacex = mapX2 * w - oldX2 - MARGIN; }
			if (mapY2 > oldMapY2) { yblock = true; newy = mapY2; ybnd = Def.UPPER_BOUND; spacey = mapY2 * h - oldY2 - MARGIN; }
			
			var xbump: Bool = false; 
			var ybump: Bool = false;
			var bound: Int = 0;
			var edge: Int = Def.directionSetToInt (levelBounds);
			if (ignoreLevelBounds) edge = 0;
			
			if (xblock)
			{
				for (j in oldMapY1 ... oldMapY2 + 1)
					bound |= (layer.readBoundMap (newx, j, edge, bounceGroup, 0x0F) & xbnd);
				if (bound & xbnd != 0) xbump = true;
			}
			if (yblock)
			{
				for (i in oldMapX1 ... oldMapX2 + 1)
					bound |= (layer.readBoundMap (i, newy, edge, bounceGroup, 0x0F) & ybnd);
				if (bound & ybnd != 0) ybump = true;
			}
			if ((xblock && yblock) && ((!xbump) && (!ybump)))
			{
				bound |= (layer.readBoundMap (newx, newy, edge, bounceGroup, 0x0F) & ybnd);
				if (bound & xbnd != 0) xbump = true;
				if (bound & ybnd != 0) ybump = true;
				if (xbump && ybump)
				{
					if (Math.abs (speedX) > Math.abs (speedY))
					{
						xbump = false;
						bound = bound & ~xbnd;
					}
					else
					{
						ybump = false;
						bound = bound & ~ybnd;
					}
				}
			}
			if (! xbump) spacex = 0;
			if (! ybump) spacey = 0;
			
			if (bound != 0) bounce (Def.intToDirectionSet (bound), spacex, spacey, null);
		}
	}
	
	
	public function run ()
	{
		if (active && (! simple))
		{
			oldX = x;
			oldY = y;
			if (skipFrameEvent > 0)
				skipFrameEvent--;
			else
				onFrame ();
			speedX += accX;
			speedY += accY;
			if (slowDownX > 0)
			{
				if (speedX > 0) speedX = Math.max (speedX - slowDownX, 0);
				if (speedX < 0) speedX = Math.min (speedX + slowDownX, 0);
			}
			if (slowDownY > 0)
			{
				if (speedY > 0) speedY = Math.max (speedY - slowDownY, 0);
				if (speedY < 0) speedY = Math.min (speedY + slowDownY, 0);
			}
			if (maxSpeedX != 0)
			{
				if (speedX > maxSpeedX) speedX = maxSpeedX;
				if (speedX < -maxSpeedX) speedX = -maxSpeedX;
			}
			if (maxSpeedY != 0)
			{
				if (speedY > maxSpeedY) speedY = maxSpeedY;
				if (speedY < -maxSpeedY) speedY = -maxSpeedY;
			}
			
			//if (speedX != 0 || speedY != 0)
				checkMapBounds ();
			
			x += speedX;
			y += speedY;
			
			checkDirection ();
			
		}
	}

	
	public function draw ()
	{
		if (active)
		{
			var hmir = Utils.xor (animationFlags & Def.TF_MIRROR == 0, 
									Utils.xor (mirrorLeftRight, objFlags.autoMirrorLeftRight && lastDirectionLeft));
			var vmir = Utils.xor (animationFlags & Def.TF_UPSIDEDOWN == 0,
									Utils.xor (mirrorUpDown, objFlags.autoMirrorUpDown && lastDirectionUp));
			var xp = x + tileset.tileW / 2 + offsetX;
			var yp = y + tileset.tileH / 2 + offsetY;
			if (layer != null)
			{
				xp -= (layer.scrollX ()) + layer.shiftX;
				yp -= (layer.scrollY ()) + layer.shiftY;
			}
			var m = 3 - Utils.boolToInt (hmir) - 2 * Utils.boolToInt (vmir);
			var tile = tileset.getAnimationFrame (animation - 1, frameCounter);
			if (tile == 0)
				surface.fillRect (new Rectangle (0, 0, tileset.tileW, tileset.tileH), 0);
			else
				tileset.drawTile (surface, 0, 0, tile - 1, m);
			bitmap.visible = true;
			bitmap.alpha = alpha;
			bitmap.x = Std.int (xp - tileset.tileW / 2 + 0.5);  ///
			bitmap.y = Std.int (yp - tileset.tileH / 2 + 0.5);  ///
			
			frameCounter++;
		}
		else
			bitmap.visible = false;
		if (framesToLive > -1)
		{
			framesToLive--;
			if (framesToLive <= 0)
				deleteObject ();
		}
	}
	
	
	function deleteObject ()
	{
		active = false;
		objlist.remove (this);
		mcContainer.removeChild (bitmap);
		bitmap = null;
		surface = null;
		mcContainer = null;
	}

	
	public static function iterator ()
	{
		return objlist.iterator ();
	}
	
}

