package game.objs
{
	import game.GameBaseObj;
	import game.GameMain;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Building extends GameObj
	{
		
		private var _bombed:Boolean = false;
		
		private var _bombingProgress:Number = 0;
		private var _progressBar:Quad;
		
		private var _bombLocked:Boolean = false;
		private var _countDown:TextField;
		private var _countDownValue:Number = 5;
		
		private static const COUNT_DOWN:int = 5;
		static private const LETHAL_AREA:Number = 100;
		static private const MAX_HIT_POINTS:Number = 1000;
		
		private var _exploded:Boolean = false;
		private var _img:Image;
		
		public function Building()
		{
			_img = new Image(Assets.getTexture("bmpBuilding" + Math.floor(Math.random() * 3)));
			_img.x = -_img.width / 2;
			_img.y = -_img.height + 25;
			addChild(_img);
			
			_progressBar = new Quad(_img.width, 5, 0xff0000);
			_progressBar.x = -_img.width / 2;
			_progressBar.y = -(_img.height - 25) - 8;
			_progressBar.visible = false;
			addChild(_progressBar);
			
			_countDown = new TextField(35, 30, COUNT_DOWN.toString(), "Verdana", 18, 0xff0000);
			_countDown.y = -(_img.height - 25) - 40;
			_countDown.x = -_img.width / 2;
			_countDown.visible = false;
			addChild(_countDown);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var t:Touch = e.touches[0];
			
			if (t.phase == TouchPhase.BEGAN)
			{
				if (!_bombLocked)
					VillainBase.inst.produceAgent(this);
			}
		}
		
		override protected function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_bombLocked)
			{
				var pre:int = Math.floor(_countDownValue);
				_countDownValue -= deltaTime;
				var pos:int = Math.floor(_countDownValue);
				
				if (_countDownValue <= 0)
				{
					_boom();
				}
				else
				{
					if (pos != pre)
					{
						if (pos == 0)
							Assets.sndPlay("sndTick1");
						else
							Assets.sndPlay("sndTick0");
					}
					_countDown.text = Math.floor(_countDownValue).toString();
				}
			}
		}
		
		private function _boom():void
		{
			for each (var obj:GameBaseObj in GameMain.inst.objs)
			{
				if (obj is GameMob)
				{
					var f:Number = howFar(obj);
					if (f <= LETHAL_AREA)
					{
						(obj as GameMob).hit(MAX_HIT_POINTS);
					}
				}
			}
			
			var e:Explosion = new Explosion();
			e.x = x;
			e.y = y;
			parent.addChild(e);
			parent.removeChild(this);
			_exploded = true;
		}
		
		public function get bombed():Boolean
		{
			return _bombed;
		}
		
		public function get bombingProgress():Number
		{
			return _bombingProgress;
		}
		
		public function set bombingProgress(value:Number):void
		{
			if (value >= 1)
			{
				value = 1;
				if (!_bombLocked)
				{
					_bombLocked = true;
					_countDown.text = COUNT_DOWN.toString();
					_countDownValue = COUNT_DOWN;
					_countDown.visible = true;
				}
			}
			
			if (value < 0)
				value = 0;
			
			if (value > 0)
			{
				_progressBar.visible = true;
				_progressBar.width = _img.width * value;
				_bombed = true;
			}
			if (value == 0)
			{
				_progressBar.visible = false;
				_bombed = false;
				_bombLocked = false;
				_countDown.visible = false;
			}
			
			_bombingProgress = value;
		}
		
		public function get bombLocked():Boolean
		{
			return _bombLocked;
		}
		
		public function get exploded():Boolean
		{
			return _exploded;
		}
	}

}