
#if flash9
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundLoaderContext;
import flash.media.SoundTransform;
#else flash8
import flash.Sound;
#end

enum ScrollSound
{
//  NiceNice;
  Block_disappear;
  Bump;
  Color_change;
  Falling;
  False_win;
  Jump_platform; 
  Win;
}

#if flash9
//class NiceNice_mp3 extends Sound { }
class Block_disappear_wav extends Sound { }
class Bump_wav extends Sound { }
class Color_change_wav extends Sound { }
class Falling_wav extends Sound { }
class False_win_wav extends Sound { }
class Jump_platform_wav extends Sound { }
class Win_wav extends Sound { }
#end

class ScrollSnd
{
  public static var enabled: Bool;
  public static var channel: SoundChannel;
//  public static var snd_NiceNicePlaying: Bool;
  /*
#if flash9
  public static var snd_NiceNice: NiceNice_mp3;
#else flash8
  public static var snd_NiceNice: Sound = new Sound ();
#end
*/
//  public static var snd_NiceNice: NiceNice;
  public static var snd_Block_disappear: Block_disappear_wav;
  public static var snd_Bump: Bump_wav;
  public static var snd_Color_change: Color_change_wav;
  public static var snd_Falling: Falling_wav;
  public static var snd_False_win: False_win_wav;
  public static var snd_Jump_platform: Jump_platform_wav; 
  public static var snd_Win: Win_wav;
				

  public static function init ()
  {
	  /*
	  snd_NiceNicePlaying = false;
#if flash9
    snd_NiceNice = new NiceNice_mp3 ();
#else flash8
    snd_NiceNice.attachSound ("NiceNice_mp3");
#end*/
	snd_Jump_platform = new Jump_platform_wav ();
	snd_Bump = new Bump_wav ();
	snd_Block_disappear = new Block_disappear_wav ();
	snd_Color_change = new Color_change_wav ();
	snd_Falling = new Falling_wav ();
	snd_False_win = new False_win_wav ();
	snd_Jump_platform = new Jump_platform_wav ();
	snd_Win = new Win_wav ();
  }

  public static function play (s: ScrollSound, ?vol: Float=1.0)
  {
	channel = null;
    if (enabled)
      switch (s)
      {
		  case Block_disappear:
			channel = snd_Block_disappear.play ();
		  case Bump:
			channel = snd_Bump.play ();
		  case Color_change:
			channel = snd_Color_change.play ();
		  case Falling: 
			channel = snd_Falling.play ();
		  case False_win:
			channel = snd_False_win.play ();
		  case Jump_platform:
			channel = snd_Jump_platform.play ();
		  case Win:
			channel = snd_Win.play ();
/*#if flash9   
        case NiceNice:
			channel = snd_NiceNice.play ();
			snd_NiceNicePlaying = true;
#else flash8
        case NiceNice: snd_NiceNice.start ();
#end*/
      }
	if (channel != null)
	{
		//trace(vol);
		channel.soundTransform = new SoundTransform(vol);
	}

  }

    public static function stop (s: ScrollSound)
  {
  //  if (enabled)
 //     switch (s)
 //     {
/*#if flash9
        case NiceNice: 
			if (snd_NiceNicePlaying)
				channel.stop();
			snd_NiceNicePlaying = false;
#else flash8
        case NiceNice: snd_NiceNice.stop (); //? copy-paste
#end*/
  //    }
  return true;
  }
}
