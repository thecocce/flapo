﻿/**
 * Contains all the LevelData's, maintains and inits any
 * @author Bence Dobos
 */

package flapo;

import flapo.LevelData;
import flash.display.Sprite;
import gamelib2d.TileSet;
import gamelib2d.Layer;
import gamelib2d.MapData;
import flash.geom.ColorTransform;

class LevelContainer 
{

	public var LevelDatas: Array<LevelData>;
	var maxLevel: Int;
	
	public function new() 
	{
		maxLevel = 1;
		var l: Int;
		LevelDatas = new Array<LevelData>();
		l = 0;
		var ld: LevelData;
		ld = new LevelData();
		ld.AddTile(new BackgroundInfo());
		ld.AddMap(new BackgroundMap1Info());
		LevelDatas.push(ld);

	}
	
	/*returns LevelData*/
	public function getLevel(levelnum: Int, screen: Sprite, scalefactor: Float, scaleoffset: Float) : Level
	{
		/*if (levelnum<0 || levelnum>maxLevel)
			return null;*/
		var retval: Level = null;
		var tiles: TileSet;
//		var layer: Layer;
		var numlayer: Int;
		var scale: Float;
		numlayer = 0;
		switch (levelnum)
		{
			case -2: //win
				retval = new Level();
				tiles = new TileSet (screen);
				tiles.init (new BlocksInfo ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new BlocksloseInfo(),
					8/10, 8/10, true, 0.2, 1.0, 1.0)); 			
			case -1: //win
				retval = new Level();
				tiles = new TileSet (screen);
				tiles.init (new BlocksInfo ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new BlockswinInfo(),
					8/10, 8/10, true, 0.2, 1.0, 1.0)); 

			case 0:
				retval = new Level();
				tiles = new TileSet (screen);
				tiles.init (new Abstract1Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Abstract1m4Info(), 0.5, 0.5, false));

				++numlayer;		
				tiles = new TileSet (screen);
				tiles.init (new Clouds1Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Clouds1back1Info(),
					0.5, 0.5, true, 1.0, 0.6));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new BlocksInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new BlocksBlocks2Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 

				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new BlocksMap1Info(),
					1.0, 1.0, true, scale, 1.0, scale));
			case 1:
				retval = new Level();
/*				tiles = new TileSet (screen);
				tiles.init (new BackgroundInfo ());  // BackgroundInfo.hx is generated by Tile Studio
				retval.addMyLayer(addNewLayer(screen, tiles, new BackgroundMap1Info(), 0.5, 0.5, false)); */
				retval = new Level();
				tiles = new TileSet (screen);
				tiles.init (new Abstract1Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Abstract1m1Info(), 0.5, 0.5, false)); 
				
				++numlayer;		
				tiles = new TileSet (screen);
				tiles.init (new Clouds1Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Clouds1back1Info(),
					0.5, 0.5, true, 1.0, 0.6));
					
				++numlayer;
				trace(1);
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new BlocksInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new Blocksm1l2Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
				trace(2);
				++numlayer;
				//++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new Blocksm1l1Info(),
					1.0, 1.0, true, scale, 1.0, scale)); 
			default:
				retval = null;
		}
		return retval;
		//return LevelDatas[levelnum];
	}
	
	public function addNewLayer(isBackground, screen: Sprite, tiles: TileSet, data: MapData,
		?xscroll: Float = 1.0, ?yscroll: Float = 1.0,
		?transparent: Bool = true, ?scale: Float = 1.0,
		?alpha: Float = 1.0, ?gamma: Float = 1.0) : MyLayer
	{
		var layer: Layer;
		layer = new Layer (screen);
		layer.init (tiles, data, transparent, scale, scale, mrp_tile, mrp_tile, true, true );
		var colortransform : ColorTransform;
		colortransform = new ColorTransform(gamma, gamma, gamma, alpha, 0, 0, 0, 0);
		layer.setColorTransform(colortransform);
		var mylayer: MyLayer = new MyLayer(layer, xscroll, yscroll, colortransform);
		mylayer.isBackground = isBackground;
		return mylayer;
	}
	
}