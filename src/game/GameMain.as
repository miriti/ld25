package game
{
	import flash.display.Bitmap;
	import game.objs.Building;
	import game.objs.GameMob;
	import game.objs.Road;
	import game.objs.Solder;
	import game.objs.SolderSpawn;
	import game.objs.VillainBase;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMain extends GameBaseObj
	{
		private var _back:Quad;
		
		private var _buildings:Vector.<Building> = new Vector.<Building>();
		private var _mobs:Vector.<GameMob> = new Vector.<GameMob>();
		private var _objs:Vector.<GameBaseObj> = new Vector.<GameBaseObj>();
		
		private var _grid:Vector.<Vector.<GameBaseObj>>;
		
		private static var _inst:GameMain;
		
		public static var keys:Vector.<Boolean> = new Vector.<Boolean>(256);
		
		public function GameMain()
		{
			super();
			_inst = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 *
		 * @param	atX
		 * @param	atY
		 * @return
		 */
		public function getGrid(atX:int, atY:int):GameBaseObj
		{
			if (atX >= 0)
			{
				if (atY >= 0)
				{
					if (atX < _grid.length)
					{
						if (atY < _grid[0].length)
						{
							return _grid[atX][atY];
						}
					}
				}
			}
			
			return null;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (child is GameBaseObj)
			{
				_objs.push(child);
				if (child is Building)
					_buildings.push(child);
				if (child is GameMob)
					_mobs.push(child);
			}
			return super.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject, dispose:Boolean = false):DisplayObject
		{
			if (child is GameBaseObj)
			{
				var i:int = _objs.indexOf(child);
				if (i != -1)
					_objs.splice(i, 1);
				
				i = _buildings.indexOf(child);
				if (i != -1)
				{
					_buildings.splice(i, 1);
					
					if (_buildings.length == 0)
					{
						Main.inst.finishGameSuccess();
					}
				}
				
				i = _mobs.indexOf(child);
				if (i != -1)
					_mobs.splice(i, 1);
			}
			return super.removeChild(child, dispose);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			_initScene();
		}
		
		private function _initScene():void
		{
			_back = new Quad(Main.viewPort.width, Main.viewPort.height, 0x558889);
			addChild(_back);
			
			var layout:Bitmap = new Assets.bmpLayout();
			var layoutScale:Number = Main.viewPort.width / layout.width;
			
			_grid = new Vector.<Vector.<GameBaseObj>>(layout.width);
			
			for (var i:int = 0; i < layout.width; i++)
			{
				_grid[i] = new Vector.<GameBaseObj>(layout.height);
				
				for (var j:int = 0; j < layout.height; j++)
				{
					var newObj:GameBaseObj = ColorFactory.produce(layout.bitmapData.getPixel32(i, j));
					
					if (newObj != null)
					{
						newObj.x = i * layoutScale + layoutScale / 2;
						newObj.y = j * layoutScale + layoutScale / 2;
						newObj.setGridPos(i, j);
						addChild(newObj);
					}
					
					_grid[i][j] = newObj;
					
					if (newObj is SolderSpawn)
					{
						var newRoad:Road = new Road();
						newRoad.x = i * layoutScale + layoutScale / 2;
						newRoad.y = j * layoutScale + layoutScale / 2;
						addChild(newRoad);
					}
				}
			}
			
			var instr:Instructions = new Instructions();
			instr.addEventListener("instructionComplete", onStartGame);
			addChild(instr);
		}
		
		private function onStartGame(e:Event):void
		{
			SolderSpawn.active = true;
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		static public function get inst():GameMain
		{
			return _inst;
		}
		
		public function get buildings():Vector.<Building>
		{
			return _buildings;
		}
		
		public function get objs():Vector.<GameBaseObj>
		{
			return _objs;
		}
		
		public function get mobs():Vector.<GameMob>
		{
			return _mobs;
		}
		
		public function get grid():Vector.<Vector.<GameBaseObj>>
		{
			return _grid;
		}
	
	}

}