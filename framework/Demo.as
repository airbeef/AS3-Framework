package com.efg.demos.classupdates
	{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.efg.framework.BasicScreen;
	import flash.geom.Point;
	
	/**	 * ...* @author Jeff Fulton **/
	public class BasicScreenDemo extends Sprite 
	{		
			[Embed(source = 'assets/asciirooidstitle.jpg')]
				public static const TitleJpg:Class;	
		
			[Embed(source = 'assets/playbutton_off.jpg')]
				public static const PlayButtonOffJpg:Class;	
		
			[Embed(source = 'assets/playbutton_on.jpg')]
				public static const PlayButtonOnJpg:Class;
		
	private var titleScreen:BasicScreen;
	
	//FlexSDK  
	private var titleBitmap:Bitmap = new TitleJpg();
	//end Flex SDK		
	
	//Flash IDE
	//private var titleBitmapData:BitmapData = new TitleJpg(0,0);
	//end flash IDE		  
	
	public function BasicScreenDemo():void 
	{
		if (stage) init(); 
		
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}		    
	
	private function init(e:Event = null):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// entry point			   
			titleScreen = new BasicScreen(1, 400, 400, false, 0x000000);			
			//Flex SDK    
			titleScreen.addImage(titleBitmap.bitmapData);
			//end Flex SDK	
			
			//Flash IDE      
			//titleScreen.addImage(titleBitmapData);   
			//end Flash IDE			
			
			titleScreen.imageBitmap.x = 50;			
			titleScreen.useImageButton = true;	
			
			//Flex SDK  
			titleScreen.createImageButton(new PlayButtonOffJpg().bitmapData, new PlayButtonOnJpg().bitmapData, _    
									  new Point(150, 300));  
			//end Flex SDK			
		
			//Flash IDE  
			//titleScreen.createImageButton(new PlayButtonOffJpg(0,0), new PlayButtonOnJpg(0,0), _
			//end Flash IDE 
			
			new Point(150, 300)); 
			addChild(titleScreen);		
		}			
	}
}