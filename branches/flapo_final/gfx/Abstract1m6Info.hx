
import gamelib2d.MapData;

class Abstract1m6Info extends MapData
{
  public function new ()
  {
    name = "m6";
    mapW = 3;
    mapH = 3;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 27, 27, 27],
   [ 27, 27, 27],
   [ 27, 27, 27]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0],
   [  0,  0,  0],
   [  0,  0,  0]]; 
  }
}
