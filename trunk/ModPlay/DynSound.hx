/*
 * Flash9 Dynamic Sound Playback
 */
package modplay;
 
import flash.display.Loader;
import flash.utils.ByteArray;

/**
 * Creates a Flash9 Sound object using a ByteArray with the sound wave.
 */
class DynSound
{
    private static function writeTagInfo(swf:ByteArray,code:Int,len:Int)
    {
        if (len >= 63)
        {
            swf.writeShort((code << 6)|0x3F);
            swf.writeInt(len);
        }
        else swf.writeShort((code << 6)|len);
    }

    public static function playSound(wave:ByteArray,repeat:Bool):Loader
    {
        var swf:ByteArray = new ByteArray();
        var ldr:Loader;
        
        // generate the file
        swf.endian = flash.utils.Endian.LITTLE_ENDIAN;
        
        // SWF header
        swf.writeByte(0x46);    // 'FWS' signature
        swf.writeByte(0x57);
        swf.writeByte(0x53);
        swf.writeByte(0x07);    // version
        swf.writeUnsignedInt(0);// filesize (will be set later)
        swf.writeByte(0x78);    // area size
        swf.writeByte(0x00);
        swf.writeByte(0x05);
        swf.writeByte(0x5F);
        swf.writeByte(0x00);
        swf.writeByte(0x00);
        swf.writeByte(0x0F);
        swf.writeByte(0xA0);
        swf.writeByte(0x00);
        swf.writeByte(0x00);   // framerate (12fps)
        swf.writeByte(0x0C);
        swf.writeShort(1);      // one frame
        
        // DefineSound tag
        writeTagInfo(swf, 14, 2 + 1 + 4 + wave.length); 
        swf.writeShort(1);      // sound (character) ID
        swf.writeByte(0x3C);    // sound format (uncompressed) = 4 bits (3)
                                // 44100 rate = 2 bits (3)
                                // 8bit samples = 1 bit (0)
                                // mono sound = 1 bit (0)
                                // 00111100 = 0x3C
        swf.writeUnsignedInt(wave.length); // sample count (one byte=one sample)
        swf.writeBytes(wave);   // samples
        
        // StartSound tag
        writeTagInfo(swf, 15, 2 + 1);
        swf.writeShort(1);      // character id of the sound
		if (repeat) {
			swf.writeByte(4);	// thanks to oNyx for this :-)
			swf.writeShort(65535);
		} else swf.writeByte(0);       // SOUNDINFO flags (all 0)
        
        // End tag
        writeTagInfo(swf, 0, 0);
        
        // Set size
        swf.position = 4;
        swf.writeUnsignedInt(swf.length);
        swf.position = 0;
        
        // "load" it
        ldr = new Loader();
        ldr.loadBytes(swf);
        ldr.addEventListener(flash.events.Event.COMPLETE, function(d:Dynamic){
            swf.length = 0;
        });
        
        return ldr;
    }
}

