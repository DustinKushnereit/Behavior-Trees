package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.DisplayObject;
	
	[SWF(width = "800", height = "400", frameRate = "30", backgroundColor = "0x00000")]
	
	public class Main extends MovieClip
	{
		
		public var myFormat:TextFormat = new TextFormat;
		
		public var particleContainer:MovieClip = new MovieClip();
		public var farParticleContainer:MovieClip = new MovieClip();
		public var blockHolder:Sprite = new Sprite();
		public var gridHolder:Sprite = new Sprite();
		
		public var laserFired:Boolean = false;
		public var movedLeft:Boolean = false;
		public var movedRight:Boolean = false;
		public var movedUp:Boolean = false;
		public var movedDown:Boolean = false;
		public var hitSpace:Boolean = false;
		public var hitEnemy:Boolean = false;
		public var makeDiamond:Boolean = false;
		public var levelTwoBool:Boolean = false;
		public var victory:Boolean = false;
		
		public var jumping:Boolean = false;
		public var jumpSpeedMax:int = 20;
		public var jumpSpeed:Number = 0;
		public var onGround:Boolean = true;
		
		public var X:String = 'PLAYER';
		
		public var mapHeight:int = 16;
		public var mapWidth:int = 44;
		public var tileSize:int = 35;
		public var row:int = 0;
		public var column:int = 0;

		public var outputText:TextField = new TextField;
		public var winText:TextField = new TextField;
		public var gameBoundary:TextField = new TextField;
		public var timeText:TextField = new TextField;
		public var livesText:TextField = new TextField;

		public var score:int = 0;
		public var enemyCount:int = 0;
		public var laserCount:int = 0;
		public var enemyTime:int = 0;
		public var enemyLimit:int = 18;
		public var reverseEnemyTime:int = 0;
		public var reverseEnemyLimit:int = 18;
		public var downEnemyTime:int = 0;
		public var downEnemyLimit:int = 10;
		public var maxSpeed:int = 2;
		public var time:int = 1500;
		public var timeDisplay:int = 0;
	
		public var startScreen:TextField = new TextField;
		public var loseScreen:TextField = new TextField;

		private var _root:Object;
		
		public var player:Player = new Player();
		public var blocks:Array = [];
		public var prevX:int = 0
		public var prevY:int = 0;
		
		public var gr:Graphics = player.graphics;
		public var enemy:Enemy;
		public var reverseEnemy:ReverseEnemy;
		public var downEnemy:DownEnemy;
		public var diamond:Diamond;
		public var DG:Graphics;
		public var glow:GlowFilter;
		public var lives:int = 0;
		
		public var levelOneArray:Array =
		[
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
			[0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		];
		
		public function Main()
		{
			beginGame();
			addEventListener(MouseEvent.CLICK, youWin);
			addEventListener(Event.ENTER_FRAME, generateParticles);
			stage.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		public function beginGame():void
		{
			_root = MovieClip(root);
			myFormat.size = 25;
			myFormat.align = TextFormatAlign.CENTER;
			
			startScreen.defaultTextFormat = myFormat;
			startScreen.textColor = 0xFF0000;
			startScreen.border = true;
			startScreen.borderColor = 0xFF0000;
			startScreen.width = 420;
			startScreen.height = 250;
			startScreen.x = stage.stageWidth / 4;
			startScreen.y = stage.stageHeight / 6;
			startScreen.text = "Survive till the timer hits 0!\n\nUse The Arrow Keys To Move\n\nDon't Get Hit!\n\nClick Here To Start!"
			addChild(startScreen);
			stage.addChild(particleContainer);
			stage.addChild(farParticleContainer);
		}
		
		public function createLevel():void
		{	
			var iterator:int = 0;
			for( var i:int = 0; i < levelOneArray.length; i++ )
			{
				for( var j:int = 0; j < levelOneArray[0].length; j++ )
				{
					iterator++;
					if (levelOneArray[i][j] == 1)
					{
						var block:Block = new Block();
						block.graphics.beginFill(0xFFFFFF, 1);
						block.graphics.drawRect(x - 20, y - 20, 40, 40);
						block.graphics.endFill();
						block.x = j * 40 + 20;
						block.y = i * 40 + 20;
						block.ID = iterator;
						blocks.push(block);
						blockHolder.addChild(block);
					}
					if (levelOneArray[i][j] == 0)
					{
						block = new Block();
						block.graphics.beginFill(0x000000, 1);
						block.graphics.drawRect(x - 20, y - 20, 40, 40);
						block.graphics.endFill();
						block.x = j * 40 + 20;
						block.y = i * 40 + 20;
						blockHolder.addChild(block);
					}
				}
			}
			
		}
		
		public function startGame(e:MouseEvent):void
		{	
			if (levelTwoBool)
			{
				stage.removeEventListener(MouseEvent.CLICK, startGame);
				removeChild(startScreen);
			
				//createLevel();
				addChild(blockHolder);
				
				addChild(timeText);
				addChild(outputText);
				addChild(livesText);
				
				gameBoundary = new TextField;
				gameBoundary.border = true;
				gameBoundary.borderColor = 0xFF0000;
				gameBoundary.width = 797;
				gameBoundary.height = 364;
				gameBoundary.x = 1;
				gameBoundary.y = 34;
				//stage.addChild(gameBoundary);
				
				movedLeft = false;
				movedRight = false;
				movedUp = false;
				hitEnemy = false;
				//makeDiamond = true;
				score = 2;
				time = 3000;
				enemyLimit = 35;
				reverseEnemyLimit = 35;
				downEnemyLimit = 8;
				lives = 3;
				levelTwoBool = true;
				victory = false;
				
				stage.addEventListener(Event.ENTER_FRAME, update);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
				
				player.x = 400;
				player.y = 200;
				
				blockHolder.x = 0;
				blockHolder.y = 0;
				prevX = player.x;
				prevY = player.y;
				
				blockHolder.addChild(player);
			}
			else
			{
				stage.removeEventListener(MouseEvent.CLICK, startGame);
				removeChild(startScreen);
				
				createLevel();
				addChild(blockHolder);
				
				addChild(timeText);
				addChild(outputText);
				addChild(livesText);
				
				gameBoundary = new TextField;
				gameBoundary.border = true;
				gameBoundary.borderColor = 0xFF0000;
				gameBoundary.width = 797;
				gameBoundary.height = 364;
				gameBoundary.x = 1;
				gameBoundary.y = 34;
				//stage.addChild(gameBoundary);
				
				movedLeft = false;
				movedRight = false;
				movedUp = false;
				hitEnemy = false;
				//makeDiamond = true;
				score = 1;
				time = 1500;
				enemyLimit = 35;
				reverseEnemyLimit = 35;
				downEnemyLimit = 10;
				lives = 3;
				levelTwoBool = false;
				victory = false;
				
				stage.addEventListener(Event.ENTER_FRAME, update);
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
				
				player.x = 400;
				player.y = 200;
				
				blockHolder.x = 0;
				blockHolder.y = 0;
				prevX = player.x;
				prevY = player.y;
				
				blockHolder.addChild(player);
			}
		}

		public function keyPressed( event:KeyboardEvent ):void
		{			
			if ( event.keyCode == Keyboard.RIGHT )
			{
				movedRight = true;
			}
			else if ( event.keyCode == Keyboard.LEFT ) 
			{
				movedLeft = true;
			}
			else if ( event.keyCode == Keyboard.UP && movedUp == false && player.gravity == 0 ) 
			{
				movedUp = true;
				player.gravity = -20;
			}
			else if ( event.keyCode == Keyboard.P ) 
			{
				time = 100;
			}
			else if ( event.keyCode == Keyboard.L ) 
			{
				lives += 2;
			}
			else if ( event.keyCode == Keyboard.E ) 
			{
				lives = 0;
			}
		}

		public function MoveRight():void
		{
			player.x += 10;
		}

		public function MoveLeft():void
		{
			player.x -= 10;
		}

		public function keyReleased( event:KeyboardEvent ):void
		{
			if ( event.keyCode == Keyboard.RIGHT )
			{
				movedRight = false;
			}
			if ( event.keyCode == Keyboard.LEFT ) 
			{
				movedLeft = false;
			}
			if ( event.keyCode == Keyboard.UP ) 
			{
				movedUp = false;
			}
		}

		public function update(e:Event):void
		{
			prevX = player.x;
			prevY = player.y;
			
			if( movedLeft )
				MoveLeft();
			
			if( movedRight )
				MoveRight();
			
			playerCollision();
			
			time--;
			timeDisplay = time / 25;
			showScore();
			
			if (time <= 0 && levelTwoBool == false)
			{
				levelTwoBool = true;
				endGame();
			}
			else if(time <= 0 && levelTwoBool == true)
			{
				victory = true;
				levelTwoBool = false;
				endGame();
			}
			
			if( enemyTime < enemyLimit )
				enemyTime++;
			else
				createDownEnemies();
				
			/*if( makeDiamond )
				createDiamond();*/
			
			if ( hitEnemy || score >= 50)
			{
				if (levelTwoBool)
					levelTwoBool = false;
				endGame();
			}
			
			/*if (score >= 1 && score < 10 )
				createReverseEnemies();
				
			if (score >= 10)
				createDownEnemies();
				
			if (score >= 20)
				createReverseEnemies();*/
		}

		public function endGame():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
			blockHolder.removeChild(player);
			removeChild(blockHolder);
			//stage.removeChild(gameBoundary);
			removeChild(timeText);
			removeChild(outputText);
			removeChild(livesText);

			if( victory )
			{
				startScreen.text = " ";
				myFormat.size = 30;
				myFormat.align = TextFormatAlign.CENTER;
				
				winText.defaultTextFormat = myFormat;
				winText.textColor = 0xFF0000;
				winText.border = true;
				winText.borderColor = 0xFF0000;
				winText.width = 420;
				winText.height = 250;
				winText.x = stage.stageWidth / 4;
				winText.y = stage.stageHeight / 6;
				winText.text = "\n\nYou Win!\nClick To Start Again"
				addChild(winText);
				stage.addEventListener(MouseEvent.CLICK, youWin);
			}
			else if (levelTwoBool)
			{
				myFormat.size = 30;
				myFormat.align = TextFormatAlign.CENTER;
				
				winText.defaultTextFormat = myFormat;
				winText.textColor = 0xFF0000;
				winText.border = true;
				winText.borderColor = 0xFF0000;
				winText.width = 420;
				winText.height = 250;
				winText.x = stage.stageWidth / 4;
				winText.y = stage.stageHeight / 6;
				winText.text = "\n\nLevel Two!\nClick To Start"
				addChild(winText);
				stage.addEventListener(MouseEvent.CLICK, levelTwo);
			}
			else
			{
				myFormat.size = 30;
				myFormat.align = TextFormatAlign.CENTER;
				
				loseScreen.defaultTextFormat = myFormat;
				loseScreen.textColor = 0xFF0000;
				loseScreen.border = true;
				loseScreen.borderColor = 0xFF0000;				
				loseScreen.width = 420;
				loseScreen.height = 250;
				loseScreen.x = stage.stageWidth / 4;
				loseScreen.y = stage.stageHeight / 6;
				loseScreen.text = "\n\nYou Lose!\nClick To Start Again"
				addChild(loseScreen);
				stage.addEventListener(MouseEvent.CLICK, youLose);
			}
		}

		public function youLose(e:MouseEvent):void
		{
			hitEnemy = false;
			stage.removeEventListener(MouseEvent.CLICK, youLose);
			removeChild(loseScreen);
			
			addChild(startScreen);
			stage.addEventListener(MouseEvent.CLICK, startGame);
		}

		public function youWin(e:MouseEvent):void
		{
			hitEnemy = false;
			winText.border = false;
			winText.text = " "
			stage.removeEventListener(MouseEvent.CLICK, youWin);
			
			addChild(startScreen);
			stage.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		public function levelTwo(e:MouseEvent):void
		{
			hitEnemy = false;
			winText.border = false;
			winText.text = " "
			stage.removeEventListener(MouseEvent.CLICK, levelTwo);
			
			stage.addEventListener(MouseEvent.CLICK, startGame);
		}

		public function showScore():void
		{	
			myFormat.size = 18;
			myFormat.align = TextFormatAlign.LEFT;
			
			outputText.defaultTextFormat = myFormat;
			outputText.textColor = 0xFF0000;
			outputText.border = true;
			outputText.borderColor = 0xFF0000;
			outputText.width = 85;
			outputText.height = 25;
			outputText.x = 710;
			outputText.y = 5;
			
			timeText.defaultTextFormat = myFormat;
			timeText.textColor = 0xFF0000;
			timeText.border = true;
			timeText.borderColor = 0xFF0000;
			timeText.width = 95;
			timeText.height = 25;
			timeText.x = 5;
			timeText.y = 5;
			
			livesText.defaultTextFormat = myFormat;
			livesText.textColor = 0xFF0000;
			livesText.border = true;
			livesText.borderColor = 0xFF0000;
			livesText.width = 95;
			livesText.height = 25;
			livesText.x = 350;
			livesText.y = 5;
			
			glow = new GlowFilter();
			glow.color = 0xFF0000;
			glow.alpha = 40;
			glow.blurX = 18;
			glow.blurY = 18;
			glow.quality = BitmapFilterQuality.HIGH;
			livesText.filters = [glow];
			
			outputText.text = "Level: " + String(score);
			timeText.text = "Time: " + String(timeDisplay);
			livesText.text = "Lives: " + String(lives);
		}

		public function playerCollision():void
		{
			if (player.y >= 800)
				endGame();
				
			player.adjust();
			
			for ( var i:int = 0; i < blocks.length; i++)
				blocks[i].checkObject(player, i);
				
			blockHolder.x -= player.x - prevX;
			blockHolder.y -= player.y - prevY;
		}

		public function createEnemies():void
		{
			if( enemyTime < enemyLimit )
				enemyTime++;
			else
			{
				enemy = new Enemy();
				var dimensions:int = 14;
				enemy.graphics.beginFill(0xFFCC00,15);
				enemy.graphics.drawCircle( dimensions, dimensions, dimensions );
				enemy.graphics.endFill();
				enemy.x = 800;
				enemy.y = int(Math.floor(Math.random() * (350 - 20 + 1)) + 50);
				
				glow = new GlowFilter();
				glow.color = 0xFF6600;
				glow.alpha = 1;
				glow.blurX = 15;
				glow.blurY = 15;
				glow.quality = BitmapFilterQuality.HIGH;
				enemy.filters = [glow];
				
				addChild(enemy);
				enemyCount++;
				enemyTime = 0;
			}
		}
		
		public function createReverseEnemies():void
		{
			if( reverseEnemyTime < reverseEnemyLimit )
				reverseEnemyTime++;
			else
			{
				reverseEnemy = new ReverseEnemy();
				var dimensions:int = 14;
				reverseEnemy.graphics.beginFill(0x33FF00,1);
				reverseEnemy.graphics.drawCircle( dimensions, dimensions, dimensions );
				reverseEnemy.graphics.endFill();
				reverseEnemy.graphics.endFill();
				reverseEnemy.x = -50;
				reverseEnemy.y = int(Math.floor(Math.random() * (350 - 20 + 1)) + 50);
				
				glow = new GlowFilter();
				glow.color = 0x33FF00;
				glow.alpha = 4;
				glow.blurX = 15;
				glow.blurY = 15;
				glow.quality = BitmapFilterQuality.HIGH;
				reverseEnemy.filters = [glow];
				
				addChild(reverseEnemy);
				enemyCount++;
				reverseEnemyTime = 0;
			}
		}
		
		public function createDownEnemies():void
		{
			if( downEnemyTime < downEnemyLimit )
				downEnemyTime++;
			else
			{
				downEnemy = new DownEnemy();
				var dimensions:int = 14;
				downEnemy.graphics.beginFill(0x00F400, 1);
				downEnemy.graphics.drawCircle( dimensions, dimensions, dimensions );
				downEnemy.graphics.endFill();
				downEnemy.x = int(Math.floor(Math.random() * (2000 - 200 + 1)) + 50);
				downEnemy.y = -200;
				
				glow = new GlowFilter();
				glow.color = 0x00F400;
				glow.alpha = 8;
				glow.blurX = 15;
				glow.blurY = 15;
				glow.quality = BitmapFilterQuality.HIGH;
				downEnemy.filters = [glow];
				
				blockHolder.addChild(downEnemy);
				enemyCount++;
				downEnemyTime = 0;
			}
		}
		
		public function createDiamond():void
		{
			if ( makeDiamond )
			{
				diamond = new Diamond();
				var dimensions:int = 6;
				DG = diamond.graphics;
				diamond.graphics.beginFill(0xCCFFFF,3);
				diamond.graphics.drawCircle( dimensions, dimensions, dimensions );
				diamond.x = int(Math.floor(Math.random() * (750 - 20 + 1)) + 50);
				diamond.y = int(Math.floor(Math.random() * (350 - 20 + 1)) + 50);
				
				glow = new GlowFilter();
				glow.color = 0xCCFFFF;
				glow.alpha = 4;
				glow.blurX = 18;
				glow.blurY = 18;
				glow.quality = BitmapFilterQuality.HIGH;
				diamond.filters = [glow];
				
				addChild(diamond);
				makeDiamond = false;
			}
		}

		public function generateParticles(event:Event):void
		{
			if( Math.random()*20 < 2)
			{
				var newParticle:Shape = new Shape(); 
				var dimensions:int = 4;
				
				newParticle.graphics.beginFill(0x99999,15);
				newParticle.graphics.drawCircle( dimensions, dimensions, dimensions );
				newParticle.x = 800; 
				newParticle.y = int(Math.random() * 500) - 40;
				
				glow = new GlowFilter();
				glow.color = 0x99999;
				glow.alpha = 1;
				glow.blurX = 15;
				glow.blurY = 15;
				glow.quality = BitmapFilterQuality.HIGH;
				newParticle.filters = [glow];
				
				particleContainer.addChild(newParticle);
			}
			
			if( Math.random()*15 < 2)
			{
				var newParticle2:Shape = new Shape(); 
				var dimensions2:int = 2;
				
				newParticle2.graphics.beginFill(0x99999,15);
				newParticle2.graphics.drawCircle( dimensions2, dimensions2, dimensions2 );
				newParticle2.x = 800; 
				newParticle2.y = int(Math.random() * 500) - 40;
				
				glow = new GlowFilter();
				glow.color = 0x99999;
				glow.alpha = 4;
				glow.blurX = 15;
				glow.blurY = 15;
				glow.quality = BitmapFilterQuality.HIGH;
				newParticle2.filters = [glow];
				
				farParticleContainer.addChild(newParticle2);
			}
			
			for(var i:int = 0; i < particleContainer.numChildren; i++)
			{
				var particle:DisplayObject = particleContainer.getChildAt(i);
				
				particle.x -= maxSpeed;
				
				if( particle.x <= 0 )
					particleContainer.removeChild( particle );
			}
			
			for(var u:int = 0; u < farParticleContainer.numChildren; u++)
			{
				var farParticle:DisplayObject = farParticleContainer.getChildAt(u);
				
				farParticle.x -= 1;
				
				if( farParticle.x <= 0 )
					farParticleContainer.removeChild( farParticle );
			}
		}
		
		/*public function levelTwoStart():void
		{
			time = 3000;
			stage.removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
			blockHolder.removeChild(player);
			removeChild(blockHolder);
			stage.removeChild(gameBoundary);
			removeChild(timeText);
			removeChild(outputText);
			removeChild(livesText);
			hitEnemy = false;
			score++;
			
			startScreen.text = "Level Two!\n\nDon't Get Hit!\n\nClick Here To Start!"
			addChild(startScreen);
			stage.addEventListener(MouseEvent.CLICK, levelTwoSetUp);
		}*/
	
	}

}
