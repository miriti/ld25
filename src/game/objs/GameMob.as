package game.objs
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import game.GameBaseObj;
	import game.GameMain;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMob extends GameBaseObj
	{
		private var _dead:Boolean;
		protected var _health:Number = 100;
		
		private var _path:Vector.<Point>;
		private var _pathTween:TweenLite;
		
		protected var _onPath:Boolean = false;
		
		protected var _cellTime:Number = 0.3;
		
		public function GameMob()
		{
			super();
		}
		
		private function _pathNextStep():void
		{
			if (_path.length > 0)
			{
				var cell:Point = _path.pop();
				if (cell.x < _gridPos.x)
					scaleX = -1;
				else
					scaleX = 1;
				_gridPos = cell.clone();
				
				_pathTween = TweenLite.to(this, _cellTime, {x: cell.x * 50 + 25, y: cell.y * 50 + 25, ease: Linear.easeNone, onComplete: _pathNextStep});
			}
			else
			{
				
			}
		}
		
		protected function pathStop():void
		{
			if (_pathTween != null)
				_pathTween.kill();
			
			_onPath = false;
		}
		
		public function pathTo(point:Point):void
		{
			pathStop();
			
			_path = new Vector.<Point>();
			_findPath(point);
			_onPath = true;
			_pathNextStep();
		}
		
		private function _inPath(p:Point):Boolean
		{
			for (var i:int = 0; i < _path.length; i++)
			{
				if (_path[i].equals(p))
					return true;
			}
			return false;
		}
		
		private function _findPath(initPos:Point):void
		{
			_path.push(initPos);
			
			var choosenCell:Point = initPos.clone();
			
			do
			{
				var neigh:Vector.<Point> = new Vector.<Point>();
				var p:Point;
				var obj:GameBaseObj;
				
				p = new Point(choosenCell.x - 1, choosenCell.y);
				if (p.equals(_gridPos))
				{
					_path.push(p);
					break;
				}
				else
				{
					obj = GameMain.inst.getGrid(p.x, p.y);
					if ((obj is Road) || (obj is SolderSpawn))
					{
						if (!_inPath(p))
							neigh.push(p);
					}
				}
				
				p = new Point(choosenCell.x, choosenCell.y - 1);
				if (p.equals(_gridPos))
				{
					_path.push(p);
					break;
				}
				else
				{
					obj = GameMain.inst.getGrid(p.x, p.y);
					if ((obj is Road) || (obj is SolderSpawn))
					{
						if (!_inPath(p))
							neigh.push(p);
					}
				}
				
				p = new Point(choosenCell.x + 1, choosenCell.y);
				if (p.equals(_gridPos))
				{
					_path.push(p);
					break;
				}
				else
				{
					obj = GameMain.inst.getGrid(p.x, p.y);
					if ((obj is Road) || (obj is SolderSpawn))
					{
						if (!_inPath(p))
							neigh.push(p);
					}
				}
				
				p = new Point(choosenCell.x, choosenCell.y + 1);
				if (p.equals(_gridPos))
				{
					_path.push(p);
					break;
				}
				else
				{
					obj = GameMain.inst.getGrid(p.x, p.y);
					if ((obj is Road) || (obj is SolderSpawn))
					{
						if (!_inPath(p))
							neigh.push(p);
					}
				}
				
				if (neigh.length == 0)
				{
					return;
				}
				else
				{
					var minLn:Number = Number.MAX_VALUE;
					var minIn:int;
					
					for (var i:int = 0; i < neigh.length; i++)
					{
						p = neigh[i];
						var l:Number = new Point(p.x - _gridPos.x, p.y - _gridPos.y).length;
						
						if (l < minLn)
						{
							minLn = l
							minIn = i;
						}
					}
					
					choosenCell = neigh[minIn];
					_path.push(choosenCell);
				}
			} while (!choosenCell.equals(_gridPos));
		}
		
		public function hit(points:Number):void
		{
			_health -= points;
			if (_health <= 0)
				death();
		}
		
		protected function death():void
		{
			_dead = true;
			parent.removeChild(this);
		}
		
		public function get dead():Boolean
		{
			return _dead;
		}
	
	}

}