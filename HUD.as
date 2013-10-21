package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import mochi.as3.*;

	public class HUD extends Entity
	{
		//Here we are embedding a font we can use for the HUD. Weirdly enough with fonts, you refer to the font
		//By the fontFamily string you provide, not the variable name.
		[Embed(source = "assets/pirate.ttf", embedAsCFF='false', fontFamily = "pirate")]
		private var font:Class;

		//initiate all the vars we will need. Static means it is the same variable across all instances,
		//and therefore can be accessedfrom an other class
		public static var scoreText:Text;
		public static var gameOverText1:Text;
		public static var gameOverText2:Text;
		private var display:Graphiclist;
		public static var gameOver:Boolean = false;
		public var mochiScoreSubmitted:Boolean = false;
		public var ID:String = "7fd452bb2b3324cb";
		public static var playCount:int = 1;
		public static var endLevel:int = 5; // EDIT to 5, was 6
		public static var musicLooped:Boolean = false;

		public function HUD() {
			//This is meaning the HUD will draw on top of EVERYTHING, which is what we want.
			//unless specified, all entities have a layer of 0
			layer = -1

			//Set up all the textfields we are gong to be using. Pretty self explanitory
			scoreText = new Text(String(playCount) + "/" + String(endLevel - 1) + " " + "Score: " + String(AGworld.score), 360, 360 , 385, 70)
			scoreText.font = "pirate"
			scoreText.color = 0x000000;
			scoreText.size = 54

			gameOverText1 = new Text("",10,10,700,52);//,FP.screen.width/2-55,FP.screen.height/2-8,110,18);
			gameOverText1.font = "pirate";
			gameOverText1.color = 0x000000;
			gameOverText1.size = 32

			gameOverText2 = new Text("",10,70,700,52);//,FP.screen.width/2-138,FP.screen.height/2+8,276,18);
			gameOverText2.font = "pirate";
			gameOverText2.color = 0x000000;
			gameOverText2.size = 32

			display = new Graphiclist(scoreText,gameOverText1,gameOverText2)

			//This time we are going to be displaying multiple graphics (Text, in this case) on screen
			//to do this, we use a Graphiclist

			graphic = display
			//We can then set the Graphiclist to the graphic property of an Entity to make it draw all
			//the Images passed to the Graphiclist
		}

		override public function update():void
		{
			//updates the score
			scoreText.text = String(playCount) + "/" + String(endLevel - 1) + " " + "Score: " + String(AGworld.score)

			//Restarts the game if it's GAME OVER!
			if (gameOver) {
				Kongregate.submit("Score", AGworld.score);
				if (AGworld.score > AGworld.scoreToAdvance) {
					var scoreToAdvance:Number = AGworld.score * 1.5 //AGworld.score + AGworld.score;
				}
				else {scoreToAdvance = AGworld.scoreToAdvance;}

				if (!mochiScoreSubmitted && Player.killed || king.Kingkilled) { //playCount == endLevel) {
					var o:Object = { n: [4, 4, 12, 10, 9, 6, 4, 8, 14, 4, 0, 4, 10, 12, 14, 10], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
					var boardID:String = o.f(0,"");
					MochiScores.showLeaderboard({boardID: boardID, score: AGworld.score});
					mochiScoreSubmitted = true;
				}
				if (Player.killed) {
					AGworld.score = 0;
					//Player.killed = false;
				}

//				var i:int = 0;
//				var pauseTime:int = 3;
//				while (i < pauseTime) {
//					i++;
//				}
				if (Input.check(Key.SPACE) || fire.firePressed) {
//					var oldMuteStatus:Boolean = AGworld.mute;
					if (playCount < endLevel) {
						Player.killed = false;
						FP.world = new AGworld;
//						AGworld.mute = oldMuteStatus;
						AGworld.scoreToAdvance = scoreToAdvance;
						gameOverText1.text = ""
						gameOverText2.text = ""
						gameOver = false;
					}
				}
				if (king.Kingkilled) {
					FP.world = new End;
					Kongregate.submit("Score", AGworld.score);
					Kongregate.submit("GameComplete", 1);
					MochiEvents.trackEvent("Game Beaten");
					}
			}
		}

	}

}
