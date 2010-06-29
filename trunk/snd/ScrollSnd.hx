
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
#if mp3Music
  Peace;
#end
  Block_disappear;
  Bump;
  Color_change;
  Falling;
  False_win;
  Jump_platform; 
  Win;
  Ticktack;
}
/*
#if flash9
#if mp3Music
class Peace_mp3 extends Sound { }
#end
class Block_disappear_wav extends Sound { }
class Bump_wav extends Sound { }
class Color_change_wav extends Sound { }
class Falling_wav extends Sound { }
class False_win_wav extends Sound { }
class Jump_platform_wav extends Sound { }
class Win_wav extends Sound { }
class Ticktack_wav extends Sound { }
#end*/

class ScrollSnd
{
  public static var enabled: Bool;
  public static var channel: SoundChannel;
  public static var channelTicktack: SoundChannel;
#if mp3Music
  public static var channel_Peace: SoundChannel;
  public static var snd_PeacePlaying: Bool;
#if flash9
  //public static var snd_Peace: Peace_mp3;
  public static var snd_Peace: Sound;
#else flash8
  public static var snd_Peace: Sound = new Sound ();
#end
#end
/*
  public static var snd_Block_disappear: Block_disappear_wav;
  public static var snd_Bump: Bump_wav;
  public static var snd_Color_change: Color_change_wav;
  public static var snd_Falling: Falling_wav;
  public static var snd_False_win: False_win_wav;
  public static var snd_Jump_platform: Jump_platform_wav; 
  public static var snd_Win: Win_wav;
  public static var snd_Ticktack: Ticktack_wav;
*/		
  public static var snd_Block_disappear: Sound;
  public static var snd_Bump: Sound;
  public static var snd_Color_change: Sound;
  public static var snd_Falling: Sound;
  public static var snd_False_win: Sound;
  public static var snd_Jump_platform: Sound; 
  public static var snd_Win: Sound;
  public static var snd_Ticktack: Sound;

  public static function init ()
  {
#if mp3Music
	  snd_PeacePlaying = false;
#if flash9
    //snd_Peace = new Peace_mp3 ();
	snd_Peace = Type.createInstance(Type.resolveClass("Peace_mp3"), []);
#else flash8
    snd_Peace.attachSound ("Peace_mp3");
#end
#end
/*
	snd_Jump_platform = new Jump_platform_wav ();
	snd_Bump = new Bump_wav ();
	snd_Block_disappear = new Block_disappear_wav ();
	snd_Color_change = new Color_change_wav ();
	snd_Falling = new Falling_wav ();
	snd_False_win = new False_win_wav ();
	snd_Jump_platform = new Jump_platform_wav ();
	snd_Win = new Win_wav ();
	snd_Ticktack = new Ticktack_wav ();
*/
	snd_Jump_platform = Type.createInstance(Type.resolveClass("Jump_platform_wav"), []);
	snd_Bump = Type.createInstance(Type.resolveClass("Bump_wav"), []);
	snd_Block_disappear = Type.createInstance(Type.resolveClass("Block_disappear_wav"), []);
	snd_Color_change = Type.createInstance(Type.resolveClass("Color_change_wav"), []);
	snd_Falling = Type.createInstance(Type.resolveClass("Falling_wav"), []);
	snd_False_win = Type.createInstance(Type.resolveClass("False_win_wav"), []);
	snd_Jump_platform = Type.createInstance(Type.resolveClass("Jump_platform_wav"), []);
	snd_Win = Type.createInstance(Type.resolveClass("Win_wav"), []);
	snd_Ticktack = Type.createInstance(Type.resolveClass("Ticktack_wav"), []);
	channelTicktack = null;
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
		  case Ticktack:
			if (channelTicktack != null)
				channelTicktack.stop();
			channelTicktack = snd_Ticktack.play ();
			if (channelTicktack != null)
				channelTicktack.soundTransform = new SoundTransform(vol);
#if mp3Music
#if flash9   
        case Peace:
			channel_Peace = snd_Peace.play (0, 999);
			channel_Peace.soundTransform = new SoundTransform(0.4);
			snd_PeacePlaying = true;
#else flash8
        case Peace: snd_Peace.start (0, 999);
#end
#end
      }
	if (channel != null)
	{
		//trace(vol);
		channel.soundTransform = new SoundTransform(vol);
	}

  }

   public static function stop (s: ScrollSound)
  {
#if mp3Music
    if (enabled)
	{
//      switch (s) // ez a switch vmiert forditasi hibat okoz, pedig regen mukodott
//      {
#if flash9
//        case Peace: 
			if (snd_PeacePlaying)
				channel_Peace.stop();
#else flash8
//        case Peace:
			snd_Peace.stop (); //? copy-paste
#end
	    //}
	  }
  snd_PeacePlaying = false;
#end
  return true;
  }
}
