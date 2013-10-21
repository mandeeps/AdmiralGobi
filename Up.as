// Admiral Gobi up button

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class Up extends Entity {
		[Embed(source="assets/up.png")]
		public var Upclass:Class;
		[Embed(source="assets/up2.png")]
		public var Upclass2:Class;
		public static var upPressed:Boolean = false;
		private var up1:Image = new Image(Upclass);
		private var up2:Image = new Image(Upclass2);

		public function Up():void {
			graphic = up1;
			x = FP.screen.width / 10;
			y = 440 - 64;//416;
			width = 60;
			height = 60;
			type = "up"
		}

		override public function update():void {
			if (Input.mouseDown && collidePoint(x,y,Input.mouseX,Input.mouseY)) { //if (Input.mouseDown && this.collidePoint(Input.mouseX,Input.mouseY,Input.mouseX,Input.mouseY)) {
				upPressed = true;
				down.downPressed = false;
				fire.firePressed = false;
			}
			if (upPressed) {
				graphic = up2;
				if (Input.mouseReleased) {
					graphic = up1;
					upPressed = false;
				}
			}
		}

	}
}
