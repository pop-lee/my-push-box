package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class PlayGameEvent extends Event
	{
		public static const SELECT_LEVEL_EVENT : String = "palyGameEvent";
		
		public var lv : int;
		
		public function PlayGameEvent(lv : int)
		{
			this.lv = lv;
			super(SELECT_LEVEL_EVENT);
		}
	}
}