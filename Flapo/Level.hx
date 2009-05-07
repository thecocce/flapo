/**
 * Containing one level!s data
 * @author Bence Dobos
 */

package flapo;

import flash.display.BitmapData;
import gamelib2d.TileSet;
import gamelib2d.Layer;
import flapo.MyLayer;

class Level 
{

	public var name: String;
	public var Layers: Array<MyLayer>;
	
	public function new() 
	{
		Layers = new Array<MyLayer>();
	}
	
	public function AddLayer(layer: Layer, xs: Float, ys: Float)
	{
		var mylayer = new MyLayer(layer, xs, ys);
		Layers.push(mylayer);
	}
}