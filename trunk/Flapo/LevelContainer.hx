﻿/**
 * Contains all the LevelData's, maintains and inits any
 * @author Bence Dobos
 */

package flapo;

import flapo.LevelData;
import flash.display.Sprite;
import gamelib2d.TileSet;
import gamelib2d.Layer;
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
		if (levelnum<0 || levelnum>maxLevel)
			return null;
		var retval: Level;
		var tiles: TileSet;
		var layer: Layer;
		var numlayer: Int;
		var scale: Float;
		numlayer = 0;
		switch (levelnum)
		{
			case 0:
				retval = new Level();
				trace(0);
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new BackgroundInfo ());  // BackgroundInfo.hx is generated by Tile Studio
				layer = new Layer (screen);
				layer.init (tiles, new BackgroundMap1Info (), false, scale, scale, mrp_tile, mrp_tile, true, true);
				//retval.TileSets.push(tiles);
				retval.AddLayer(layer, 1/2, 1/2);
				//retval.AddScroll (1 / 2, 1 / 2);

				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new BlocksInfo ());
				layer = new Layer (screen);
				layer.init (tiles, new BlocksBlocks2Info (), true, scale, scale, mrp_tile, mrp_tile, true, true );
				var colortransform : ColorTransform;
#if inverse
				colortransform = new ColorTransform(2.0, 2.0, 2.0, 1, 0, 0, 0, 0);
#else
				colortransform = new ColorTransform(scale, scale, scale, 1, 0, 0, 0, 0);
#end
				layer.setColorTransform(colortransform);
				retval.AddLayer(layer, 8/10, 8/10);
				//retval.AddScroll (1, 1);
				trace(1);
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;				
				layer = new Layer (screen);
				layer.init (tiles, new BlocksMap1Info (), true, scale, scale, mrp_tile, mrp_tile, true, true);
				//retval.Layers.push(layer);
				retval.AddLayer(layer, 1, 1);
				//retval.AddScroll( 2 / 3,  2 / 3);
		
				/*
				var colortransform : ColorTransform;
				colortransform = new ColorTransform(0.6, 0.6, 0.6, 1, 0, 0, 0, 0);
				foregroundLayer2.setColorTransform(colortransform);
				*/
				
				//delete colortransform;
				//colortransform = new ColorTransform(1, 1, 1, 0.6, 0, 0, 0, 0);
				//foregroundLayer.setColorTransform(colortransform
			default:
				retval = null;
		}
		return retval;
		//return LevelDatas[levelnum];
	}
	
}