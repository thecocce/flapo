
import gamelib2d.MapData;

class Abstract1m4Info extends MapData
{
  public function new ()
  {
    name = "m4";
    mapW = 3;
    mapH = 3;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  4,  4,  4],
   [  4,  4,  4],
   [  4,  4,  4]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0],
   [  0,  0,  0],
   [  0,  0,  0]]; 
  }
}
