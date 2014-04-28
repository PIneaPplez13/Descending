package
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.FP;
	
	public class Tile extends Entity
	{
		[Embed(source = 'assets/Graphics/Tileset.png')] private const TILESET:Class;
		private var tiles:Tilemap;
		private var grid:Grid;
		private var WarningEmitter:Emitter;
		private var CreationEmitter:Emitter;
		private var time:Number = 0;
		public var BeforeTime:int = 0;
		private var RandomColumn:int;
		private var RandomRow:int;
		
		public function Tile(LevelIndex:int)
		{
			//Tilemap/Grid stuff
			tiles = new Tilemap(TILESET, 800, 600, 50, 50);
			grid = new Grid(800, 600, 50, 50, 0, 0);
			mask = grid;
			
			tiles.createGrid([1], grid);
			
			type = "Platform";
			
			//Particle stuff
			
			//Warning type
			WarningEmitter = new Emitter(new BitmapData(2, 2), 2, 2);
			WarningEmitter.relative = false;
			
			WarningEmitter.newType("Warning", [0]);
			WarningEmitter.setAlpha("Warning", 0, 1);
			WarningEmitter.setMotion("Warning", 0, 50, 1, 360, 0, 0, Ease.quadIn);
			WarningEmitter.setColor("Warning", 0x000000);
			
			//Creation type
			CreationEmitter = new Emitter(new BitmapData(4, 4), 4, 4);
			CreationEmitter.relative = false;
			
			CreationEmitter.newType("Creation", [0]);
			CreationEmitter.setAlpha("Creation", 1, 0, Ease.quadIn);
			CreationEmitter.setMotion("Creation", 0, 25, 2, 360, 25, 2, Ease.quadOut);
			CreationEmitter.setColor("Creation", 0x000000);
			
			
			//Define graphic
			graphic = new Graphiclist(tiles, WarningEmitter, CreationEmitter);
		}
		
		override public function update():void
		{
			//Intro stuff
			if (BeforeTime < 250) BeforeTime += 1;
			if (BeforeTime >= 60 && BeforeTime < 240)
			{
				WarningEmitter.emit("Warning", 375, 325);
				WarningEmitter.emit("Warning", 425, 325);
			}
			if (BeforeTime >= 130 && BeforeTime < 240)
			{
				CreationEmitter.emit("Creation", 375, 325);
				CreationEmitter.emit("Creation", 425, 325);
			}
			if (BeforeTime >= 180)
			{
				tiles.setRect(7, 6, 2, 1, 1);
				tiles.createGrid([1], grid);
			}
			
			
			//After Intro
			if (BeforeTime > 240) time ++;
			if (time == 60)
			{
				RandomColumn = Math.random() * 16;
				RandomRow = Math.random() * 12;
			}
			if (time >= 60)
			{
				WarningEmitter.emit("Warning", (RandomColumn * 50) + 25, (RandomRow * 50) + 25);
			}
			if (time >= 60) CreationEmitter.emit("Creation", (RandomColumn * 50) + 25, (RandomRow * 50) + 25);
			if (time >= 180)
			{
				tiles.setTile(RandomColumn, RandomRow, 1);
				tiles.createGrid([1], grid);
				
				time = 0;
			}
		}
	}
}