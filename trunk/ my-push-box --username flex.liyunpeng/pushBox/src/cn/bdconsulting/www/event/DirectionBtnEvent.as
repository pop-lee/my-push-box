package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class DirectionBtnEvent extends Event
	{
		public static const DIRECTION_EVENT:String = "directionEvent";
		
		public static const LEFT:uint = 37;
		public static const TOP : uint = 38;
		public static const RIGHT : uint = 39;
		public static const BOTTOM:uint = 40;
		
		public var direction : uint ;
		
		public function DirectionBtnEvent(_direction : uint)
		{
			direction = _direction;
			super(DIRECTION_EVENT);
		}
		
	}
}