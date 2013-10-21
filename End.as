// Admiral Gobi End Screen

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;

	public class End extends World {
		[Embed(source = "assets/pirate.ttf", embedAsCFF = "false", fontFamily = "pirate")]
		private var font:Class;
		[Embed(source="assets/AdmiralGobi2.jpg")]
		public const Img:Class;

		[Embed(source="assets/introBackdrop.jpg")]
		private var spr_backdrop:Class;
		private var backdrop:Image;

		override public function begin():void {
			Text.font = "pirate"
			var myText:Text = new Text("Thanks to you the pirates have been defeated!",140,230,745,52);
			myText.color = 0x000000;
			myText.size = 32;
			var myTextEntity:Entity = new Entity(0, 0, myText);
//			myTextEntity.x = (FP.width / 2) - (myText.width / 2);
//			myTextEntity.y = (FP.height / 2) - (myText.height / 2) +50;
			add(myTextEntity);
			var instructText:Text = new Text("You have won the thanks of the famous Admiral Gobi,",80,260,745,52);
//			instructText.font = "pirate"
			instructText.color = 0x000000;
			instructText.size = 32;
			var instructTextEntity:Entity = new Entity(0, 0, instructText);
//			instructTextEntity.x = (FP.width / 2) - (instructText.width / 2);
//			instructTextEntity.y = (FP.height / 2) - (instructText.height / 2) +85;
			add(instructTextEntity);
			var rewardText:Text = new Text("and a massive share of the Pirate King's treasure!",100,290,745,52);
//			rewardText.font = "pirate"
			rewardText.color = 0x000000;
			rewardText.size = 32;
			var rewardTextEntity:Entity = new Entity(0, 0, rewardText);
//			rewardTextEntity.x = (FP.width / 2) - (rewardText.width / 2);
//			rewardTextEntity.y = (FP.height / 2) - (rewardText.height / 2) +120;
			add(rewardTextEntity);

			var gobi:Image = new Image(Img)
			var imgEntity:Entity = new Entity(0, 0, gobi);
			imgEntity.x = (FP.width / 2) - (gobi.width / 2);
			imgEntity.y = 10;//(FP.height / 2) - (myText.height / 2);
			add(imgEntity);
			add(new ShergillGames);
			super.begin();
		}

		public function End() {
			Intro.music.stop();
			backdrop = new Image(spr_backdrop);
			addGraphic(backdrop);
//			FP.screen.color = 0x70DBDB;
//			add(new playButton);
		}

		override public function render():void {
			super.render();
		}

	}

}
