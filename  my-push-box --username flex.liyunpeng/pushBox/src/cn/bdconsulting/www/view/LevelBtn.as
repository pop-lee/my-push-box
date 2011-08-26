package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.core.BdcButton;
	
	import com.qq.openapi.MttService;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class LevelBtn extends BdcButton
	{
		private var _lv : int;
		
		private var _loader : Loader = new Loader();
		
		public function LevelBtn(lv : int) : void
		{
			super();
			_lv = lv;
			
			this.backgroundImage = MttService.getSubResource("resourceURL") + "/lockLevel.png";
		}
		
		public function get lv() : int
		{
			return _lv;
		}
		
		public function openLv() : void
		{
			
		}
		
		public function openLvBtn() : void
		{
			this.backgroundImage = MttService.getSubResource("resourceURL") + "/unLockLevel.png";
		}
	}
}