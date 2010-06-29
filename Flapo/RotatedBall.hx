/**
 * Creating a rolling ball with texture. Using the zoom effect.
 * @author Bence Dobos
 */

package flapo;

import flash.display.BitmapData;
import flash.geom.Point;

class RotatedBall
{	
	public var transtab: Array < Array < Point >> ;
	public var shade: BitmapData ;
	public var LENRAD: Int;
	//public var surface: BitmapData;
/**
 * Filling a zoomMatrix
 * @param	int d origo distance
 * @param	int r radius
 */
public function tabfill(d: Int, r: Int)
{
  var x: Int;
  var y: Int;
  var z: Float;
  		transtab = new Array < Array < Point >> ();
		var ins: Array<Point>;
		for (i in 0 ... 2*LENRAD)
		{
			ins = new Array<Point>();
			transtab.insert(i, ins);
			for (j in 0 ... 2*LENRAD)
				transtab[i].insert(j, new Point(0,0));
		}
  
  for(x in -LENRAD ... LENRAD)
  for(y in -LENRAD ... LENRAD)
  {
    if (x*x+y*y<=r*r) //bent van e a korben
    {
      z = Math.sqrt(d*d-x*x-y*y+r*r)/5+1;
      transtab[Std.int(x + LENRAD)][Std.int(y + LENRAD)].x = Std.int((x * d) / (z + d) * 4 + LENRAD);
      transtab[Std.int(x + LENRAD)][Std.int(y + LENRAD)].y = Std.int((y * d) / (z + d) * 4 + LENRAD);
    }
    else //ha nincs, akkor marad
    {
      transtab[x + LENRAD][y + LENRAD].x = -99;//x+LENRAD;
      transtab[x + LENRAD][y + LENRAD].y = -99;// y + LENRAD;
    }
  }
}
/*
A cuccos ki van szamolva.

Ennyi maga az effekt:
*/
/**
 * 
 */
public function len (surface: BitmapData, fromImg: BitmapData, offset: Point)
{
	//surface.setPixel32(8, 8, 0xffff0000);
	//trace (LENRAD);
  var x: Int;
  var y: Int;
  x=Std.int(offset.x - LENRAD);
  y=Std.int(offset.y - LENRAD);
  for(n in 0 ... 2*LENRAD)
  for(m in 0 ... 2*LENRAD)
  {
	  if (transtab[n][m].x == -99)
		surface.setPixel32(n, m, 0x00000000);
	  else
		surface.setPixel32(n, m,
			fromImg.getPixel32(Std.int(x + transtab[n][m].x), Std.int(y + transtab[n][m].y))
			//0xffffff00
		);

  }
}

 public function new(gsize: Int)
 {
	LENRAD = Std.int( gsize / 2 );
//	surface = new BitmapData (2 * LENRAD, 2 * LENRAD, true, 0x0);
 }
 
}