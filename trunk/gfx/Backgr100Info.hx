
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Backgr100 extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class Backgr100Info extends TileSetData
{
  public function new ()
  {
    name = "Backgr100";
    tileW = 100;
    tileH = 100;
    numTilesX = 2;
    numTilesY = 8;
    numTiles = 15;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Backgr100 ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
