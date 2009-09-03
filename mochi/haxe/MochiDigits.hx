/*
 * MochiAds.com haXe code, version 3.02
 * Copyright (C) 2006-2008 Mochi Media, Inc. All rigths reserved.
 * Haxe conversion (C) 2009 Kostas Michalopoulos
 */

/*! @module "mochi.haxe" */
package mochi.haxe;

/**
 * In-memory encoded values. This class can be used to encode sensitive values
 * (such as scores) in memory to make highscore hacking more difficult.
 */
class MochiDigits
{
	private var Fragment:UInt;
	private var Sibling:MochiDigits;
	private var Encoder:UInt;
	
	/**
	 * Construct and initialize the value of a MochiDigit
	 *
	 * @param digit initialization value
	 * @param index internal use only
	 */
	public function new(digit:UInt=0,index:UInt=0)
	{            
		Encoder=0;
		setValue(digit, index);
	}
	
	public var value(valGet,valSet):UInt;
	
	private function valGet():UInt
	{
		return Std.parseInt(this.toString());
	}
	
	private function valSet(v:UInt):UInt
	{
		setValue(v);
		return v;
	}
	
	/**
	 * Increments the stored value by a specified amount
	 *
	 * @param inc value to add to the stored variable
	 */
	public function addValue(inc:UInt):Void
	{
		value += inc;
	}
	
	/**
	 * Resets the stored value
	 *
	 * @param digit initialization value
	 * @param index internal use only
	 */
	public function setValue(digit:UInt=0,index:UInt=0):Void
	{
		var s:String = Std.string(digit);
		Fragment = s.charCodeAt(index++) ^ Encoder;

		if (index < s.length)
			Sibling = new MochiDigits(digit, index);
		else
			Sibling = null;
		
		reencode();
	}
	
	/**
	 * Reencodes the stored number without changing its value
	 */
	public function reencode():Void
	{
		var newEncode:UInt = Std.int(0x7FFFFFFF * Math.random());
		
		Fragment ^= newEncode ^ Encoder;
		Encoder = newEncode;
	}
	
	/**
	 * Returns the stored number as a formatted string
	 */
	public function toString():String
	{
		var s:String = String.fromCharCode(Fragment ^ Encoder);
		
		if( Sibling != null)
			s += Sibling.toString();
			
		return s;
	}
}

