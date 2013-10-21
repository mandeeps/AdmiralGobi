package
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.*;

	/**
	 * A fun place for particles to hang out!
	 * @author Zachary Weston Lewis
	 */
	public class ParticleWorld extends World
	{
		private var _em:Emitter;
		[Embed(source = "assets/particle.jpg")] private static const ANIMATED_PARTICLE:Class;
		public function ParticleWorld()
		{
			_em = new Emitter(ANIMATED_PARTICLE, 8, 8);
			_em.newType("animated", [0, 1, 2, 3]);
			_em.setAlpha("animated", 1, 0);
			_em.setMotion("animated", 0, 0, 0.4, 15, 5, 0.4);
		}

		override public function update():void
		{
			if (Input.mouseDown)
			{
				_em.emit("animated", FP.world.mouseX, FP.world.mouseY);
			}
			super.update();
		}

		override public function render():void
		{
			_em.render(new Point, FP.camera);
			super.render();
		}

	}

}
