package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.core.BdcButton;
	import cn.bdconsulting.www.core.BdcContainer;
	import cn.bdconsulting.www.core.BdcTextField;
	import cn.bdconsulting.www.core.BdcViewStack;
	import cn.bdconsulting.www.event.ChangePageEvent;
	import cn.bdconsulting.www.event.SuccessEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
	
	public class GamePage extends BdcViewStack
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _map:Map;
		
		private var _role:Role ;
		
		private var topBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.TOP);
		private var bottomBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.BOTTOM);
		private var leftBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.LEFT);
		private var rightBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.RIGHT);
		
		private var _playBtn : PlayButton = new PlayButton();
		
		private var _restartBtn : TouchBtn = new TouchBtn();
		
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			_map = new Map(_model.lv);
			_map.backgroundAlpha = 0;
//			_map.backgroundColor = 0xff0000;
			this.addItem(_map);
			_map.lv = _model.lv;
			_map.addEventListener(SuccessEvent.SUCCESS_EVENT,successHandle);
//			
			_role = new Role(_map);
			_map.addChild(_role);
			
//			var title : BdcTextField = new BdcTextField();
//			title.text = "大连尚嘉";
//			title.x = stage.stageWidth - title.width;
//			title.y = stage.stageHeight - title.textHeight - 2;
//			addChild(title);
			
//			_scoreBar.text = "0秒";
//			_scoreBar.width = _scoreBar.textWidth + 10;
//			_scoreBar.x = stage.stageWidth - _scoreBar.width;
//			_scoreBar.y = 5;
//			addChild(_scoreBar);
			
//			topBtn.x = (this.width - topBtn.width)/2;
//			topBtn.y = 5;
//			topBtn.visible = false;
//			addChild(topBtn);
//			bottomBtn.x = (this.width - bottomBtn.width)/2;
//			bottomBtn.y = this.height - bottomBtn.height - 2;
//			bottomBtn.visible = false;
//			addChild(bottomBtn);
//			leftBtn.y = (this.height - leftBtn.height)/2;
//			leftBtn.x = 5;
//			leftBtn.visible = false;
//			addChild(leftBtn);
//			rightBtn.y = (this.height - rightBtn.height)/2;
//			rightBtn.x = this.width - rightBtn.width - 5;
//			rightBtn.visible = false;
//			addChild(rightBtn);
			
//			_playBtn.text = "开始"
//			_playBtn.addEventListener(MouseEvent.CLICK,playBtnClickHandle);
//			_playBtn.x = stage.stageWidth - _playBtn.width - 10;
//			_playBtn.y = title.y - _playBtn.height - 2;
//			addChild(_playBtn);
			
			_restartBtn.text = "重玩此关";
			_restartBtn.x = 5;
			_restartBtn.y = _playBtn.y;
//			_restartBtn.addEventListener(MouseEvent.CLICK,restartPlay);
			_restartBtn.visible = false;
			addChild(_restartBtn);
			
//			_timer.addEventListener(TimerEvent.TIMER,timerHandle);
			
			var backMainBtn : BdcButton = new BdcButton();
			backMainBtn.width = 100;
			backMainBtn.height = 30;
			backMainBtn.x = 5;
			backMainBtn.y = 300;
			backMainBtn.addEventListener(MouseEvent.CLICK,toMainPage);
			addChild(backMainBtn);
			
		}
		
		private function toMainPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent(ChangePageEvent.CHANGE_PAGE_EVENT);
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
		private function successHandle(event : SuccessEvent) : void
		{
			_model.lv ++;
			_map.lv = _model.lv;
			_role.getPosition();
//			_role = new Role(_map);
//			_map.addChild(_role);
		}
	}
}