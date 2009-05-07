/**
 * Containing one level!s data
 * @author Bence Dobos
 */

package flapo;

import gamelib2d.Layer;

class MyLayer 
{

	public var layer: Layer;
	public var xscroll: Float;
	public var yscroll: Float;
		
	public function new(gl: Layer, xs: Float, ys: Float)
	{
		layer = gl;
		xscroll = xs;
		yscroll = ys;
	}
}