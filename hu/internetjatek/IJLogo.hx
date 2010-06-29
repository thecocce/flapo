package hu.internetjatek;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.Lib;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.filters.BlurFilter;
	
	import flash.display.PixelSnapping;

	class IJLogo extends Sprite
	{
		private static var BITMAP_WIDTH: Int = 347;
		private static var BITMAP_HEIGHT: Int = 347;
		
		private static var FLASHS: Int = 100;
		private static var FLASHE: Int  = 140;
		private static var FLASHD: Int = FLASHE - FLASHS;
		private static var LOGO1S: Int = 100;
		private static var LOGO1E: Int = 120;
		private static var LOGO1D: Int = LOGO1E - LOGO1S;
		private static var LOGO2S: Int = 110;
		private static var LOGO2E: Int = 130;
		private static var LOGO2D: Int = LOGO2E - LOGO2S;
		private static var LOGO3S: Int = 130;
		private static var LOGO3E: Int = 180;
		private static var LOGO3D: Int = LOGO3E - LOGO3S;
		private static var FADEINS: Int = 0;
		private static var FADEINE: Int = 50;
		private static var FADEIND: Int = FADEINE - FADEINS;
		private static var FADEOUTS: Int = 300;
		private static var FADEOUTE: Int = 400;
		private static var FADEOUTD: Int = FADEOUTE - FADEOUTS;
		
		private static var bLogo1x: Int = 240;
		private static var bLogo1y: Int = 70;
		private static var bLogo2x: Int = 260;
		private static var bLogo2y: Int = 120;
		private static var bLogo3x: Int = 270;
		private static var bLogo3y: Int = 190;
	   
		private var earthBitmap:Bitmap;
		private var xPos:Float;
		private var yPos:Float;
		private var displacementFilter:DisplacementMapFilter;
		private static var p:Point = new Point(0, 0); 
		private var yspeed: Float;
		private var xspeed: Float;
		private var x_mult: Int;
		private var y_mult: Int;
		private var bmp: BitmapData;
		private var earth: Sprite;
		private var earthMask: Bitmap;
		private var textureBD: BitmapData;
		private var texture: Bitmap;
		private var texture2: Bitmap;
		private var texture3: Bitmap;
		private var displacementBitmap: Bitmap;
		private var displacementBD: BitmapData;
		private var mcContainer: Sprite;
		
		//Shade
		private var bdShade : BitmapData;
		private var mcPlayerShade : Sprite;
		private var bitmapShade : Bitmap;
		private var counter : Int;
		
		private var bLogo1: Bitmap;
		private var bLogo2: Bitmap;
		private var bLogo3: Bitmap;
		
		private var bg: Sprite;
		private var stars: Sprite;
		private var vertOffset: Float;
		
		private var done: Bool;
		
		public function new(stage: Stage)
		{
			super();
			done = false;
			counter = 0;
			yspeed = 0;
			xspeed = 0;
			x_mult = 130;
			y_mult = 130;
			xPos = 0;
			yPos = 210;
			
			addEventListener(MouseEvent.CLICK, mouseDownHandler);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		private function firstinit():Void
		{
			vertOffset = (stage.stageHeight - 242) / 2;
			//vertOffset = Lib.current.stage.stageWidth;
			//Black background
			bg = new Sprite();
			bg.graphics.beginFill(0x000000);
			bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			addChild(bg);
			
			//Stars
			stars = new Sprite();
			for (i in 0 ... 500)
			{
				stars.graphics.beginFill(0x111111 * Std.int(Math.random()*15 + 1));
				stars.graphics.drawCircle(
					Math.random() * stage.stageWidth,
					Math.random() * stage.stageHeight,
					Math.random() * 1.3);
			}	
			stars.graphics.beginFill(0x000000);
			stars.graphics.drawCircle(121, 121 + vertOffset, 100);
			//stars.alpha = 0;
			addChild(stars);
			//Textures
			textureBD = new BitmapData(BITMAP_WIDTH, BITMAP_HEIGHT, false, 0x000000);
			texture = new Bitmap(textureBD);
			texture2 = new Bitmap(new EarthImg());
			texture3 = new Bitmap(new EarthImgBlue());
			textureBD.copyPixels (texture2.bitmapData, texture2.getRect(this) , new Point (0, 0));

			//Circle mask
			var earthMask:Sprite = new Sprite();
			earthMask.graphics.beginFill(0xFF0000);
			earthMask.graphics.drawCircle(121, 121+vertOffset, 100);
			addChild(earthMask);
			earthMask.visible = false;
			
			//Earth
			bmp = new BitmapData(BITMAP_WIDTH, BITMAP_HEIGHT, false, 0x000000);
			earthBitmap = new Bitmap(bmp);
			earth = new Sprite();			
			earth.addChild(earthBitmap);
			earth.alpha = 0;
			addChild(earth);
			earth.y = vertOffset;
			earth.mask = earthMask;

			//Displacement filter
			//displacementBitmap = new dispmapImg(); 
			displacementBD = new BitmapData(BITMAP_WIDTH, BITMAP_HEIGHT, false, 0x808080);
			displacementBitmap = new Bitmap(displacementBD); 
			calcDisplacement(110, 121);
			//displacementBitmap.x = 260;
			addChild(displacementBitmap);
			displacementBitmap.visible = false;
			displacementFilter = new DisplacementMapFilter(displacementBitmap.bitmapData, p, 1, 2, x_mult, y_mult /*, "color"*/);
			earthBitmap.filters = [displacementFilter];
			
			//Shade
			bdShade = new BitmapData (BITMAP_WIDTH, BITMAP_HEIGHT, true, 0x0);
			mcPlayerShade = new Sprite ();
			bitmapShade = new Bitmap(bdShade, AUTO, true);
			mcPlayerShade.addChild (bitmapShade);
			earth.addChild(mcPlayerShade);
			calcShade(100, 121);
			
			//Texts
			bLogo1 = new Bitmap(new LogoText1());
			bLogo2 = new Bitmap(new LogoText2());
			bLogo3 = new Bitmap(new LogoText3());
			bLogo1.x = 550;
			bLogo1.y = bLogo1y + vertOffset;
			bLogo1.alpha = 0;
			bLogo2.x = 550;
			bLogo2.y = bLogo2y + vertOffset;
			bLogo2.alpha = 0;
			bLogo3.x = 550;
			bLogo3.y = bLogo3y + vertOffset;
			bLogo3.alpha = 0;
			addChild(bLogo1);
			addChild(bLogo2);
			addChild(bLogo3);

		}
		
		private function destroy():Void
		{
			trace("destroy IJLogo");
			removeEventListener(MouseEvent.CLICK, mouseDownHandler);
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			removeChild(bLogo1);
			removeChild(bLogo2);
			removeChild(bLogo3);
			bLogo1 = null;
			bLogo2 = null;
			bLogo3 = null;

			earth.removeChild(mcPlayerShade);
			mcPlayerShade.removeChild (bitmapShade);
			bdShade = null;
			mcPlayerShade = null;
			bitmapShade = null;

			removeChild(displacementBitmap);
			displacementFilter = null;
			displacementBitmap = null;
			displacementBD = null;

			removeChild(earth);
			earth.mask = null;
			earth.removeChild(earthBitmap);
			bmp = null;
			earthBitmap = null;
			earth = null;	
			earthMask= null;

			textureBD = null;
			texture = null;
			texture2 = null;
			texture3 = null;
			
			removeChild(stars);
			stars = null;
			
			removeChild(bg);
			bg = null;
			
			done = true;
			trace("Destroy done");
		}
		
		private function mouseDownHandler(event:MouseEvent):Void
		{
			try {
				Lib.getURL(new URLRequest("http://Internetjatek.hu"),"_blank");
			} catch (e:Dynamic) {
				trace (e);
			}

		}

		public function isDone(): Bool
		{
			return done;
		}
		
		private function enterFrameHandler(event:Event):Void
		{
			if (counter == 0)
				firstinit();
			//shade on blue Earth
			if (counter == FLASHS)
			{
				//earth.removeChild(mcPlayerShade);
			}
			//fade in
			if (counter >= FADEINS && counter <= FADEINE)
			{
				stars.alpha = counter / FADEIND;
				earth.alpha = counter / FADEIND;
			}
			//White flash
			if (counter >= FLASHS && counter < FLASHE)
			{
				textureBD.copyPixels (texture3.bitmapData, texture3.getRect(this) , new Point (0, 0));
				var m: Float = FLASHD - (counter - FLASHS);
				var ct:ColorTransform = new ColorTransform( 1,1,1, 1, m*7, m*7, m*7 );
				this.transform.colorTransform = ct;
			}
			//Texts
			var v: Float;
			var x: Float;
			if (counter >= LOGO1S && counter < LOGO1E)
			{
				v = (counter - LOGO1S) / LOGO1D;
				x = bLogo1x + (1-v) * (1-v) * 300;
				bLogo1.x = x;
				bLogo1.alpha = v;
				bLogo1.filters = [new BlurFilter((1-v)*(1-v) * 10, 0, 1)];
			}
			if (counter >= LOGO2S && counter < LOGO2E)
			{
				v = (counter - LOGO2S) / LOGO2D;
				x = bLogo2x + (1-v) * (1-v) * 300;
				bLogo2.x = x;
				bLogo2.alpha = v;
				bLogo2.filters = [new BlurFilter((1-v)*(1-v) * 10, 0, 1)];
			}
			if (counter >= LOGO3S && counter < LOGO3E)
			{
				v = (counter - LOGO3S) / LOGO3D;
				x = bLogo3x + (1-v) * (1-v) * 300;
				bLogo3.x = x;
				bLogo3.alpha = v;
				bLogo3.filters = [new BlurFilter((1-v)*(1-v) * 10, 0, 1)];
			}
			
			//Fade out
			if (counter > FADEOUTS && counter < FADEOUTE)
			{
				this.alpha = 1-(counter - FADEOUTS) / FADEOUTD;
			}
			
			//Calculate Earth new texture coordinates
			xspeed = 5;
			yspeed = 0;
			xPos += xspeed;
			yPos += yspeed;
			p.x = xPos;
			p.y = yPos;
			if (xPos > BITMAP_WIDTH) xPos -= BITMAP_WIDTH;
			if (xPos < 0) xPos += BITMAP_WIDTH;
			if (yPos > BITMAP_HEIGHT) yPos -= BITMAP_HEIGHT;
			if (yPos < 0) yPos += BITMAP_HEIGHT;
			
			//Draw Earth texture
			bmp.copyPixels (texture.bitmapData, texture.getRect(this) , new Point (xPos, yPos));
			bmp.copyPixels (texture.bitmapData, texture.getRect(this) , new Point (xPos-BITMAP_WIDTH, yPos));
			bmp.copyPixels (texture.bitmapData, texture.getRect(this) , new Point (xPos, yPos-BITMAP_HEIGHT));
			bmp.copyPixels (texture.bitmapData, texture.getRect(this) , new Point (xPos - BITMAP_WIDTH, yPos - BITMAP_HEIGHT));
			counter++;
			if (counter > FADEOUTE)
				destroy();
		}
		
		private function calcShade( r: Int, center: Int ):Void
		{
			var iz: Float;
			var alpha: Int;
			var shade: Int;
			var rr:Int = r * r;
			var xxyy:Int;

			for (ix in -r ... r)
			{
				for (iy in -r ... r)
				{
					xxyy = ix * ix + iy * iy;
					if (xxyy<=rr) //in the circle?
					{
						iz = Math.sqrt(1 * 1 - ix * ix - iy * iy + r * r) / 3 + 1;
						alpha = Std.int(255 - iz*5);
						if (alpha > 255) alpha = 255;
						if (alpha < 0) alpha = 0;
						shade =  128 - Std.int( (ix + iy ) * 128 / (r));
						if (shade > 255) shade = 255;
						if (shade < 0) shade = 0;
						bdShade.setPixel32(ix + center, iy + center,
						(alpha << 24) + (shade << 16) + (shade << 8) + shade );
					}
					else //if not in the circle
					{
						bdShade.setPixel32(ix+center, iy+center, 0x0);
					}
				}
			}
		}
		
		private function calcDisplacement( r: Int, center: Int ):Void
		{
			var iz: Float;
			var alpha: Int;
			var shade: Int;
			var shadeX: Int;
			var shadeY: Int;
			var rr:Int = r * r;
			var xxyy:Int;

			for (ix in -r ... r)
			{
				for (iy in -r ... r)
				{
					xxyy = ix * ix + iy * iy;
					if (xxyy<=rr) //in the circle?
					{
						iz = Math.sqrt(1 * 1 - ix * ix - iy * iy + r * r) / 5 + 1;
						alpha = 255;
						if (alpha > 255) alpha = 255;
						if (alpha < 0) alpha = 0;
						shadeX =  128 - Std.int( ix * iz*4 / (r));
						shadeY =  128 - Std.int( iy * iz*2 / (r) + iy/4);
						if (shadeX > 255) shadeX = 255;
						if (shadeX < 0) shadeX = 0;
						if (shadeY > 255) shadeY = 255;
						if (shadeY < 0) shadeY = 0;

						displacementBD.setPixel32(ix + center, iy + center,
						(alpha << 24) + (shadeX << 16) + (shadeY << 8) + shadeX );
					}
					else //if not in the circle
					{
						displacementBD.setPixel32(ix+center, iy+center, 0xff808080);
					}
				}
			}
		}
    }
