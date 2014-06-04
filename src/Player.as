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
		private var Gravity:Number = 2;
		private var Xmomentum:Number = 0;
		private var Ymomentum:Number = 0;
		private var DeadTime:int = 0;
		private var BeforeTime:Number = 0;
		private var CanJump:Boolean = false;
		private var JumpNumber:int = 0;
		private var MaxSpeed:Number = 4;
		
		public function Player(INx:Number, INy:Number)
		{
			x = INx;
			y = INy;
			
			graphic = Image.createRect(25, 25, 0x000000)
			setHitbox(25, 25);
			type = "Player";
		}
		
		override public function update():void
		{
			//Intro stuff
			if (BeforeTime < 200)
			{
				BeforeTime += 1;
				Gravity = 0;
			}
			else //After intro
			{
				Gravity = 2;
				
				//Player input & physics for horizontal movement
				if (Input.check(Key.D)) Xmomentum += 1; //Move right
				else if (Input.check(Key.A)) Xmomentum += -1; //Move left
				else if (Xmomentum > 0) Xmomentum += -0.5; //Momentum carries you right
				else if (Xmomentum < 0) Xmomentum += 0.5; //Momentum carries you left
			}
			
			//Jumping
			if (Input.pressed(Key.W) && CanJump == true && JumpNumber < 2)
			{
				Ymomentum = -20;
				JumpNumber += 1;
			}
			if (Ymomentum < 12) CanJump = true;
			else CanJump = false;
			
			//Player physics
			if (Xmomentum > MaxSpeed) Xmomentum = MaxSpeed;
			if (Xmomentum < -MaxSpeed) Xmomentum = -MaxSpeed;
			Ymomentum += Gravity;
			if (Ymomentum > 18) Ymomentum = 18;

			//X movmement and collision
			x += Xmomentum;
			if (collide("Platform", x, y) && Xmomentum > 0)
			{
				Xmomentum = 0;
				x = int(x / 40) * 40 + (40 - this.width);
			}
			if (collide("Platform", x, y) && Xmomentum < 0)
			{
				Xmomentum = 0;
				x = int(x / 40) * 40 + 40;
			}
			 
			//Y axis movement and collision
			y += Ymomentum;
			if (collide("Platform", x, y) && Ymomentum > 0)
			{
				Ymomentum = 0;
				y = int(y / 40) * 40 + (40 - this.height);
				Gravity = 2;
				CanJump = true;
				JumpNumber = 0;
				MaxSpeed = 4;
			}
			else MaxSpeed = 5.5;
			if (collide("Platform", x, y) && Ymomentum < 0)
			{
				Ymomentum = 0;
				y = int(y / 40) * 40 + 40;
				Gravity = 2;
			}
			
			//Stay away from the screen!
			if (y < 0)
			{
				Ymomentum = 0;
				y = 0;
				Gravity = 2;
			}
			if (x + width > FP.screen.width) 
			{
				Xmomentum = 0;
				x = FP.screen.width - width;
			}
			if (x < 0)
			{
				Xmomentum = 0;
				x = 0;
			}		
			
			//Dying Possibilites
			if (y > FP.screen.height)
			{
				DeadTime ++;
				if (DeadTime > 90) Dead();
			}
			if (collide("Spark", x, y))
			{
				DeadTime ++;
				if (DeadTime > 90) Dead();
			}
		}
		public function Dead():void
		{
			FP.world = new Level1;
		}
	}
}