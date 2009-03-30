/**
 * Containing one level's metadata
 * @author Bence Dobos
 */

package flapo;

import flash.display.BitmapData;
import gamelib2d.TileSet;
import gamelib2d.Layer;

class LevelData 
{

	public var name: String;
	public var TileSets: Array <TileSet>;
	public var Layers: Array<Layer>;
	
	public function new() 
	{
		TileSets = new Array<TileSet>();
		Layers = new Array<Layer>();
	}
	
	public function AddTile(tile: Class<BitmapData>)
	{

	}
}