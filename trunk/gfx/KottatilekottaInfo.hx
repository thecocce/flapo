
import gamelib2d.MapData;

class KottatilekottaInfo extends MapData
{
  public function new ()
  {
    name = "kotta";
    mapW = 4;
    mapH = 5;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  1,  2,  3,  4],
   [  5,  6,  7,  8],
   [  9, 10, 11, 12],
   [ 13, 14, 15, 16],
   [ 17, 18, 19, 20]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0],
   [  0,  0,  0,  0],
   [  0,  0,  0,  0],
   [  0,  0,  0,  0],
   [  0,  0,  0,  0]]; 
  }
}
