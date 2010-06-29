/**
 * ...
 * @author Bence Dobos
 */

package flapo;

#if MochiScores
import mochi.haxe.MochiScores;
#end

#if MochiScores2
import mochi.as3.MochiScores;
#end

#if MindJolt
import apis.mindjolt.MindJolt;
#end

class Score 
{
	static var o: Dynamic = { n: [
		//Level 1 (0)
		[8, 13, 4, 13, 10, 6, 13, 6, 6, 1, 6, 11, 8, 13, 14, 10],
		[12, 7, 8, 9, 4, 0, 5, 8, 8, 4, 6, 1, 0, 9, 7, 14],
		[4, 2, 5, 15, 0, 5, 0, 6, 14, 11, 5, 3, 0, 11, 12, 8],
		[13, 8, 3, 4, 15, 5, 13, 15, 10, 11, 14, 7, 12, 1, 12, 10],
		[13, 4, 13, 10, 0, 5, 7, 2, 3, 6, 7, 13, 7, 13, 10, 15],
		[2, 1, 14, 3, 10, 13, 12, 15, 0, 2, 10, 8, 2, 4, 0, 6],
		[0, 1, 0, 9, 5, 8, 2, 6, 11, 4, 4, 1, 5, 9, 14, 1],
		[14, 8, 15, 6, 6, 0, 14, 12, 8, 14, 6, 5, 12, 5, 13, 8],
		[4, 2, 12, 10, 5, 4, 2, 7, 15, 0, 9, 2, 9, 11, 5, 9],
		[6, 12, 7, 9, 15, 3, 11, 5, 4, 14, 6, 8, 8, 5, 15, 15],
		//Level 10 (9)
		[6, 8, 9, 10, 1, 0, 9, 0, 15, 10, 5, 7, 3, 4, 1, 6],
		[11, 5, 6, 7, 6, 12, 1, 15, 7, 11, 7, 7, 15, 1, 11, 7],
		[15, 14, 10, 1, 8, 15, 14, 8, 11, 5, 0, 3, 15, 12, 0, 8],
		[5, 1, 14, 14, 10, 8, 11, 6, 14, 1, 11, 3, 4, 1, 9, 10],
		[15, 8, 4, 11, 11, 5, 7, 11, 8, 12, 5, 6, 12, 4, 11, 12],
		[7, 6, 7, 12, 0, 4, 12, 1, 5, 6, 15, 7, 3, 10, 12, 13],
		[11, 9, 6, 10, 12, 0, 6, 7, 3, 13, 15, 8, 9, 3, 14, 9],
		[2, 12, 8, 5, 0, 1, 6, 14, 4, 5, 10, 10, 13, 13, 3, 7],
		[11, 1, 9, 8, 7, 11, 4, 2, 14, 10, 9, 13, 1, 5, 8, 14],
		//Level 20 (19)
		[11, 1, 11, 0, 15, 7, 7, 8, 2, 8, 7, 13, 10, 4, 7, 3],
		[2, 4, 8, 11, 11, 5, 10, 7, 1, 11, 0, 7, 9, 0, 6, 8],
		[12, 1, 1, 6, 3, 13, 5, 6, 7, 2, 13, 14, 11, 12, 3, 1],
		[5, 2, 12, 0, 10, 10, 5, 14, 1, 9, 0, 14, 6, 4, 10, 11],
		[14, 1, 5, 9, 7, 13, 6, 12, 1, 6, 3, 8, 15, 14, 5, 0],
		[14, 15, 10, 4, 10, 5, 10, 12, 5, 9, 1, 9, 3, 0, 10, 12],
		[7, 15, 15, 2, 2, 3, 6, 9, 3, 12, 13, 0, 15, 3, 14, 12],
		[13, 3, 2, 5, 12, 0, 12, 15, 15, 2, 2, 3, 3, 0, 1, 13],
		[15, 5, 0, 12, 9, 4, 7, 12, 3, 7, 1, 8, 11, 2, 15, 2],
		[10, 7, 3, 1, 3, 11, 13, 2, 13, 8, 8, 7, 8, 8, 11, 4],
		[7, 5, 9, 4, 5, 4, 11, 5, 5, 2, 10, 11, 10, 2, 5, 0],
		] };
		
	public static function GetBoardID(Board:Int, i:Int, s:String): String
	{
		if (s.length == 16) return s;
		return GetBoardID(Board,i+1,s + o.n[Board][i].toString(16));
	}
	
	public static function submitScore(gboard: Int, ?gscore: Int=0)
	{
#if MochiScores
		trace("show leaderboard");
		var boardID:String = GetBoardID(gboard, 0, "");
		MochiScores.showLeaderboard({boardID: boardID, score: gscore>0?gscore:null});
//				MochiScores.showLeaderboard({boardID: boardID});
#end
#if MochiScores2
		trace("show leaderboard");
		var o:Dynamic = null;
		o = { n: [8, 13, 4, 13, 10, 6, 13, 6, 6, 1, 6, 11, 8, 13, 14, 10],
			f: function(i:Int,s:String):String {
				if (s.length == 16) return s;
				return o.f(i+1,s + o.n[i].toString(16));
			}
		};
		var boardID:String = o.f(0, "");
//				MochiScores.showLeaderboard({boardID: boardID, score: playerscore});
		MochiScores.showLeaderboard({boardID: boardID});
#end
#if MindJolt
	if (MindJolt.MindJoltAPI)
	{
			var board:Int = gboard + 1;
			MindJolt.MindJoltAPI.service.submitScore(gscore > 0?gscore:null, "Level" + gboard);
			trace("MINDJOLT score submit" + "Level" + board);
	}
#end
	}
	
	public static function convertTime(gtime: Int, bMS: Bool=false, MSDigits: Int = 2): String
	{
		var t: Int=gtime;
		var hour: Int=Std.int(t/1000/60/60);
		t=t-hour*1000*60*60;
		var min: Int=Std.int(t/1000/60);
		t=t-min*1000*60;
		var sec: Int=Std.int(t/1000);
		t = t - sec * 1000;
		var res: String = "";
		if (hour > 0)
		{
			if (hour < 10) res = "0"+hour;
			else res = "" + hour;
			res = res + ":";
		}
		if (min < 10) res = res + "0" + min;
		else res = res + min;
		res = res + "'";
		if (sec < 10) res = res + "0" + sec;
		else res = res + sec;
		if (bMS)
		{
			var ms: String = "";
			var substract: Int = 0;
			trace (t);
			for (i in 0 ... MSDigits)
			{
				var digit: Int = Std.int( (t - substract) / Math.pow(10, 2 - i));
				trace(digit);
				substract += Std.int(digit * Math.pow(10, 2 - i));
				trace(substract);
				ms = ms + digit;
				trace(ms);
			}
			return res + "." + ms;
		}
		else
			return res;
	}
}