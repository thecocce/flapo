
import gamelib2d.MapData;

class Backgr100purpleInfo extends MapData
{
  public function new ()
  {
    name = "purple";
    mapW = 1;
    mapH = 4;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  2],
   [  3],
   [  4],
   [  5]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0],
   [  0],
   [  0],
   [  0]]; 
  }
}
