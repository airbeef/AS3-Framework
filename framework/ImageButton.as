package com.efg.framework 
{
	import flash.display.Bitmap;   
	import flash.display.BitmapData;  
	import flash.display.Sprite;   
	import flash.geom.Point; 
	
	public class ImageButton extends Sprite
	{
		//Two states that will be contrailled by
		//BasicScreen.as and passed through changeButton()
		public static const OFF:int = 1;     
		public static const OVER:int = 2;
		
		//button bitmap, what it will look like hovering over
		//what it will look like with no interaction
		public var buttonBitmap:Bitmap;     
   		public var offBitmapData:BitmapData;      
 		public var overBitmapData:BitmapData;
		
		public function ImageButton(off:BitmapData, over:BitmapData, location:Point) 
		{
		   //accepts two BitmapData objects representing the look for OFF & OVER states of a button
		   //also accepts the Point class instance used to position button inside its container object [ex BasicScreen.as]
		   offBitmapData = off;         
		   overBitmapData = over;        
		   buttonBitmap = new Bitmap(offBitmapData);        
		   addChild(buttonBitmap);    
		   
		   x = location.x;        
		   y = location.y;         
		   this.buttonMode = true;         
		   this.useHandCursor = true;  
		}
		
		//public interface used to change the button state using if/else
	    public function changeButton(typeval:int):void
	  	{        
	  	  if (typeval == OFF) 
	 	    {           
	 		 buttonBitmap.bitmapData = offBitmapData;        
	  		}
	  	  else
			{           
				buttonBitmap.bitmapData = overBitmapData;        
			}    
		}
	}
}