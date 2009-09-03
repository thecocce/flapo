package mochi.as3;

extern class MochiAd {
	static function _allowDomains(server : String) : String;
	static function _cleanup(mc : Dynamic) : Void;
	static function _getRes(options : Dynamic, clip : Dynamic) : Array<Dynamic>;
	static function _isNetworkAvailable() : Bool;
	static function _parseOptions(options : Dynamic, defaults : Dynamic) : Dynamic;
	static function adShowing(mc : Dynamic) : Void;
	static function createEmptyMovieClip(parent : Dynamic, name : String, depth : Float) : flash.display.MovieClip;
	static function doOnEnterFrame(mc : flash.display.MovieClip) : Void;
	static function getValue(base : Dynamic, objectName : String) : Dynamic;
	static function getVersion() : String;
	static function load(options : Dynamic) : flash.display.MovieClip;
	static function rpc(clip : Dynamic, callbackID : Float, arg : Dynamic) : Void;
	static function runMethod(base : Dynamic, methodName : String, argsArray : Array<Dynamic>) : Dynamic;
	static function setValue(base : Dynamic, objectName : String, value : Dynamic) : Void;
	static function showClickAwayAd(options : Dynamic) : Void;
	static function showInterLevelAd(options : Dynamic) : Void;
	static function showPreGameAd(options : Dynamic) : Void;
	static function showPreloaderAd(options : Dynamic) : Void;
	static function showTimedAd(options : Dynamic) : Void;
	static function unload(clip : Dynamic) : Bool;
}
