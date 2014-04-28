package
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.FP;
	
	public class CreationSpark extends Entity
	{
		[Embed(source = 'assets/Graphics/CreationSpark.png')] private const CREATION_SPARK:Class;
		
		private var CreationSparkEmitter:Emitter;
		private var Time:Number = 0;
		private var Alpha:Number = 0;
		
		public function CreationSpark(INx:Number, INy:Number)
		{
			x = INx;
			y = INy;
			
			
			setHitbox(140, 140, 10, 10);
			type = "Spark";
			
			CreationSparkEmitter = new Emitter(new BitmapData(2, 2), 2, 2);
			CreationSparkEmitter.relative = false;
			
			CreationSparkEmitter.newType("Spark", [0]);
			CreationSparkEmitter.setAlpha("Spark", 0, 1, Ease.quartInOut);
			CreationSparkEmitter.setColor("Spark", 0x000000);
			CreationSparkEmitter.setMotion("Spark", 0, 150, 2, 360, -10, 0, Ease.quadOut);
			
			graphic = new Graphiclist(CREATION_SPARK, CreationSparkEmitter);
		}
		
		override public function update():void 
		{
			Time ++;
			CreationSparkEmitter.emit("Spark", x - halfWidth, y - halfHeight);
			Alpha += 0.016666667
			if (Time == 60) FP.world.remove(this);
		}
	}
}