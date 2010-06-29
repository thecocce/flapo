
//import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Flag_en extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class Flag_en_Info
{
  public function new ()
  {
  }

#if flash9
  public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Flag_en ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end
}
