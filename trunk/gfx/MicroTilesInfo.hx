
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class MicroTiles extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class MicroTilesInfo extends TileSetData
{
  public function new ()
  {
    name = "MicroTiles";
    tileW = 48;
    tileH = 48;
    numTilesX = 5;
    numTilesY = 6;
    numTiles = 29;
    numSequences = 5;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new MicroTiles ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [
   [12,2,512, 12,2,512, 12,2,512, 12,2,512],
   [13,5,1280],
   [11,5,1280],
   [14,0,0, 15,0,0, 16,0,0, 17,0,0, 18,0,0, 19,0,0, 20,0,0, 21,0,0, 22,0,0, 23,0,0, 24,0,0],
   [25,2,512, 26,2,512, 27,2,512, 28,4,1024] ];
  }
}
