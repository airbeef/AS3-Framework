﻿package com.efg.framework
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	/*
	* @author JC Brazil
	*/
		
	public class SimpleBlitButton extends Sprite
	{
		public static const OFF:int = 1;
		public static const OVER:int = 2;
		
		private var offBackGroundBD:BitmapData;
		private var overBackGroundBD:BitmapData;
		
		private var positionOffset:Number;
		
		private var buttonBackGroundBitmap:Bitmap;
		private var buttonTextBitmapData:BitmapData;
		private var buttonTextBitmap:Bitmap;
		

		public function SimpleBlitButton
		(
		 x:Number, y:Number, width:Number,
	     height:Number, text:String, offColor:uint,
		 overColor:uint, textFormat:TextFormat, 
		 positionOffset:Number = 0
		 ) 
			{
				//position
				this.positionOffset = positionOffset;
				this.x = x;
				this.y = y;
				
				//background
				offBackGroundBD = new BitmapData(width, height,
												 false, offColor);
				
				overBackGroundBD = new BitmapData(width, height,
												 false, overColor);
				
				buttonBackGroundBitmap = new Bitmap(offBackGroundBD);
				
				//text
				var tempText:TextField = new TextField();
				tempText.text = text; 
				tempText.setTextFormat(textFormat);

				buttonTextBitmapData = new BitmapData
				(tempText.textWidth+positionOffset,tempText.textHeight+positionOffset, true, 0x00000000);
				
				buttonTextBitmapData.draw(tempText);
				buttonTextBitmap = new Bitmap(buttonTextBitmapData);
				
				buttonTextBitmap.x = ((buttonBackGroundBitmap.width - int(tempText.textWidth))/2)-positionOffset;
				
				buttonTextBitmap.y = ((buttonBackGroundBitmap.height - int(tempText.textHeight))/2)-positionOffset;
				
				
				addChild(buttonBackGroundBitmap);
				addChild(buttonTextBitmap);
				this.buttonMode = true;
				this.useHandCursor = true;
			}
			
			
			public function changeBackGroundColor(typeval:int):void
			{
				if (typeval == SimpleBlitButton.OFF)
				{
					buttonBackGroundBitmap.bitmapData = offBackGroundBD;
				}
					else
					{
						buttonBackGroundBitmap.bitmapData = overBackGroundBD;
					}
			}

	  }
	
}
