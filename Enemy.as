// Admiral Gobi Enemy file

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*

	public class Enemy extends Entity {

		[Embed(source="assets/pirate2.png")]
		public var pirateclass:Class;
		public static var speed:Number = 100;//80;//200;//100;
		private var myspeed:Number = speed;
		[Embed(source="assets/shipexplode.png")]
		public const explodeImg:Class;
		private var killedcounter:Number = 0;
		private var killed:Boolean = false;
		[Embed(source="assets/boom.swf#sound")]
//		[Embed(source="assets/boom2.mp3")]
		public var boomSound:Class;
		public var boom:Sfx = new Sfx(boomSound);

		public function Enemy(_x:int, _y:int):void {
			var img:Image = new Image(pirateclass);
			mask = new Pixelmask(pirateclass);
			width = img.width; //pirateclass.width; //71;
			height = img.height; //pirateclass.height; //78;
			graphic = img;
			x = _x; //FP.screen.width - width;
			y = _y; //(FP.screen.height/2) - (height /2) ;
			type = "enemy"
		}

		override public function update():void {
			move();
			var bullet:Bullet = collide("bullet", x,y) as Bullet;
			if (bullet) {
//				cameraShake.activateCameraJitter(20);
				AGworld.score += 50;
				bullet.destroy();
				myspeed = 0;
				y += 25;
				if (!AGworld.mute) {boom.play();}
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

			if (!HUD.gameOver && (x + width) < 0) {
				//HUD.gameOver = true;
				//HUD.gameOverText1.text = "A Pirate Got Past You!";
				//HUD.gameOverText2.text = "Press Fire";
				if (AGworld.score <= 50) {
					AGworld.score = 0;
				}
				else {
					AGworld.score -= 25;
				}
				destroy()
			}
		}

		private function move():void {
			x -= myspeed * FP.elapsed;
		}

		public function destroy():void {
			FP.world.remove(this);
		}

//		public function fire():void {
//
//		}

	}
}
