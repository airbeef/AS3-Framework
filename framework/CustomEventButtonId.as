package com.efg.framework
{
	import flash.events.*;
		
	/*
	@ JC Brazil
	*/
	
	public class CustomEventButtonId extends Event
	{
		public static const BUTTON_ID:String = "button id";
		
		public var id:int;
		
		//Molly's Suggestions
		public var m_OverrideNextState:int;
						
		public function CustomEventButtonId(type:String, id:int, overrideNextState:int = -1, bubbles:Boolean = false,
										   cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			
			this.id = id;
			
			//Molly's Suggestions//
			this.m_OverrideNextState = overrideNextState;
		}
				
		public override function clone():Event
		{
			//test//
			return new CustomEventButtonId(type, id, m_OverrideNextState, bubbles, cancelable);
		}
	}
	
}