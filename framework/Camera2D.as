﻿package com.efg.framework 
{
	import flash.display.*;
	import flash.geom.*;
	
	public class Camera2D 
	{
		public var width:int;
		public var height:int;
		public var cols:int;
		public var rows:int;
		public var x:Number;
		public var y:Number;
		
		public var startX:Number;
		public var startY:Number;
		public var nextX:Number;
		public var nextY:Number;
		
		//buffer is 1 tile longer and higher than the camera
		//first copy all of the tiles to the buffer
		//then copy just the portion needed to the camera buffer
		
		public var bufferBD:BitmapData;
		public var bufferWidth:int;
		public var bufferHeight:int;
		public var bufferRect:Rectangle;
		public var bufferPoint:Point;

		public function Camera2D()
		{
			// constructor code
		}

	}
	
}
