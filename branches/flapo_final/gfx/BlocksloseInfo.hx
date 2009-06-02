
import gamelib2d.MapData;

class BlocksloseInfo extends MapData
{
  public function new ()
  {
    name = "lose";
    mapW = 20;
    mapH = 7;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  6,  0,  0,  0,  0,  6,  6,  0,  0,  0,  6,  6,  0,  0,  6,  6,  6,  0,
      0,  0],
   [  6,  0,  0,  0,  6,  0,  0,  6,  0,  6,  0,  0,  0,  0,  6,  0,  0,  0,
      0,  0],
   [  6,  0,  0,  0,  6,  0,  0,  6,  0,  0,  6,  6,  0,  0,  6,  6,  0,  0,
      0,  0],
   [  6,  0,  0,  0,  6,  0,  0,  6,  0,  0,  0,  0,  6,  0,  6,  0,  0,  0,
      0,  0],
   [  6,  6,  6,  0,  0,  6,  6,  0,  0,  0,  6,  6,  0,  0,  6,  6,  6,  0,
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
