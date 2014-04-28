package
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class PressEnter extends Entity
	{
		[Embed(source = 'assets/Fonts/PIXELADE.ttf', embedAsCFF = "false", fontFamily = 'Pixelade')] private const PIXELADE:Class;
		
		public function PressEnter()
		{
			Text.size = 32;
			Text.font = "Pixelade";
			graphic = new Text("Press Enter", 325, 380, "visible");
		}
		
		public var time:Number = 0;
		
		override public function update():void 
		{
			time ++;
			if (time == 45 && visible == true)
			{
				visible = false;
				time = 0;
			}
			if (time == 45 && visible == false)
			{
				visible = true;
				time = 0;
			}
		}
	}
}