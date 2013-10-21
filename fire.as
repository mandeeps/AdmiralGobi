// Admiral Gobi fire button

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class fire extends Entity {
		[Embed(source="assets/fire.png")]
		public var fireclass:Class;
		public static var firePressed:Boolean = false;
		private var fire1:Image = new Image(fireclass);
		[Embed(source="assets/fire2.png")]
		public var fireclass2:Class;
		private var fire2:Image = new Image(fireclass2);

		public function fire():void {
			graphic = fire1;
			width = 60;
			height = 60;
			x = (FP.screen.width / 10) + 103;
			y = 440 - 64;//416;
			type = "fire"
		}

		override public function update():void {
			if (Input.mouseDown && collidePoint(x,y,Input.mouseX,Input.mouseY)) { //(Input.mouseDown && this.collidePoint(Input.mouseX,Input.mouseY,Input.mouseX,Input.mouseY)) {
				firePressed = true;
				Up.upPressed = false;
				down.downPressed = false;
			}
			if (firePressed) {
				graphic = fire2;
				if (Input.mouseReleased) {
					graphic = fire1;
					firePressed = false;
				}
			}
		}

	}
}
