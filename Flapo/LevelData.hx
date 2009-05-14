/**
 * Containing one level's metadata
 * @author Bence Dobos
 */

package flapo;

import flash.display.BitmapData;
import gamelib2d.MapData;
import gamelib2d.TileSetData;

class LevelData 
{

	public var name: String;
	public var MapDatas: Array<MapData>;
	public var theBitmapData: TileSetData;
	
	public function new() 
	{
		MapDatas = new Array<MapData>();
		theBitmapData = null;
	}
	
	public function AddTile(tile: TileSetData)
	{
		theBitmapData = tile;
	}
	
	public function AddMap(map: MapData)
	{
		MapDatas.push(map);
	}
}