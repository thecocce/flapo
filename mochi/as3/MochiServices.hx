package mochi.as3;

extern class MochiServices {
	static var childClip(default,null) : Dynamic;
	static var clip(default,null) : Dynamic;
	static var comChannelName(null,default) : Void;
	static var connected(default,null) : Bool;
	static var id(default,null) : String;
	static var netup : Bool;
	static var netupAttempted : Bool;
	static var onError : Dynamic;
	static var servicesSync : MochiSync;
	static var widget : Bool;
	static function addLinkEvent(url : String, burl : String, btn : flash.display.DisplayObjectContainer, ?onClick : Dynamic) : Void;
	static function allowDomains(server : String) : String;
	static function bringToTop(?e : flash.events.Event) : Void;
	static function connect(id : String, clip : Dynamic, ?onError : Dynamic) : Void;
	static function connectWait(e : flash.events.TimerEvent) : Void;
	static function createEmptyMovieClip(parent : Dynamic, name : String, depth : Float, ?doAdd : Bool) : flash.display.MovieClip;
	static function disconnect() : Void;
	static function doClose() : Void;
	static function getVersion() : String;
	static function isNetworkAvailable() : Bool;
	static function send(methodName : String, ?args : Dynamic, ?callbackObject : Dynamic, ?callbackMethod : Dynamic) : Void;
	static function setContainer(?container : Dynamic, ?doAdd : Bool) : Void;
	static function stayOnTop() : Void;
	static function warnID(bid : String, leaderboard : Bool) : Void;
}
