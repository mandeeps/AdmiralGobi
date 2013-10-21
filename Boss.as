// Admiral Gobi pirate boss ship

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import mochi.as3.*
	import net.flashpunk.masks.*

	public class Boss extends Entity {

		[Embed(source="assets/boss2.png")]
		public var bossclass:Class;
		private var speed:Number = 60;//30;
		public static var health:int = 2;
		public static var curHealth:int = health;
		public static var gameWon:Boolean = false;
		private var killed:Boolean = false;
		private var myspeed:Number = speed;
		[Embed(source="assets/shipexplode.png")]
		public const explodeImg:Class;
		private var killedcounter:Number = 0;
		[Embed(source="assets/bigboom.swf#sound")]
//		[Embed(source="assets/bigboom.mp3")]
		public var bigboomSound:Class;
		public var bigboom:Sfx = new Sfx(bigboomSound);
//		public static var nextWave:Boolean = false;

		public function Boss(_x:int, _y:int):void {
			var img:Image = new Image(bossclass);
			mask = new Pixelmask(bossclass);
			width = img.width;
			height = img.height;
			graphic = img;
			x = _x; //FP.screen.width - width;
			y = _y; //(FP.screen.height/2) - (height /2) ;
			type = "boss"
		}

		override public function update():void {
			move();
			var bullet:Bullet = collide("bullet", x,y) as Bullet;
			if (bullet) {
//				cameraShake.activateCameraJitter(20);
				curHealth -= 1;
				bullet.destroy();
			}
			if (curHealth <= 0) {
				AGworld.score += 500;
				gameWon = true;
//				nextWave = true;
				myspeed = 0;
				y += 15;
				if (!AGworld.mute) {bigboom.play();}
//				AGworld.particleExplosion(x,y);
				graphic = new Image(explodeImg);
				killed = true;
			}
			if (killed) {
				killedcounter++;
			}
			if (killedcounter >= 2) {
				destroy();
				}
			if ((x + width) < 0) {
				AGworld.saveLSO();
				HUD.gameOver = true;
				HUD.gameOverText1.text = "The Pirates Have Landed! - Your Highest Score: " + String(AGworld.highScore);
				HUD.gameOverText2.text = "Press Fire To Restart";
				Player.killed = true;
				MochiEvents.trackEvent("boss landed");
				//AGworld.score = 0;
			}
		}

		private function move():void {
			x -= speed * FP.elapsed;
		}

		public function destroy():void {
			FP.world.remove(this);
		}

	}
}
