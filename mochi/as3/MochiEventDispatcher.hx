package mochi.as3;

extern class MochiEventDispatcher {
	function new() : Void;
	function addEventListener(event : String, delegate : Dynamic) : Void;
	function removeEventListener(event : String, delegate : Dynamic) : Void;
	function triggerEvent(event : String, args : Dynamic) : Void;
}
