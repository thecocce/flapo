/**
 * ...
 * @author Bence Dobos
 */

package flapo;

class Effect 
{
	public var numLayer: Int;
	public var x: Int;
	public var y: Int;
	public var timeCounter: Int;
	public var length: Int;
	public var type: Int; //type of effect
	public var state: Int;
	public var startState: Int; //1-solid
	public var endState: Int;
	public var changeState: Int; //if (timecounter==changeState) 

	public function new(gx: Int, gy: Int, gz: Int, gtype: Int, glength: Int) 
	{
		numLayer = gz;
		x = gx;
		y = gy;
		type = gtype;
		timeCounter = 0;
		length = glength;
		startState = 0;
		endState = 0;
		changeState = -1;
		state = startState;
	}
	
	public function setState(start: Int, end: Int, change:Int)
	{
		startState = start;
		endState = end;
		changeState = change;
		state = startState;
	}
	
	public function update()
	{
		++timeCounter;
		if (timeCounter == changeState)
			state = endState;
	}
	
	public function isChange(): Bool
	{
		if (timeCounter == changeState)
			return true;
		return false;
	}
	
	public function isEnd(): Bool
	{
		if (timeCounter >= length)
			return true;
		else
			return false;
	}
	
}