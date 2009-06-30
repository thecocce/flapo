package flapo;
import flash.net.SharedObject;

class Savegame {
	public var localInfo: SharedObject;

	public function new()
	{
		localInfo = SharedObject.getLocal("test");
	}
	
    public function saveScore(score: Int) {
    	localInfo.data.score = score;
    }

	public function loadScore(def: Int)
	{
		if (localInfo.data.score == null/*undefined*/) {
			return def;
		}
		return localInfo.data.score;
	}
}
