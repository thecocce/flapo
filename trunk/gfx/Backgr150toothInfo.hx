
import gamelib2d.MapData;

class Backgr150toothInfo extends MapData
{
  public function new ()
  {
    name = "tooth";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  3]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
