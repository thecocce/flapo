
import gamelib2d.MapData;

class Blocksm2l1Info extends MapData
{
  public function new ()
  {
    name = "m2l1";
    mapW = 16;
    mapH = 13;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0, 11, 35, 11,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0, 11,  0, 33,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0, 36,  0, 11,  2,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0, -1, 11,  0, 36,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0, 33,  0, 11,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0, 11, 35, 11,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,4096,4096,4096,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,4096,  0,4096,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,4096,  0,4096,256,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,4096,  0,4096,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,4096,  0,4096,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,4096,4096,4096,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0]]; 
  }
}
