/**
 * Containing one level!s data
 * @author Bence Dobos
 */

package flapo;

import flash.Boot;
import flash.display.BitmapData;
import flash.display.Sprite;
import gamelib2d.TileSet;
import gamelib2d.Layer;
import flapo.MyLayer;

class Level 
{
	public var startposx: Int;
	public var startposy: Int;
	public var startposz: Int; //which layer
	public var name: String;
	public var Layers: Array<MyLayer>;
	public var mcContainer: Sprite;
	
	public function new(screen: Sprite) 
	{
		mcContainer = screen;
		startposx = -1;
		startposy = -1;
		startposz = -1;
		Layers = new Array<MyLayer>();
	}
	
	public function addLayer(layer: Layer, xs: Float, ys: Float)
	{
		var mylayer = new MyLayer(layer, xs, ys, null);
		Layers.push(mylayer);
	}
	
	public function addMyLayer(mylayer: MyLayer)
	{
		Layers.push(mylayer);
	}
	
	public function findStartPos()
	{
		startposx = -1;
		startposy = -1;
		startposz = -1;
		var i: Int = 0;
		var rv: Bool = false;
		for (d in Layers)
		{
			rv = d.layer.findMapCode(1); //0x00 = start position
			if (rv)
			{
				startposx = d.layer.resultX;
				startposy = d.layer.resultY;
				startposz = i;
				break;
			}
			++i;
		}		
	}
	
	public function isBackground(layernum: Int): Bool
	{
		if ((layernum<0) || (layernum>Layers.length-1))
			return true;
		return Layers[layernum].isBackground;
	}
	
	public function clear()
	{
		for (obj in Layers)
			if (obj.layer != null)
			{
				if (obj.playerlayer != null)
					mcContainer.removeChild (obj.playerlayer);
				obj.playerlayer = null;
				obj.layer.clear();
//				obj.layer = null;
			}
		Layers = null;
	}
}