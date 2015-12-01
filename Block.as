package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Block extends Sprite
	{	
		public var ID:int = 0;
		
		public function Block()
		{			
			//this.graphics.lineStyle(1, 0xFF0000);
			/*this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawRect(x - 20, y - 20, 40, 40);
			this.graphics.endFill();*/
		}
		
		public function checkObject(object:MovieClip, location:int):void
		{
			if (object.x + object.width / 2 > x - width / 2 && object.x < x - width / 2 + 7 && Math.abs(object.y - y) < height / 2)
			{
				object.x = x - width / 2 - object.width / 2;
			}
				
			if (object.x - object.width / 2 < x + width / 2 && object.x > x - width / 2 - 7 && Math.abs(object.y - y) < height / 2)
			{
				object.x = x + width / 2 + object.width / 2;
			}
			
			if (Math.abs(object.x - x) < width / 2 + object.width / 2 && object.y < y - height / 2 && object.floor > y - height / 2 && object.onBlock != location)
			{
				object.floor = y;
				object.onBlock = location;
			}
			
			if (Math.abs(object.x - x) >= width / 2 + object.width / 2 + object.width / 2 && object.onBlock == location)
			{
				object.onBlock = -1;
				object.floor = 1000;
			}
			
			if (object.y - object.height / 2 < y + height / 2 && object.y > y && Math.abs(object.x - x) < width / 2 + object.width / 2)
			{
				object.y = y + height / 2 + object.height / 2;
			}
		}
	}
}
