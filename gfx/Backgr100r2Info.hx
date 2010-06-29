
import gamelib2d.MapData;

class Backgr100r2Info extends MapData
{
  public function new ()
  {
    name = "r2";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 10]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
