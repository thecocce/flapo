/**
 * ...
 * @author Bence Dobos
 */

package flapo;

import flapo.Player;
import flapo.LevelState;
import flapo.LevelPlayer;
import flash.display.Sprite;
import gamelib2d.TileSet;

class LevelSelector 
{
	public var players: Array<LevelPlayer>;
	public var mc: Sprite;
	public var playerTileSet: TileSet;
	var timer: Int;
	
	public function new(screen, tileset: TileSet) 
	{
		var p: Player;
		var lp: LevelPlayer;
		var ls: LevelState;
		mc = new Sprite();
		//screen.addChild(mc);
		//mc.scaleX = 0.8;
		//mc.scaleY = 0.8;
		playerTileSet = tileset;
		players = new Array<LevelPlayer>();
		for (i in 0 ... 30)
		{
			p = new Player(screen, playerTileSet);
			p.changeScale(1.0);
			p.moveTo((i % 10) * 55+5, Std.int(i / 10) * 100+50);
			ls = new LevelState();
			lp = new LevelPlayer(p, ls);
			players.push(lp);
		}
		players[0].state.unlock();
		timer = 0;
	}
	
	public function draw()
	{
		for (p in players)
		{
			p.draw();
		}
	}
	
	public function process()
	{
		timer++;
		for (p in players)
		{
			p.process();
		}
	}
	
	public function hover (x : Int, y : Int)
	{
	//players[5].activate();
		for (p in players)
		{
			if (!p.state.lock)
			{
				if (p.hover(x, y))
				{
					p.activate();
					p.roll(0.5, 0.5);
				}
				else
					p.deactivate();
			}
		}
	}
	
	public function down(x : Int, y : Int)
	{
	//players[5].activate();
		for (p in players)
		{
			if (p.hover(x, y))
			{
				if (p.state.lock)
					p.state.unlock();
				else
					p.state.setlock();
			}
		}
	}
	
	public function setStates(states: Array<LevelState>)
	{
		if (states == null)
		{
			trace("Got null");
			return;
		}
		if (states.length == players.length)
		{
			trace(states);
			for (i in 0 ... states.length)
			{
				players[i].state = states[i];
				players[i].needRedraw = true;
			}
		}
		else
			trace("ERROR: size != size");	
	}
	
	public function getStates() : Array<LevelState>
	{
		var states: Array<LevelState> = new Array<LevelState>();
		for (p in players)
		{
				states.push(p.state);
		}
		return states;
	}
}