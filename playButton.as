// Admiral Gobi Intro play button to start main game

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import mochi.as3.*;


	public class playButton extends Entity {
		[Embed(source="assets/playButton2.png")]
		public var playB:Class;

		public function playButton():void {
			var img:Image = new Image(playB);
			graphic = img
			width = img.width; //64;
			height = img.height; //64;
			x = (FP.stage.width/2) - (width/2);
			y = FP.stage.height - (height);
			type = "play"
		}

		override public function update():void {
			if (Input.mousePressed && collidePoint(x,y,Input.mouseX,Input.mouseY)) {
				MochiEvents.startPlay()
				Intro.musicStart();
				FP.world = new AGworld;
			}
		}

	}
}
