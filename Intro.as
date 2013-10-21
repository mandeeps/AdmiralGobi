// Admiral Gobi Intro Screen

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
//	import mochi.as3.*;

	public class Intro extends World {
		[Embed(source = "assets/pirate.ttf", embedAsCFF='false', fontFamily = "pirate")]
		private var font:Class;
		[Embed(source="assets/AdmiralGobi2.jpg")]
		public const Img:Class;

		[Embed(source="assets/music.swf#sound")]
		public static var bgmusic:Class;
		public static var music:Sfx = new Sfx(bgmusic);

		[Embed(source="assets/introBackdrop.jpg")]
		private var spr_backdrop:Class;
		private var backdrop:Image;

		override public function begin():void {
			Text.font = "pirate";
			var myText:Text = new Text("Help Admiral Gobi and his damaged ship fend off a pirate attack!",5,230,745,52);
			myText.color = 0x000000;
			myText.size = 32;
			var myTextEntity:Entity = new Entity(0, 0, myText);
//			myTextEntity.x = 10;//(FP.width / 2) - (myText.width / 2);
//			myTextEntity.y = 250;//(FP.height / 2) - (myText.height / 2) +30;//+50;
			add(myTextEntity);
			var instructText:Text = new Text("Press the buttons and destroy your foes",180,260,745,52);
			////instructText.font = "pirate"
			instructText.color = 0x000000;
			instructText.size = 32;
			var instructTextEntity:Entity = new Entity(0, 0, instructText);
			//instructTextEntity.x = (FP.width / 2) - (instructText.width / 2);
			//instructTextEntity.y = (FP.height / 2) - (instructText.height / 2) +65;//+85;
			add(instructTextEntity);
			var kingText:Text = new Text("But beware the mighty Pirate King!",195,290,745,52);
			////kingText.font = "pirate"
			kingText.color = 0x000000;
			kingText.size = 32;
			var kingTextEntity:Entity = new Entity(0, 0, kingText);
			//kingTextEntity.x = (FP.width / 2) - (kingText.width / 2);
			//kingTextEntity.y = (FP.height / 2) - (kingText.height / 2) +100;//+120;
			add(kingTextEntity);

			var gobi:Image = new Image(Img)
			var imgEntity:Entity = new Entity(0, 0, gobi);
			imgEntity.x = (FP.width / 2) - (gobi.width / 2);
			imgEntity.y = 10;//(FP.height / 2) - (myText.height / 2);
			add(imgEntity);
			add(new ShergillGames);
			add(new playButton);
			super.begin();
		}

		public function Intro() {
//			FP.screen.color = 0x70DBDB;

			backdrop = new Image(spr_backdrop);
			addGraphic(backdrop);

			//if (!HUD.musicLooped) {
				//music.loop();
				//HUD.musicLooped = true;
			//}
//			add(new playButton);
		}

		override public function render():void {
			super.render();
		}

		public static function musicStart():void {
			if (!HUD.musicLooped) {
				music.volume = 0.5;
				music.loop();
				HUD.musicLooped = true;
			}
		}

	}

}
