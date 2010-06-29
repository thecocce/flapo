/**
 * ...
 * @author Bence Dobos
 */

package flapo;
import flash.Lib;
import flash.system.Capabilities;

class SiteLock 
{
	public static function getBrowserLanguage(): String
	{
		var lang = Capabilities.language;
		trace ("getBrowserLanguage:"+lang);
		return lang;
	}
	
	public static function getDomain() : String
	{
		var url:String = Lib.current.stage.loaderInfo.url;
		//url = "http://www.internetjatek.hu/jkl";
		var urlStart:Int = url.indexOf("://");
		if (urlStart < 0 || urlStart > 10)
		{
			return null;
		}
		urlStart += 3;
		var urlEnd:Int = url.indexOf("/", urlStart);
		trace(url);
		var domain:String;
		if (urlEnd < 0)
			domain = url.substr(urlStart);
		else
			domain = url.substr(urlStart, urlEnd - urlStart);
		var LastDot:Int = domain.lastIndexOf(".")-1;
		var domEnd:Int = domain.lastIndexOf(".", LastDot)+1;
		domain = domain.substr(domEnd, domain.length);
		trace(domain);
		return domain;
	}
	
	public static function check() : Bool
	{
		var url:String = Lib.current.stage.loaderInfo.url;
		//url = "http://www.internetjatek.hu/games/?id=99908";
		//url = "http://www.internetjatek.hu";
		var urlStart:Int = url.indexOf("://");
		if (urlStart < 0 || urlStart > 10)
		{
			trace("LOCK: Something is wrong");
			return false;
		}
		urlStart += 3;
		var urlEnd:Int = url.indexOf("/", urlStart);
		trace(url);
		var domain:String;
		if (urlEnd < 0)
			domain = url.substr(urlStart);
		else
			domain = url.substr(urlStart, urlEnd - urlStart);
		trace(domain);
		var LastDot:Int = domain.lastIndexOf(".")-1;
		var domEnd:Int = domain.lastIndexOf(".", LastDot)+1;
		domain = domain.substr(domEnd, domain.length);
		trace(domain);

		if (urlStart == urlEnd) //file:///
		{
			trace("LOCK: file:///");
			return true;
			//return false;
		}
		else
		if (domain != "hatekonyan.hu" && domain != "internetjatek.hu") {
			trace("LOCK: Stolen");
			return false;
		}
		trace("LOCK: All right");
		return true;
	}
}