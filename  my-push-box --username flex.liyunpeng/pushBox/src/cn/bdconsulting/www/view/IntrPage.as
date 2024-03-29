package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.event.ChangePageEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import com.qq.openapi.MttService;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class IntrPage extends BdcContainer
	{
		private var _intr : String = "" +
			"游戏说明：\n" +
			"■将所有箱子推到目的地即为过关。\n" +
			"■使用时间越少，则最后积分越高。\n" +
			"■我们将记录玩家每一关的最高记录，以算去所有以解锁的关卡的总分数进行排名。";
		
		private var label : BdcLabel = new BdcLabel();
		
		private var tf : TextFormat = new TextFormat();
		
		public function IntrPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			
			label.text = _intr;
			label.bold = true;
			label.wordWrap = true;
			label.color = 0xff0000;
			label.size = 14;
			label.width = 180;
			label.height = 180;
			label.x = 30;
			label.y = 60;
			addChild(label);
			
			var backMainBtn : BdcButton = new BdcButton();
			backMainBtn.width = 100;
			backMainBtn.height = 30;
			backMainBtn.x = 5;
			backMainBtn.y = 300;
//			backMainBtn.label = "";
			backMainBtn.backgroundImage = ModelLocator.getImageResource("returnBtn");
			backMainBtn.addEventListener(MouseEvent.CLICK,toMainPage);
			addChild(backMainBtn);
		}
		
		private function loadComplete(event : Event) :void
		{
//			this.backgroundImage = event.target.loader.content;
		}
		
		private function toMainPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent(ChangePageEvent.CHANGE_PAGE_EVENT);
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			this.dispatchEvent(changePageEvent);
		}
	}
}