package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class DirectionBtnEvent extends Event
	{
		public static const DIRECTION_EVENT:String = "directionEvent";
		
		public static const LEFT:String = "Left";
		public static const RIGHT : String = "Right";
		public static const TOP : String = "Top";
		public static const BOTTOM:String = "Bottom";
		
		public var direction : String ;
		
		public function DirectionBtnEvent(_direction : String)
		{
			direction = _direction;
			super(DIRECTION_EVENT);
		}
		
	}
}