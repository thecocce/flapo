
import gamelib2d.MapData;

class Backgr100blueInfo extends MapData
{
  public function new ()
  {
    name = "blue";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  8]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
