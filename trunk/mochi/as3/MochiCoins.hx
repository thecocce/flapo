package mochi.as3;

extern class MochiCoins {
	static var ERROR : String;
	static var IO_ERROR : String;
	static var ITEM_NEW : String;
	static var ITEM_OWNED : String;
	static var LOGGED_IN : String;
	static var LOGGED_OUT : String;
	static var LOGIN_HIDE : String;
	static var LOGIN_SHOW : String;
	static var NO_USER : String;
	static var PROFILE_HIDE : String;
	static var PROFILE_SHOW : String;
	static var PROPERTIES_SAVED : String;
	static var PROPERTIES_SIZE : String;
	static var STORE_HIDE : String;
	static var STORE_ITEMS : String;
	static var STORE_SHOW : String;
	static var USER_INFO : String;
	static var WIDGET_LOADED : String;
	static function addEventListener(eventType : String, delegate : Dynamic) : Void;
	static function getStoreItems() : Void;
	static function getUserInfo() : Void;
	static function getVersion() : String;
	static function hideLoginWidget() : Void;
	static function removeEventListener(eventType : String, delegate : Dynamic) : Void;
	static function saveUserProperties(properties : Dynamic) : Void;
	static function showItem(?options : Dynamic) : Void;
	static function showLoginWidget(?options : Dynamic) : Void;
	static function showStore(?options : Dynamic) : Void;
	static function showVideo(?options : Dynamic) : Void;
	static function triggerEvent(eventType : String, args : Dynamic) : Void;
}
