package game.objs
{
	import flash.geom.Point;
	import game.GameBaseObj;
	import game.GameMain;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class VillainAgent extends GameMob
	{
		private var _target:GameBaseObj;
		
		static private const BOMBING_SPEED:Number = 0.1;
		private var _movingSpeed:Number = 100;
		private var _anim:MovieClip;
		
		public function VillainAgent(target:GameBaseObj)
		{
			super();
			
			_anim = new MovieClip(Assets.getAgentAnim(), 30);
			_anim.x = -_anim.width / 2;
			_anim.y = -_anim.height / 2;
			addChild(_anim);
			Starling.juggler.add(_anim);
			_target = target;
		}
		
		override protected function death():void
		{
			super.death();
			
			var cntAgent:int = 0;
			
			for each (var m:GameMob in GameMain.inst.mobs)
			{
				if (m is VillainAgent)
				{
					cntAgent++;
					break;
				}
			}
			
			if ((cntAgent == 0) && (VillainBase.inst.availAgents == 0))
				Main.inst.finishGameFail();
		}
		
		override protected function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_target is Building)
			{
				var b:Building = (_target as Building);
				
				if ((!b.exploded) && ((b.bombingProgress >= 1) || (b.bombLocked)))
				{
					_anim.play();
					_target = VillainBase.inst;
					pathTo(_target.gridPos);
				}
			}
			
			if (howFar(_target) >= (_radius))
			{
				if (!_onPath)
				{
					var v:Point = vTo(_target);
					
					x += v.x * (_movingSpeed * deltaTime);
					y += v.y * (_movingSpeed * deltaTime);
				}
			}
			else
			{
				pathStop();
				
				if (_target is Building)
				{
					_anim.stop();
					_bombing(deltaTime);
				}
				else if (_target is VillainBase)
				{
					VillainBase.inst.backAgent(this);
				}
			}
		}
		
		private function _bombing(d:Number):void
		{
			(_target as Building).bombingProgress += d * BOMBING_SPEED;
		}
	}

}