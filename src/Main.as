package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author PIneaPplez13
	 */
	public class Main extends Engine 
	{
		
		public function Main()
		{
			super(800, 600, 60);
			FP.world = new TitleScreen;
		}
		
		override public function init():void 
		{
			trace("Man I haven't done this in a while");
		}
	}
	
}