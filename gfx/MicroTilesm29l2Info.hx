
import gamelib2d.MapData;

class MicroTilesm29l2Info extends MapData
{
  public function new ()
  {
    name = "m29l2";
    mapW = 15;
    mapH = 15;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  5,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  5,  0,  0,  0,  0,  0,  0,  6,  6,  6],
   [  0,  0,  0,  0,  0,  5,  0,  0,  0,  0,  0,  0,  6,  0,  6],
   [  0,  0,  0,  0,  0,  5,  0,  0,  0,  0,  0,  0,  6, 30,  6],
   [  0,  0,  0,  0,  0,  5,  5,  0,  0,  0, 33, 33, 33,  1,  0],
   [  0,  0,  0,  0,  0,  0, 31, 31,  0,  0, 33,  0, 33,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0, 31, 31, 33, 35, 33, 33,  0,  0],
   [  0,  0,  0,  0,  0,  0, 31, 31,  0,  0, 33,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0, 31,  0,  0,  0, 33,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0, 31,  0, -5, 36, 33,  0,  0,  0,  0]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4352,4352,4352],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4352,  0,4352],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4352,20736,4352],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,4096,4096,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,  0,4096,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,20480,4096,4096,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,8448,4096,  0,  0,  0,  0]]; 
  }
}
