
#if flash9
import flash.media.Sound;
import flash.media.SoundLoaderContext;
#else flash8
import flash.Sound;
#end

enum ScrollSound
{
  NiceNice;
}

#if flash9
class NiceNice_mp3 extends Sound { }
#end

class ScrollSnd
{
  public static var enabled: Bool;

#if flash9
  public static var snd_NiceNice: NiceNice_mp3;
#else flash8
  public static var snd_NiceNice: Sound = new Sound ();
#end

  public static function init ()
  {
#if flash9
    snd_NiceNice = new NiceNice_mp3 ();
#else flash8
    snd_NiceNice.attachSound ("NiceNice_mp3");
#end
  }

  public static function play (s: ScrollSound)
  {
    if (enabled)
      switch (s)
      {
#if flash9
        case NiceNice: snd_NiceNice.play ();
#else flash8
        case NiceNice: snd_NiceNice.start ();
#end
      }
  }

}
