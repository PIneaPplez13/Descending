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
		private var BeforeTime:int = 0;
		private var TotalTime:Number = 1;
		private var BlockTime:Number = 0;
		private var BlockDown:Number = 180;
		private var BlockNumber:int = 1;
		private var RandomColumn:Array = new Array(0, 0, 0, 0);
		private var RandomRow:Array = new Array(0, 0, 0, 0);
		private var IntroDone:Boolean = false;
		
		public function Tile(LevelIndex:int)
		{
			//Tilemap/Grid stuff
			tiles = new Tilemap(TILESET, 640, 480, 40, 40);
			grid = new Grid(640, 480, 40, 40, 0, 0);
			mask = grid;
			
			tiles.createGrid([1], grid);
			
			type = "Platform";
			
			//Particle stuff
			{
			//Warning type
				WarningEmitter = new Emitter(new BitmapData(2, 2), 2, 2);
				WarningEmitter.relative = false;
				
				WarningEmitter.newType("Warning", [0]);
				WarningEmitter.setAlpha("Warning", 0, 1);
				WarningEmitter.setMotion("Warning", 0, 40, 1, 360, 0, 0, Ease.quadIn);
				WarningEmitter.setColor("Warning", 0x000000);
				
				//Creation type
				CreationEmitter = new Emitter(new BitmapData(4, 4), 4, 4);
				CreationEmitter.relative = false;
				
				CreationEmitter.newType("Creation", [0]);
				CreationEmitter.setAlpha("Creation", 1, 0, Ease.quadIn);
				CreationEmitter.setMotion("Creation", 0, 20, 2, 360, 20, 2, Ease.quadOut);
				CreationEmitter.setColor("Creation", 0x000000);
			}
			
			//Define graphic
			graphic = new Graphiclist(tiles, WarningEmitter, CreationEmitter);
		}
		
		override public function update():void
		{
			//Intro stuff
			{
				if (BeforeTime < 250) BeforeTime += 1;
				else IntroDone = true;
				
				if (BeforeTime >= 60 && BeforeTime < 240)
				{
					WarningEmitter.emit("Warning", 300, 260);
					WarningEmitter.emit("Warning", 340, 260);
				}
				if (BeforeTime >= 130 && BeforeTime < 240)
				{
					CreationEmitter.emit("Creation", 300, 260);
					CreationEmitter.emit("Creation", 340, 260);
				}
				if (BeforeTime >= 180)
				{
					tiles.setRect(7, 6, 2, 1, 1);
					tiles.createGrid([1], grid);
				}
			}
				
			//After Intro
			if (IntroDone == true)
			{
				TotalTime ++;
				BlockTime ++;
			}
			
			//Adjust BlockDown & BlockNumber
			if (TotalTime % 900 == 0) BlockDown = BlockDown - 8;
			if (TotalTime % 1800 == 0 && BlockNumber != 4) BlockNumber = BlockNumber + 1;
			
			//Add Blocks
			if (BlockTime == 1)
			{
				for (var i:int = 0; i < BlockNumber; i++)
				{
					RandomColumn[i] = int(Math.random() * 16);
					RandomRow[i] = int(Math.random() * 12);
				}
			}
			if (BlockTime >= BlockDown / 2)
			{
				for (var n:int = 0; n < BlockNumber; n++)
				{
					WarningEmitter.emit("Warning", (RandomColumn[n] * 40) + 20, (RandomRow[n] * 40) + 20);
					CreationEmitter.emit("Creation", (RandomColumn[n] * 40) + 20, (RandomRow[n] * 40) + 20);
				}
			}
			if (BlockTime >= BlockDown)
			{
				for (var q:int = 0; q < BlockNumber; q++)
				{
					tiles.setTile(RandomColumn[q], RandomRow[q], 1);
					tiles.createGrid([1], grid);
				}
				BlockTime = 0;
			}
		}
	}
}