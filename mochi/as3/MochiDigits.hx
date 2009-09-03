package mochi.as3;

extern class MochiDigits {
	var value : Float;
	function new(?digit : Float, ?index : UInt) : Void;
	function addValue(inc : Float) : Void;
	function reencode() : Void;
	function setValue(?digit : Float, ?index : UInt) : Void;
	function toString() : String;
}
