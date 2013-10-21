// Admiral Gobi world file

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.Backdrop;
	import Math;
	import net.flashpunk.utils.*;
	import flash.net.SharedObject;
	import net.flashpunk.Sfx;
//	import flash.events.Event;
//	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.geom.Point;
	import net.flashpunk.graphics.*;

	public class AGworld extends World {
		private var spawnTimer:Number = 2.5;//3;//4;//6;
		public var spawnLimit:Number = 1.20;//1.25;//1.5; //0.5
		public static var score:int = 0;
		private var bossFight:Boolean = false;
		public static var scoreToAdvance:Number = 1000;
		public static var pause:Boolean = false;
		public static var highScore:int;
//		[Embed(source="assets/music5.mp3")]
//		[Embed(source="assets/music.swf#importedsound")]
//		public var bgmusic:Class;
//		public var music:Sfx = new Sfx(bgmusic);
		public static var musicStop:Boolean = false;
		public static var mute:Boolean = false;
		[Embed(source="assets/backdrop2.jpg")]
		private var spr_backdrop:Class;
		private var backdrop1:Image;
		public var buttonCounter:int = 0;
		[Embed(source="assets/particle.jpg")]
		private var particleClass:Class;
		public static var explode:Emitter;
		public var motionSicknessTimer:int = 0;
		public var Kong:Boolean = true;

		public function AGworld() {
			FP.stage.frameRate = 24; // 10
			FP.stage.scaleMode = StageScaleMode.NO_SCALE;
			FP.stage.align = StageAlign.TOP_LEFT;

//			FP.stage.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			var lso:SharedObject = SharedObject.getLocal("AdmGobiScore");
			if (lso.data.savedData == null) {
				highScore = score;
			}
			else {
				highScore = int(lso.data.savedData);
			}
			lso.flush();

			backdrop1 = new Image(spr_backdrop);
			backdrop1.centerOO();
			addGraphic(backdrop1);
//			backdrop1.originX = 750;
//			backdrop1.originY = 440
			add(new HUD);
			add(new cameraShake)
			add(new muteButton);
			add(new down);
			add(new fire);
			add(new Up);
			add(new Player);
			add(new fireExplosion);
			if (HUD.playCount < (HUD.endLevel - 1)) {
				add(new Enemy(FP.width+10, 200));
				resetSpawnTimer();
			}
			else {add(new king(760,150))}
//			if (!HUD.musicLooped) { //HUD.playCount == 1 && !HUD.musicLooped) {
//				music.loop();
//				HUD.musicLooped = true;
//			}

//			explode = new Emitter(particleClass, 2,2);
//			explode.newType("explosion", [0]);
//			explode.setMotion("explosion",0,50,0.1,360,50,0.9)

		}

		override public function update():void {
			if (Kong) {Kongregate.connect(FP.stage); Kongregate.submit("Started Game", 1); Kong = false;}
			if (Input.pressed(Key.P)) { //|| android pause) {
				pause = !pause;
			}
			if (muteButton.muteButtonPressed){//Input.pressed(Key.M) || muteButton.muteButtonPressed) {
				mute = !mute;
			}

			if (Boss.gameWon) {
				if (Boss.health < 16 ) {Boss.health *= 2}
				Boss.curHealth = Boss.health;
				bossFight = false;
				HUD.gameOverText1.text = "You Beat This Wave!";
				HUD.gameOverText2.text = "Press Fire To Continue!";
				HUD.gameOver = true;
				Boss.gameWon = false;
				HUD.playCount++;
				saveLSO();

				if (Enemy.speed < 200) {//160) {
					Enemy.speed += 30
				}
				if (Player.playerSpeed > 80) {
					Player.playerSpeed -= 10
				}
				resetSpawnTimer();
			}

			if (!pause) {

			if (motionSicknessTimer < 24 ) {motionSicknessTimer++}
			else {motionSicknessTimer = 0, backdrop1.angle = 0}
//			if (motionSicknessTimer == 0) {backdrop1.angle = 0}
			if (motionSicknessTimer == 3) {backdrop1.angle = .5}
			if (motionSicknessTimer == 6) {backdrop1.angle = 1}
			if (motionSicknessTimer == 9) {backdrop1.angle = .5}
			if (motionSicknessTimer == 12) {backdrop1.angle = 0}
			if (motionSicknessTimer == 15) {backdrop1.angle = -.5}
			if (motionSicknessTimer == 18) {backdrop1.angle = -1}
			if (motionSicknessTimer == 21) {backdrop1.angle = -.5}

				if (!mute && musicStop) {
					musicStop = false;
					if (!Intro.music.playing) {Intro.music.resume();}
					}

				if (HUD.playCount < (HUD.endLevel -1)) {
					spawnTimer -= FP.elapsed;
					if (!HUD.gameOver) {
						if (spawnTimer < .25) {
							if (score < scoreToAdvance) {
								spawnEnemy();
								resetSpawnTimer();
							}
							else if (!bossFight) {
								add(new Boss(FP.width+10, 160));
								bossFight = true;
							}
						}
					}
				}
//				explode.update();
				super.update();
			}
			else {
				musicStop = true;
				if (Intro.music.playing) {Intro.music.stop();}
			}

			if (mute) {
				musicStop = true;
				if (Intro.music.playing) {Intro.music.stop();}
			}
		}

		override public function render():void {
//			explode.render(new Point, FP.camera);
			super.render();
		}

		private function spawnEnemy():void {
			var _x:int = FP.screen.width;
			var range:Number = ((FP.screen.height) - (FP.screen.height/3) -40);
			var _y:int = (Math.random() * range) + 40;
			add(new Enemy(_x, _y));
		}

		private function resetSpawnTimer():void {
			spawnTimer *= 0.5;//0.75
			if (spawnTimer < spawnLimit) {
				spawnTimer = spawnLimit;
			}
		}

		public static function saveLSO():void {
			var lso:SharedObject = SharedObject.getLocal("AdmGobiScore");
			if (lso.data.savedData == null) {
				highScore = score;
			}
			else {
				highScore = int(lso.data.savedData);
				if (score > highScore) {
					highScore = score;
				}
			}
			lso.data.savedData = highScore;
			lso.flush();
		}

//		public static function particleExplosion(_x:Number, _y:Number):void {
//			for (var i:int = 0; i < 11; i++) {
//				explode.emit("explosion", _x, _y)
//			}
//		}


//		private function onAddedToStage(evt:Event):void {
//			stage.frameRate = 10;
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.align = StageAlign.TOP_LEFT;
//		}



	}

}
