package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class SuccessEvent extends Event
	{
		public static const SUCCESS_EVENT : String = "successEvent";
		
		public function SuccessEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}