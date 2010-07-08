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
				"Destroy all rounded tiles before entering the exit tile!",
			//5
				"<font color='#FFFFFF'><p align='center'><b>Flapo 2</b></p></font><br>" +
					"<font color='#aaaaff'>Control the ball through multilevel mazes. Destroy all rounded tiles before entering the exit tile. You can destroy tiles which color match your ball's color. Use jump pads to access higher levels.<br><br>" +
					"Written by <a href='http://dobosbence.wordpress.com' target='_blank'><font color='#ccccFF'>Bence Dobos</font></a><br>" +
					"Music and sfx by <a href='http://www.freshmindworkz.hu/vincenzo' target='_blank'><font color='#ccccFF'>Vincenzo</font></a><br>" +
					"Idea and gfx by Microshark/Damage<br>" +
					"<p align='center'>copyright 2009</p></font>",
				"<p align='center'><b>You win!</b></p><br></center>You beat Flapo 2! Congratulation! " +
					"<br><br>You got new skins for the ball as a reward. Press T to change skin during play.<br>" +
					"<a href='http://dobdob.metacortex.hu/?p=5' target='_blank'>Click here to try Flapo 1.</a><br><br>" +
					"<p align='center'>Click to close this message.</p>",
				"<p align='center'>No yet</p>",
				"<p align='center'>Time: ",
				"<p align='center'>No medals earned</p>",
			//10
				"<p align='center'>Bronze medal</p>",
				"<p align='center'>Silver medal</p>",
				"<p align='center'>Gold medal</p>",
				"<font color='#0000FF'><p align='center'>Submit</p></font>",
				"<font color='#0000FF'><p align='center'>Show</p></font>",
			//15
				"<font color='#5090F0'><p align='center'>Submit</p></font>",
				"<font color='#5090F0'><p align='center'>Show</p></font>",
				"<p align='center'>Personal best: ",
				"<font color='#F04020'><p align='center'>Clear times</p></font>",
				"Back",
			//20
				"<p align='center'>One moment</p>",
				"<p align='center'><a href='http://internetjatek.hu'>Game is stolen! Click here to play!</a></p>",
				"<p align='right'>More games</p>",
				"Again",
				"Move to start",
			//25
				"Upload score"
			],
			[ 
			//0
				"Magyar",
				"Zene",
				"Info",
				"Tovább",
				"Szedd le az összes kerek mezőt mielött kimész!",
			//5
				"<font color='#FFFFFF'><p align='center'><b>Flapo 2</b></p></font><br>" +
					"<font color='#aaaaff'>Irányítsd a labdát több szinten és szedd le az összes kerek elemet, majd menj a kijárathoz! Csak a golyóval megegyezö színűeket veheted le. Ugratókkal juthatsz fel magasabb helyekre.<br><br>" +
					"Írta: <a href='http://dobosbence.wordpress.com' target='_blank'><font color='#ccccFF'>Dobos Bence</font></a><br>" +
					"Zene és sfx: <a href='http://www.freshmindworkz.hu/vincenzo' target='_blank'><font color='#ccccFF'>Vincenzo</font></a><br>" +
					"Ötlet és gfx: Microshark/Damage<br>" +
					"<p align='center'>Minden jog fenttartva 2009</p></font>",
				"<p align='center'><b>Nyertél!</b></p><br></center>Legyőzted a Flapo 2-t!" +
					"<br><br>Jutalmul új külsejű golyókat kaptál. A T gombbal válthatod játék közben.<br>" +
					"<a href='http://dobdob.metacortex.hu/?p=5' target='_blank'>A Flapo 1 kipróbálásához kattints ide.</a><br><br>" +
					"<p align='center'>Az üzenet bezárásához kattints!</p>"	,
				"<p align='center'>Még nincs</p>",
				"<p align='center'>Idő: ",
				"<p align='center'>Nincs medál</p>",
			//10
				"<p align='center'>Bronz medál</p>",
				"<p align='center'>Ezüst medál</p>",
				"<p align='center'>Arany medál</p>",
				"<font color='#0000FF'><p align='center'>Küld</p></font>",
				"<font color='#0000FF'><p align='center'>Megnéz</p></font>",
			//15
				"<font color='#5090F0'><p align='center'>Küld</p></font>",
				"<font color='#5090F0'><p align='center'>Megnéz</p></font>",
				"<p align='center'>Saját legjobb: ",
				"<font color='#F04020'><p align='center'>Idők törlése</p></font>",
				"Vissza",
			//20
				"<p align='center'>Egy pillanat</p>",
				"<p align='center'><a href='http://internetjatek.hu'>Lopott játék. Kattints ide!</a></p>",
				"<p align='right'>Még több játék</p>",
				"Újra",
				"Mozdulj!",
			//25
				"Pontszám elküldése"				
			]
		]; 

	
	public function new(lang: DLang) 
	{
		if (lang == null)
			Language = DICT_ENG;
		else
			Language = lang;
		switch ( Language )
		{
			case DICT_ENG: nLang = 0;
			case DICT_HUN: nLang = 1;
		}
		maxText = Dictionary[nLang].length;
	}
	
	public function change(lang: DLang)
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