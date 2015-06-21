package game.objs
{
	import com.greensock.TweenLite;
	import game.GameBaseObj;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Explosion extends GameBaseObj
	{
		private var _img:Quad
		private var lay1:Sprite;
		private var lay2:Sprite;
		
		public function Explosion()
		{
			super();
			lay1 = new Sprite();
			_img = new Quad(200, 200, 0xFDCD64);
			_img.x = -_img.width / 2;
			_img.y = -_img.height / 2;
			lay1.addChild(_img);
			lay1.rotation = Math.PI / 4;
			
			lay2 = new Sprite();
			_img = new Quad(200, 200, 0xFF7745);
			_img.x = -_img.width / 2;
			_img.y = -_img.height / 2;
			lay2.addChild(_img);
			
			addChild(lay1);
			addChild(lay2);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			TweenLite.to(lay1, 0.3, {rotation: -Math.PI / 4 * 5});
			TweenLite.to(lay2, 0.3, {rotation: Math.PI * 2});
			
			var t:Explosion = this;
			TweenLite.to(this, 0.3, {alpha: 0, onComplete: function():void
				{
					t.parent.removeChild(t);
				}});
			
			Assets.sndPlay("sndExplosion" + Math.floor(Math.random() * 2).toString());
		}
	
	}

}