package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class OpenLevelEvent extends Event
	{
		public static const OPEN_LEVEL_EVENT : String = "openLevelEvent";
		
		public function OpenLevelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}