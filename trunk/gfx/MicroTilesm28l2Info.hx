
import gamelib2d.MapData;

class MicroTilesm28l2Info extends MapData
{
  public function new ()
  {
    name = "m28l2";
    mapW = 15;
    mapH = 15;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0, -1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0, 45, 45, 45, 45, 45,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0, 45,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0, 45,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [ 45, 45, -5, 45, 45, 45, -5, 45, 45,  0,  0,  0,  0,  0,  0],
   [ 45, -5, 45, 56, 45, 57, 45, -5, 45,  0,  0,  0,  0,  0,  0],
   [ 45, 45, 45, 45, 45, 45, 45, 45, 45,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0, 45, 45, 45,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0, -5, 45, -5,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0, 45, 45, 45,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [ 45, 45, -5, 45, 45, 45, -5, 45, 45,  0,  0,  0,  0,  0,  0],
   [ -5, 45, 45, 45, 45, 45, 45, 45, -5,  0,  0,  0,  0,  0,  0],
   [ 45, 45, 45, 45, 45, 45, 45, 45, 45,  0,  0,  0,  0,  0,  0]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,8448,  0,8704,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0]]; 
  }
}
