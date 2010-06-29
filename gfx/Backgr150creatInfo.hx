
import gamelib2d.MapData;

class Backgr150creatInfo extends MapData
{
  public function new ()
  {
    name = "creat";
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
