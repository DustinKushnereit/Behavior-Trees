package
{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class DownEnemy extends MovieClip
	{
		private var _root:Object;
		public var speed:int = 3;
		
		public var gravity:Number = 0;
		public var floor:int = 1000;
		public var onBlock:int = -1;
		
		public var sequenceRunning:Boolean = true;
		public var fallingBool:Boolean = true;
		public var rollingBool:Boolean = true;
		public var attackEnemyBool:Boolean = true;
		
		public var currentState:int = 1;
		
		public function DownEnemy()
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
			switch(currentState) //Behavior Tree - Back and Forth
			{
				case 1:
					if (!fallDown())
						currentState = 2;
					break;
				case 2:
					if (!rollLeft())
						currentState = 1;
					break;
				default:
					currentState = 1;
					break;
			}
				
			if (hitTestObject(_root.player))
			{
				_root.lives--;
				if ( _root.lives >= 1 )
				{
					removeEventListener(Event.ENTER_FRAME, enterFrame);
					_root.blockHolder.removeChild(this);
				}
			}
			
			if(this.y >= 1000)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrame);
				_root.blockHolder.removeChild(this);
			}
			
			for ( var i:int = 0; i < _root.blocks.length; i++)
				_root.blocks[i].checkObject(this, i);
				
			if (_root.lives <= 0 )
				_root.hitEnemy = true;
			
			if(_root.hitEnemy)
			{
				removeEventListener(Event.ENTER_FRAME, enterFrame);
				_root.blockHolder.removeChild(this);
			}
			
			if(_root.score >= 50)
				_root.hitEnemy = true;			
		}
		
		public function removeListeners():void
		{
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function fallDown():Boolean
		{
			this.y += gravity;
			
			if (this.y + this.height + 20 < floor)
			{
				gravity = 3;
				return true;
			}
			else
			{
				gravity = 0;
				this.y = floor - 20 - this.height;
				return false;
			}
		}
		
		public function rollLeft():Boolean
		{
			this.x -= speed;
			this.y += gravity;
			
			if (this.y + this.height + 19 < floor)
			{
				speed = 10;
				gravity = 1;
				return true;
			}
			else
			{
				speed = 0;
				gravity = 0;
				this.y = floor - 20 - this.height;
				return false;
			}
		}
	}
}
