package mochi.as3;

extern class MochiSync extends flash.utils.Proxy {
	function new() : Void;
	function triggerEvent(eventType : String, args : Dynamic) : Void;
	static var SYNC_PROPERTY : String;
	static var SYNC_REQUEST : String;
}
