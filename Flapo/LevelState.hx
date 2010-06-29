/**
 * ...
 * @author Bence Dobos
 */

package flapo;

class LevelState implements Dynamic<Int>
{

	public var lock: Bool;
	public var completed: Bool;
	public var score: Int;
	public var medal: Int; //0-none, 1-bronze, 2-silver, 3-gold
	
	public function reset()
	{
		lock = true;
		completed = false;
		score = 0;
		medal = 0;		
	}
	
	public function new() 
	{
		reset();
	}

	public function convert(d: Dynamic)
	{
		lock = d.lock;
		completed = d.completed;
		score = d.score;
		medal = d.medal;
	}
	
	public function copy()
	{
		var res: LevelState = new LevelState();
		res.lock = lock;
		res.completed = completed;
		res.score = score;
		res.medal = medal;
		return res;
	}
	
	public function unlock()
	{
		lock = false;
	}

	public function setlock()
	{
		lock = true;
	}
	
	public function isLocked(): Bool
	{
		return lock;
	}
	
	public function setCompleted(gscore: Int, ?gmedal: Int = -1)
	{
		lock = false;
		completed = true;
		score = gscore;
		trace("setting score to " + gscore);
		if (gmedal >= 0)
			medal = gmedal;
	}
}