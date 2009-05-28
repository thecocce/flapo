/**
 * Containing one level!s data
 * @author Bence Dobos
 */

package flapo;

import flash.geom.ColorTransform;
import gamelib2d.Layer;

class MyLayer 
{

	public var layer: Layer;
	public var colort: ColorTransform;
	public var xscroll: Float;
	public var yscroll: Float;
	public var isBackground: Bool;
		
	public function new(gl: Layer, xs: Float, ys: Float, ct: ColorTransform)
	{
		layer = gl;
		xscroll = xs;
		yscroll = ys;
		if (ct != null) colort = ct;
		isBackground = false;
	}
	
	public function setAlpha(alpha: Float)
	{
		//colort.alphaMultiplier = alpha;
		layer.setAlpha(alpha);
	}
}