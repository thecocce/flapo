
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Blocks extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class BlocksInfo extends TileSetData
{
  public function new ()
  {
    name = "Blocks";
    tileW = 48;
    tileH = 48;
    numTilesX = 5;
    numTilesY = 10;
    numTiles = 49;
    numSequences = 5;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Blocks ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [
   [7,2,512, 8,2,512, 9,2,512, 10,2,512],
   [11,2,512, 12,2,512, 13,2,512, 12,2,512],
   [13,5,1280, 14,5,1280, 15,5,1280, 16,5,1280],
   [17,0,0, 18,0,0, 19,0,0, 20,0,0, 21,0,0, 22,0,0, 23,0,0, 24,0,0, 25,0,0, 26,0,0, 27,0,0],
   [28,2,512, 29,2,512, 30,2,512, 31,4,1024] ];
  }
}
