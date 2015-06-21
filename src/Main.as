package
{
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import game.GameMain;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		static private var _viewPort:Rectangle;
		static private var _inst:Main;
		
		private var _starling:Starling;
		private var intro:Intro;
		
		public function Main():void
		{
			_inst = this;
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			intro = new Intro();
			intro.addEventListener("introFinished", startGame);
			intro.addEventListener(MouseEvent.CLICK, onIntroClick);
			intro.x = 400;
			intro.y = 300;
			addChild(intro);
		}
		
		private function onIntroClick(e:MouseEvent):void
		{
			startGame();
		}
		
		public function startGame(e:Event = null):void
		{
			if (intro.parent)
			{
				intro.stop();
				removeChild(intro);
			}
			_viewPort = new Rectangle(0, 0, 800, 600);
			_starling = new Starling(GameMain, stage, _viewPort);
			_starling.start();
		}
		
		private function _finishShowHAHAHA():void
		{
			_starling.stop();
			//_starling.dispose();
			
			var hahaha:HaHaHa = new HaHaHa();
			TweenLite.from(hahaha, 1, {alpha: 0});
			addChild(hahaha);
		}
		
		public function finishGameSuccess():void
		{
			TweenLite.to(GameMain.inst, 1, {alpha: 0, onComplete: _finishShowHAHAHA});
		}
		
		private function _finishGameShowFail():void
		{
			_starling.stop();
			_starling.dispose();
			
			var failScreen:FailScreen = new FailScreen();
			failScreen.addEventListener("playAgain", function(e:Event):void
				{
					removeChild(failScreen);
					startGame();
				});
			TweenLite.from(failScreen, 1, {alpha: 0});
			addChild(failScreen);
		}
		
		public function finishGameFail():void
		{
			TweenLite.to(GameMain.inst, 1, {alpha: 0, onComplete: _finishGameShowFail});
		}
		
		static public function get viewPort():Rectangle
		{
			return _viewPort;
		}
		
		static public function get inst():Main
		{
			return _inst;
		}
	
	}

}