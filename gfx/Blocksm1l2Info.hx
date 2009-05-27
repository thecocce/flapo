
import gamelib2d.MapData;

class Blocksm1l2Info extends MapData
{
  public function new ()
  {
    name = "m1l2";
    mapW = 16;
    mapH = 10;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  2,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  3,  0,  0,  0,  4,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  4,  3,  3,  3,  3,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,512,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,4096,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,4096,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,4096,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,32768,4096,4096,4096,4096,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0]]; 
  }
}
