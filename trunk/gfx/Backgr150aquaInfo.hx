
import gamelib2d.MapData;

class Backgr150aquaInfo extends MapData
{
  public function new ()
  {
    name = "aqua";
    mapW = 5;
    mapH = 5;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  7,  7,  7,  7,  7],
   [  7,  7,  7,  7,  7],
   [  8,  7,  9,  7, 10],
   [ 11, 11, 11, 11, 11],
   [ 11, 11, 11, 11, 11]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0]]; 
  }
}
