
#if flash9
import flash.media.Sound;
import flash.media.SoundChannel;
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
  public static var channel: SoundChannel;
  public static var snd_NiceNicePlaying: Bool;
#if flash9
  public static var snd_NiceNice: NiceNice_mp3;
#else flash8
  public static var snd_NiceNice: Sound = new Sound ();
#end

  public static function init ()
  {
	  snd_NiceNicePlaying = false;
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
        case NiceNice:
			channel = snd_NiceNice.play ();
			snd_NiceNicePlaying = true;
#else flash8
        case NiceNice: snd_NiceNice.start ();
#end
      }
  }

    public static function stop (s: ScrollSound)
  {
    if (enabled)
      switch (s)
      {
#if flash9
        case NiceNice: 
			if (snd_NiceNicePlaying)
				channel.stop();
			snd_NiceNicePlaying = false;
#else flash8
        case NiceNice: snd_NiceNice.stop (); //? copy-paste
#end
      }
  }
  
}
