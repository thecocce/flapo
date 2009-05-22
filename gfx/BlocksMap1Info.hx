
import gamelib2d.MapData;

class BlocksMap1Info extends MapData
{
  public function new ()
  {
    name = "Map1";
    mapW = 24;
    mapH = 24;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  1,  0,  2,  2,  5,  6,  7,  1,  1,  4,  3,  3,  2,  4,  4,  2,  2,  2,
      2,  4,  3,  4,  4,  2],
   [  4,  0,  0,  0,  0,  0,  4,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      1,  3,  0,  0,  0,  2],
   [  1,  0, -1,  4,  3,  0,  3,  0,  0,  0,  0, -1,  4,  1,  2,  0,  0,  0,
      0,  4,  0,  0,  0,  1],
   [  1,  0,  0,  0,  3,  0,  3,  3,  0,  0,  0,  0,  4,  0,  2,  3,  4,  0,
      0,  4,  0,  0,  0,  2],
   [  2,  0,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  4,  0,  0,  0,  4,  0,
      0,  4,  0,  0,  0,  1],
   [  2,  0,  2,  1,  3,  0,  0,  0,  0,  3,  0,  0,  2,  0,  0,  0,  4,  0,
      0,  4,  0,  0,  0,  2],
   [  1,  0,  1,  0,  3,  0,  0,  2,  1,  3,  0,  0,  4,  0,  0,  0,  1,  0,
      0,  2,  0,  0,  0,  2],
   [  2,  0,  1,  0,  0,  0,  0,  0,  0,  3,  0,  0,  4,  0,  0,  0,  4,  0,
      0,  4,  0,  0,  0,  2],
   [  5,  0,  1,  0,  0,  0,  0,  0,  4,  3,  0,  0,  2,  0,  0,  0,  4,  0,
      0,  4,  0,  0,  0,  1],
   [  6,  0,  0,  0,  0,  0,  0,  0,  0,  3, -1,  0,  2,  0,  0,  0,  2,  0,
      0,  2,  0,  0,  0,  1],
   [  7,  0,  0,  0,  5,  2,  0,  0,  0,  2,  4,  2,  2,  0,  0,  0,  4,  0,
      0,  4,  0,  0,  0,  1],
   [  0,  0,  0,  0,  0,  4,  0,  0,  0,  0,  0,  0,  2,  0,  0,  0,  4,  2,
      4,  4,  2,  2,  2,  4],
   [  4,  0,  0,  4,  4,  4,  0,  0,  0,  0,  0,  0,  4,  2,  4,  0,  0,  0,
      0,  0,  0,  0,  2,  1],
   [  2,  0,  0,  0,  0,  3,  0,  0,  0,  2,  0,  0,  0,  0,  4,  0,  0,  0,
      0,  0,  0,  0,  0,  1],
   [  2,  2,  4,  4,  4,  4,  0,  0,  2,  0,  0,  0,  0,  0,  2,  0,  0,  0,
      0, -1,  0,  0,  0,  1],
   [  4,  0,  4,  0,  0,  4,  0,  0,  2,  0,  0,  0,  0,  0,  4,  2,  2,  5,
      0,  0,  0,  0,  0,  4],
   [  4,  0,  2,  0,  0,  5,  0,  0,  2,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  4],
   [  2,  0,  2,  0,  0,  0,  0,  0,  2,  4,  4,  1,  0,  0,  0,  0,  3,  3,
      3,  3,  1,  1,  3,  1],
   [  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  2,  2,  3,  0,  0,  0,  0,
      0,  0,  0,  3,  3,  1],
   [  2,  0,  0,  0,  4,  1,  2,  0,  0,  0,  0,  0,  4,  0,  0,  1,  0,  0,
      0,  0,  0,  3,  0,  1],
   [  1,  2,  4,  4,  3,  0,  0,  0,  0,  0,  0,  0,  4,  0, -1, -1,  4,  4,
      1,  0,  0,  3,  0,  1],
   [  2,  0,  0,  0,  4,  0,  0,  0,  0,  0,  0,  0,  4,  0, -1, -1,  3,  0,
      0,  0,  4,  4,  0,  1],
   [  2,  0,  0,  0,  0,  0,  0,  2,  2,  1,  4,  3,  2,  0,  0,  0,  0,  0,
      0,  0,  4,  0,  0,  4],
   [  2,  1,  4,  4,  4,  2,  1,  1,  1,  4,  4,  1,  2,  2,  2,  1,  1,  1,
      1,  2,  4,  2,  2,  2]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1<<8,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0,  0,  0,  0,  0]]; 
  }
}
