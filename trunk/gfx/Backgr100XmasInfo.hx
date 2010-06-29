
import gamelib2d.MapData;

class Backgr100XmasInfo extends MapData
{
  public function new ()
  {
    name = "Xmas";
    mapW = 2;
    mapH = 2;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  1,  1],
   [  1,  1]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0],
   [  0,  0]]; 
  }
}
