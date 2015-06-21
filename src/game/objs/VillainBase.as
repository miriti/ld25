package game.objs
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import game.GameMain;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class VillainBase extends GameObj
	{
		static private const MAX_HEALTH:Number = 1000;
		static private const HEALTH_RECOVERY:Number = 0;
		
		static private var _inst:VillainBase;
		private var _healthBar:Quad;
		
		private var _health:Number = MAX_HEALTH;
		private var _shotDelay:Number = 0.5;
		private var _shotTime:Number = 0;
		
		private var _availAgents:int = 10;
		private var _img:Image;
		private var _agentCountIndicator:TextField;
		private var _exploded:Boolean = false;
		
		public function VillainBase()
		{
			super();
			_inst = this;
			
			_img = new Image(Assets.getTexture("bmpVillainBaloon"));
			_img.x = -_img.width / 2;
			_img.y = -_img.height + 25;
			addChild(_img);
			
			_agentCountIndicator = new TextField(50, 30, "10", "Verdana", 18);
			_agentCountIndicator.x = _img.x;
			_agentCountIndicator.y = _img.y;
			addChild(_agentCountIndicator);
			
			_healthBar = new Quad(50, 5, 0xff0000);
			_healthBar.y = -_img.height + 25;
			_healthBar.x = -_img.width / 2;
			addChild(_healthBar);
			
			_radius = 50;
		}
		
		override protected function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if (_shotTime <= 0)
			{
				var mobsToShot:Vector.<Solder> = new Vector.<Solder>();
				
				for each (var mob:GameMob in GameMain.inst.mobs)
				{
					if ((mob is Solder) && (howFar(mob) <= (_radius + mob.radius)))
					{
						mobsToShot.push(mob);
					}
				}
				
				if (mobsToShot.length > 0)
				{
					var m:Solder = mobsToShot[Math.floor(Math.random() * mobsToShot.length)];
					var f:Number = howFar(m);
					var l:LaserShot = new LaserShot(f);
					l.x = x;
					l.y = y;
					l.rotation = Math.atan2(m.y - y, m.x - x);
					parent.addChild(l);
					m.hit(50);
					
					Assets.sndPlay("sndLaser");
				}
				
				_shotTime = _shotDelay;
			}
			else
			{
				_shotTime -= deltaTime;
			}
			
			if (_health < MAX_HEALTH)
			{
				_health += deltaTime * HEALTH_RECOVERY;
				if (_health > MAX_HEALTH)
					_health = MAX_HEALTH;
			}
		}
		
		public function hit(points:Number):void
		{
			if (!_exploded)
			{
				_health -= points;
				if (_health <= 0)
				{
					_health = 0;
					_exploded = true;
					_explode();
				}
				_healthBar.width = 50 * (_health / 1000);
			}
		}
		
		private function _explode():void
		{
			SolderSpawn.active = false;
			for (var i:int = 0; i < 4; i++)
			{
				var e:Explosion = new Explosion();
				e.x = x + (-25 + Math.random() * 50);
				e.y = y + (-25 + Math.random() * 50);
				parent.addChild(e);
			}
			
			parent.removeChild(this);
			Main.inst.finishGameFail();
		}
		
		public function backAgent(agent:VillainAgent):void
		{
			agent.parent.removeChild(agent);
			_availAgents++;
			_agentCountIndicator.text = _availAgents.toString();
		}
		
		public function produceAgent(target:Building):void
		{
			if ((_availAgents > 0) && (_health > 0))
			{
				var newAgent:VillainAgent = new VillainAgent(target);
				newAgent.x = x;
				newAgent.y = y;
				newAgent.setGridPos(gridPos.x, gridPos.y);
				newAgent.pathTo(target.gridPos);
				GameMain.inst.addChild(newAgent);
				_availAgents--;
				_agentCountIndicator.text = _availAgents.toString();
			}
		}
		
		static public function get inst():VillainBase
		{
			return _inst;
		}
		
		public function get availAgents():int
		{
			return _availAgents;
		}
	}

}