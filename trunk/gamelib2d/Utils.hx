package gamelib2d;

#if flash9
	import flash.net.LocalConnection;
#end
import flash.display.Sprite;
import flash.display.BitmapData;

class Utils
{
	public static inline function boolToInt (b: Bool): Int { return b? 1 : 0; }
	public static inline function intToBool (i: Int): Bool { return (i != 0)? true : false; }

	public static inline function rgb (r: Int, g: Int, b: Int): Int { return b + (g << 8) + (r << 16); }
	public static inline function rgba (r: Int, g: Int, b: Int, ?a: Int = 0xFF): Int { return b + (g << 8) + (r << 16) + (a << 24); }
	
	public static inline function sgn (x: Int) { if (x == 0) return 0; else if (x > 0) return 1; else return -1; }
	
	public static function xor (b1: Bool, b2: Bool): Bool
	{
		if (b1 && b2)
			return false;
		else
			return (b1 || b2);
	}
	
	public static function safeDiv (x: Float, n: Float): Int
	{
		return Std.int (x / n - ((x < 0)? 1 : 0));
	}

	public static function safeMod (x: Int, y: Int)
	{
		var z: Int = x % y;
		if (z < 0)
			z += y;
		return z;
	}

	public static function iAbs (X: Int)
	{
		if (X < 0) return -X else return X;
	}
	
	public static function rAbs (X: Float)
	{
		if (X < 0) return -X else return X;
	}

	public static function iRnd (n: Int): Int
	{
		return Std.int ((Math.random () * n) - (Math.random () * n));
	}

	public static function rRnd (n: Float): Float  
	{
		return ((Math.random () * n) - (Math.random () * n));
	}

	public static var randSeed1: Int = 0;
	public static var randSeed2: Int = 0;
	
	public static function rnd (?n: Int = 0)
	{
		randSeed1 = (randSeed1 + 0x152 + randSeed2) << 1;
		randSeed2 = (randSeed2 ^ 0x259) + randSeed1;
		randSeed1 = ((randSeed1 << 1) + randSeed2) & 0xFFFF;
		randSeed2 = ((randSeed2 & 0xFF) << 8) + ((randSeed2 & 0xFF00) >> 8);
		if (n == 0)
			return randSeed1;
		else
			return (randSeed1 % n);
	}

    public static function drawCircle(mc:Sprite, x:Float, y:Float, r:Float) {
      mc.graphics.beginFill(0xE5E5E5,100);
      mc.graphics.moveTo(x+r, y);
      mc.graphics.curveTo(r+x, Math.tan(Math.PI/8)*r+y, Math.sin(Math.PI/4)*r+x,
      Math.sin(Math.PI/4)*r+y);
      mc.graphics.curveTo(Math.tan(Math.PI/8)*r+x, r+y, x, r+y);
      mc.graphics.curveTo(-Math.tan(Math.PI/8)*r+x, r+y, -Math.sin(Math.PI/4)*r+x,
      Math.sin(Math.PI/4)*r+y);
      mc.graphics.curveTo(-r+x, Math.tan(Math.PI/8)*r+y, -r+x, y);
      mc.graphics.curveTo(-r+x, -Math.tan(Math.PI/8)*r+y, -Math.sin(Math.PI/4)*r+x,
      -Math.sin(Math.PI/4)*r+y);
      mc.graphics.curveTo(-Math.tan(Math.PI/8)*r+x, -r+y, x, -r+y);
      mc.graphics.curveTo(Math.tan(Math.PI/8)*r+x, -r+y, Math.sin(Math.PI/4)*r+x,-Math.sin(Math.PI/4)*r+y);
      mc.graphics.curveTo(r+x, -Math.tan(Math.PI/8)*r+y, r+x, y);
      mc.graphics.endFill();
    }
       /* draw an filled arc with center at x,y and radius r, clockwise with 0<=hour<=12
    */
	  public static function drawArc(mc:Sprite, x:Float, y:Float, r:Float, hour:Int) {
      mc.graphics.beginFill(0xC0C0C0,0.6);
      var i:Int;
      var alpha : Float;
      var beta : Float;
      var delta: Float;
      var maxVal;// :Int = 12;
      maxVal = 30;
      i=0;
      alpha = Math.PI;
      //delta = Math.PI/6;
      delta = Math.PI*2/maxVal;
      mc.graphics.moveTo(x,y);
      mc.graphics.lineTo(x+Math.sin(alpha)*r,y+Math.cos(alpha)*r);
      if(hour<0){
        hour=0;
      }else if(hour>maxVal){
        hour=maxVal;
      }
      while(i<hour){
        beta = alpha - delta/2;
        alpha = alpha - delta;
        mc.graphics.curveTo(
          x+Math.sin(beta)*r,y+Math.cos(beta)*r,
          x+Math.sin(alpha)*r,y+Math.cos(alpha)*r);
        i++;
      }
      mc.graphics.lineTo(x,y);
      mc.graphics.endFill();
    }
	
	static function drawThing(mc: Sprite)
	{
	
	}
	
#if flash9	
	public static function gc ()
	{
		// unsupported hack that seems to force a full GC
		// http://marcel-panse.blogspot.com/2007/09/garbage-collection.html
		// Garbage Collection hack
		try
		{
			var lc1: LocalConnection = new LocalConnection();
			var lc2: LocalConnection = new LocalConnection();

			lc1.connect('name');
			lc2.connect('name');
		}
		catch (e: Dynamic)
		{
		}
	}
#end
	
}
