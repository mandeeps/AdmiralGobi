// Admiral Gobi pirate king ship

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;

	public class king extends Entity {

		[Embed(source="assets/king.png")]
		public var kingclass:Class;
		private var speed:Number = 100;//30;
		public var kinghealth:int = 20;
//		public static var curHealth:int = health;
//		public static var gameWon:Boolean = false;
		public static var Kingkilled:Boolean = false;
		private var myspeed:Number = speed;
		[Embed(source="assets/shipexplode.png")]
		public const explodeImg:Class;
		private var killedcounter:Number = 0;
		[Embed(source="assets/bigboom.swf#sound")]
//		[Embed(source="assets/bigboom.mp3")]
		public var bigboomSound:Class;
		public var bigboom:Sfx = new Sfx(bigboomSound);
//		public static var nextWave:Boolean = false;
		public var img:Image = new Image(kingclass);
		public var moveUp:Boolean = false;
		public var moveDown:Boolean = false;
		public var shotfired:Boolean = false;
		private var reloadTime:int = 20;
		private var lastShot:Number = reloadTime;
		[Embed(source="assets/cannon.swf#sound")]
		private var cannonSound:Class;
		public var cannon:Sfx = new Sfx(cannonSound);

		public function king(_x:int, _y:int):void {
			graphic = img;
			width = 69;
			height = 74;
			x = _x; //FP.screen.width - width;
			y = _y; //(FP.screen.height/2) - (height /2) ;
			type = "king"
		}

		override public function update():void {
			move();
			lastShot++
			var bullet:Bullet = collide("bullet", x,y) as Bullet;
			if (bullet) {
				kinghealth -= 1;
				bullet.destroy();
			}
			if (kinghealth == 0) {
				AGworld.score += 24000;
				Boss.gameWon = true;
				HUD.gameOver = true;
//				nextWave = true;
				myspeed = 0;
				y += 15;
				if (!AGworld.mute) {bigboom.play();}
//				AGworld.particleExplosion(x,y);
				graphic = new Image(explodeImg);
				Kingkilled = true;
				kinghealth = 1;
			}
			if (Kingkilled) {
				killedcounter++;
			}
			if (killedcounter >= 2) {
				kingBullet.remove = true;
				destroy();
				}
//			if ((x + width) < 0) {
//				AGworld.saveLSO();
//				HUD.gameOver = true;
//				HUD.gameOverText1.text = "The Pirates Have Landed! - Your Highest Score: " + String(AGworld.highScore);
//				HUD.gameOverText2.text = "Press Fire To Restart";
//				Player.killed = true;
				//AGworld.score = 0;
//			}
		}

		private function move():void {
			if (x > FP.stage.width - width - 20) {
				x -= speed * FP.elapsed;
				moveUp = true;
			}
			else {
				fire(x, y)
				if (moveDown) {
					y += speed * FP.elapsed;
					if (y >= FP.stage.height - height - 70) {
						moveDown = false;
						moveUp = true;
					}
				}
				else if (moveUp) {
					y -= speed * FP.elapsed;
					if (y <= height - 30) {
						moveUp = false;
						moveDown = true;
					}
				}
			}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

		public function fire(x:int,y:int):void {
			if (lastShot >= reloadTime) {
//				showFlames = true
				if (!AGworld.mute) {cannon.play();}
				world.add(new kingBullet((x),(y+(height/2)+20)));
				lastShot = 0;
				shotfired = true;
			}
		}


	}
}
