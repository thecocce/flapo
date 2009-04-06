/**
 * ...
 * @author Bence Dobos
 */

package flapo;
import flapo.GameLogic;
import flash.display.MovieClip;
//import cr

class Menu 
{
    static var game: GameLogic;
	static var mc: MovieClip;
	
	public function new(getgame: GameLogic) 
	{
		game = getgame;
		mc = new MovieClip();
		//CreateEmptyMovieClip
	}
	
	public function Show()
	{
		
	}
	
	public function Hide()
	{
		
	}
	
	//gets mouse x,y coordinates
	//returns selected menu or 0
	public function checkMouse(x: Int, y: Int) :Int
	{
		//game.x = 999;
		return 0;
	}
}