
import gamelib2d.MapData;

class Backgr100squareInfo extends MapData
{
  public function new ()
  {
    name = "square";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 13]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
