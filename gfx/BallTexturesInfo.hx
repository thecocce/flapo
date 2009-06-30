
import gamelib2d.MapData;

class BallTexturesInfo extends MapData
{
  public function new ()
  {
    name = "Textures";
    mapW = 10;
    mapH = 2;
  }

  override public function mapdata () : Array<Array<Int>> {
  return 
  [[  1,  2,  3,  4,  5,  6,  7,  8,  9, 10],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0]]; 
  }

  override public function boundmapdata () : Array<Array<Int>> {
  return 
  [[  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
   [  0,  0,  0,  0,  0,  0,  0,  0,  0,  0]]; 
  }
}
