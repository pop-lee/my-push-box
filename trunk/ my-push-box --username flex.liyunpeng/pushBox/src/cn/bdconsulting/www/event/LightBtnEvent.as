package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class LightBtnEvent extends Event
	{
		public static const LIGHT_BTN_EVENT : String = "lightBtnEvent";
		
		public function LightBtnEvent()
		{
			super(LIGHT_BTN_EVENT);
		}
	}
}