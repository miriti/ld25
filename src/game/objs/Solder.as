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
	public class Solder extends GameMob
	{
		//private var _img:Quad;
		static private const UNBOMBING_SPEED:Number = 0.1;
		static private const HIT_POWER:Number = 15;
		static private const BOMB_DETECT_DISTANCE:Number = 100;
		private var _radiusAdd:Number;
		private var _target:GameBaseObj;
		private var _anim:MovieClip;
		
		public function Solder()
		{
			super();
			
			_anim = new MovieClip(Assets.getSolderAnim(), 30);
			_anim.x = -_anim.width / 2;
			_anim.y = -_anim.height / 2;
			addChild(_anim);
			
			Starling.juggler.add(_anim);
			
			_radiusAdd = Math.floor(Math.random() * 10);
		}
		
		override public function setGridPos(gx:int, gy:int):void
		{
			super.setGridPos(gx, gy);
			if (gx == 0)
				x = -25;
			if (gy == 0)
				y = -25;
			if (gx == 15)
				x = 16 * 50 + 25;
			if (gy == 11)
				y = 12 * 50 + 25;
			
			_target = VillainBase.inst;
			pathTo(VillainBase.inst.gridPos);
		}
		
		override protected function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_target is Building)
			{
				var b:Building = (_target as Building);
				
				if ((!b.bombed) || (b.exploded))
				{
					_target = VillainBase.inst;
					pathTo(_target.gridPos);
				}
			}
			
			if (!(_target is Building))
			{
				for each (var build:Building in GameMain.inst.buildings)
				{
					if (build != _target)
					{
						if ((build.bombed) && (howFar(build) < BOMB_DETECT_DISTANCE) && (!build.exploded))
						{
							_target = build;
							pathTo(_target.gridPos);
							break;
						}
					}
				}
			}
			
			if (howFar(_target) > (_target.radius + _radiusAdd))
			{
				if (!_onPath)
				{
					//
				}
			}
			else
			{
				if (_onPath)
					pathStop();
				
				if (_target is Building)
				{
					(_target as Building).bombingProgress -= deltaTime * UNBOMBING_SPEED;
				}
				else if (_target is VillainBase)
				{
					(_target as VillainBase).hit(HIT_POWER * deltaTime);
				}
			}
		
		}
	}

}