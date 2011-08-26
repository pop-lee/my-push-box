package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class DirectionBtnEvent extends Event
	{
		public static const DIRECTION_EVENT:String = "directionEvent";
		
		public static const LEFT:String = "left";
		public static const RIGHT : String = "right";
		public static const TOP : String = "top";
		public static const BOTTOM:String = "bottom";
		
		public var direction : String ;
		
		public function DirectionBtnEvent(_direction : String)
		{
			direction = _direction;
			super(DIRECTION_EVENT);
		}
		
	}
}