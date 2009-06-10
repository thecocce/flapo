package {
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;

    import flash.display.LoaderInfo;
    import flash.net.URLRequest;
    import flash.events.Event;

    public class Test extends Sprite {

        [Embed(source="Flapo.swf")]
        private var HxSwf:Class;

        private var hxinst : Sprite;

        public function Test() {
            super();
            if (stage != null)
                init (false);
        }
        
        /*
        This function will be called from the Haxe swf

        */
        public function traceCallback():void {
            mytrace("Hello from AS3 preloader");
        }
      
        /*
        This is an ugly function to call a custom haxe trace function defined in Main.hx's Main object.

        Object hierarchy: Test object -> HxInst object -> Loader object -> Haxe Boot object -> First child added to Boot (will be Main now).

        */
        function mytrace(s:String):void {
           (((hxinst.getChildAt(0) as Loader).content as Object).getChildAt(0) as Object).htrace(s);
        }

        public function init(did_load:Boolean):void {
            hxinst = new HxSwf();
            addChild(hxinst);
            
            /* 
            Beware! hxinst contains a Loader which loads the content with loadBytes asynchronously, 
            so we may not call access the haxe object yet. Be sure to check the loader status if you would like. 
            */
        }
   }
}
