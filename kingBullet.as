// AdmiralGobi king cannonball class

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.Sfx;
	import net.flashpunk.masks.*

	public class kingBullet extends Entity {
		private var speed:int = 500;//2000;//1000;
//		private var gravity:Number = .1;
//		private var decline:Number = 10;//20;
//		[Embed("assets/kingBullet.png")]
//		private var kingBulletImage:Class;
		public static var remove:Boolean = false;

		public function kingBullet(_x:int, _y:int) {
			x = _x;
			y = _y;
			width = 4
			height = 4
//			graphic = new Image(kingBulletImage);
			graphic = Image.createRect(width,height,0x000000);
//			graphic = new Image(img);
//			mask = new Pixelmask(img);
			type = "kingBullet";
		}

		override public function update():void {
			x -= speed * FP.elapsed;
//			speed -= decline;
//			y += gravity * FP.elapsed;
//			gravity *= decline;
//			decline += .001
//			speed -= gravity;
//			gravity += gravity;
			if (x < 0 || remove) {
				destroy();
			}
		}

		public function destroy():void {
			FP.world.remove(this);
		}

	}

}
