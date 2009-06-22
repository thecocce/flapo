package nl.demonsters.debugger;

extern class MonsterDebugger {
	var _enabled : Bool;
	function new(?p0 : Dynamic) : Void;
	function onReceivedData(p0 : flash.utils.ByteArray) : Void;
	static var COLOR_ERROR : UInt;
	static var COLOR_NORMAL : UInt;
	static var COLOR_WARNING : UInt;
	static var enabled : Bool;
	static function clearTraces() : Void;
	static function inspect(p0 : Dynamic) : Void;
	static function snapshot(p0 : flash.display.DisplayObject, ?p1 : UInt) : Void;
	static function trace(p0 : Dynamic, p1 : Dynamic, ?p2 : UInt, ?p3 : Bool, ?p4 : Int) : Void;
}
