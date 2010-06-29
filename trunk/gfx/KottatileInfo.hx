
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Kottatile extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class KottatileInfo extends TileSetData
{
  public function new ()
  {
    name = "Kottatile";
    tileW = 100;
    tileH = 100;
    numTilesX = 2;
    numTilesY = 11;
    numTiles = 21;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Kottatile ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
