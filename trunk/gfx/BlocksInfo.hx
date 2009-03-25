
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
    numTilesX = 3;
    numTilesY = 2;
    numTiles = 6;
    numSequences = 0;
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
  return [ ];
  }
}
