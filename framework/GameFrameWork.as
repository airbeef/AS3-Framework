package com.efg.framework
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	
	import flash.display.DisplayObject;
		
	//This is the Model of the MVC system; MAIN.as is either VIEW/Helper MODEL
	public class GameFrameWork extends MovieClip
	{
		public static const EVENT_WAIT_COMPLETE:String = "wait complete";
		
		//Mute and Pause [Added Chapter 11]
		public static const KEY_MUTE:int = 77;
		public static const KEY_PAUSE:int = 80;
		public var paused:Boolean = false;
		public var pausedScreen:BasicScreen;
		
		public var systemFunction:Function;
		public var currentSystemState:int;
		public var nextSystemState:int;
		public var lastSystemState:int;
		
		public var appBackBitmapData:BitmapData;
		public var appBackBitmap:Bitmap;
		
		public var frameRate:int;
		public var timerPeriod:Number;
		public var gameTimer:Timer;
		
		public var titleScreen:BasicScreen;
		public var gameOverScreen:BasicScreen;
		public var instructionsScreen:BasicScreen;
		public var levelInScreen:BasicScreen;
		
		//Test: Multiple screens flow
		public var dummyScreen:BasicScreen;
		public var scoreScreen:BasicScreen;
		public var infoScreen:BasicScreen;
		
		public var screenTextFormat:TextFormat; 
		public var screenButtonFormat:TextFormat; 
		
		public var levelInText:String;
		
		public var soundManager:SoundManager;
		
		public var scoreBoard:ScoreBoard;
		public var scoreBoardTextFormat:TextFormat;
		
		//Chapter 11
		public var frameCounter:FrameCounter = new FrameCounter();
		public var lastTime:Number;
		public var timeDifference:Number;
		
		public var frameRateProfiler:FrameRateProfiler;
		
		//Game Logic for the game
		public var game:Game;
		
		//waitTime is use with STATE_SYSTEM_WAIT state
		//it suspends the game, allowa animation and other process
		//to finish
		public var waitTime:int;
		public var waitCount:int=0;
		
		

		public function GameFrameWork()
		{
			soundManager = new SoundManager();
		}
		
		//Added chapter 11
		public function addedToStage(e:Event = null):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			this.focusRect = false;
			stage.focus = stage;
			
			//trace();
		}
		
		//init
		public function init():void
		{
			//trace();
		}
		
		public function frameRateProfileComplete(e:Event):void
		{
			//stub
		}
		
		public function addSounds():void
		{
			//stub needed with IDE loading only
		}
		
		
		public function setApplicationBackGround(width:Number, height:Number,isTransparent:Boolean = false, color:uint = 0x000000):void
		{
			//Bitmap Data/ Bitmap is seperated to manipulate attributes
			appBackBitmapData = new BitmapData(width, height, isTransparent, color);
			appBackBitmap = new Bitmap(appBackBitmapData);
			addChild(appBackBitmap);
		}
		
		
		//Start timer of game sequence; backwards compatible to previous games
		public function startTimer(timeBasedAnimation:Boolean = false):void
		{
			stage.frameRate = frameRate;
			
			if (timeBasedAnimation)
			{
				lastTime = getTimer();
				addEventListener(Event.ENTER_FRAME, runGameEnterFrame);
			}
			
			else
			{
				timerPeriod = 1000/frameRate;
				gameTimer = new Timer(timerPeriod);
				gameTimer.addEventListener(TimerEvent.TIMER, runGame);
				gameTimer.start();
			}
		}
		
		

		//Runs game; gauges framerate by individual machine with framerateCounter
		// This drove me bonkers. I've turned this off for right now - JCB 02.27.13
		public function runGame(e:TimerEvent):void
		{
			systemFunction();
			//frameCounter.countFrames();
		}
		
		public function runGameEnterFrame(e:Event):void
		{
			timeDifference = getTimer() - lastTime;
			lastTime = getTimer();
			systemFunction();
			//frameCounter.countFrames();
		}

		//switchSystem state is called only when the
		//state is to be changed; not every frame like in
		//some switch/case based on simple state machines
		
		public function switchSystemState(stateval:int):void
		{
			lastSystemState = currentSystemState;
			currentSystemState = stateval;

				switch(stateval)
				{
					case FrameWorkStates.STATE_SYSTEM_WAIT:
					systemFunction = systemWait;
					break;
					
					case FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE:
					systemFunction = systemWaitForClose;
					break;
					
					case FrameWorkStates.STATE_SYSTEM_TITLE:
					systemFunction = systemTitle;
					break;
												
					case FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS:
					systemFunction = systemInstructions;
					break;
					
					case FrameWorkStates.STATE_SYSTEM_NEW_GAME:
					systemFunction = systemNewGame;
					break;
					
					case FrameWorkStates.STATE_SYSTEM_NEW_LEVEL:
					systemFunction = systemNewLevel;
					break;
					
					case FrameWorkStates.STATE_SYSTEM_LEVEL_IN:
					systemFunction = systemLevelIn;
					break;
					
					case FrameWorkStates.STATE_SYSTEM_GAME_PLAY:
					systemFunction = systemGamePlay;
					break;
					
					case FrameWorkStates.STATE_SYSTEM_GAME_OVER:
					systemFunction = systemGameOver;
					break;
					
					//Test
					case FrameWorkStates.STATE_SYSTEM_DUMMY:
					systemFunction = systemDummy;
					break;
					
					//Test #2
					case FrameWorkStates.STATE_SYSTEM_SCORE_SCREEN:
					systemFunction = systemScoreScreen;
					break;
					
					//Test
					case FrameWorkStates.STATE_SYSTEM_INFO:
					systemFunction = systemInfo;
					break;
					
				}
		}
		
		//Dummy Screen returns to Title
		public function systemInfo():void
		{
			addChild(infoScreen);
			
			infoScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
			switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
			nextSystemState = FrameWorkStates.STATE_SYSTEM_TITLE;
			
			
		}
		
		//Score Screen returns to Title
		public function systemScoreScreen():void
		{
			addChild(scoreScreen);
			
			scoreScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false,0,true);
			switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
			nextSystemState = FrameWorkStates.STATE_SYSTEM_TITLE;
		}
		
		//Dummy Screen returns to Title
		public function systemDummy():void
		{
			addChild(dummyScreen);
			
			dummyScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
			switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
			nextSystemState = FrameWorkStates.STATE_SYSTEM_TITLE;
		}
		

		public function systemTitle():void
		{
			addChild(titleScreen);
			
			titleScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
			switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
			nextSystemState = FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS; //FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS;
		}
		
		
		public function systemInstructions():void
		{
			addChild(instructionsScreen);
			
			instructionsScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
			switchSystemState(FrameWorkStates. STATE_SYSTEM_WAIT_FOR_CLOSE);
			nextSystemState = FrameWorkStates.STATE_SYSTEM_NEW_GAME; //FrameWorkStates.STATE_SYSTEM_NEW_GAME;
		}
		
		public function systemNewGame():void
		{
			addChild(game);
			
			game.addEventListener(CustomEventScoreBoardUpdate.UPDATE_TEXT, scoreBoardUpdateListener, false, 0, true);
			game.addEventListener(CustomEventLevelScreenUpdate.UPDATE_TEXT, levelScreenUpdateListener, false, 0, true);
			game.addEventListener(CustomEventSound.PLAY_SOUND, soundEventListener, false, 0, true);
			game.addEventListener(Game.GAME_OVER,gameOverListener, false, 0, true);
			game.addEventListener(Game.NEW_LEVEL,newLevelListener, false, 0, true);
			
			game.newGame();
			switchSystemState(FrameWorkStates.STATE_SYSTEM_NEW_LEVEL);
		}
		
		public function systemNewLevel():void
		{
			game.newLevel();
			switchSystemState(FrameWorkStates.STATE_SYSTEM_LEVEL_IN);
		}
		
		public function systemLevelIn():void
		{
			addChild(levelInScreen);
			
			waitTime = 30;
			switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT);
			nextSystemState = FrameWorkStates.STATE_SYSTEM_GAME_PLAY;
			addEventListener(EVENT_WAIT_COMPLETE,waitCompleteListener, false, 0, true);
		}
		
		public function systemGameOver():void
		{
			removeChild(game);
			addChild(gameOverScreen);
			
			gameOverScreen.addEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener, false, 0, true);
			switchSystemState(FrameWorkStates.STATE_SYSTEM_WAIT_FOR_CLOSE);
			nextSystemState = FrameWorkStates.STATE_SYSTEM_TITLE;
		}
		
		public function systemGamePlay():void
		{
			game.runGame();
		}
		
		public function systemWaitForClose():void
		{
			//do nothing
		}
		
		//dude, what's the system doing? switchin? waitin? Hmmm.
		public function systemWait():void
		{
			waitCount++;
			trace("Waiting..." + (waitCount));
			if (waitCount > waitTime)
			{
				waitCount = 0;
				dispatchEvent(new Event(EVENT_WAIT_COMPLETE));
			}
		}
		
		
		//okay button work in different space
		public function okButtonClickListener(e:CustomEventButtonId):void
		{
			switch(e.id)
			{
				case FrameWorkStates.STATE_SYSTEM_TITLE:
				removeChild(titleScreen);
				titleScreen.removeEventListener
						(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
				break;
				
				case FrameWorkStates.STATE_SYSTEM_INFO:
				removeChild(infoScreen);
				infoScreen.removeEventListener
						(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
				break;
												
				case FrameWorkStates.STATE_SYSTEM_INSTRUCTIONS:
				removeChild(instructionsScreen);
				instructionsScreen.removeEventListener
						(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
				break;
				
				case FrameWorkStates.STATE_SYSTEM_GAME_OVER:
				removeChild(gameOverScreen);
				gameOverScreen.removeEventListener
						(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
				break;
				
				
			}
			trace("next system state = " +nextSystemState);
			
			switchSystemState(nextSystemState);
			
			//Molly's Example
			var gotoState:int = nextSystemState;
				
				if(e.m_OverrideNextState != -1)
				{
					gotoState = e.m_OverrideNextState;
				}
				switchSystemState(gotoState);
		}
				
		public function scoreBoardUpdateListener(e:CustomEventScoreBoardUpdate):void
		{
			scoreBoard.update(e.element, e.value);
		}
		
		public function levelScreenUpdateListener(e:CustomEventLevelScreenUpdate):void
		{
			levelInScreen.setDisplayText(levelInText + e.text);
		}
		
		
		//gameOverListener listens for GAME.GAMEOVER simple
		//custom events callsandchanges state accordingly
		public function gameOverListener(e:Event):void
		{
			switchSystemState(FrameWorkStates.STATE_SYSTEM_GAME_OVER);
			
			game.removeEventListener(CustomEventScoreBoardUpdate.UPDATE_TEXT, scoreBoardUpdateListener);
			game.removeEventListener(CustomEventLevelScreenUpdate.UPDATE_TEXT, levelScreenUpdateListener);
			game.removeEventListener(CustomEventSound.PLAY_SOUND,soundEventListener);
			game.removeEventListener(Game.GAME_OVER, gameOverListener);
			game.removeEventListener(Game.NEW_LEVEL, newLevelListener);
		}
		
		//newLevelListener listens for Game.NEWLEVEL simple 
		//custom events calls and changes state accordingly
		public function newLevelListener(e:Event):void
		{
			switchSystemState(FrameWorkStates.STATE_SYSTEM_NEW_LEVEL);
		}
		
		//waits for the last system switch, removes and loads new system switch
		public function waitCompleteListener(e:Event):void
		{
			switch(lastSystemState)
			{
				case FrameWorkStates.STATE_SYSTEM_LEVEL_IN:
				removeChild(levelInScreen);
				break;
			}
			removeEventListener(EVENT_WAIT_COMPLETE, waitCompleteListener);
			switchSystemState(nextSystemState);
		}
		
		
		public function soundEventListener(e:CustomEventSound):void
		{
			if (e.type == CustomEventSound.PLAY_SOUND)
			{
				trace("Play Sound");
				soundManager.playSound(e.name, e.isSoundTrack, e.loops, e.offset, e.volume);
			}
			
			else
			{
				soundManager.stopSound(e.name, e.isSoundTrack);
			}
		}
		
		public function keyDownListener (e:KeyboardEvent):void
		{
			trace("key down: " + e.keyCode);
			
			switch(e.keyCode)
			{
				//pause key pressed
				case KEY_PAUSE:
				pausedKeyPressedHandler();
				break;
				
				//mute key pressed
				case KEY_MUTE:
				muteKeyPressedHandler();
				break;
			}
		}
		
		public function pausedKeyPressedHandler():void
		{
			trace("handle pause");
			addChild(pausedScreen);
			pausedScreen.addEventListener(CustomEventButtonId.BUTTON_ID, pausedScreenClickListener, false,0,true);
			paused = true;
		}
		
		public function pausedScreenClickListener(e:Event):void
		{
			removeChild(pausedScreen);
			
			pausedScreen.removeEventListener(CustomEventButtonId.BUTTON_ID, okButtonClickListener);
			trace("clicked");
			paused = false;
			stage.focus = game;
		}
		
		public function muteKeyPressedHandler():void
		{
			soundManager.muteSound();
		}
		
		//Molly's suggestion
		public override function addChild(child:DisplayObject):DisplayObject
		{
			trace("GameFrameWork is adding Child: " + "," + child.name);
			
			return super.addChild(child);
		}
		
		
	}
	
}
