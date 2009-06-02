
//import gamelib2d.TileSetData;

#if flash9
import flash.display.Bitmap;
import flash.display.BitmapData;

class Winback extends BitmapData
{
    public function new()
    {
        super(0,0);
    }
}
#end

class WinbackInfo
{
	public var width: Int;
	public var height: Int;
  public function new ()
  {
	  width = 300;
	  height = 300;
  }

#if flash9
  public function getBitmap (): Bitmap
  {
    var bd: BitmapData;
    bd = new Winback ();
    return new flash.display.Bitmap (bd, flash.display.PixelSnapping.AUTO, true);
  }
#end
}
