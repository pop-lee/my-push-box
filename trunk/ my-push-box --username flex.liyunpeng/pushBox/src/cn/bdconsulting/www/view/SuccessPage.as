package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.core.BdcContainer;
	
	import com.qq.openapi.MttService;
	
	public class SuccessPage extends BdcContainer
	{
		public function SuccessPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.backgroundImage = MttService.getSubResource("resourceURL") + "/success.png";
			
			
		}
	}
}