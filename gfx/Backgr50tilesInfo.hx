
import gamelib2d.MapData;

class Backgr50tilesInfo extends MapData
{
  public function new ()
  {
    name = "tiles";
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
