﻿package com.efg.framework
{
	//Import necessary classes from the flash libraries
	import flash.display.MovieClip;
	import com.efg.framework.CustomEventScoreBoardUpdate;
	import com.efg.framework.CustomEventLevelScreenUpdate;
	
	
	public class Game extends MovieClip
	{
		//Create constants for simple custom events
		public static const GAME_OVER:String = "game over";
		public static const NEW_LEVEL:String = "new level";
		
		public var timeBasedUpdateModifier:Number = 40;
		public var frameRateMultiplier:Number = 1;
		public var lastScore:Number = 0;
		
		//Constructor calls init() only
		public function Game() 
		{}
		
		public function setRendering(profiledRate:int, frameRate:int):void
		{}
		
		public function newGame():void 
		{}
		
		public function newLevel():void
		{}
		
		public function runGame():void 
		{}
		
		public function runGameTimeBased(paused:Boolean = false, timeDifference:Number = 1):void
		{}

	}
	
}

