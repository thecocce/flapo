package flapo;
import flash.net.SharedObject;
import flapo.LevelState;

class Savegame {
	public var localInfo: SharedObject;

	public function new()
	{
		localInfo = SharedObject.getLocal("test");
		//for (prop in localInfo.data) {
			//trace(prop+": "+localInfo.data[prop]);
		//}
	}

    public function saveMoreTexture(moreTexture: Bool) {
    	localInfo.data.moretext = moreTexture;
    }	
	
    public function saveScore(score: Int) {
    	localInfo.data.score = score;
    }

	public function saveArray(a: Array<LevelState> ) {
		trace("save array");
		trace (a);
    	localInfo.data.a = a.copy();
		localInfo.flush();
    }
	
	public function saveState(a: LevelState ) {
		trace("save LevelState");
    	localInfo.data.b = a.copy();
		localInfo.flush();
    }
	
	public function loadState() : Dynamic {
		trace("load LevelState");
		if (localInfo.data.b == null/*undefined*/) {
			trace("load failed");
			return null;
		}
		trace(localInfo.data.b);
		return localInfo.data.b;
    }
	
	public function loadMoreTexture(def: Bool)
	{
		if (localInfo.data.moretext == null/*undefined*/) {
			return def;
		}
		return localInfo.data.moretext;
	}	
	
	public function loadScore(def: Int)
	{
		if (localInfo.data.score == null/*undefined*/) {
			return def;
		}
		return localInfo.data.score;
	}
	
	public function loadArray(): Array<Dynamic>
	{
		trace("load array");
		if (localInfo.data.a == null/*undefined*/) {
			trace("load failed");
			return null;
		}
		return localInfo.data.a;
	}

}
