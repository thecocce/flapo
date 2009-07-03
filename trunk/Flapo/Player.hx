/**
 * ...
 * @author Bence Dobos
 */

package flapo;

import BlocksInfo;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
//import BlocksInfo;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import gamelib2d.TileSet;
import flash.geom.Rectangle;
import flapo.Effect;
import flapo.RotatedBall;
import flash.display.PixelSnapping;
import gamelib2d.Utils;

class Player 
{

		//player
	public var surfaceShadow: BitmapData;
	public var surface: BitmapData;
	#if flash9
		private var mcContainer: Sprite;
		public var mcPlayer: Sprite;
		public var mcPlayerShadow: Sprite;
		public var mcPlayer2: Sprite;
	#elseif flash8
		private var mcContainer: MovieClip;
		public var mcPlayer: MovieClip;
	#end
	public var bdShadow: BitmapData;
	public var bitmap: Bitmap;
	public var bitmapShadow: Bitmap;
	public var playertiles: TileSet;
	public var plX: Int; //Draw here (screen coordinates)
	public var plY: Int;
	public var timeCounter: Int;
	public var scale: Float;
	public var fNewX: Float;
	public var fNewY: Float;
	public var x: Float; //Coords in map
	public var y: Float;
	public var z: Float;
	public var Depth: Int;
	public var Effects: List<Effect>;
	public var EffectsRemove: List<Effect>;
	public var colortransform: ColorTransform;
	public var rball: RotatedBall;
	
	public function calcShadow( r: Int, center: Int )
	{
	  var ix: Int;
	  var iy: Int;
	  var iz: Int;
	  var alpha: Int;
	  
	  for(ix in -r ... r+1)
	  for(iy in -r ... r+1)
	  {
		if (ix*ix+iy*iy<=r*r) //bent van e a korben
		{
			iz = Std.int(Math.sqrt(1 * 1 - ix * ix - iy * iy + r * r) / 3 + 1);
			alpha = (iz * 20);
			if (alpha > 255) alpha = 255;
			if (alpha < 0) alpha = 0;
			bdShadow.setPixel32(ix+center, iy+center, alpha << 24); //alpha
		}
		else //ha nincs, akkor marad
		{
			bdShadow.setPixel32(ix+center, iy+center, 0x0);
		}
	  }
	}
	
	public function new(screen) 
	{
		//player init
		playertiles = new TileSet (screen);
		playertiles.init (new BallInfo ());
		mcContainer = screen;
		surface = new BitmapData (400, 400, true, 0x0);
		surfaceShadow = new BitmapData (400, 400, true, 0x0);

	//	#if flash9
			mcPlayerShadow = new Sprite();
			mcPlayer2 = new Sprite ();
			mcPlayer = new Sprite ();
			bitmap = new Bitmap(surface, AUTO, true);
			bitmapShadow = new Bitmap(surfaceShadow, AUTO, true);
			mcPlayerShadow.addChild (bitmapShadow);
			mcPlayer2.addChild (bitmap);
			mcPlayer.addChild(mcPlayerShadow);
			mcPlayer.addChild(mcPlayer2);
			mcContainer.addChild (mcPlayer);
			//mcContainer.addChild (bitmap);
	/*	#elseif flash8
			var Depth = flash.Lib._root.getNextHighestDepth ();
			mcplayer = mcContainer.createEmptyMovieClip ("player", 2);
			mcplayer.attachBitmap (surface, 99);
		#end*/
		
		timeCounter = 0;
		scale = 1.0;
		Effects = new List<Effect>();
		EffectsRemove = new List<Effect>();
		colortransform = null;
		rball = new RotatedBall( 48 );
		rball.tabfill(3, 20);
		bdShadow = new BitmapData(200, 200, true, 0x0);
		calcShadow(20,24);
	}

	public function clear()
	{
		surface.fillRect (new Rectangle (0, 0, playertiles.tileW, playertiles.tileH), 0);

	}

	public function draw(?tile:Int)
	{
		mcPlayer2.x = x;
		mcPlayer2.y = y;
		var curSeq: Int;
		if (tile != null && tile == 0)
		{
			clear();
			return;
		}
		var t: Int;
		if (tile == null)
			t = 5;
		else
		{
			//trace(tile);
			if (tile < 0)
			{
				curSeq = (tile ^ gamelib2d.Def.TF_SEQUENCE) - 1;
				t = curSeq;//playertiles.getAnimationFrame (curSeq, timeCounter);
			}
			else
				t = tile-1;
		}
		
		playertiles.drawTile(surface, 0, 0, t, 0);
	}

	public function drawBall(?tile:Int)
	{
		mcPlayer2.x = x;
		mcPlayer2.y = y;
		var curSeq: Int;
		if (tile != null && tile == 0)
		{
			clear();
			return;
		}
		var t: Int;
		if (tile == null)
			t = 1;
		else
		{
			//trace(tile);
			if (tile < 0)
			{
				curSeq = (tile ^ gamelib2d.Def.TF_SEQUENCE) - 1;
				t = curSeq;//playertiles.getAnimationFrame (curSeq, timeCounter);
			}
			else
				t = tile-1;
		}
		t = t % playertiles.numTiles;
		
		var texture: BitmapData = new BitmapData(2 * 200, 2 * 200, true, 0x0);
		playertiles.drawTile(texture, 0, 0, t, 0);
		playertiles.drawTile(texture, 200, 0, t, 0);
		playertiles.drawTile(texture, 0, 200, t, 0);
		playertiles.drawTile(texture, 200, 200, t, 0);
		rball.len(surface, texture,
			new Point(
				100 + 200 - Utils.iAbs(Utils.safeMod(Std.int(x), 200)),
				100 + 200 - Utils.iAbs(Utils.safeMod(Std.int(y), 200))
			)
		);
		
	}

	public function drawShadow(insurf: BitmapData)
	{
		//mcPlayerShadow.x = x;
		//mcPlayerShadow.y = y;
		var shx: Int = Utils.iAbs(Utils.safeMod(Std.int(x), 48));
		var shy: Int = Utils.iAbs(Utils.safeMod(Std.int(y), 48));
		var offset: Float = z - Std.int(z);
		var alpha: Float = 1 - offset;
		mcPlayerShadow.alpha = alpha;
		clearShadow();
		surfaceShadow.copyPixels (bdShadow, new Rectangle(0,0,48,48), new Point (offset*48, offset*48)
			//, insurf, new Point(shx, shy), false
			);
	}
	
	public function clearShadow()
	{
		surfaceShadow.fillRect(new Rectangle(0, 0, 200, 200), 0x0);
	}	
	
	public function moveTo(X: Float, Y: Float)
	{
		fNewX = Std.int (X);
		fNewY = Std.int (Y);
		#if flash8
			mcPlayer2._x = fNewX;
			mcPlayer2._y = fNewY;
		#elseif flash9
			mcPlayer2.x = fNewX;
			mcPlayer2.y = fNewY;

		#end
		x = fNewX;
		y = fNewY;
	}
	
	public function moveToShadow(X: Float, Y: Float)
	{
		mcPlayerShadow.x = X+5;
		mcPlayerShadow.y = Y+5;
	}
	
	public function setColorTransformRGBA(rgba: RGBA)
	{
		if (colortransform != null)
		{
			colortransform.redMultiplier = rgba.r;
			colortransform.greenMultiplier = rgba.g;
			colortransform.blueMultiplier = rgba.b;
			colortransform.alphaMultiplier = rgba.a;
			setColorTransform(colortransform);
		}
	}
	
	public function update ()
	{
		timeCounter++;
		var rgba: RGBA= new RGBA(1,1,1,1);
		for (e in Effects)
		{
			e.update();

			switch (e.type)
			{
			case 1:
				var i:Float = e.timeCounter / e.length;
				rgba.r = (e.startRGBA.r) + ((e.endRGBA.r) - (e.startRGBA.r)) * i;
				rgba.g = (e.startRGBA.g) + ((e.endRGBA.g) - (e.startRGBA.g)) * i;
				rgba.b = (e.startRGBA.b) + ((e.endRGBA.b) - (e.startRGBA.b)) * i;
				rgba.a = (e.startRGBA.a) + ((e.endRGBA.a) - (e.startRGBA.a)) * i;
				setColorTransformRGBA(rgba);
			case 2:
				if (e.isChange())
				{
					rgba = flapo.RGBA.getRGBAFromCT(colortransform);
					e.startRGBA = rgba;
				}
				if (e.timeCounter > e.changeState)
				{
					var i:Float = (e.timeCounter-e.changeState) / (e.length-e.changeState);
					rgba.r = (e.startRGBA.r) + ((e.endRGBA.r) - (e.startRGBA.r)) * i;
					rgba.g = (e.startRGBA.g) + ((e.endRGBA.g) - (e.startRGBA.g)) * i;
					rgba.b = (e.startRGBA.b) + ((e.endRGBA.b) - (e.startRGBA.b)) * i;
					rgba.a = (e.startRGBA.a) + ((e.endRGBA.a) - (e.startRGBA.a)) * i;
					setColorTransformRGBA(rgba);
				}
			default:
				trace("Invalid Effect.type");
			}
			if (e.isEnd())
				EffectsRemove.add(e);
		}
		for (e in EffectsRemove)
		{
			Effects.remove(e);
		}
		EffectsRemove.clear();
	}
	
	public function changeScale(gscale: Float)
	{
		scale = gscale;
		#if flash9
			mcPlayer2.scaleX = scale;
			mcPlayer2.scaleY = scale;
		#elseif flash8
			mcPlayer2._xscale = 100 * scale;
			mcPlayer2._yscale = 100 * scale;
		#end
	}

	public function changeScaleShadow(gscale: Float)
	{
		//scale = gscale;
		#if flash9
			mcPlayerShadow.scaleX = gscale;
			mcPlayerShadow.scaleY = gscale;
		#elseif flash8
			mcPlayerShadow._xscale = 100 * gscale;
			mcPlayerShadow._yscale = 100 * gscale;
		#end
	}
	
	public function changeAlpha(galpha: Float)
	{
		mcPlayer2.alpha = galpha;
	}
	
	public function changeAlphaShadow(galpha: Float)
	{
		mcPlayerShadow.alpha = galpha;
	}
	
	public function changeDepth(depth: Int)
	{
		#if flash10
			mcPlayer.z = depth;
		#end
	}
	/*
	public function setDepth0 (newContainer: Sprite)
	{
		mcContainer.removeChild (mcPlayer);
		mcContainer = newContainer;
		mcContainer.addChild (mcPlayer);
	}
	
	public function setDepth (newContainer: Sprite)
	{
		mcContainer.removeChild (bitmap);
		mcContainer = newContainer;
		mcContainer.addChild (bitmap);
	}	
	*/
	public function setDepth2 (newContainer: Sprite)
	{
		mcPlayer.removeChild (mcPlayerShadow);
		mcPlayer.removeChild (mcPlayer2);
		mcPlayer = newContainer;
		mcPlayer.addChild (mcPlayerShadow);
		mcPlayer.addChild (mcPlayer2);
	}
	
	public function setColorTransform(ct: ColorTransform)
	{
		bitmap.transform.colorTransform = ct;
		colortransform = ct;
	}
	
	public function destroy()
	{
		mcPlayerShadow.removeChild(bitmapShadow);
		mcPlayer2.removeChild(bitmap);
		mcPlayer.removeChild (mcPlayerShadow);
		mcPlayer.removeChild (mcPlayer2);
		mcPlayer2 = null;
		mcPlayerShadow = null;
		bitmap = null;
		bitmapShadow = null;
	}
	
	public function changexyz(gx: Float, gy: Float, ?gz: Float)
	{
		x = gx;
		y = gy;
		if (gz != null) z = gz;
	}
	
	public function addEffect(e: Effect)
	{
		if (e == null) return;
		Effects.add(e);
	}
	
	public function clearEffects()
	{
		Effects.clear();
	}
	
	public function changeColorTransform(rgba: RGBA, length: Int,
		?change: Int = 0, ?type: Int = 1)
	{
		var e: Effect;
		if (colortransform == null) return;
		var fromRGBA:RGBA = flapo.RGBA.getRGBAFromCT(colortransform);
		if (type == 1)
		{
			e = findEffectType(1);
			if (e != null)
				Effects.remove(e);
			if (fromRGBA.equal(rgba))
				return;
		}
		e = new Effect(0, 0, 0, type, length);
		e.setRGBA(fromRGBA, rgba);
		if (type != 1)
		{
			e.setState(0, 1, change);
		}
		Effects.add(e);
	}
	
	public function findEffectType(type: Int) : Effect
	{
		var res : Effect = null;
		for (e in Effects)
		{
			if (e.type == type)
			{
				res = e;
				return e;
			}	
		}
		return null;
	}
}