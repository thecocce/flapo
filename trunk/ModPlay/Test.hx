import flash.media.Sound;
import flash.utils.ByteArray;
import flash.text.TextField;
import flash.events.MouseEvent;

class Test
{
    static var pb:flash.display.Sprite;
    static var mp:ModPlayer;
	static var te:flash.text.TextField;
	static var musix:Array<String>;
	static var curmus:Int = 0;
	static var lastclick:Float = 0;
    
    static function setProgress(prg:Int)
    {
        pb.graphics.clear();
        pb.graphics.beginFill(0x5ec4ee);
        pb.graphics.drawRect(0, 0, 128*prg/100, 48);
        pb.graphics.endFill();
		if (prg == 100) {
			te.text = musix[curmus] + "\n\nClick to change";
		} else te.text = "\n" + prg + "%";
    }
	
	/* ...with extra code for click-crazy people! */
	static function onteclick(ev:MouseEvent)
	{
		mp.stop();
		if (haxe.Timer.stamp() - lastclick < 0.2) {
			te.text = "\nDONT DO THIS!!!";
			lastclick = haxe.Timer.stamp();
			return;
		}
		lastclick = haxe.Timer.stamp();
		curmus++;
		if (curmus > musix.length) curmus = 0;
		if (curmus < musix.length) {
			mp = new ModPlayer();
			mp.onProgress = function(prg:Int) { setProgress(prg); }
			flash.media.SoundMixer.stopAll();
			mp.play(musix[curmus]);
		}
		else te.text = "Stopped\n\nClick to start";
	}

    static function main()
    {
        pb = new flash.display.Sprite();
		pb.addEventListener(MouseEvent.CLICK, onteclick);
        flash.Lib.current.addChild(pb);
		
		te = new TextField();
		te.width = 128;
		te.height = 48;
		te.autoSize = flash.text.TextFieldAutoSize.CENTER;
		te.addEventListener(MouseEvent.CLICK, onteclick);
		flash.Lib.current.addChild(te);
		
		var musicfiles:String = flash.Lib.current.loaderInfo.parameters.modfile;
		musix = musicfiles.split(",");
        
		lastclick = haxe.Timer.stamp();
        mp = new ModPlayer();
        mp.onProgress = function(prg:Int) { setProgress(prg); }
        mp.play(musix[0]);
    }
}

