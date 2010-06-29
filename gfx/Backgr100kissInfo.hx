
import gamelib2d.MapData;

class Backgr100kissInfo extends MapData
{
  public function new ()
  {
    name = "kiss";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 11]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
