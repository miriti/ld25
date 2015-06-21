package game.objs 
{
	import game.GameBaseObj;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Road extends GameBaseObj 
	{
		private var _image:Image;
		
		public function Road() 
		{
			super();
			_image = new Image(Assets.getTexture("bmpRoad0"));
			_image.x = -_image.width / 2;
			_image.y = -_image.height  / 2;			
			addChild(_image);
			
			rotation + Math.PI * (Math.random() * 4);
		}
		
	}

}