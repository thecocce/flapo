
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Clouds1 extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class Clouds1Info extends TileSetData
{
  public function new ()
  {
    name = "Clouds1";
    tileW = 32;
    tileH = 32;
    numTilesX = 6;
    numTilesY = 3;
    numTiles = 18;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Clouds1 ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
