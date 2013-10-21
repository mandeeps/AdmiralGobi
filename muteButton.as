// Admiral Gobi muteButton button

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import mochi.as3.*;

	public class muteButton extends Entity {
		[Embed(source="assets/sound.png")]
		public var muteButtonclass:Class;
		[Embed(source="assets/muteButton.png")]
		public var unmute:Class;
		public static var muteButtonPressed:Boolean = false;
		public var buttonCounter:int = 0;
		public var un:Image = new Image(unmute)
		public var img1:Image = new Image(muteButtonclass);
		public var img2:Image = un;

		public function muteButton():void {
			if (!AGworld.mute) {graphic = img1;}
			else {graphic = img2}
			x = FP.screen.width / 10 - 80;
			y = 440 - 64;//416;
			width = 64;
			height = 64;
			type = "muteButton"
			visible = true;
		}

		override public function update():void {
			if (Input.mousePressed && collidePoint(x,y,Input.mouseX,Input.mouseY)) {
				MochiEvents.trackEvent("mutePressed")
				buttonCounter++
				if (buttonCounter >0) {//{muteButtonPressed = !muteButtonPressed; graphic = un}
					AGworld.mute = !AGworld.mute;
					if (AGworld.mute && graphic == img1) {
						graphic = img2;
					}
					else if (!AGworld.mute && graphic == img2) {
						graphic = img1;
					}
				}
			}
		}

	}
}
