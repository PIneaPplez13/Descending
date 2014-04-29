package
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{
		public var Gravity:Number = 2;
		public var Xmomentum:Number = 0;
		public var Ymomentum:Number = 0;
		public var BeforeTime:Number = 0;
		
		public function Player(INx:Number, INy:Number)
		{
			x = INx;
			y = INy;
			
			graphic = Image.createRect(35, 35, 0x000000)
			setHitbox(35, 35);
			type = "Player";
		}
		
		private var JumpNumber:int = 2;
		override public function update():void
		{
			//Intro stuff
			if (BeforeTime < 200) 
			{
				BeforeTime += 1;
				Gravity = 0;
				
			}
			else 
			{
				Gravity = 2;
				//Player input.
				if (Input.check(Key.D)) Xmomentum += 1.25; //move right
				else if (Input.check(Key.A)) Xmomentum += -1.25; //move left
				else Xmomentum = 0; //not moving
			}
			
			
			
			if (Input.pressed(Key.W) && JumpNumber == 0)
			{
				Ymomentum = -25;
				JumpNumber += 1;
			}
			else if (Input.pressed(Key.W) && JumpNumber == 1 && Ymomentum < 0)
			{
				Ymomentum += -10;
			}
			
			//Applying Physics.
			if (Xmomentum > 7) Xmomentum = 7;
			if (Xmomentum < -7) Xmomentum = -7;
			Ymomentum += Gravity;

			//X movmement and collision
			x += Xmomentum;
			if (collide("Platform", x, y) && Xmomentum > 0)
			{
				Xmomentum = 0;
				x = int(x / 50) * 50 + (50 - this.width);
			}
			if (collide("Platform", x, y) && Xmomentum < 0)
			{
				Xmomentum = 0;
				x = int(x / 50) * 50 + 50;
			}
			 
			//Y axis movement and collision
			y += Ymomentum;
			if (collide("Platform", x, y ) && Ymomentum > 0)
			{
				Ymomentum = 0;
				y = int(y / 50) * 50 + (50 - this.height);
				Gravity = 2;
				JumpNumber = 0;
			}
			if (collide("Platform", x, y) && Ymomentum < 0)
			{
				Ymomentum = 0;
				y = int(y / 50) * 50 + 50;
				Gravity = 2;
				JumpNumber = 0;
			}
			if (y > FP.screen.height + 10000) Dead();
			if (collide("Spark", x, y)) Dead();
		}
		public function Dead():void
		{
			var deadtime:int = 0;
			FP.world = new Level1;
		}
	}
}