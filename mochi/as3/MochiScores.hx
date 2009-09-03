package mochi.as3;

extern class MochiScores {
	static var onCloseHandler : Dynamic;
	static var onErrorHandler : Dynamic;
	static function closeLeaderboard() : Void;
	static function getPlayerInfo(callbackObj : Dynamic, ?callbackMethod : Dynamic) : Void;
	static function onClose(?args : Dynamic) : Void;
	static function requestList(callbackObj : Dynamic, ?callbackMethod : Dynamic) : Void;
	static function scoresArrayToObjects(scores : Dynamic) : Dynamic;
	static function setBoardID(boardID : String) : Void;
	static function showLeaderboard(?options : Dynamic) : Void;
	static function submit(score : Float, name : String, ?callbackObj : Dynamic, ?callbackMethod : Dynamic) : Void;
}
