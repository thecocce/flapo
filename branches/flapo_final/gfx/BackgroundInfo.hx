
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Background extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class BackgroundInfo extends TileSetData
{
  public function new ()
  {
    name = "Background";
    tileW = 32;
    tileH = 32;
    numTilesX = 8;
    numTilesY = 1;
    numTiles = 8;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Background ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
