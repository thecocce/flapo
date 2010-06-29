
import gamelib2d.MapData;

class MicroTilesm3l2Info extends MapData
{
  public function new ()
  {
    name = "m3l2";
    mapW = 20;
    mapH = 20;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, -5,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 33,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 33,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0, 33, 33, 33,  0, 12, 12, 12,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0, 33, 12, 35, 35, 12, 12, 12,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0, 33, 33, 33,  0, 12, 12, 12,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 12, 12, 12, -1,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 12,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,4096,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,4096,4096,4096,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,4096,  0,20480,20480,  0,  0,  0,  0,  0,  0,
      0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,4096,4096,4096,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
      0,  0]]; 
  }
}
