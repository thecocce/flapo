/**
 * ...
 * @author Bence Dobos
 */

package flapo;

import flash.display.Bitmap;
import flash.display.BitmapData;
import BlocksInfo;
import flash.display.MovieClip;
import flash.display.Sprite;
import gamelib2d.TileSet;
import flash.geom.Rectangle;

class Player 
{

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
	public var bitmap: Bitmap;
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
	
	public function new(screen) 
	{
		//player init
		playertiles = new TileSet (screen);
		playertiles.init (new BlocksInfo ());
		mcContainer = screen;
		surface = new BitmapData (100, 100, true, 0x0);

	//	#if flash9
			mcPlayer = new Sprite ();
			bitmap = new Bitmap(surface);
			mcPlayer.addChild (bitmap);
			mcContainer.addChild (mcPlayer);
			//mcContainer.addChild (bitmap);
	/*	#elseif flash8
			var Depth = flash.Lib._root.getNextHighestDepth ();
			mcplayer = mcContainer.createEmptyMovieClip ("player", 2);
			mcplayer.attachBitmap (surface, 99);
		#end*/
		
		timeCounter = 0;
		scale = 1.0;
	}

	public function clear()
	{
		surface.fillRect (new Rectangle (0, 0, playertiles.tileW, playertiles.tileH), 0);

	}
	
	public function draw(?tile:Int)
	{
		mcPlayer.x = x;
		mcPlayer.y = y;
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
	
	public function moveTo(X: Float, Y: Float)
	{
		fNewX = Std.int (X);
		fNewY = Std.int (Y);
		#if flash8
			mcPlayer._x = fNewX;
			mcPlayer._y = fNewY;
		#elseif flash9
			mcPlayer.x = fNewX;
			mcPlayer.y = fNewY;
		#end
		x = fNewX;
		y = fNewY;
	}
	
	public function update ()
	{
		timeCounter++;
	}
	
	public function changeScale(gscale: Float)
	{
		scale = gscale;
		#if flash9
			mcPlayer.scaleX = scale;
			mcPlayer.scaleY = scale;
		#elseif flash8
			mcPlayer._xscale = 100 * scale;
			mcPlayer._yscale = 100 * scale;
		#end
	}
	
	public function changeAlpha(galpha: Float)
	{
		mcPlayer.alpha = galpha;
	}
	
	public function changeDepth(depth: Int)
	{
		#if flash10
			mcPlayer.z = depth;
		#end
	}
	
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

	public function setDepth2 (newContainer: Sprite)
	{
		mcPlayer.removeChild (bitmap);
		mcPlayer = newContainer;
		mcPlayer.addChild (bitmap);
	}		
	
	public function changexyz(gx: Float, gy: Float, ?gz: Float)
	{
		x = gx;
		y = gy;
		if (gz != null) z = gz;
	}
}