﻿package com.efg.framework 
{
	import flash.events.*;
	
	public class BasicFrameTimer extends EventDispatcher
	{
		public static const TIME_IS_UP:String = "timeisup";
		
		public var countUp:Boolean = false;
		public var started:Boolean = false;
		public var min:int = 0;
		public var max:int = 0;
		public var seconds:int = 0;
		
		private var frameCount:int;
		private var framesPerSecond:int;

		public function BasicFrameTimer(framesPerSecond:int)
		{
			this.framesPerSecond = framesPerSecond;
		}
		
		public function start():void
		{
			frameCount = 0;
			started = true;
		}
		
		public function stop():void
		{
			started = false;
		}
		
		public function reset():void
		{
			if (countUp)
			{
				seconds = max;
			}
			
			else
			{
				seconds = min;
			}
		}
		
		public function update():void
		{
			frameCount++;
			
			if (started)
			{
				if (frameCount > framesPerSecond)
				{
					frameCount = 0;
					
					if (countUp)
					{
						seconds++;
						
						if (seconds == max)
						{
							stop();
							dispatchEvent(new Event(TIME_IS_UP));
						}
					}
					
					else
					{
						seconds--;
						
						if (seconds == min)
						{
							stop();
							dispatchEvent(new Event(TIME_IS_UP));
						}
					}
				}
			}
		}

	}
	
}
