/**
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
	public var maxLevel: Int;
	
	public function new() 
	{
		maxLevel = 29;
		//maxLevel = 0;
	}
	
	/*returns LevelData*/
	public function getLevel(levelnum: Int, screen: Sprite, scalefactor: Float, scaleoffset: Float) : Level
	{
		/*if (levelnum<0 || levelnum>maxLevel)
			return null;*/
		var retval: Level = null;
		var tiles: TileSet;
		var cloudTiles: TileSet;
//		var layer: Layer;
		var numlayer: Int;
		var scale: Float;
		numlayer = 0;
		cloudTiles = new TileSet (screen);
		cloudTiles.init (new Clouds1Info ());
		switch (levelnum)
		{
			case 25:
			//garden
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150toothInfo(), 0, 0, false)); 

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 2.0, 0.6));
					
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm23l1Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm23l2Info(),
					1.0, 1.0, true, scale, 1.0, scale));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 2.0, 0.4));
			case 11:
			//cow
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150birdInfo(), 0, 0, false)); 

				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm24l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back3Info(),
					3, 2, true, 1.0, 0.4));
			case 10:
			//cat
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150autumnInfo(), 0, 0, false)); 
					
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm25l1Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
				++numlayer;
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 1.0, 0.5));
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 2.0, 0.2));
			case 9:
			//racetrack
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150zebraInfo(), 0, 0, false));
				
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					1, 0, true, 0.5, 0.6));
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back3Info(),
					2, 0.5, true, 0.8, 0.4));
					
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm26l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;	
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					3, -1, true, 2.0, 0.4));
			case 14:
			//racetrack 2
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150zebraInfo(), 0, 0, false)); 
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back3Info(),
					0.7, -0.3, true, 1.0, 0.4));					
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm27l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					3, -0.2, true, 2.0, 0.3));
			case 20:
			//apple
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100purpleInfo(), 0, 0, false)); 

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					-2, -1, true, 0.3, 0.3));
					
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm28l2Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm28l1Info(),
					1.0, 1.0, true, scale, 1.0, scale));
			case 18:
			//bubblo bobble
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100r2Info(), 0, 0, false));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm2l1Info (),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					-1, 0.7, true, 0.7, 0.4));					
			case 12:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150pastelInfo(), 0, 0, false));

				++numlayer;
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.6, 0.3));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back3Info(),
					1, 0.4, true, 1.0, 0.2));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm1l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					2, 0, true, 1.5, 0.2));
			case 8:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100ornamentInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.1));

				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm3l2Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm3l1Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
			case 13:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150pastelInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.1));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 1.0, 0.2));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm4l1Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
			case 16:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100squareInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					-0.8, 0.5, true, 0.5, 0.6));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm5l1Info(),
					8/10, 8/10, true, scale, 1.0, scale)); 
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm5l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
					
			case 15:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100pastelstarInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					2, 0, true, 0.4, 0.4));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					1, 0.5, true, 1.0, 0.3));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm6l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back3Info(),
					0.7, 0.4, true, 1.0, 0.2));
					
			case 19:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100pastelstarInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					3, 0.5, true, 0.6, 0.4));
					
				//++numlayer;		
				//retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					//0.5, 0.5, true, 1.0, 0.2));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm7l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm7l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
			case 21:
			//girls
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100kissInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					-1, 0, true, 0.3, 0.5));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm8l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm8l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
			case 28:
			//virag
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100ornamentInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0, 0, true, 1, 0.4));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm9l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm9l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
			case 0:
			//first
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100r2Info(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.4));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 1.0, 0.3));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm10l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new NewInfo ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new NewIntroInfo(),
					0, 0, true, scale, 1.0, scale));										
			case 1:
			//second
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100r2Info(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.5));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm11l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm11l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new NewInfo ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new NewIntro2Info(),
					0, 0, true, scale, 1.0, scale));			
										
			case 4:
			//second colorchange
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr50Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr50circlesInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.8, 0.8, true, 0.4, 0.6));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm12l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm12l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 1.0, 0.3));
			case 26:
			//xmas
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100XmasInfo(), 0, 0, false));

				++numlayer;	
				tiles = new TileSet (screen);
				tiles.init (new Backgr50Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr50snowInfo(),
					0, -1.2, true, 0.4, 0.5));
					
				//++numlayer;		
				//retval.addMyLayer(addNewLayer(true, screen, tiles, new Clouds1back1Info(),
					//0.5, 0.5, true, 1.0, 0.2));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm13l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm13l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
										
			case 22:
			//Billiard
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr50Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr50circlesInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 0.4, 0.6));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm14l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm14l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
										
			case 6:
			//first clock
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100tvInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					1, 1, true, 0.6, 0.4));
					
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm15l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm15l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
										
			case 27: 
			//hard
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100tileInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					-2, 0.5, true, 0.4, 0.3));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm29l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm29l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
										
			case 2:
			//all colorchanger (first?)
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr50Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr50circlesInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.4));
					
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm16l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
//				++numlayer;		
//				scale = scalefactor * numlayer + scaleoffset;
//				tiles = new TileSet (screen);
//				tiles.init (new NewInfo ());
//				retval.addMyLayer(addNewLayer(true, screen, tiles, new NewIntro3Info(),
//					0, 0, true, scale, 1.0, scale));					
				++numlayer;
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
				0.5, 0.5, true, 1.0, 0.3));
										
			case 5:
			//stairway to heaven
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100squareInfo(), 0, 0, false));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm17l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm17l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm17l3Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm17l4Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm17l5Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
			case 23:
			//Invaders
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr50Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr50invadersInfo(), 0, 0, false));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm18l4Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm18l3Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm18l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm18l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
			case 24:
				//fish
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr150Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr150aquaInfo(), 0, 0, false));

				//++numlayer;		
				//retval.addMyLayer(addNewLayer(true, screen, tiles, new Clouds1back1Info(),
					//0.5, 0.5, true, 1.0, 0.2));
				
				++numlayer;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new MicroTilesm19lbackInfo(),
					0, 2, true, 0.5, 0.4));	 //Background!	
				++numlayer;	
				scale = scalefactor * numlayer + scaleoffset;				
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm19l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm19l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;	
				retval.addMyLayer(addNewLayer(true, screen, tiles, new MicroTilesm19lbackInfo(),
					0, 2, true, 1.3, 0.1));	 //Background!	
			case 17:
				//kotta
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new KottatileInfo ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new KottatilekottaInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					2, -1, true, 0.4, 0.6));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm20l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
			case 7:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100blueInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.4));
									
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm21l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm21l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm21l3Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));					
			case 3:
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr50Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr50circlesInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.5));
					
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm22l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 0.8, 0.4));
			case 29:
			//last
				retval = new Level(screen);
				tiles = new TileSet (screen);
				tiles.init (new Backgr100Info ());
				retval.addMyLayer(addNewLayer(true, screen, tiles, new Backgr100rainbowInfo(), 0, 0, false));

				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back2Info(),
					0.5, 0.5, true, 0.4, 0.1));
					
				++numlayer;		
				retval.addMyLayer(addNewLayer(true, screen, cloudTiles, new Clouds1back1Info(),
					0.5, 0.5, true, 1.0, 0.2));
				
				++numlayer;		
				scale = scalefactor * numlayer + scaleoffset;
				tiles = new TileSet (screen);
				tiles.init (new MicroTilesInfo ());
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm30l2Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
				++numlayer;
				scale = scalefactor * numlayer + scaleoffset;
				retval.addMyLayer(addNewLayer(false, screen, tiles, new MicroTilesm30l1Info(),
					8 / 10, 8 / 10, true, scale, 1.0, scale));
					default:
				trace("Missing level");
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
		var playerlayer: Sprite;
		playerlayer = new Sprite();
		mylayer.playerlayer = playerlayer;
		screen.addChild(playerlayer);
		return mylayer;
	}
	
}