package game
{
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameBaseObj extends Sprite
	{
		private var _lastTime:Number;
		
		protected var _radius:Number = 30;
		
		protected var _gridPos:Point;
		
		public function GameBaseObj()
		{
			super();
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			_lastTime = new Date().getTime();
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			var _currentTime:Number = new Date().getTime();
			update((_currentTime - _lastTime) / 1000);
			_lastTime = _currentTime;
		}
		
		public function setGridPos(gx:int, gy:int):void
		{
			_gridPos = new Point(gx, gy);
		}
		
		protected function update(deltaTime:Number):void
		{
		
		}
		
		protected function howFar(obj:GameBaseObj):Number
		{
			return new Point(obj.x - x, obj.y - y).length;
		}
		
		protected function vTo(obj:GameBaseObj):Point
		{
			var v:Point = new Point(obj.x - x, obj.y - y);
			v.normalize(1);
			return v;
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function get gridPos():Point 
		{
			return _gridPos;
		}
	
	}

}