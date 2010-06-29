
import gamelib2d.MapData;

class Backgr100tvInfo extends MapData
{
  public function new ()
  {
    name = "tv";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 12]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
