package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Diamond extends MovieClip
	{
		private var _root:Object;
		
		public function Diamond()
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
			if (hitTestObject(_root.player))
			{
				_root.score += 1;
				
				if ( _root.lives >= 1 )
				{
					removeEventListener(Event.ENTER_FRAME, enterFrame);
					_root.removeChild(this);
					_root.makeDiamond = true;
				}
			}
			
			if(_root.hitEnemy)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrame);
				_root.removeChild(this);
			}
		}
		
		public function removeListeners():void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
	}

}
