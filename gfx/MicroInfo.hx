
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Micro extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class MicroInfo extends TileSetData
{
  public function new ()
  {
    name = "Micro";
    tileW = 48;
    tileH = 48;
    numTilesX = 5;
    numTilesY = 3;
    numTiles = 0;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Micro ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
