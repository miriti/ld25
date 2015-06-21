package game.objs
{
	import com.greensock.TweenLite;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class LaserShot extends Sprite
	{
		private var _img:Quad;
		
		public function LaserShot(w:Number)
		{
			super();
			_img = new Quad(w, 2, 0xffff88);
			_img.x = 0;
			_img.y = -_img.height / 2;
			addChild(_img);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			var l:LaserShot = this;
			
			TweenLite.to(l, 0.3, {alpha: 0, onComplete: function():void
				{
					l.parent.removeChild(l);
				}});
		}
	
	}

}