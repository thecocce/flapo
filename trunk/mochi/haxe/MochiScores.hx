/*
 * MochiAds.com haXe code, version 3.02
 * Copyright (C) 2006-2008 Mochi Media, Inc. All rigths reserved.
 * Haxe conversion (C) 2009 Kostas Michalopoulos
 */

/*! @module "mochi.haxe" */
package mochi.haxe;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.TextField;

/**
 * Provides access to Mochi leaderboards.
 */
class MochiScores
{
	public static function onClose(args:Dynamic=null):Void
	{
		if (args != null) {
			if (Reflect.field(args, "error") != null) {
				if (args.error == true) {
					if (onErrorHandler != null) {
						if (Reflect.field(args, "errorCode") == null)
							args.errorCode = "IOError";
						onErrorHandler(args.errorCode);
						MochiServices.doClose();
						return;
					}
				}
			}
		}
		onCloseHandler();
		MochiServices.doClose();
	}
	
	public static var onCloseHandler:Dynamic = null;
	public static var onErrorHandler:Dynamic = null;
	private static var boardID:String;
    
	/**
	 * Sets the name of the mode to use for categorizing submitted and displayed
	 * scores. The board ID is assigned in the online interface.
	 *
	 * @param boardID the unique string name of the mode
	 */
	public static function setBoardID(boardID:String):Void
	{
		MochiServices.warnID(boardID, true);
		MochiScores.boardID = boardID;
		MochiServices.send("scores_setBoardID", { boardID: boardID } );
	}
	
	/**
	 * Displays the leaderboard GUI showing the current top scores. The
	 * callback event is triggered when the leaderboard is closed.
	 *
	 * For the options below see {@link guiOptions}.
	 *
	 * @param options object containing variables representing the changeable
	 *        parameters.
	 */
	public static function showLeaderboard(options:Dynamic=null):Void
	{
		if (options != null) {
			if (Reflect.field(options, "clip") != null) {
				if (Std.is(options.clip, Sprite)) MochiServices.setContainer(options.clip);
				Reflect.deleteField(options, "clip");
			} else {
				MochiServices.setContainer();
			}
			
			MochiServices.stayOnTop();
			
			if (Reflect.field(options, "name") != null) {
				if (Std.is(options.name, TextField)) {
					if (options.name.text.length > 0) {
						options.name = options.name.text;
					}
				}
			}
			
			if (Reflect.field(options, "score") != null) {
				if (Std.is(options.score, TextField)) {
					if (options.score.text.length > 0) {
						options.score = options.score.text;
					}
				} else if (Std.is(options.score, MochiDigits)) {
					options.score = options.score.toString();
				}

				var n:Float = Std.parseFloat(options.score);
				// check if score is a numeric value
				if (Math.isNaN(n)) {
					//trace( "ERROR: Submitted score '" + options.score + "' will be rejected, score is 'Not a Number'" );
				}
				else if (!Math.isFinite(n)) {
					//trace( "ERROR: Submitted score '" + options.score + "' will be rejected, score is an infinite" ); 
				} else {
					if (Math.floor(n) != n) 
					{}//trace( "WARNING: Submitted score '" + options.score + "' will be truncated" );
					
					options.score = n;
				}
			}
			
			if (Reflect.field(options, "onDisplay") != null) {
				options.onDisplay();
			} else {
				if (MochiServices.clip != null) {
					if (Std.is(MochiServices.clip, MovieClip)) {
						MochiServices.clip.stop();
					} else {
						//trace("Warning: Container is not a MovieClip, cannot call default onDisplay.");
					}
				}
			}
		} else {
			options = {};
			if (Std.is(MochiServices.clip, MovieClip)) {
				MochiServices.clip.stop();
			} else {
				//trace("Warning: Container is not a MovieClip, cannot call default onDisplay.");
			}
		}
		
		if (Reflect.field(options, "onClose") != null) {
			onCloseHandler = options.onClose;
		} else {
			onCloseHandler = function():Void { 
				if (Std.is(MochiServices.clip, MovieClip)) {
					MochiServices.clip.play(); 
				} else {
					//trace("Warning: Container is not a MovieClip, cannot call default onClose.");
				}
			}
		}
			
		if (Reflect.field(options, "onError") != null) {
			onErrorHandler = options.onError;
		} else {
			onErrorHandler = null;
		}
		
		if (Reflect.field(options, "boardID") == null) {
			if (MochiScores.boardID != null) {
				options.boardID = MochiScores.boardID;
			}
		}
		MochiServices.warnID(options.boardID, true);
		
		//trace("[MochiScores] NOTE: Security Sandbox Violation errors below are normal");
		MochiServices.send("scores_showLeaderboard", { options: options }, null, onClose); 
	}
	
	/**
	 * Closes the leaderboard immediately
	 */
	public static function closeLeaderboard():Void
	{
		MochiServices.send("scores_closeLeaderboard");
	}
	
	
	/**
	 * Retrieves all persistent player data that has been saved in a
	 * SharedObject. Will send to the callback an object containing key->value
	 * pairs contained in the player cookie.
	 */
	public static function getPlayerInfo(callbackObj:Dynamic,callbackMethod:Dynamic=null):Void
	{
		MochiServices.send("scores_getPlayerInfo", null, callbackObj, callbackMethod);
	}
	
	/**
	 * Submits a score to the server using the current id and mode.
	 *
	 * @param name the string name of the user as entered or defined by MochiBridge.
	 * @param score the number representing a score.  Can be an integer or float.  If the score is time, send it in seconds - can be float
	 * @param callbackObj the object or class instance containing the callback method
	 * @param callbackMethod the string name of the method to call when the score has been sent
	 */
	public static function submit(score:Float,name:String,callbackObj:Dynamic=null,callbackMethod:Dynamic=null):Void
	{ 
		score = Std.int(score);
		
		// check if score is a numeric value
		if (Math.isNaN(score)) {
			//trace( "ERROR: Submitted score '" + score + "' will be rejected, score is 'Not a Number'" );
		}
		else if (!Math.isFinite(score)) {
			//trace( "ERROR: Submitted score '" + score + "' will be rejected, score is an infinite" ); 
		} else {
			if (Math.floor(score) != score)
			{}//trace( "WARNING: Submitted score '" + score + "' will be truncated" );
			
			score = Std.int(score);
		}
	
		MochiServices.send("scores_submit", {score: score, name: name}, callbackObj, callbackMethod); 
	}
	
	/**
	 * Method: requestList
	 *
	 * Requests a listing from the server using the current game id and mode.
	 * Returns an array of at most 50 score objects. Will send to the callback
	 * an array of objects [{name, score, timestamp}, ...]
	 *
	 * @param callbackObj the object or class instance containing the callback method
	 * @param callbackMethod the string name of the method to call when the score has been sent. default: "onLoad"
	 */
	public static function requestList(callbackObj:Dynamic,callbackMethod:Dynamic=null):Void
	{
		MochiServices.send("scores_requestList", null, callbackObj, callbackMethod);
	}
	
	/**
	 * Method: scoresArrayToObjects
	 *
	 * Converts the cols/rows array format retrieved from the server into an
	 * array of objects - one object for each row containing key-value pairs.
	 *
	 * @param scores the scores object received from the server
	 * @return the array of objects
	 */
	public static function scoresArrayToObjects(scores:Dynamic):Dynamic
	{
		var so:Dynamic = {};
		var i:Int;
		var j:Int;
		var row_obj:Dynamic;
		var fields:Array<String> = Reflect.fields(scores);
		
		for (item in fields) {
			var entry:Dynamic = Reflect.field(scores, item);
			
			if (Reflect.isObject(entry)) {
				if (Reflect.field(entry, "cols") != null && Reflect.field(entry, "rows") != null) {
					Reflect.setField(so, item, new Array<Dynamic>());
					
					for (j in 0...entry.rows.length) {
						row_obj = {};
						for (i in 0...entry.cols.length) {
							Reflect.setField(row_obj, entry.cols[i], entry.rows[j][i]);
						}
						Reflect.field(so, item).push(row_obj);
					}
				} else {
					var params:Array<String> = Reflect.fields(entry);
					Reflect.setField(so, item, {});
					
					for (param in params) {
						Reflect.setField(Reflect.field(so, item), param, Reflect.field(entry, param));
					}
				}
			} else {
				Reflect.setField(so, item, entry);
			}
		}
		
		return so;
	}
}

