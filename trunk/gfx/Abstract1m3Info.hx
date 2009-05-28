
import gamelib2d.MapData;

class Abstract1m3Info extends MapData
{
  public function new ()
  {
    name = "m3";
    mapW = 3;
    mapH = 3;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  3,  3,  3],
   [  3,  3,  3],
   [  3,  3,  3]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0],
   [  0,  0,  0],
   [  0,  0,  0]]; 
  }
}
