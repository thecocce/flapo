
import gamelib2d.MapData;

class Abstract1m5Info extends MapData
{
  public function new ()
  {
    name = "m5";
    mapW = 3;
    mapH = 3;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  1,  1,  1],
   [  1,  1,  1],
   [  1,  1,  1]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0],
   [  0,  0,  0],
   [  0,  0,  0]]; 
  }
}
