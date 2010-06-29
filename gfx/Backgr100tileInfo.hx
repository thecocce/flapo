
import gamelib2d.MapData;

class Backgr100tileInfo extends MapData
{
  public function new ()
  {
    name = "tile";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 14]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
