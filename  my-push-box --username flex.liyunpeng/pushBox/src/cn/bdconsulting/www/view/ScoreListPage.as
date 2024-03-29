package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.event.ChangePageEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import com.qq.openapi.MttService;
	
	import flash.events.MouseEvent;
	
	public class ScoreListPage extends BdcContainer
	{
		private var _scoreCount : int = 10;
		
		private var _dataProvider : Vector.<int> = new Vector.<int>;
		
		private var _scoreListView : Array = new Array();
		
		public function ScoreListPage()
		{
			super();
			
			var textFieldY : int = 20;
			for(var i: int = 0;i<_scoreCount;i++) {
				var _textField : BdcLabel = new BdcLabel();
				_textField.text = "第" + (i+1) + "名";
				_textField.x = 40;
				_textField.y = textFieldY ;
				textFieldY = _textField.y + _textField.height + 7;
				_scoreListView.push(_textField);
				this.addChild(_textField);
			}
			
			
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
		
		public function set dataProvider(_arr : Vector.<int>) : void
		{
			_dataProvider = _arr;
			updateData();
		}
		
		private function updateData() : void
		{
			for(var k:int = 0;k<_scoreCount;k++) {
				(_scoreListView[k] as BdcLabel).text ="第" + (k+1) + "名" + "   " + ((_dataProvider.length<k+1)?0:_dataProvider[k]) + "分";
			}
		}
		
		private function toMainPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent(ChangePageEvent.CHANGE_PAGE_EVENT);
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			this.dispatchEvent(changePageEvent);
		}
	}
}