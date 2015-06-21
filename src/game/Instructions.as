package game
{
	import com.greensock.TweenLite;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Instructions extends Sprite
	{
		private var _bg:Quad;
		private var inst1:Image = new Image(Assets.getTexture("bmpInstruction1"));
		private var inst2:Image = new Image(Assets.getTexture("bmpInstruction2"));
		private var inst3:Image = new Image(Assets.getTexture("bmpInstruction3"));
		
		private var _tweens:Vector.<TweenLite> = new Vector.<TweenLite>();
		
		public function Instructions()
		{
			super();
			
			_bg = new Quad(800, 600, 0xffffff);
			_bg.alpha = 0.8;
			addChild(_bg);
			
			inst1.alpha = 0;
			addChild(inst1);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			
			var t:Instructions = this;
			
			_tweens.push(TweenLite.to(inst1, 1, {alpha: 1, onComplete: function():void
				{
					_tweens.push(TweenLite.to(inst1, 1, {alpha: 0, delay: 3, onComplete: function():void
						{
							inst1.parent.removeChild(inst1);
							inst2.alpha = 0;
							addChild(inst2);
							_tweens.push(TweenLite.to(inst2, 1, {alpha: 1, onComplete: function():void
								{
									_tweens.push(TweenLite.to(inst2, 1, {alpha: 0, delay: 3, onComplete: function():void
										{
											inst2.parent.removeChild(inst2);
											inst3.alpha = 0;
											addChild(inst3);
											_tweens.push(TweenLite.to(inst3, 1, {alpha: 1, onComplete: function():void
												{
													_tweens.push(TweenLite.to(t, 1, {alpha: 0, delay: 3, onComplete: function():void
														{
															instructionComplete();
														}}));
												}}));
										}}));
								}}));
						}}));
				}}));
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.touches[0].phase == TouchPhase.BEGAN)
			{
				instructionComplete();
			}
		}
		
		private function instructionComplete():void
		{
			for each (var twn:TweenLite in _tweens)
				twn.kill();
				
			dispatchEvent(new Event("instructionComplete"));
			parent.removeChild(this);
		}
	
	}

}