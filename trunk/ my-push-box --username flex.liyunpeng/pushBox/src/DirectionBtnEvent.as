package
{
	import flash.events.Event;
	
	public class DirectionBtnEvent extends Event
	{
		public static const LEFT:String = "left";
		public static const RIGHT : String = "right";
		public static const TOP : String = "top";
		public static const BOTTOM:String = "bottom";
		
		public var _direction : String ;
		
		public function DirectionBtnEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}