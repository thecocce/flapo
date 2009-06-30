
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Ball extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class BallInfo extends TileSetData
{
  public function new ()
  {
    name = "Ball";
    tileW = 200;
    tileH = 200;
    numTilesX = 1;
    numTilesY = 11;
    numTiles = 11;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Ball ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
