package {
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.IOErrorEvent;
    import flash.utils.getDefinitionByName;

    // Must be dynamic!
    public dynamic class Preloader extends MovieClip {
        // Keep track to see if an ad loaded or not
        private var did_load:Boolean;

        // Change this class name to your main class
        public static var MAIN_CLASS:String = "Test";

        // Substitute these for what's in the MochiAd code
        // !! Replace id with the game's id
        public static var GAME_OPTIONS:Object = {
          id:"db35cc64b8673507",             // !update this
          res:"550x400",         // !update this
          background:0x6D6DFF, 
          color:0x2424B6, 
          outline:0x2424B6, 
          no_bg:false
        };

        public function Preloader() {
            super();

            var f:Function = function(ev:IOErrorEvent):void {
                // Ignore event to prevent unhandled error exception
            }
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, f);

            var opts:Object = {};
            for (var k:String in GAME_OPTIONS) {
                opts[k] = GAME_OPTIONS[k];
            }

            opts.ad_started = function ():void {
                did_load = true;
            }

            opts.ad_finished = function ():void {
                // don't directly reference the class, otherwise it will be
                // loaded before the preloader can begin
                var mainClass:Class = Class(getDefinitionByName(MAIN_CLASS));
                var app:Object = new mainClass();
                addChild(app as DisplayObject);
                if (app.init) {
                    app.init(did_load);
                }
            }

            opts.clip = this;

            /* 
            This call will preload and display a bar too  using MochiAd.
            
            If you would like custom loading (draw an own progress bar, etc), then use
            the ratio (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal) to show progress.
            (Add a handler to ENTER_FRAME for updating progress)

            Once completed (bytesLoaded == bytesTotal), execute something similar as in opts.ad_finished.
            
            */
            MochiAd.showPreGameAd(opts);
        }


    }

}
