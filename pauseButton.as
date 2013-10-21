// Admiral Gobi pause button

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;

	public class pauseButton extends Entity {
		[Embed(source="assets/pauseButton.png")]
		public var pauseclass:Class;
		public var buttonCounter:int = 0;
//		public static var mouseCheck:Boolean = false;

		public function pauseButton():void {
			var img:Image = new Image(pauseclass);
			graphic = img;
			width = img.width;
			height = img.height;
			x = (FP.screen.width / 10) + 240;//310;
			y = 440 - height;
			type = "pause"
		}

//		override public function update():void {
//			if (Input.mousePressed && collidePoint(x,y,Input.mouseX,Input.mouseY)) {
//				buttonCounter++
//				if (buttonCounter >2) {
//					AGworld.pause = !AGworld.pause;
//				}
//			}
//		}

	}
}
