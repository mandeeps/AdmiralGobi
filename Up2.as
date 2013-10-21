// Admiral Gobi up file

package {

	import net.flashpunk.*;
	import net.flashpunk.graphics.*;

	public class Up2 extends Entity {
		[Embed(source="assets/up.png")]
		public var upclass:Class;

		public function Up2():void {
			graphic = new Image(upclass);
			width = 71;
			height = 78;
			x = 300;
			y = 200;
			type = "up"
		}

	}
}
