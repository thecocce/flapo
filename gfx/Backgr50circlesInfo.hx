
import gamelib2d.MapData;

class Backgr50circlesInfo extends MapData
{
  public function new ()
  {
    name = "circles";
    mapW = 6;
    mapH = 6;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[ 12, 13, 14, 15, 13, 12],
   [ 13, 12, 13, 14, 15, 14],
   [ 15, 14, 15, 12, 13, 14],
   [ 13, 14, 12, 14, 15, 13],
   [ 12, 15, 13, 13, 14, 12],
   [ 14, 13, 12, 14, 13, 14]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0]]; 
  }
}
