
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
    numTilesY = 3;
    numTiles = 15;
    numSequences = 3;
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
   [7,16,4096, 8,16,4096, 9,16,4096, 8,16,4096],
   [10,4,1024, 11,4,1024, 12,4,1024, 11,4,1024],
   [12,5,1280, 13,5,1280, 14,5,1280, 15,5,1280] ];
  }
}
