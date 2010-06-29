package apis.mindjolt;

import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.net.URLRequest;
import flash.events.Event;
import flash.system.Security;

class MindJolt 
{
	// You'll use this variable to access the API
	//   (make sure you can access it from wherever you will later call submitScore)
	public static var MindJoltAPI:Dynamic;
	public var type: Int; //0 - none, 1 - Local,
						//2 - flashvar, 3 - flashvar via preloader
	public var loaded:Bool;
	

	//////
	// All of this code should be executed at the very beginning of the game
	//
	
	// this function is called after everything has been successfully loaded
	// it is good to wait for this method to be called before attempting to use the API
	function postMindJoltAPIConnect (success:Bool) {  
	  trace("[MindJoltAPI] service successfully loaded"); 
	}
	
	public function new(testobj: Dynamic)
    {
		MindJoltAPI = null;
		type = 0;		
        loaded = false;

		var parameters = flash.Lib.current.loaderInfo.parameters;	
		
        var url: String;		
	
		// get the parameters passed into the game
		Security.allowDomain("static.mindjolt.com");

        url = parameters.api_path;
		if (url == null && testobj != null)
		try {
			trace("testobj: " + testobj);
			parameters = testobj.parametersCallback();
			trace("ok");
			url = parameters.mjPath;
			//url = testobj.loaderInfo.parameters.api_path;
			trace(url);
			type = 3;
		}
		else
		{
			type = 2;
		}
        
		// The API path. The debug version ("shadow" API) will load if testing locally. 
        if (url == null)
		{
            url = "http://static.mindjolt.com/api/as3/api_as3_local.swf";
			type = 1;
		}	
        trace ( "API path: " + url );

        var request = new URLRequest(url);             
        
        var loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFinished);
        loader.load(request);

        flash.Lib.current.addChild(loader);
	}
	
	function loadFinished (e:Event) {
		MindJoltAPI=e.currentTarget.content;
		if (MindJoltAPI != null) {
		  MindJoltAPI.service.connect(postMindJoltAPIConnect);
		  trace ("[MindJoltAPI] service successfully loaded");
		  loaded = true;
		} else {
		  trace("[MindJoltAPI] failed to load");
		}
	}	
}
