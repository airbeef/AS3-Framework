package com.efg.framework
{
	//import the good stuff from Flash Libraries
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	
	/*
	@ JC Brazil
	*/
	
	public class ScoreBoard extends Sprite
	{
		//Constructor calls init() only
		private var textElements:Object;
		
		public function ScoreBoard() 
		{
			init();
		}
			
		private function init():void
		{
			textElements = {};
		}
		
		
		public function createTextElement(key:String, obj:SideBySideScoreElement):void
		{
			textElements[key] = obj;
			addChild(obj);
		}
		
		public function update(key:String, value:String):void
		{
			var tempElement:SideBySideScoreElement = textElements[key];
			
			tempElement.setContextText(value);
		}
		
	}
		
}

		
	