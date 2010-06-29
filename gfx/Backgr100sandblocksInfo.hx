
import gamelib2d.MapData;

class Backgr100sandblocksInfo extends MapData
{
  public function new ()
  {
    name = "sandblocks";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
