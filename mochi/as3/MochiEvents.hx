package mochi.as3;

extern class MochiEvents {
	static var ACHIEVEMENT_RECEIVED : String;
	static var ALIGN_BOTTOM : String;
	static var ALIGN_BOTTOM_LEFT : String;
	static var ALIGN_BOTTOM_RIGHT : String;
	static var ALIGN_CENTER : String;
	static var ALIGN_LEFT : String;
	static var ALIGN_RIGHT : String;
	static var ALIGN_TOP : String;
	static var ALIGN_TOP_LEFT : String;
	static var ALIGN_TOP_RIGHT : String;
	static var FORMAT_LONG : String;
	static var FORMAT_SHORT : String;
	static function addEventListener(eventType : String, delegate : Dynamic) : Void;
	static function endGame() : Void;
	static function endLevel() : Void;
	static function getVersion() : String;
	static function removeEventListener(eventType : String, delegate : Dynamic) : Void;
	static function setNotifications(clip : flash.display.MovieClip, style : Dynamic) : Void;
	static function startGame() : Void;
	static function startLevel() : Void;
	static function startSession(achievementID : String) : Void;
	static function trigger(kind : String, ?obj : Dynamic) : Void;
	static function triggerEvent(eventType : String, args : Dynamic) : Void;
}
