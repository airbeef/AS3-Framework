package com.efg.framework
{
	public class TileByTileBlitSprite extends BlitSprite
	{
		public var inTunnel:Boolean = false;
		public var currRow:int;
		public var currCol:int;
		
		//collision stuff
		public var targetRow:int;
		public var targetCol:int;
		
		public var nextRow:int;
		public var nextCol:int;
		
		public var moveDirectionsToTest:Array = [];
		
		public var missileDelay:Number = 100;
		public var missileTime:int;
		public var healthPoints:int;
		
		public var destinationX:Number;
		public var destinationY:Number;
		public var currDirection:int = 0;
		
		public var moveSpeed:Number = 4;
		public var currentRegion:int;
		
		public function TileByTileBlitSprite(tileSheet:TileSheet, tileList:Array, firstFrame:int)
		{
			super(tileSheet, tileList, firstFrame);
		}
		
	}
}