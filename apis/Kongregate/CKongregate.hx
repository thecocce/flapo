package apis.kongregate;
import flash.Lib;

class CKongregate 
{
    var kongregate: Dynamic;
	public var type: Int; //0 - none, 1 - Local,
						//2 - flashvar, 3 - flashvar via preloader
	public var loaded: Bool;
	
    public function new(testobj: Dynamic)
    {
        kongregate = null;
		type = 0;
        loaded = false;
		
        var parameters = flash.Lib.current.loaderInfo.parameters;

        var url: String;
        
        url = parameters.api_path;
		if (url == null && testobj != null)
		try {
			trace("testobj: " + testobj);
			parameters = testobj.parametersCallback();
			trace("ok");
			url = parameters.api_path;
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
            url = "http://www.kongregate.com/flash/API_AS3_Local.swf";
			type = 1;
		}	
        trace ( "API path: " + url );

        var request = new flash.net.URLRequest(url);             
        
        var loader = new flash.display.Loader();
        loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, OnLoadComplete);
        loader.load(request);

        flash.Lib.current.addChild(loader);
    }

    function OnLoadComplete(e: flash.events.Event)
    {
        try
        {
            kongregate = e.target.content;
            kongregate.services.connect();
			trace ( "\n" + kongregate.services );
			trace ( "\n" + kongregate.user );
			trace ( "\n" + kongregate.scores );
			trace ( "\n" + kongregate.stats );
			loaded = true;
        }
        catch(msg: Dynamic)
        {
            kongregate = null;
        }
    }

    public function SubmitScore(score: Float, mode: String)
    {
        if(kongregate != null)
        {
            kongregate.scores.submit(score, mode);
        }
    }

    public function SubmitStat(name: String, stat: Float)
    {
        if(kongregate != null)
        {
            kongregate.stats.submit(name, stat);
        }
    }

}
