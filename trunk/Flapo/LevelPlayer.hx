/**
 * ...
 * @author Bence Dobos
 */

package flapo;

import flapo.Player;
import flapo.LevelState;

class LevelPlayer 
{
	public var player: Player;
	public var state: LevelState;
	public var timer: Int;
	public var glowstrength: Int;
	public var rollspeedX: Float;
	public var rollspeedY: Float;
	static private var rollslowdown = 0.3;
	public var rollX: Float;
	public var rollY: Float;
	public var needRedraw: Bool;
	
	public function new(p: Player, s: LevelState) 
	{
		player = p;
		state = s;
		timer = 0;
		glowstrength = 0;
		rollspeedX = 0;
		rollspeedY = 0;
		needRedraw = true;
		rollX = 0;
		rollY = 0;
	}
	
	public function draw()
	{
		if (needRedraw)
		{
			player.drawBall(3 + (state.lock?0:1) + state.medal);
			needRedraw = false;
		}
	}
	
	public function process()
	{
		timer++;
		if (gamelib2d.Utils.rAbs(rollspeedX) < rollslowdown)
			rollspeedX = 0
		else
			rollspeedX += rollspeedX > 0? -rollslowdown:rollslowdown;
		if (gamelib2d.Utils.rAbs(rollspeedY) < rollslowdown)
			rollspeedY = 0
		else
			rollspeedY += rollspeedY > 0? -rollslowdown:rollslowdown;
		if (rollspeedX != 0 && rollspeedY != 0)
		{
			rollX += rollspeedX;
			rollY += rollspeedY;
			needRedraw = true;
		}
		player.changerollxy(rollX, rollY);
	}
	
	public function hover(x: Int, y: Int)
	{
		if (player.x < x && player.x + 48 > x &&
			player.y < y && player.y + 48 > y)
			{
				return true;
			}
		return false;
	}
	
	public function activate()
	{
		if (state.lock)
			return;
		#if vyes18
			return
		#end
		//trace(9);
		if (glowstrength < 5)
			glowstrength += 10;
		else if (glowstrength < 20)
			glowstrength += 3;
		else
			glowstrength++;
		if (glowstrength > 30) glowstrength = 30;
		player.setFilter(glowstrength, glowstrength/5);
	}
	
	public function deactivate()
	{
		if (glowstrength > 0)
		{
			--glowstrength;
			if (glowstrength != 0)
				player.setFilter(glowstrength, glowstrength / 5);
			else
				player.deleteFilter();
		}
	}
	
	public function roll(rx: Float, ry: Float)
	{
		rollspeedX += rx;
		rollspeedY += ry;
		if (gamelib2d.Utils.rAbs(rollspeedX) > 100 * rollslowdown)
			rollspeedX = (rollspeedX > 0?1: -1) * 100 * rollslowdown;
		if (gamelib2d.Utils.rAbs(rollspeedY) > 100 * rollslowdown)
			rollspeedY = (rollspeedY > 0?1: -1) * 100 * rollslowdown;
	}
}