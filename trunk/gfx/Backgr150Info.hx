
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Backgr150 extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class Backgr150Info extends TileSetData
{
  public function new ()
  {
    name = "Backgr150";
    tileW = 150;
    tileH = 150;
    numTilesX = 1;
    numTilesY = 12;
    numTiles = 12;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Backgr150 ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
