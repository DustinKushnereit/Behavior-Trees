package 
{
	import flash.display.MovieClip;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;

	public class Player extends MovieClip
	{
		public var gravity:int = 0;
		public var floor:int = 1000;
		public var onBlock:int = -1;
		
		public function Player() 
		{
			var glow:GlowFilter = new GlowFilter();
			glow.color = 0xFF0000;
			glow.alpha = 3;
			glow.blurX = 18;
			glow.blurY = 18;
			glow.quality = BitmapFilterQuality.HIGH;
			
			this.graphics.lineStyle(4, 0xFF0000);
			this.graphics.drawRect(x - 20, y - 20, 40, 40);
			this.x = -50;
			this.y = 150;
			this.filters = [glow];
		}
		
		public function adjust():void
		{
			this.y += gravity;
			
			if(this.y + this.height < floor)
				gravity++;
			else
			{
				gravity = 0;
				this.y = floor - this.height;
			}
			
			/*if (this.x - this.width / 7 < 0)
				this.x = this.width / 7;
				
			if (this.x + this.width > 800)
				this.x = 800 - this.width;*/
		}
		
	}

}
