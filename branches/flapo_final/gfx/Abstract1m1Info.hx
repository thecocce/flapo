
import gamelib2d.MapData;

class Abstract1m1Info extends MapData
{
  public function new ()
  {
    name = "m1";
    mapW = 3;
    mapH = 3;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 24, 24, 24],
   [ 24, 24, 24],
   [ 24, 24, 24]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0],
   [  0,  0,  0],
   [  0,  0,  0]]; 
  }
}
