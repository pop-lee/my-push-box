package cn.bdconsulting.www.event
{
	import flash.events.Event;
	
	public class UnLightBtnEvent extends Event
	{
		public static const UNLIGHT_BTN_EVENT : String = "unLightBtnEvent";
		
		public function UnLightBtnEvent()
		{
			super(UNLIGHT_BTN_EVENT);
		}
	}
}