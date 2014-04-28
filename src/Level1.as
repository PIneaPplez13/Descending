package
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	public class Level1 extends World
	{
		public function Level1()
		{
			FP.screen.color = 0xFFFFFF;
			add(new Player(375, 225));
			add(new Tile(0));
		}
	}
}