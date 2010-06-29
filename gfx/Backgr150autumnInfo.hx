
import gamelib2d.MapData;

class Backgr150autumnInfo extends MapData
{
  public function new ()
  {
    name = "autumn";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  6]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
