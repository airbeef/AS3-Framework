package com.efg.framework
{
	import flash.media.*;
	import flash.media.SoundMixer;
	
	public class SoundManager 
	{
		private var sounds:Array;
		private var soundTrackChannel: SoundChannel = new SoundChannel();
		private var soundChannels:Array = [];
		private var soundMute:Boolean = false;
		private var tempSoundTransform:SoundTransform = new SoundTransform();
		private var muteSoundTransform:SoundTransform = new SoundTransform();
		private var tempSound:Sound;
		
		public function SoundManager() 
		{
			sounds = new Array();
			//soundChannels = new Array();
		}
		
		public function playSound(soundName:String, isSoundTrack:Boolean = false, 
								  loops:int = 1, offset:Number = 0, volume:Number = 1):void
		{
			//trace("sound=+ + snd);
			//var tsound:Object;
			
			tempSoundTransform.volume = volume;
			tempSound = sounds[soundName];
			
			if (isSoundTrack)
			{
				if (soundTrackChannel != null)
				{
					soundTrackChannel.stop();
				}
				soundTrackChannel = tempSound.play(offset, loops);
				soundTrackChannel.soundTransform = tempSoundTransform;
			}
			else
			{
				//trace("playing sound " + soundName);
				soundChannels[soundName] = tempSound.play(offset, loops);
				
				//trace(sndTransform = " + sndTransform);
				soundChannels[soundName].soundTransform = tempSoundTransform;
			}
		}
		
		public function addSound(soundName:String, sound:Sound):void
		{
			//trace("adding sound");
			sounds[soundName] = sound;
		}
		
		//This is from Chapter 12
		public function stopSound(soundName:String, isSoundTrack:Boolean = false):void
		{
			trace("stop sound");
			
			if (isSoundTrack)
				{
					trace ("isSoundTrack");
					soundTrackChannel.stop();
				}
			else
				{
					trace ("stopping sound");
					soundChannels[soundName].stop();
				}
		}
		
		//added in Chapter 11
		public function muteSound():void
		{
			trace("sound manager mutes");
			
			if (soundMute)
			{
				soundMute = false;
				muteSoundTransform.volume = 1;
				SoundMixer.soundTransform = muteSoundTransform;
				// if (startMusicPlaying) playSound("startMusic", 2000, 1);
			}
			else
			{
				muteSoundTransform.volume = 0;
				SoundMixer.soundTransform = muteSoundTransform;
				soundMute = true;
			}
		}

	}
	
}
