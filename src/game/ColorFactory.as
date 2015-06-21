package game
{
	import game.objs.Building;
	import game.objs.Road;
	import game.objs.SolderSpawn;
	import game.objs.VillainBase;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ColorFactory
	{
		static public function produce(pixel32:uint):GameBaseObj
		{
			switch (pixel32)
			{
				case 0xff00ff00:
					return new Building();
					break;
				case 0xffff0000:
					return new VillainBase();
					break;
				case 0xffffff00:
					return new SolderSpawn();
					break;
				case 0xff808080:
					return new Road();
					break;
				default:
					return null;
					break;
			}
		}
	}

}