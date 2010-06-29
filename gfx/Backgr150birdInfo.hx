
import gamelib2d.MapData;

class Backgr150birdInfo extends MapData
{
  public function new ()
  {
    name = "bird";
    mapW = 1;
    mapH = 1;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  2]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0]]; 
  }
}
