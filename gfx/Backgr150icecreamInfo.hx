
import gamelib2d.MapData;

class Backgr150icecreamInfo extends MapData
{
  public function new ()
  {
    name = "icecream";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  1]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
