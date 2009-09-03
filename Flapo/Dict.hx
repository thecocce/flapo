/**
 * ...
 * @author Bence Dobos
 */

package flapo;

enum DLang
{
  DICT_ENG;
  DICT_HUN;
}

class Dict
{

	public var Language: DLang;
	public var nLang: Int;
	static public var maxText: Int = 7;
	static public var Dictionary: Array < Array < String >> = 
		[
			[
			//0
				"English",
				"Music",
				"Info",
				"Continue",
				"Destroy all round tiles before entering the exit tile!",
			//5
				"<font color='#FFFFFF'><p align='center'><b>Flapo 2</b></p></font><br>" +
					"<font color='#aaaaff'>Control the ball trough multilevel mazes. Destroy all round tiles before entering the exit tile. You can destroy tiles which colors match your ball`s color. Use jump pads to access higher levels><br><br>" +
					"Written by <a href='http://dobosbence.wordpress.com'><font color='#ccccFF'>Bence Dobos</font></a><br>" +
					"Music and sfx by <a href='http://www.freshmindworkz.hu/vincenzo'><font color='#ccccFF'>Vincenzo</font></a><br>" +
					"Idea and gfx by Microshark/Damage<br>" +
					"<p align='center'>copyright 2009</p></font>",
				"<p align='center'><b>You win!</b></p><br></center>You beat Flapo 2 techdemo! Congratulation! " +
					"You can continue playing levels from Flapo 1!<br><br>" +
					"<p align='center'>Click to close this message.</p>",
				"<p align='center'>no score yet</p>",
				"<p align='center'>Score: ",
				"<p align='center'>no medals earned</p>",
			//10
				"<p align='center'>Bronze medal</p>",
				"<p align='center'>Silver medal</p>",
				"<p align='center'>Gold medal</p>",
				"<font color='#804020'><p align='center'>Submit</p></font>",
				"<font color='#804020'><p align='center'>Show</p></font>",
			//15
				"<font color='#5090F0'><p align='center'>Submit</p></font>",
				"<font color='#5090F0'><p align='center'>Show</p></font>"
				
			],
			[ 
			//0
				"Magyar",
				"Zene",
				"Info",
				"Tovább",
				"Szedd le az összes kerek mezőt mielött kimész!",
			//5
				"<font color='#FFFFFF'><p align='center'><b>Flapo</b></p></font><br>" +
					"<font color='#aaaaff'>Irányítsd a labdát több szinten és szedd le az összes kerek elemet, majd menj a kijárathoz! Csak a golyóval megegyezö színűeket veheted le. Ugratókkal juthatsz fel magasabb helyekre.<br><br>" +
					"Írta: <a href='http://dobosbence.wordpress.com'><font color='#ccccFF'>Dobos Bence</font></a><br>" +
					"Zene és sfx: <a href='http://www.freshmindworkz.hu/vincenzo'><font color='#ccccFF'>Vincenzo</font></a><br>" +
					"Ötlet és gfx: Microshark/Damage<br>" +
					"<p align='center'>Minden jog fenttartva 2009</p></font>",
				"<p align='center'><b>Nyertél!</b></p><br></center>Legyőzted a Flapo 2 techdemót! Gratulálok! " +
					"Folytathatod a játékot a Flapo 1 pályáin!<br><br>" +
					"<p align='center'>Az üzenet bezárásához kattints!</p>"	,
				"<p align='center'>még nincs pont</p>",
				"<p align='center'>Pont: ",
				"<p align='center'>nincs medál</p>",
			//10
				"<p align='center'>Bronz medál</p>",
				"<p align='center'>Ezüst medál</p>",
				"<p align='center'>Aranz medál</p>",
				"<font color='#804020'><p align='center'>Küld</p></font>",
				"<font color='#804020'><p align='center'>Megnéz</p></font>",
			//15
				"<font color='#5090F0'><p align='center'>Küld</p></font>",
				"<font color='#5090F0'><p align='center'>Megnéz</p></font>"

			]
		]; 

	
	public function new(lang: DLang) 
	{
		Language = lang;
		switch ( Language )
		{
			case DICT_ENG: nLang = 0;
			case DICT_HUN: nLang = 1;
		}
		maxText = Dictionary[nLang].length;
	}
	
	public function get(textnum: Int)
	{
		if (textnum<0 || textnum>=maxText)
			return "(error)";
		return Dictionary[nLang][textnum];
	}
}