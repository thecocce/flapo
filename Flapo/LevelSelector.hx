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
import flapo.TextObj;
import flapo.Dict;
import flash.filters.GlowFilter;
import flash.events.MouseEvent;
import flapo.Score;



class LevelSelector 
{
	public var players: Array<LevelPlayer>;
	public var mc: Sprite;
	public var mcContainer: Sprite;
	public var playerTileSet: TileSet;
	var timer: Int;
	var bubble: Sprite;
	var texts: Array<TextObj>;
	var dict: Dict;
	var bubbleCounter: Int;
	static var maxBubbleCounter: Int = 5;
	var lastBubbleX: Float;
	var lastBubbleY: Float;
	var bubbleHighlighted: Bool;
	var board: Int;
	
	
	public function new(screen, tileset: TileSet, gdict: Dict) 
	{
		var p: Player;
		var lp: LevelPlayer;
		var ls: LevelState;
		mc = new Sprite();
		mcContainer = screen;
		mcContainer.addChild(mc);
		//mc.scaleX = 0.8;
		//mc.scaleY = 0.8;
		playerTileSet = tileset;
		players = new Array<LevelPlayer>();
		for (i in 0 ... 30)
		{
			p = new Player(mc, playerTileSet);
			p.changeScale(1.0);
			p.moveTo((i % 10) * 50+25, Std.int(i / 10) * 100+50);
			ls = new LevelState();
			lp = new LevelPlayer(p, ls);
			players.push(lp);
		}
		players[10].state.unlock();
		players[11].state.unlock();
		players[12].state.unlock();
		players[13].state.unlock();
		players[14].state.unlock();
		players[15].state.unlock();
		players[12].state.score = 1000;
		players[13].state.medal = 1;
		players[13].state.score = 1200;
		players[14].state.medal = 2;
		players[14].state.score = 1400;
		players[15].state.medal = 3;
		players[15].state.score = 1600;
	
		for (p in players)
			p.setCTbyState();
		timer = 0;
		
		//bubble text
		bubble = new Sprite();
		//gamelib2d.Utils.drawCircle(bubble, 30, 30, 30);
		gamelib2d.Utils.drawBubble(bubble, 0, 0, 10, 90, 45);
		
		mc.addChild(bubble);
		bubble.x = 100;
		bubble.y = 100;
		bubble.alpha = 0.7;
		bubble.visible = false;
		bubble.addEventListener(MouseEvent.MOUSE_OVER,this.highlightBubble);
		bubble.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightBubble);
		//bubble.graphics.filters = [new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)];
		dict = gdict;
		texts = new Array<TextObj>();
		var ts = new flash.text.TextFormat();
		ts.font="Times New Roman";
		ts.size = 10;
		ts.color=0x000000;
		var text: TextObj = new TextObj(bubble, dict, 7, -45, -55, 90, 20,
			ts, true, 
//			[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)]
			null,true); //no visible
		texts.push(text);
		text = new TextObj(bubble, dict, 9, -45, -42, 90, 20,
			ts, true,
			//[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)],
			null, true); //no visible
		texts.push(text);
		text = new TextObj(bubble, dict, 13, -45, -28, 45, 20,
			ts, true,
			//[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)],
			null, true); //no visible
		text.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.submitScoreEvent);
		text.tf.addEventListener(MouseEvent.MOUSE_OVER,this.submitScoreOver);
		text.tf.addEventListener(MouseEvent.MOUSE_OUT,this.submitScoreOut);

		texts.push(text);
		text = new TextObj(bubble, dict, 14, 0, -28, 45, 20,
			ts, true,
			//[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)],
			null, true); //no visible
		text.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.showScoreEvent);
		text.tf.addEventListener(MouseEvent.MOUSE_OVER,this.showScoreOver);
		text.tf.addEventListener(MouseEvent.MOUSE_OUT,this.showScoreOut);		texts.push(text);
		bubbleCounter = 0;
		bubbleHighlighted = false;
		board = 0;
	}
	
	public function hide()
	{
		mc.visible = false;
	}
	
	public function show()
	{
		mc.visible = true;
	}
	
	public function draw()
	{
		for (p in players)
		{
			p.draw();
		}
		if (bubbleCounter>0)
		{
			bubble.visible=true;
			bubble.scaleX=bubbleCounter/(maxBubbleCounter);
			bubble.scaleY=bubbleCounter/(maxBubbleCounter);
		}
		else
			bubble.visible=false;
	}
	
	public function process()
	{
		timer++;
		for (p in players)
		{
			p.process();
		}
		if (bubbleCounter<0)
			bubbleCounter=0;
		if (bubbleCounter>maxBubbleCounter)
			bubbleCounter = maxBubbleCounter;
		if (bubbleHighlighted)
			bubbleCounter = maxBubbleCounter;
	}
	
	public function hover (x : Int, y : Int)
	{
	//players[5].activate();
		var found: Bool = false;
		var i = 0;
		for (p in players)
		{
			if (!p.state.lock)
			{
				if (p.hover(x, y))
				{
					p.activate();
					p.roll(0.5, 0.5);
					if (bubble.x-24 == p.player.x && bubble.y-10 == p.player.y)
						bubbleCounter++;
					else
					{
						if (!bubbleHighlighted)
							bubbleCounter--;
						if (bubbleCounter <= 0)
						{
							bubble.x = p.player.x+24;
							bubble.y = p.player.y+10;
							bubble.visible = true;
							if (p.state.score > 0)
								texts[0].setText( dict.get(8) + p.state.score, true);
							else
								texts[0].setText( dict.get(7), true);
							texts[1].setText ( dict.get(9 + p.state.medal), true);
							if (p.state.score == 0)
								texts[2].tf.visible = false;
							else
								texts[2].tf.visible = true;
							board = i;
						}
					}
					found = true;
				}
				else
					p.deactivate();
			}
			++i;
		}
		if (!found)
		{
			if (!bubbleHighlighted)
				bubbleCounter--;
		}
	}
	
	public function down(x : Int, y : Int)
	{
	//players[5].activate();
		for (p in 0 ... players.length)
		{
			if (players[p].hover(x, y))
			{
				return p + 1;
/*				if (p.state.lock)
					p.state.unlock();
				else
					p.state.setlock();
*/			}
		}
		return -1;
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
	
	public function changeMC (newContainer: Sprite)
	{
		for (p in players)
		{
			p.changeMC(newContainer);
		}

		mcContainer.removeChild (mc);
		mc.removeChild (bubble);
		mc = newContainer;
		mcContainer.addChild (mc);
		mc.addChild (bubble);
	}
	
	public function highlightBubble(e:MouseEvent) {
		bubble.alpha = 1;
		bubbleHighlighted = true;
	}
	public function unhighlightBubble(e:MouseEvent) {
		bubble.alpha = 0.7;
		bubbleHighlighted = false;
	}
	public function submitScoreEvent(e:MouseEvent) {
		Score.submitScore(board, players[board].state.score);
	}
	public function showScoreEvent(e:MouseEvent) {
		Score.submitScore(board);
	}
	
	public function submitScoreOver(e:MouseEvent) {
		texts[2].setText( dict.get(15), true);
	}	
	public function submitScoreOut(e:MouseEvent) {
		texts[2].setText( dict.get(13), true);
	}	
	public function showScoreOver(e:MouseEvent) {
		texts[3].setText( dict.get(16), true);
	}	
	public function showScoreOut(e:MouseEvent) {
		texts[3].setText( dict.get(14), true);
	}	
	

		
}