package
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Assets
	{
		[Embed(source="../assets/bmp/layout.png")]
		static public var bmpLayout:Class;
		
		[Embed(source="../assets/bmp/building-0.png")]
		static public var bmpBuilding0:Class;
		
		[Embed(source="../assets/bmp/building-1.png")]
		static public var bmpBuilding1:Class;
		
		[Embed(source="../assets/bmp/building-2.png")]
		static public var bmpBuilding2:Class;
		
		[Embed(source="../assets/bmp/road-0.png")]
		static public var bmpRoad0:Class;
		
		[Embed(source="../assets/bmp/instructions/instructions0001.png")]
		static public var bmpInstruction1:Class;
		
		[Embed(source="../assets/bmp/instructions/instructions0002.png")]
		static public var bmpInstruction2:Class;
		
		[Embed(source="../assets/bmp/instructions/instructions0003.png")]
		static public var bmpInstruction3:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0001.png")]
		static public var bmpSolder1:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0002.png")]
		static public var bmpSolder2:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0003.png")]
		static public var bmpSolder3:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0004.png")]
		static public var bmpSolder4:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0005.png")]
		static public var bmpSolder5:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0006.png")]
		static public var bmpSolder6:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0007.png")]
		static public var bmpSolder7:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0008.png")]
		static public var bmpSolder8:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0009.png")]
		static public var bmpSolder9:Class;
		
		[Embed(source="../assets/bmp/solder-anim/solder0010.png")]
		static public var bmpSolder10:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0001.png")]
		static public var bmpAgent1:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0002.png")]
		static public var bmpAgent2:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0003.png")]
		static public var bmpAgent3:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0004.png")]
		static public var bmpAgent4:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0005.png")]
		static public var bmpAgent5:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0006.png")]
		static public var bmpAgent6:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0007.png")]
		static public var bmpAgent7:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0008.png")]
		static public var bmpAgent8:Class;
		
		[Embed(source="../assets/bmp/agent-anim/agent0009.png")]
		static public var bmpAgent9:Class;
		
		[Embed(source="../assets/bmp/villain-baloon.png")]
		static public var bmpVillainBaloon:Class;
		
		[Embed(source="../assets/snd/explosion-0.mp3")]
		static public var sndExplosion0:Class;
		
		[Embed(source="../assets/snd/explosion-1.mp3")]
		static public var sndExplosion1:Class;
		
		[Embed(source="../assets/snd/laser.mp3")]
		static public var sndLaser:Class;
		
		[Embed(source="../assets/snd/tick-0.mp3")]
		static public var sndTick0:Class;
		
		[Embed(source="../assets/snd/tick-1.mp3")]
		static public var sndTick1:Class;
		
		static private var _bitmapPool:Dictionary = new Dictionary();
		
		static private var _texturePool:Dictionary = new Dictionary();
		
		static private var _solderAnim:Vector.<Texture> = null;
		
		static private var _agentAnim:Vector.<Texture> = null;
		
		static private var _sounds:Dictionary = new Dictionary();
		
		static private var _soundChannels:Vector.<SoundChannel> = new Vector.<SoundChannel>();
		
		public static function getBitmap(name:String):Bitmap
		{
			if (_bitmapPool[name] == undefined)
				_bitmapPool[name] = new Assets[name]() as Bitmap;
			
			return _bitmapPool[name];
		}
		
		public static function getTexture(name:String):Texture
		{
			if (_texturePool[name] == undefined)
				_texturePool[name] = Texture.fromBitmap(getBitmap(name));
			
			return _texturePool[name];
		}
		
		public static function getAgentAnim():Vector.<Texture>
		{
			if (_agentAnim == null)
			{
				_agentAnim = new Vector.<Texture>();
				
				_agentAnim.push(getTexture("bmpAgent1"));
				_agentAnim.push(getTexture("bmpAgent2"));
				_agentAnim.push(getTexture("bmpAgent3"));
				_agentAnim.push(getTexture("bmpAgent4"));
				_agentAnim.push(getTexture("bmpAgent5"));
				_agentAnim.push(getTexture("bmpAgent6"));
				_agentAnim.push(getTexture("bmpAgent7"));
				_agentAnim.push(getTexture("bmpAgent8"));
				_agentAnim.push(getTexture("bmpAgent9"));
			}
			
			return _agentAnim;
		}
		
		public static function getSolderAnim():Vector.<Texture>
		{
			if (_solderAnim == null)
			{
				_solderAnim = new Vector.<Texture>();
				
				_solderAnim.push(getTexture("bmpSolder1"));
				_solderAnim.push(getTexture("bmpSolder2"));
				_solderAnim.push(getTexture("bmpSolder3"));
				_solderAnim.push(getTexture("bmpSolder4"));
				_solderAnim.push(getTexture("bmpSolder5"));
				_solderAnim.push(getTexture("bmpSolder6"));
				_solderAnim.push(getTexture("bmpSolder7"));
				_solderAnim.push(getTexture("bmpSolder8"));
				_solderAnim.push(getTexture("bmpSolder9"));
				_solderAnim.push(getTexture("bmpSolder10"));
			}
			
			return _solderAnim;
		}
		
		public static function sndPlay(name:String):void
		{
			if (_sounds[name] == undefined)
			{
				_sounds[name] = new Assets[name]() as Sound;
			}
			
			var sndChannel:SoundChannel = (_sounds[name] as Sound).play();
			sndChannel.addEventListener(Event.SOUND_COMPLETE, function(e:Event):void
				{
					_soundChannels.splice(_soundChannels.indexOf(e.target as SoundChannel), 1);
				});
			_soundChannels.push(sndChannel);
		}
	}

}