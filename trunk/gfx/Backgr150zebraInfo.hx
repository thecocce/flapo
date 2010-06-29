
import gamelib2d.MapData;

class Backgr150zebraInfo extends MapData
{
  public function new ()
  {
    name = "zebra";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  4]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
