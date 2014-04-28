package
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	public class TitleScreen extends World
	{
		public function TitleScreen()
		{
			FP.screen.color = 0x000000
			add(new TitleText());
			add(new PressEnter());
		}
	}
}