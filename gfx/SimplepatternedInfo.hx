
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Simplepatterned extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class SimplepatternedInfo extends TileSetData
{
  public function new ()
  {
    name = "Simplepatterned";
    tileW = 48;
    tileH = 48;
    numTilesX = 5;
    numTilesY = 1;
    numTiles = 5;
    numSequences = 5;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Simplepatterned ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [
   [1,2,512, 2,2,512, 3,2,512, 4,2,512],
   [4,5,1280, 1,5,1280],
   [1,32,8192],
   [1,2,512, 0,2,512, 1,2,512, 0,2,512, 1,2,512],
   [4,5,1280, 3,5,1280] ];
  }
}
