
import gamelib2d.MapData;

class Backgr100ornamentInfo extends MapData
{
  public function new ()
  {
    name = "ornament";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  7]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
