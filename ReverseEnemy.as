package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class ReverseEnemy extends MovieClip
	{
		private var _root:Object;
		public var speed:int = 3;
		
		public function ReverseEnemy()
		{
			addEventListener(Event.ADDED, beginClass);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function beginClass(event:Event):void
		{
			_root = MovieClip(root);
		}
		
		private function enterFrame(event:Event):void
		{
			x += speed;
		
			if(this.x >= 810)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrame);
				_root.removeChild(this);
			}
			
			if (hitTestObject(_root.player))
			{
				_root.lives--;
				if ( _root.lives >= 1 )
				{
					removeEventListener(Event.ENTER_FRAME, enterFrame);
					_root.removeChild(this);
				}
			}
				
			if (_root.lives <= 0 )
				_root.hitEnemy = true;
			
			if(_root.hitEnemy)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrame);
				_root.removeChild(this);
			}
			
			if(_root.score >= 50)
				_root.hitEnemy = true;			
		}
		
		public function removeListeners():void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
	}
}
