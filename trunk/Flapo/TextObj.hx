/**
 * ...
 * @author Bence Dobos
 */

package flapo;

import flash.text.TextFormat;
import flash.text.TextField;
import flapo.Dict;
import flash.display.Sprite;
class TextObj 
{
	public var dict: Dict;
	public var textnum: Int;
	public var tf: TextField;
	public var ts: TextFormat;
	public var isHTML: Bool;
	public var mc: Sprite;
	
	public function new(gmc: Sprite, gdict: Dict, gtextnum: Int, x: Float, y: Float, width: Int, height: Int,
		gts: TextFormat, ?gisHTML: Bool = false, ?filters: Array < Dynamic >= null, ?visible: Bool = true) 
	{
		mc = gmc;
		dict = gdict;
		textnum = gtextnum;
		ts = gts;
		isHTML = gisHTML;
		tf = new TextField ();
		tf.width = width;
		tf.height = height;
		//tf.setTextFormat(ts);
		if (isHTML)
			tf.htmlText = dict.get(textnum);
		else
			tf.text = dict.get(textnum);
		if (ts != null)
			tf.setTextFormat(ts);
		tf.x = x;
		tf.y = y;
		tf.visible = visible;
		tf.selectable = false;
		if (ts != null)
			tf.embedFonts = true;
#if Vye
#else
		if (filters != null)
			tf.filters = filters;
#end
		mc.addChild(tf);
	}
	
	public function renewText()
	{
		if (isHTML)
			tf.htmlText = dict.get(textnum);
		else
			tf.text = dict.get(textnum);
		tf.setTextFormat(ts);
	}
	
	public function removeMC()
	{
		mc.removeChild(tf);
		mc = null;
	}
	
	public function setMC(gmc: Sprite)
	{
		mc = gmc;
		mc.addChild(tf);
	}
	
	public function setText(text: String, ?isHTML: Bool = false)
	{
		//tf.setTextFormat(ts);
		if (isHTML)
		{
			tf.htmlText = text;
		}
		else
		{
			tf.text = text ;
		}
		if (ts != null)
			tf.setTextFormat(ts);
	}
}