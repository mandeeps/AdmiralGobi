// Admiral Gobi Player file

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import mochi.as3.*;
	import net.flashpunk.masks.*

	public class Player extends Entity {

		[Embed(source="assets/ship2.png")]
		private var playerclass:Class;
		public static var playerSpeed:Number = 120; //200
		public static var shotfired:Boolean = false;
		private var reloadTime:int = 15;
		private var lastShot:Number = reloadTime;
		public static var oldY:int;
		public static var oldX:int;

		[Embed(source="assets/cannon.swf#sound")]
//		[Embed(source="assets/cannon2.mp3")]
		private var cannonSound:Class;
		public var cannon:Sfx = new Sfx(cannonSound);
		public static var killed:Boolean = false;
		private var myspeed:Number = playerSpeed;
		[Embed(source="assets/shipexplode.png")]
		public const explodeImg:Class;
		private var killedcounter:Number = 0;
		public static var showFlames:Boolean = false;
		[Embed(source="assets/boom.swf#sound")]
//		[Embed(source="assets/boom.mp3")]
		public var boomSound:Class;
		public var boom:Sfx = new Sfx(boomSound);

		public function Player():void {
			var img:Image = new Image(playerclass);
			mask = new Pixelmask(playerclass);
			width = img.width;
			height = img.height;
			graphic = img;
			x = 5;
			oldX = x;
			if (!oldY) {
				y = (FP.screen.height / 2) - (height /2);
			}
			else {
				y = oldY;
			}
			type = "player"
		}

		override public function update():void {
			move();
			collision();
			shoot();
			timeToFire();
		}

		public function move():void {
			if (!killed) {

//			if (Input.check("up")) {
//			if (Input.check(Key.DOWN) || down.downPressed) {
			if (Input.check(Key.DOWN) || down.downPressed) {
//			if ( Input.mouseDown && down.collidePoint(Input.mouseX,Input.mouseY,Input.mouseX,Input.mouseY) ) {
				y += playerSpeed * FP.elapsed;
				if ((y + (FP.height /3)) > (FP.height - 20)) {
					y -= playerSpeed * FP.elapsed;
				}
			}
			else if (Input.check(Key.UP) || Up.upPressed) {
				y -= playerSpeed * FP.elapsed;
				if (y < 30) { // was 10
					y += playerSpeed * FP.elapsed;
				}
			}
			oldY = y;
		}
		}

		private function shoot():void {
			if (Input.check(Key.SPACE) || fire.firePressed) {
				if (lastShot >= reloadTime) {
					cameraShake.activateCameraJitter(3);
//					AGworld.particleExplosion(x,y);
					showFlames = true
					if (!AGworld.mute) {cannon.play();}
					world.add(new Bullet((x+width-5),(y+44)));
					lastShot = 0;
					shotfired = true;
				}
			}
		}

		private function collision():void {
			var enemy:Enemy = collide("enemy", x, y) as Enemy;
			var boss:Boss = collide("boss", x, y) as Boss;
			var kingbullet:kingBullet = collide("kingBullet", x, y) as kingBullet;
			if (enemy || boss || kingbullet) {
				if (enemy) {
					enemy.destroy();
				}
				else if (boss) {
					boss.destroy();
				}
				else if (kingbullet) {kingbullet.destroy()}
				AGworld.saveLSO();
				HUD.gameOverText1.text = "Game Over - Your Highest Score: " + String(AGworld.highScore);
				HUD.gameOverText2.text = "Press Fire To Restart";
				HUD.gameOver = true;
				myspeed = 0;
				y += 15;
				if (!AGworld.mute) {boom.play();}
				graphic = new Image(explodeImg);
//				AGworld.particleExplosion(x,y);
				killed = true;
				MochiEvents.trackEvent("killed");
			}
			if (killed) {
				killedcounter++;
			}
			if (killedcounter >= 2) {
				destroy();
				}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

		private function timeToFire():void {
			if (shotfired) {
				lastShot += 1;
			}
			if (lastShot >= reloadTime) {
				shotfired = false;
			}
		}

	}
}

