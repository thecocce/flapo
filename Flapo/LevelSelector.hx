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
	static var goldMedalsSec: Array<Int> = 
		[ 2, 7, 16, 7, 11, 8, 11, 23, 17, 28,
		14, 16, 21, 21, 41, 22, 20, 13, 13, 43,
		35, 42, 55, 40, 27, 71, 120, 35, 300, 30];
	static var silverMult: Float = 1.1;
	static var bronzeMult: Float = 1.3;
	
	public function reset()
	{
		for (p in players)
		{
			p.state.reset();
		}
		players[0].state.unlock();
		players[10].state.unlock();
		players[20].state.unlock();
		var i: Int = 0;
		for (p in players)
		{
			p.setCTbyState();
			p.init();
			++i;
		}
	}

	public function initBubbles()
	{
		bubble.x = 100;
		bubble.y = 100;
	}
	
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
			p.moveTo((i % 10) * 50+25, Std.int(i / 10) * 100+100);
			ls = new LevelState();
			lp = new LevelPlayer(p, ls);
			players.push(lp);
		}
		reset();
		timer = 0;
		
		//bubble text
		bubble = new Sprite();
		//gamelib2d.Utils.drawCircle(bubble, 30, 30, 30);
		gamelib2d.Utils.drawBubble(bubble, 0, 0, 10, 90, 45);
		
		mc.addChild(bubble);
		initBubbles();
		bubble.alpha = 0.7;
		bubble.visible = false;
		bubble.addEventListener(MouseEvent.MOUSE_OVER,this.highlightBubble);
		bubble.addEventListener(MouseEvent.MOUSE_OUT,this.unhighlightBubble);
		//bubble.graphics.filters = [new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)];
		dict = gdict;
		texts = new Array<TextObj>();
		var ts;
		//ts = null;
		ts = new flash.text.TextFormat();
		//ts.font = "Times New Roman";
		ts.font = "ArialNarrowBold";
		ts.size = 12;
		ts.color=0x000000;
		var text: TextObj = new TextObj(bubble, dict, 7, -45, -55, 90, 20,
			ts, true, 
			null, //[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)],
			true); //no visible
		texts.push(text);
		text = new TextObj(bubble, dict, 9, -45, -42, 90, 20,
			ts, true,
			null, //[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)],
			true); //no visible
		texts.push(text);
		ts = null;
		text = new TextObj(bubble, dict, 13, -45, -28, 45, 20,
			ts, true,
			//[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)],
			null, true); //no visible
		text.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.submitScoreEvent);
		text.tf.addEventListener(MouseEvent.MOUSE_OVER,this.submitScoreOver);
		text.tf.addEventListener(MouseEvent.MOUSE_OUT,this.submitScoreOut);

		texts.push(text);
		#if !MindJolt
		text = new TextObj(bubble, dict, 14, 0, -28, 45, 20,
			ts, true,
			//[new GlowFilter(0xFF6666, 1.0, 3, 3, 3, 3, false, false)],
			null, true); //no visible
		text.tf.addEventListener(MouseEvent.MOUSE_DOWN,this.showScoreEvent);
		text.tf.addEventListener(MouseEvent.MOUSE_OVER,this.showScoreOver);
		text.tf.addEventListener(MouseEvent.MOUSE_OUT, this.showScoreOut);
		texts.push(text);
		#end
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
								texts[0].setText( dict.get(8) + Score.convertTime(p.state.score), true);
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
		for (p in 0 ... players.length)
		{
			if (players[p].state.lock == false && players[p].hover(x, y))
			{
				return p;
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
		for (p in players)
		{
			p.setCTbyState();
		}
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
#if !MindJolt
		texts[3].setText( dict.get(16), true);
#end
	}	
	public function showScoreOut(e:MouseEvent) {
#if !MindJolt
		texts[3].setText( dict.get(14), true);
#end
	}	
	
	//http://lists.motion-twin.com/pipermail/haxe/2006-June/003451.html
	public function getMedalTimes(glevel: Int, obj : {gold: Int, silver: Int, bronze: Int})
	{
		obj.gold = goldMedalsSec[glevel] * 1000;
		obj.silver = Std.int(obj.gold * silverMult);
		if (Std.int(obj.silver / 1000) == Std.int(obj.gold / 1000))
			obj.silver = Std.int(obj.gold + 1000);
		obj.bronze = Std.int(obj.gold * bronzeMult);
		if (Std.int(obj.bronze / 1000) <= Std.int(obj.silver / 1000))
			obj.bronze = obj.gold + 2000;
	}
	
	public function setCompleted(glevel: Int, gscore: Int, ?gmedal: Int = -1)
	{
		if (glevel >= players.length)
		{
			trace("glevel too big");
			return;
		}
		if (gmedal == -1)
		{
			var medalTimes = { gold: -1, silver: -1, bronze: -1 };

			getMedalTimes(glevel, medalTimes);
			if (gscore <= medalTimes.gold)
				gmedal = 3;
			else if (gscore <= medalTimes.silver)
				gmedal = 2;
			else if (gscore <= medalTimes.bronze)
				gmedal = 1;
			else
				gmedal = 0;
			trace("gold: " + medalTimes.gold + "silv: " + medalTimes.silver + "bronze: " + medalTimes.bronze);
			trace("medal: " + gmedal);
		}
		players[glevel].setCompleted(gscore, gmedal);
		bubbleCounter = 1;
	}
	
	public function unlock(glevel: Int)
	{
		if (glevel >= players.length)
		{
			trace("glevel too big");
			return;
		}
		trace("unlocking level:" + glevel);
		players[glevel].state.unlock();
		players[glevel].setCTbyState();
	}
	
	public function unlockAll()
	{
		for	(p in players)	
		{
			p.state.unlock();
			p.setCTbyState();
		}
	}
}