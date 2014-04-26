package
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	
	public class TitleText extends Entity
	{
		[Embed(source = 'assets/Fonts/Ruritania.ttf', embedAsCFF = "false", fontFamily = 'Ruritania')] private const RURITANIA:Class;
		
		public function TitleText()
		{	
			Text.font = "Ruritania";
			Text.size = 72;
			graphic = new Text("Dark", 290, 230, "size");
		}
	}
	
}