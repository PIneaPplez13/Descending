package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Image;
	
	public class TitleText extends Entity
	{
		[Embed(source = 'assets/Fonts/Ruritania.ttf', embedAsCFF = "false", fontFamily = 'Ruritania')] private const RURITANIA:Class;
		
		public function TitleText()
		{	
			Text.font = "Ruritania";
			Text.size = 72;
			graphic = new Text("Descending", 200, 200, "alpha");
			
		}
		
		
		override public function update():void 
		{
			if (Input.check(Key.ENTER))
			{
				FP.world = new Level1;
			}
		}
	}
}