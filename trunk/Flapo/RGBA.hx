/**
 * ...
 * @author Bence Dobos
 */

package flapo;

import flash.geom.ColorTransform;

class RGBA 
{
	public var r: Float;
	public var g: Float;
	public var b: Float;
	public var a: Float;
	
	public function new(gr: Float, gg: Float, gb: Float, ?ga: Float=1.0) 
	{
		setRGBA(gr, gg, gb, ga);
	}
	
	public function setRGBA(gr: Float, gg: Float, gb: Float, ?ga: Float=1.0) 
	{
		r = gr;
		g = gg;
		b = gb;
		a = ga;
	}
	
	public static function getByteOneComponent(f: Float): Int
	{
		var i: Int = Std.int(f * 255);
		if (i > 255) i = 255;
		if (i < 0) i = 0;
		return i;
	}
	
	public function getHex()
	{
		var hr: Int = getByteOneComponent(r);
		var hg: Int = getByteOneComponent(g); 
		var hb: Int = getByteOneComponent(b);
		return hr << 16 + hg << 8 + hb;
	}
	
	public static function getRGBAFromCT(ct: ColorTransform) : RGBA
	{
		var rgba: RGBA = new RGBA(ct.redMultiplier, ct.greenMultiplier, ct.blueMultiplier);
		return rgba;
	}
	
	public function equal(other: RGBA)
	{
		if (r != other.r) return false;
		if (g != other.g) return false;
		if (b != other.b) return false;
		if (a != other.a) return false;
		return true;
		
	}
}