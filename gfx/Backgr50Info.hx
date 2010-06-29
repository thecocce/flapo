
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Backgr50 extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class Backgr50Info extends TileSetData
{
  public function new ()
  {
    name = "Backgr50";
    tileW = 50;
    tileH = 50;
    numTilesX = 4;
    numTilesY = 4;
    numTiles = 16;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Backgr50 ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
