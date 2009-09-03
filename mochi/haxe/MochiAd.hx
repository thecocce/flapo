/*
 * MochiAds.com haXe code, version 3.02
 * Copyright (C) 2006-2008 Mochi Media, Inc. All rigths reserved.
 * Haxe conversion (C) 2009 Kostas Michalopoulos
 */

/*! @module "mochi.haxe" */
package mochi.haxe;

import flash.Error;
import flash.system.Security;
import flash.display.MovieClip;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.LocalConnection;
import flash.Lib;

class MochiAd
{
	public static function getVersion():String
	{
		return "3.02 haxe";
	}
	
	public static function doOnEnterFrame(mc:Dynamic):Void
	{
		var f:Dynamic = null;
		f = function(ev:Dynamic):Void {
			if (mc.onEnterFrame != null) {
				mc.onEnterFrame();
			} else {
				ev.target.removeEventListener(ev.type, f);
			}
		}
		mc.addEventListener(Event.ENTER_FRAME, f);
	}
	
	public static function createEmptyMovieClip(parent:Dynamic,name:String,depth:Float):MovieClip
	{
		var mc:MovieClip = new MovieClip();
		/* bsnote: depth seems to be ignored in the original source */
		parent.addChild(mc);
		Reflect.setField(parent, name, mc);
		Reflect.setField(mc, "_name", name);
		return mc;
	}
	
	/**
	 * This function will stop the clip, load the MochiAd in a centered position
	 * on the clip and then resume the clip after a timeout or when this movie
	 * is loaded, whichever comes first.
	 *
	 * For the unique values for this function see {@ref preGameAdOptions}. For
	 * the common options see {@ref mochiAdOptions}.
	 *
	 * @param options an object with keys and values to pass to the server. See
	 *        above for the keys.
	 */
	public static function showPreGameAd(options:Dynamic):Void
	{
		var defaults:Dynamic = {
			ad_timeout: 3000,
			fadeout_time: 250,
			regpt: "o",
			method: "showPreloaderAd",
			color: 0xFF8A00,
			background: 0xFFFFC9,
			outline: 0xD58B3C,
			no_progress_bar: false,
			ad_loaded: function(width:Float, height:Float):Void{},
			ad_failed: function():Void { /*trace("[MochiAd] Couldn't load an ad, make sure your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software");*/ },
			ad_skipped: function():Void {},
			ad_progress: function(percent:Float):Void {}
		};

		options = MochiAd._parseOptions(options, defaults);
		
		if (Reflect.field(options, "ad_started") == null) {
			Reflect.setField(options, "ad_started", function():Void {
				if (Std.is(options.clip, MovieClip)) {
					options.clip.stop();
				} else {
					throw new Error("MochiAd.showPreGameAd requires a clip that is a MovieClip or is an instance of a class that extends MovieClip.  If your clip is a Sprite, then you must provide custom ad_started and ad_finished handlers.");
				}
			});
		}
		if (Reflect.field(options, "ad_finished") == null) {
			Reflect.setField(options, "ad_finished", function():Void {
				if (Std.is(options.clip, MovieClip)) {
					options.clip.play();
				} else {
					throw new Error("MochiAd.showPreGameAd requires a clip that is a MovieClip or is an instance of a class that extends MovieClip.  If your clip is a Sprite, then you must provide custom ad_started and ad_finished handlers.");
				}                    
			});
		}

		if ("c862232051e0a94e1c3609b3916ddb17".substr(0) == "dfeada81ac97cde83665f81c12da7def") {
			options.ad_started();
			var fn:Dynamic = function():Void {
				options.ad_finished();
			};
			haxe.Timer.delay(fn, 100);
			return;
		}

		var clip:Dynamic = options.clip;
		var ad_msec:Float = 11000;
		var ad_timeout:Float = options.ad_timeout;
		Reflect.deleteField(options, "ad_timeout");
		var fadeout_time:Float = options.fadeout_time;
		Reflect.deleteField(options, "fadeout_time");
  
		/* Load targeting under clip._mochiad */
		if (MochiAd.load(options) == null) {
			Reflect.callMethod(options, Reflect.field(options, "ad_failed"), []);
			Reflect.callMethod(options, Reflect.field(options, "ad_finished"), []);
			return;
		}

		options.ad_started();
		
		var mc:MovieClip = clip._mochiad;
		Reflect.setField(mc, "onUnload", function():Void {
			MochiAd._cleanup(mc);
			var fn:Dynamic = function():Void {
				options.ad_finished();
			};
			haxe.Timer.delay(fn, 100);
		});

		/* Center the clip */
		var wh:Array<Float> = MochiAd._getRes(options, clip);
		
		var w:Float = wh[0];
		var h:Float = wh[1];
		mc.x = w * 0.5;
		mc.y = h * 0.5;
	
		var chk:MovieClip = createEmptyMovieClip(mc, "_mochiad_wait", 3);
		chk.x = w * -0.5;
		chk.y = h * -0.5;

		var bar:MovieClip = createEmptyMovieClip(chk, "_mochiad_bar", 4);
		if (options.no_progress_bar) {
			bar.visible = false;
			
			Reflect.deleteField(options, "no_progress_bar");
		} else {
			bar.x = 10;
			bar.y = h - 20;
		}

		var bar_color:Float = options.color;
		Reflect.deleteField(options, "color");
		var bar_background:Float = options.background;
		Reflect.deleteField(options, "background");
		var bar_outline:Float = options.outline;
		Reflect.deleteField(options, "outline");

		var backing_mc:MovieClip = createEmptyMovieClip(bar, "_outline", 1);
		var backing:Dynamic = backing_mc.graphics;

		backing.beginFill(bar_background);
		backing.moveTo(0, 0);
		backing.lineTo(w - 20, 0);
		backing.lineTo(w - 20, 10);
		backing.lineTo(0, 10);
		backing.lineTo(0, 0);
		backing.endFill();

		var inside_mc:MovieClip = createEmptyMovieClip(bar, "_inside", 2);
		var inside:Dynamic = inside_mc.graphics;
		inside.beginFill(bar_color);
		inside.moveTo(0, 0);
		inside.lineTo(w - 20, 0);
		inside.lineTo(w - 20, 10);
		inside.lineTo(0, 10);
		inside.lineTo(0, 0);
		inside.endFill();
		inside_mc.scaleX = 0;

		var outline_mc:MovieClip = createEmptyMovieClip(bar, "_outline", 3);
		var outline:Dynamic = outline_mc.graphics;
		outline.lineStyle(0, bar_outline, 100);
		outline.moveTo(0, 0);
		outline.lineTo(w - 20, 0);
		outline.lineTo(w - 20, 10);
		outline.lineTo(0, 10);
		outline.lineTo(0, 0);

		Reflect.setField(chk, "ad_msec", ad_msec);
		Reflect.setField(chk, "ad_timeout", ad_timeout);
		Reflect.setField(chk, "started", Lib.getTimer());
		Reflect.setField(chk, "showing", false);
		Reflect.setField(chk, "last_pcnt", 0.0);
		Reflect.setField(chk, "fadeout_time", fadeout_time);

		Reflect.setField(chk, "fadeFunction", function():Void {
			var p:Float = 100 * (1 - 
				((Lib.getTimer() - Reflect.field(chk, "fadeout_start") / Reflect.field(chk, "fadeout_time"))));
			
			if (p > 0) {
				chk.parent.alpha = p * 0.01;
			} else {
				MochiAd.unload(clip);
				Reflect.deleteField(chk, "onEnterFrame");
			}
		});

		var complete:Bool = false;
		var unloaded:Bool = false;
		
		var f:Dynamic = null;
		f = function(ev:Event):Void {
			ev.target.removeEventListener(ev.type, f);
			complete = true;
			
			if (unloaded) {
				MochiAd.unload(clip);
			}
		};
		
		if (clip.loaderInfo.bytesLoaded == clip.loaderInfo.bytesTotal) {
			complete = true;
		} else if (Std.is(clip.root, MovieClip)) {
			var r:MovieClip = cast(clip.root, MovieClip);
			
			if (r.framesLoaded >= r.totalFrames)
				complete = true;
			else
				clip.loaderInfo.addEventListener(Event.COMPLETE, f);
		} else {
			clip.loaderInfo.addEventListener(Event.COMPLETE, f);
		}
				

		if (Std.is(clip.root, MovieClip)) {
			var r:MovieClip = cast(clip.root, MovieClip);
			if (r.framesLoaded >= r.totalFrames)
				complete = true;
		}

		Reflect.setField(mc, "unloadAd", function():Void {
			unloaded = true;
			if (complete) {
				MochiAd.unload(clip);
			}
		});

		Reflect.setField(mc, "adLoaded", options.ad_loaded);
		Reflect.setField(mc, "adSkipped", options.ad_skipped);
		Reflect.setField(mc, "adjustProgress", function(msec:Float):Void {
			var _chk:Dynamic = Reflect.field(mc, "_mochiad_wait");
			if (_chk != null) {
				_chk.server_control = true;
				_chk.showing = true;
				_chk.started = Lib.getTimer();
				_chk.ad_msec = msec;
			}
		});
		Reflect.setField(mc, "rpc", function(callbackID:Float, arg:Dynamic):Void {
			MochiAd.rpc(clip, callbackID, arg);
		});
		// Only used for container RPC method call testing
		Reflect.setField(mc, "rpcTestFn", function(s:String):Dynamic {
			//trace('[MOCHIAD rpcTestFn] ' + s);
			return s;
		});
		
		/* Container will call so we know Container LC */
		Reflect.setField(mc, "regContLC", function(lc_name:String):Void {
			Reflect.setField(mc, "_containerLCName", lc_name);
		});

		/* Container will call so we can start sending host loading progress */
		var sendHostProgress:Bool = false;
		Reflect.setField(mc, "sendHostLoadProgress", function(lc_name:String):Void {
			sendHostProgress = true;
		});
		
		Reflect.setField(chk, "onEnterFrame", function():Void {
			if (chk.parent == null || chk.parent.parent == null) {
				Reflect.deleteField(chk, "onEnterFrame");
				return;
			}
			var _clip:Dynamic = chk.parent.parent.root;
			var ad_clip:Dynamic = Reflect.field(chk.parent, "_mochiad_ctr");
			var elapsed:Float = Lib.getTimer() - Reflect.field(chk, "started");
			var finished:Bool = false;
			var clip_total:Float = _clip.loaderInfo.bytesTotal;
			var clip_loaded:Float = _clip.loaderInfo.bytesLoaded;
			if (complete) {
				clip_loaded = Math.max(1, clip_loaded);
				clip_total = clip_loaded;
			}
			var clip_pcnt:Float = (100.0 * clip_loaded) / clip_total;
			var ad_pcnt:Float = (100.0 * elapsed) / Reflect.field(chk, "ad_msec");
			var _inside:Dynamic = Reflect.field(chk, "_mochiad_bar")._inside;
			var pcnt:Float = Math.min(100.0, Math.min(clip_pcnt, ad_pcnt));
			pcnt = Math.max(Reflect.field(chk, "last_pcnt"), pcnt);
			Reflect.setField(chk, "last_pcnt", pcnt);
			_inside.scaleX = pcnt * 0.01;
			
			options.ad_progress(pcnt);
			
			/* Send to our targetting SWF percent of host loaded.  
			   This is so we can notify the AD SWF when we're loaded.
			*/ 
			if (sendHostProgress) {
				clip._mochiad.lc.send(clip._mochiad._containerLCName, 'notify', {id: 'hostLoadPcnt', pcnt: clip_pcnt});
				if (clip_pcnt == 100) 
					sendHostProgress = false;
			}
				 
			if (!Reflect.field(chk, "showing")) {
				var total:Float = Reflect.field(chk.parent, "_mochiad_ctr").contentLoaderInfo.bytesTotal;
				if (total > 0) {
					// ad is now showing
					Reflect.setField(chk, "showing", true);
					Reflect.setField(chk, "started", Lib.getTimer());
					MochiAd.adShowing(clip);
				} else if (elapsed > Reflect.field(chk, "ad_timeout") && clip_pcnt == 100) {
					// ad failed to show - ad_timeout and game is loaded
					options.ad_failed();
					finished = true;
				}
			}

			if (elapsed > Reflect.field(chk, "ad_msec")) {
				finished = true;
			}
			
			if (complete && finished) {
				if (Reflect.field(chk, "server_control")) {
					Reflect.deleteField(chk, "onEnterFrame");
				} else {
					Reflect.setField(chk, "fadeout_start", Lib.getTimer());
					Reflect.setField(chk, "onEnterFrame", Reflect.field(chk, "fadeFunction"));
				}
			}
		});
		doOnEnterFrame(chk);
	}

	/**
	 * This function will load a MochiAd in the upper left position on the clip.
     * This ad will remain there until unload() is called.
	 *
	 * For the unique values for this function see {@ref clickAwayAdOptions}.
	 * For the common options see {@ref mochiAdOptions}.
	 *
	 * @param options an object with keys and values to pass to the server. See
	 *        above for the keys.
	 */
	public static function showClickAwayAd(options:Dynamic):Void
	{
		var defaults:Dynamic = {
			ad_timeout: 2000,
			regpt: "o",
			method: "showClickAwayAd",
			res: "300x250",
			no_bg: true,
			ad_started: function():Void{},
			ad_finished: function():Void{},
			ad_loaded: function(width:Float, height:Float):Void{},
			ad_failed: function():Void{ /*trace("[MochiAd] Couldn't load an ad, make sure your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software");*/ },
			ad_skipped: function():Void{}

		};
		options = MochiAd._parseOptions(options, defaults);

		var clip:Dynamic = options.clip;
		var ad_timeout:Float = options.ad_timeout;
		Reflect.deleteField(options, "ad_timeout");

		/* Load targeting under clip._mochiad */
		if (MochiAd.load(options) == null) {
			options.ad_failed();
			options.ad_finished();
			return;
		}

		options.ad_started();
	
		var mc:MovieClip = clip._mochiad;
		Reflect.setField(mc, "onUnload", function ():Void {
			MochiAd._cleanup(mc);
			options.ad_finished();
		});

		/* Peg the 300x250 ad to the upper left of the MC */
		var wh:Array<Float> = MochiAd._getRes(options, clip);
		
		var w:Float = wh[0];
		var h:Float = wh[1];
		mc.x = w * 0.5;
		mc.y = h * 0.5;
	
		var chk:MovieClip = createEmptyMovieClip(mc, "_mochiad_wait", 3);
		Reflect.setField(chk, "ad_timeout", ad_timeout);
		Reflect.setField(chk, "started", Lib.getTimer());
		Reflect.setField(chk, "showing", false);
		
		Reflect.setField(mc, "unloadAd", function ():Void {
			MochiAd.unload(clip);
		});
		Reflect.setField(mc, "adLoaded", options.ad_loaded);
		Reflect.setField(mc, "adSkipped", options.ad_skipped);
		Reflect.setField(mc, "rpc", function(callbackID:Float,arg:Dynamic):Void {
			MochiAd.rpc(clip, callbackID, arg);
		});
		
		/* Container will call so we register LC name */
		var sendHostProgress:Bool = false;
		Reflect.setField(mc, "regContLC", function(lc_name:String):Void {
			Reflect.setField(mc, "_containerLCName", lc_name);
		});

		Reflect.setField(chk, "onEnterFrame", function():Void {
			if (chk.parent == null) {
				Reflect.deleteField(chk, "onEnterFrame");
				return;
			}
			var ad_clip:Dynamic = Reflect.field(chk.parent, "_mochiad_ctr");
			var elapsed:Float = Lib.getTimer() - Reflect.field(chk, "started");
			var finished:Bool = false;

			if (!Reflect.field(chk, "showing")) {
				var total:Float = Reflect.field(chk.parent, "_mochiad_ctr").contentLoaderInfo.bytesTotal;
				if (total > 0) {
					// ad is now showing
					Reflect.setField(chk, "showing", true);
					finished = true;
					Reflect.setField(chk, "started", Lib.getTimer());
				} else if (elapsed > Reflect.field(chk, "ad_timeout")) {
					// ad failed to show - ad_timeout and game is loaded
					options.ad_failed();
					finished = true;
				}
			}

			/* Poll to see if we're not being displayed anymore */
			if (chk.root == null) {
				finished = true;
			}

			/* Ad is showing, remove this function */
			if (finished) {
				Reflect.deleteField(chk, "onEnterFrame");
			}
		});
		doOnEnterFrame(chk);
	}

	/**
	 * This function will stop the clip, load the MochiAd in a centered position
	 * on the clip, and then resume the clip after a timeout.
	 *
	 * For the unique values for this function see {@ref interLevelAdOptions}.
	 * For the common options see {@ref mochiAdOptions}.
	 *
	 * @param options an object with keys and values to pass to the server. See
	 *        above for the keys.
	 */
	public static function showInterLevelAd(options:Dynamic):Void
	{
		var defaults:Dynamic = {
			ad_timeout: 2000,
			fadeout_time: 250,
			regpt: "o",
			method: "showTimedAd",
			ad_loaded: function(width:Float, height:Float):Void{},
			ad_failed: function():Void {
				//trace("[MochiAd] Couldn't load an ad, make sure your game's local security sandbox is configured for Access Network Only and that you are not using ad blocking software");
			},
			ad_skipped: function():Void{}
		};

		options = MochiAd._parseOptions(options, defaults);

		if (Reflect.field(options, "ad_started") == null) {
			Reflect.setField(options, "ad_started", function():Void {
				if (Std.is(options.clip, MovieClip)) {
					options.clip.stop();
				} else {
					throw new Error("MochiAd.showInterLevelAd requires a clip that is a MovieClip or is an instance of a class that extends MovieClip.  If your clip is a Sprite, then you must provide custom ad_started and ad_finished handlers.");
				}
			});
		}
		if (Reflect.field(options, "ad_finished") == null) {
			Reflect.setField(options, "ad_finished", function():Void {
				if (Std.is(options.clip, MovieClip)) {
					options.clip.play();
				} else {
					throw new Error("MochiAd.showInterLevelAd requires a clip that is a MovieClip or is an instance of a class that extends MovieClip.  If your clip is a Sprite, then you must provide custom ad_started and ad_finished handlers.");
				}                    
			});
		}

		var clip:Dynamic = options.clip;
		var ad_msec:Float = 11000;
		var ad_timeout:Float = options.ad_timeout;
		Reflect.deleteField(options, "ad_timeout");
		var fadeout_time:Float = options.fadeout_time;
		Reflect.deleteField(options, "fadeout_time");

		/* Load targeting under clip._mochiad */
		if (MochiAd.load(options) == null) {
			options.ad_failed();
			options.ad_finished();
			return;
		}

		options.ad_started();
	
		var mc:MovieClip = clip._mochiad;
		Reflect.setField(mc, "onUnload", function ():Void {
			MochiAd._cleanup(mc);
			options.ad_finished();
		});

		/* Center the clip */
		var wh:Array<Float> = MochiAd._getRes(options, clip);
		var w:Float = wh[0];
		var h:Float = wh[1];
		mc.x = w * 0.5;
		mc.y = h * 0.5;
		
		var chk:MovieClip = createEmptyMovieClip(mc, "_mochiad_wait", 3);
		Reflect.setField(chk, "ad_msec", ad_msec);
		Reflect.setField(chk, "ad_timeout", ad_timeout);
		Reflect.setField(chk, "started", Lib.getTimer());
		Reflect.setField(chk, "showing", false);
		Reflect.setField(chk, "fadeout_time", fadeout_time);
		Reflect.setField(chk, "fadeFunction", function ():Void {
			if (chk.parent == null) {
				Reflect.deleteField(chk, "onEnterFrame");
				Reflect.deleteField(chk, "fadeFunction");
				return;
			}
			var p:Float = 100 * (1 - 
				((Lib.getTimer() - Reflect.field(chk, "fadeout_start") / Reflect.field(chk, "fadeout_time"))));
			if (p > 0) {
				chk.parent.alpha = p * 0.01;
			} else {
				MochiAd.unload(clip);
				Reflect.deleteField(chk, "onEnterFrame");
			}
		});

		Reflect.setField(mc, "unloadAd", function():Void {
			MochiAd.unload(clip);
		});
		
		Reflect.setField(mc, "adLoaded", options.ad_loaded);
		Reflect.setField(mc, "adSkipped", options.ad_skipped);
		Reflect.setField(mc, "adjustProgress", function(msec:Float):Void {
			var _chk:Dynamic = Reflect.field(mc, "_mochiad_wait");
			if (chk != null) {
				_chk.server_control = true;
				_chk.showing = true;
				_chk.started = Lib.getTimer();
				_chk.ad_msec = msec - 250;
			}
		});
		Reflect.setField(mc, "rpc", function(callbackID:Float,arg:Dynamic):Void {
			MochiAd.rpc(clip, callbackID, arg);
		});

		Reflect.setField(chk, "onEnterFrame",function():Void {
			if (chk.parent == null) {
				Reflect.deleteField(chk, "onEnterFrame");
				Reflect.deleteField(chk, "fadeFunction");
				return;
			}
			var ad_clip:Dynamic = Reflect.field(chk.parent, "_mochiad_ctr");
			var elapsed:Float = Lib.getTimer() - Reflect.field(chk, "started");
			var finished:Bool = false;

			if (!Reflect.field(chk, "showing")) {
				var total:Float = Reflect.field(chk.parent, "_mochiad_ctr").contentLoaderInfo.bytesTotal;
				if (total > 0) {
					// ad is now showing
					Reflect.setField(chk, "showing", true);
					Reflect.setField(chk, "started", Lib.getTimer());
					MochiAd.adShowing(clip);
				} else if (elapsed > Reflect.field(chk, "ad_timeout")) {
					// ad failed to show - ad_timeout
					options.ad_failed();
					finished = true;
				}
			}

			if (elapsed > Reflect.field(chk, "ad_msec")) {
				finished = true;
			}
			if (finished) {
				if (Reflect.field(chk, "server_control")) {
					Reflect.deleteField(chk, "onEnterFrame");
				} else {
					Reflect.setField(chk, "fadeout_start", Lib.getTimer());
					Reflect.setField(chk, "onEnterFrame", Reflect.field(chk, "fadeFunction"));
				}
			}
		});
		doOnEnterFrame(chk);
	}

	public static function _allowDomains(server:String):String
	{
		var hostname:String = server.split("/")[2].split(":")[0];
	
		if (Security.sandboxType == "application") return hostname;
	
		Security.allowDomain("*");
		Security.allowDomain(hostname);
		Security.allowInsecureDomain("*");
		Security.allowInsecureDomain(hostname);
		return hostname;
	}

	/**
	 * Load a MochiAd into the given MovieClip
	 *
	 * For the options see {@ref mochiAdOptions}.
	 *
	 * @param options an object with keys and values to pass to the server. See
	 *        above for the keys.
	 */
	public static function load(options:Dynamic):MovieClip
	{
		var defaults:Dynamic = {
			server: 'http://x.mochiads.com/srv/1/',
			method: 'load',
			depth: 10333,
			id: "_UNKNOWN_"
		};
		options = MochiAd._parseOptions(options, defaults);
		// This isn't accessible yet for some reason:
		// options.clip.loaderInfo.swfVersion;
		options.swfv = 9;
		options.mav = MochiAd.getVersion();

		var clip:Dynamic = options.clip;

		if (!MochiAd._isNetworkAvailable()) {
			return null;
		}
	
		try {
			if (clip._mochiad_loaded) {
				return null;
			}
		} catch (e:Error) {
			throw new Error("MochiAd requires a clip that is an instance of a dynamic class.  If your class extends Sprite or MovieClip, you must make it dynamic.");
		}

		var depth:Float = options.depth;
		Reflect.deleteField(options, "depth");
		var mc:MovieClip = createEmptyMovieClip(clip, "_mochiad", depth);
	
		var wh:Array<Float> = MochiAd._getRes(options, clip);
		options.res = Std.int(wh[0]) + "x" + Std.int(wh[1]);

		options.server += options.id;
		Reflect.deleteField(options, "id");

		clip._mochiad_loaded = true;

		if (clip.loaderInfo.loaderURL.indexOf("http") == 0) {
			options.as3_swf = clip.loaderInfo.loaderURL;
		} else {
			//trace("[MochiAd] NOTE: Security Sandbox Violation errors below are normal");
		}

		var lv:URLVariables = new URLVariables();
		var fields:Array<String> = Reflect.fields(options);
		for (k in fields) {
			var v:Dynamic = Reflect.field(options, k);
			if (!Reflect.isFunction(v)) {
				Reflect.setField(lv, k, v);
			}
		}

		var server:String = lv.server;
		Reflect.deleteField(lv, "server");
		var hostname:String = _allowDomains(server);

		/* Set up LocalConnection recieve between here and targetting swf */
		var lc:LocalConnection = new LocalConnection();
		/* Make callbacks operate on targetting swf container */
		lc.client = mc;
		var name:String = [
			"", Math.floor((Date.now()).getTime()), Math.floor(Math.random() * 999999)
		].join("_");
		lc.allowDomain("*", "localhost");
		lc.allowInsecureDomain("*", "localhost");
		lc.connect(name);
		Reflect.setField(mc, "lc", lc);
		Reflect.setField(mc, "lcName", name);
		/* register our LocalConnection name with targetting swf */
		lv.lc = name;
		
		lv.st = Lib.getTimer();
		var loader:Loader = new Loader();

		var g:Dynamic = null;
		g = function(ev:Dynamic):Void {
			ev.target.removeEventListener(ev.type, g);
			MochiAd.unload(clip);
		}
		loader.contentLoaderInfo.addEventListener(Event.UNLOAD, g);

		var req:URLRequest = new URLRequest(server + '.swf?cacheBust=' + Date.now().getTime());
		req.contentType = 'application/x-www-form-urlencoded';
		req.method = URLRequestMethod.POST;
		req.data = lv;
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(io:IOErrorEvent):Void { /*trace("[MochiAds] Blocked URL - " + io.text);*/ });
		loader.load(req);
		mc.addChild(loader);
		/* load targetting swf */
		Reflect.setField(mc, "_mochiad_ctr", loader);
					
		return mc;
	}
	
	/**
	 * Unload a MochiAd from the given MovieClip.
	 *
	 * @param clip a MovieClip reference
	 */
	public static function unload(clip:Dynamic):Bool
	{
		if (clip.clip && clip.clip._mochiad) {
			clip = clip.clip;
		}
		
		if (Reflect.hasField(clip, "stage") && Reflect.hasField(clip, "origFrameRate")) {
			clip.stage.frameRate = clip.origFrameRate;
		}
		
		if (!Reflect.hasField(clip, "_mochiad")) {
			return false;
		}  
		
		if (Reflect.hasField(clip._mochiad, "_containerLCName")) {
			clip._mochiad.lc.send(clip._mochiad._containerLCName, 'notify', {id: 'unload'});
		}
		
		if (Reflect.isFunction(clip._mochiad.onUnload)) {
			clip._mochiad.onUnload();
		}
		
		Reflect.deleteField(clip, "_mochiad_loaded");
		Reflect.deleteField(clip, "_mochiad");
		
		return true;
	}

	public static function _cleanup(mc:Dynamic):Void
	{
		if (Reflect.hasField(mc, 'lc')) {
			var lc:LocalConnection = mc.lc;
			var f:Dynamic = function():Void {
				try {
					lc.client = null;
					lc.close();
				} catch (e:Error) {
				}
			};
			haxe.Timer.delay(f, 0);
		}
		var idx:Int = cast(mc, DisplayObjectContainer).numChildren;
		while (idx > 0) {
			idx -= 1;
			cast(mc, DisplayObjectContainer).removeChildAt(idx);
		}
		var fields:Array<String> = Reflect.fields(mc);
		for (k in fields) {
			Reflect.deleteField(mc, k);
		}
	}

	public static function _isNetworkAvailable():Bool
	{
		return Security.sandboxType != "localWithFile";
	}

	public static function _getRes(options:Dynamic,clip:Dynamic):Array<Float>
	{
		var b:Dynamic = clip.getBounds(clip.root);
		var w:Float = 0;
		var h:Float = 0;
		if (Reflect.hasField(options, "res")) {
			var xy:Array<String> = options.res.split("x");
			w = Std.parseFloat(xy[0]);
			h = Std.parseFloat(xy[1]);
		} else {
			w = b.xMax - b.xMin;
			h = b.yMax - b.yMin;
		}
		if (w == 0 || h == 0) {
			w = clip.stage.stageWidth;
			h = clip.stage.stageHeight;
		}

		return [w, h];
	}

	public static function _parseOptions(options:Dynamic,defaults:Dynamic):Dynamic
	{
		var optcopy:Dynamic = {};
		var fields:Array<String> = Reflect.fields(defaults);
		for (k in fields) {
			Reflect.setField(optcopy, k, Reflect.field(defaults, k));
		}
		if (options != null) {
			fields = Reflect.fields(options);
			for (k in fields) {
				Reflect.setField(optcopy, k, Reflect.field(options, k));
			}
		}
		if (!Reflect.hasField(optcopy, "clip")) {
			throw new Error("MochiAd is missing the 'clip' parameter.  This should be a MovieClip, Sprite or an instance of a class that extends MovieClip or Sprite.");
		}
		
		if (Reflect.hasField(optcopy.clip.loaderInfo.parameters, "options")) {
			options = optcopy.clip.loaderInfo.parameters.mochiad_options;
			if (options) {
				var pairs:Array<String> = options.split("&");
				for (pair in pairs) {
					var kv:Array<String> = pair.split("=");
					Reflect.setField(optcopy, StringTools.urlDecode(kv[0]), StringTools.urlDecode(kv[1]));
				}
			}
		}
		if (optcopy.id == 'test') {
			//trace("[MochiAd] WARNING: Using the MochiAds test identifier, make sure to use the code from your dashboard, not this example!");
		}
		return optcopy;
	}
	
	public static function rpc(clip:Dynamic,callbackID:Float,arg:Dynamic):Void
	{
		switch (arg.id) {
		case 'setValue':
			MochiAd.setValue(clip, arg.objectName, arg.value);
		case 'getValue':
			var val:Dynamic = MochiAd.getValue(clip, arg.objectName);
			clip._mochiad.lc.send(clip._mochiad._containerLCName, 'rpcResult', callbackID, val);
		case 'runMethod':
			var ret:Dynamic = MochiAd.runMethod(clip, arg.method, arg.args);
			clip._mochiad.lc.send(clip._mochiad._containerLCName, 'rpcResult', callbackID, ret);
		default:
			//trace('[mochiads rpc] unknown rpc id: ' + arg.id);
		}
	}
	
	public static function setValue(base:Dynamic,objectName:String,value:Dynamic):Void
	{
		var nameArray:Array<String> = objectName.split(".");
		var i:Int = 0;
		
		// drill down through the base object until we get the parent class of object to modify
		while (i < nameArray.length - 1) {
			var name:String = nameArray[i++];
			if (Reflect.field(base, name) == null) return;
			base = Reflect.field(base, name);
		}
		
		Reflect.setField(base, nameArray[i], value);
	}
	
	public static function getValue(base:Dynamic,objectName:String):Dynamic {
		var nameArray:Array<String> = objectName.split(".");
		var i:Int = 0;
		
		// drill down through the base object until we get the parent class of object to modify
		while (i < nameArray.length - 1) {
			var name:String = nameArray[i++];
			if (Reflect.field(base, name) == null) return;
			base = Reflect.field(base, name);
		}
		
		// return the object requested
		return Reflect.field(base, nameArray[i]);
	}
	
	public static function runMethod(base:Dynamic,methodName:String,argsArray:Array<Dynamic>):Dynamic
	{
		var nameArray:Array<String> = methodName.split(".");
		var i:Int = 0;
		
		// drill down through the base object until we get the parent class of object to modify
		while (i < nameArray.length - 1) {
			var name:String = nameArray[i++];
			if (Reflect.field(base, name) == null) return;
			base = Reflect.field(base, name);
		}
		
		// run method
		try {
			return Reflect.callMethod(base, Reflect.field(base, nameArray[i]), argsArray);
		} catch (whatever:Dynamic) {
			return null;
		}
	}
	
	public static function adShowing(mc:Dynamic):Void
	{
		// set stage framerate to 30fps for the ad undo this later in the unload
		Reflect.setField(mc, "origFrameRate", mc.stage.frameRate);
		mc.stage.frameRate = 30;
	}
}

