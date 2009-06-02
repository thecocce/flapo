
import gamelib2d.MapData;

class Abstract1m2Info extends MapData
{
  public function new ()
  {
    name = "m2";
    mapW = 3;
    mapH = 3;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 25, 25, 25],
   [ 25, 25, 25],
   [ 25, 25, 25]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0],
   [  0,  0,  0],
   [  0,  0,  0]]; 
  }
}
