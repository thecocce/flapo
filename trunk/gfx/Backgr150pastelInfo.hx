
import gamelib2d.MapData;

class Backgr150pastelInfo extends MapData
{
  public function new ()
  {
    name = "pastel";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  5]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
