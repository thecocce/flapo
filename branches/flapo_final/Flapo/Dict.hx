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
				"English",
				"Music",
				"Info",
				"Continue",
				"Destroy all bright tiles before enter the exit tile!",
				"<font color='#FFFFFF'><p align='center'><b>Flapo</b></p></font><br>" +
					"<font color='#aaaaff'>Control the ball trough multilevel mazes. Destroy all bright tiles then enter the exit tile. Use jump pads to access higher levels<br><br>" +
					"Written by <a href='http://dobosbence.extra.hu'><font color='#ccccFF'>Bence Dobos</font></a><br>" +
					"Music by <a href='http://nicenice.net'><font color='#ccccFF'>Nice Nice</font></a><br>" +
					"Idea by Microshark/Damage<br>" +
					"Special thanks to Strato<br>" +
					"<p align='center'>copyright 2009</p></font>",
				"<p align='center'><b>You win!</b></p><br></center>You beat Flapo! Congratulation! I know the last level was killer, but you did it! " +
					"Even I completed the last level only once!<br><br>" +
					"<p align='center'>Click to start over again.</p>"
			],
			[ 
				"Magyar",
				"Zene",
				"Info",
				"Tovább",
				"Szedd le az összes világos mezőt mielött kimész!",
				"<font color='#FFFFFF'><p align='center'><b>Flapo</b></p></font><br>" +
					"<font color='#aaaaff'>Irányítsd a labdát több szinten és szedd le az összes világos elemet, majd menj a kijárathoz! Ugratókkal juthatsz fel magasabb helyekre.<br><br>" +
					"Írta: <a href='http://dobosbence.extra.hu'><font color='#ccccFF'>Bence Dobos</font></a><br>" +
					"Zene: <a href='http://nicenice.net'><font color='#ccccFF'>Nice Nice</font></a><br>" +
					"Ötlet: Microshark/Damage<br>" +
					"Külön köszönet Stratonak<br>" +
					"<p align='center'>Minden jog fenttartva 2009</p></font>",
				"<p align='center'><b>Nyertél!</b></p><br></center>Legyőzted a játékot! Gratulálok! Tudom hogy az utolsó pálya kemény volt, de megcsináltad! " +
					"Ez még nekem is csak egyszer sikerült!<br><br>" +
					"<p align='center'>Kattints az újrakezdéshez</p>"	
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
	}
	
	public function get(textnum: Int)
	{
		if (textnum<0 || textnum>=maxText)
			return "(error)";
		return Dictionary[nLang][textnum];
	}
}