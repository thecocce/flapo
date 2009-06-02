
import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class New extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class NewInfo extends TileSetData
{
  public function new ()
  {
    name = "New";
    tileW = 48;
    tileH = 48;
    numTilesX = 3;
    numTilesY = 1;
    numTiles = 3;
    numSequences = 0;
  }

#if flash9
  override public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new New ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end

  override public function seq () : Array<Array<Int>> {
  return [ ];
  }
}
