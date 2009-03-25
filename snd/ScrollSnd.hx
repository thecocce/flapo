
#if flash9
import flash.media.Sound;
import flash.media.SoundLoaderContext;
#else flash8
import flash.Sound;
#end

enum ScrollSound
{
}

#if flash9
#end

class ScrollSnd
{
  public static var enabled: Bool;

#if flash9
#else flash8
#end

  public static function init ()
  {
#if flash9
#else flash8
#end
  }

  public static function play (s: ScrollSound)
  {
    if (enabled)
      switch (s)
      {
#if flash9
#else flash8
#end
      }
  }

}
