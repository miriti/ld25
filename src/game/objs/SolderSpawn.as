package game.objs
{
	import flash.utils.setTimeout;
	import game.GameBaseObj;
	import game.GameMain;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class SolderSpawn extends GameBaseObj
	{
		private var _delay:Number = 15;
		private var _time:Number = 0;
		static private var _active:Boolean = false;
		
		public function SolderSpawn()
		{
			super();
			
			_time = Math.random() * _delay;
		}
		
		private function produceSolder():void
		{
			var newSolder:Solder = new Solder();
			newSolder.x = x + (-20 + Math.random() * 40);
			newSolder.y = y + (-20 + Math.random() * 40);
			newSolder.setGridPos(_gridPos.x, _gridPos.y);
			parent.addChild(newSolder);
		}
		
		override protected function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_active)
			{
				if (_time <= 0)
				{
					produceSolder();
					_time = _delay;
					_delay *= 0.9;
				}
				else
				{
					_time -= deltaTime;
				}
			}
		}
		
		static public function get active():Boolean
		{
			return _active;
		}
		
		static public function set active(value:Boolean):void
		{
			_active = value;
			
			if (!_active)
			{
				for each (var m:GameMob in GameMain.inst.mobs)
				{
					if (m is Solder)
					{
						m.parent.removeChild(m);
					}
				}
			}
		}
	
	}

}