// AG explosion effect for when play fires cannon

package {
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	public class fireExplosion extends Entity {
		[Embed(source="assets/fireExplosion.png")]
		public const fireExploImg:Class;
		private var count:int = 0;

		public function fireExplosion():void {
			graphic = new Image(fireExploImg);
			x = 0;
			y = 0;
			width = 53;
			height = 29;
			type = "fireExplo"
			visible = false;
		}

		override public function update():void {
			if (Player.showFlames) {
				x = (Player.oldX + 10);
				y = (Player.oldY + 44);
				visible = true;
				if (count < 2) {
					count++
				}
				if (count >=2) {
					Player.showFlames = false;
					count = 0
					visible = false;
				}
			}
		}

	}
}
