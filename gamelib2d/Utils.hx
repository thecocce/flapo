package gamelib2d;

#if flash9
	import flash.net.LocalConnection;
#end

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
	
	
#if flash9	
	public static function gc ()
	{
		// unsupported hack that seems to force a full GC
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
