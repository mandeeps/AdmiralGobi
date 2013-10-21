// AdmiralGobi cannonball class

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.*

	public class Bullet extends Entity {
		private var speed:int = 1500;//1000;//2000;//1000;
//		private var gravity:Number = .1;
		private var decline:Number = 50;//20;//20;
		[Embed("assets/bullet.png")]
		private var bulletImage:Class;

		public function Bullet(_x:int, _y:int) {
			x = _x;
			y = _y;
			var img:Image = new Image(bulletImage);
			mask = new Pixelmask(bulletImage);
			width = img.width;
			height = img.height;
			graphic = img;
//			graphic = Image.createRect(width,height,0x000000);
			type = "bullet";
		}

		override public function update():void {
			x += speed * FP.elapsed;
			if (speed > decline * 5) {speed -= decline;}
//			if (speed <= 180) {destroy()}
//			y += gravity * FP.elapsed;
//			gravity *= decline;
//			decline += .001
//			speed -= gravity;
//			gravity += gravity;
			if ((x > FP.screen.width) || (y > FP.screen.width)) {
				destroy();
			}
			if (x > FP.screen.width - width) {destroy()}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

	}

}
