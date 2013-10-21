// Admiral Gobi down button

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class down extends Entity {
		[Embed(source="assets/down.png")]
		public var downclass:Class;
		[Embed(source="assets/down2.png")]
		public var downclass2:Class;
		public static var downPressed:Boolean = false;
		private var down1:Image = new Image(downclass);
		private var down2:Image = new Image(downclass2);

		public function down():void {
			graphic = down1
			width = 60;
			height = 60;
			x = (FP.screen.width / 10) + 208;
			y = 440 - 64;
			type = "down"
		}

		override public function update():void {
			if (Input.mouseDown && collidePoint(x,y,Input.mouseX,Input.mouseY)) {
				downPressed = true;
				Up.upPressed = false;
				fire.firePressed = false;
			}
			if (downPressed) {
				graphic = down2;
				if (Input.mouseReleased) {
					graphic = down1;
					downPressed = false;
				}
			}
		}


	}
}
