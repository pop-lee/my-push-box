package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.core.BdcButton;
	import cn.bdconsulting.www.core.BdcContainer;
	import cn.bdconsulting.www.core.BdcScoreList;
	import cn.bdconsulting.www.core.BdcSprite;
	import cn.bdconsulting.www.core.BdcTextField;
	import cn.bdconsulting.www.core.BdcViewStack;
	import cn.bdconsulting.www.event.ChangePageEvent;
	import cn.bdconsulting.www.event.DirectionBtnEvent;
	import cn.bdconsulting.www.event.OpenLevelEvent;
	import cn.bdconsulting.www.event.PlayGameEvent;
	import cn.bdconsulting.www.event.SuccessEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttService;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
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
		
		private var _levelList : LevelList;
		
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.backgroundImage = MttService.getSubResource("resourceURL") + "/levelBackground.png";
			initUI();
		}
		
		private function initUI() : void
		{
			
			var _levelListPanel : BdcContainer = new BdcContainer();
			_levelListPanel.percentWidth = 100;
			_levelListPanel.percentHeight = 100;
			_levelListPanel.backgroundAlpha = 0;
			this.addItem(_levelListPanel);
			
			_levelList = new LevelList();
			_levelList.backgroundAlpha = 0;
			_levelList.addEventListener(PlayGameEvent.SELECT_LEVEL_EVENT,selectLevelHandle);
			/////////////////////////////////
			var _backMainBtn1 : BdcButton = new BdcButton();
			_backMainBtn1.width = 100;
			_backMainBtn1.height = 30;
			_backMainBtn1.x = 5;
			_backMainBtn1.y = 300;
			_backMainBtn1.label = "";
			_backMainBtn1.backgroundImage = MttService.getSubResource("resourceURL") + "/returnBtn.png";
//			_backMainBtn1.backgroundAlpha = 0;
			_backMainBtn1.addEventListener(MouseEvent.CLICK,toMainPage);
			
			_levelListPanel.addChild(_levelList);
			_levelListPanel.addChild(_backMainBtn1);
			
			_model.stage.dispatchEvent(new OpenLevelEvent(OpenLevelEvent.OPEN_LEVEL_EVENT));
			
			
			
			var _gamePanel : BdcContainer = new BdcContainer();
			_gamePanel.percentWidth = 100;
			_gamePanel.percentHeight = 100;
			_gamePanel.backgroundImage = MttService.getSubResource("resourceURL") + "/gameBackground.png";
			this.addItem(_gamePanel);
			
			_map = new Map(_model.currentLv);
			_map.backgroundAlpha = 0;
			_map.addEventListener(SuccessEvent.SUCCESS_EVENT,successHandle);
			_gamePanel.addChild(_map);
			_map.lv = _model.currentLv;
			
			var _return2Btn : BdcSprite = new BdcSprite();
			_return2Btn.width = 240;
			_return2Btn.height = 51;
			_return2Btn.x = 0;
			_return2Btn.y = 295;
			_return2Btn.backgroundImage = MttService.getSubResource("resourceURL") + "/return_restart.png";
			var _backMainBtn2 : BdcButton = new BdcButton();
			_backMainBtn2.width = 90;
			_backMainBtn2.height = 30;
			_backMainBtn2.x = 15;
			_backMainBtn2.y = 300;
			_backMainBtn2.backgroundAlpha = 0;
			_backMainBtn2.label = "";
			_backMainBtn2.addEventListener(MouseEvent.CLICK,toLevelListPage);
			var _restartBtn : BdcButton = new BdcButton();
			_restartBtn.width = 90;
			_restartBtn.height = 30;
			_restartBtn.x = 145;
			_restartBtn.y = 300;
			_restartBtn.backgroundAlpha = 0;
			_restartBtn.label = "";
			_restartBtn.addEventListener(MouseEvent.CLICK,restartPlay);
			_gamePanel.addChild(_return2Btn);
			_gamePanel.addChild(_backMainBtn2);
			_gamePanel.addChild(_restartBtn);
			
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
			
			var topBtn : DirectionBtn = new DirectionBtn();
			topBtn.width = 36;
			topBtn.height = 36;
			topBtn.x = 36;
			topBtn.y = 0;
			topBtn.label = "";
			topBtn.backgroundImage = MttService.getSubResource("resourceURL") + "/up.png";
			topBtn.direction = DirectionBtnEvent.TOP;
			topBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(topBtn);
			var bottomBtn : DirectionBtn = new DirectionBtn();
			bottomBtn.width = 36;
			bottomBtn.height = 36;
			bottomBtn.x = 36;
			bottomBtn.y = 72;
			bottomBtn.label = "";
			bottomBtn.backgroundImage = MttService.getSubResource("resourceURL") + "/down.png";
			bottomBtn.direction = DirectionBtnEvent.BOTTOM;
			bottomBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(bottomBtn);
			var leftBtn : DirectionBtn = new DirectionBtn();
			leftBtn.width = 36;
			leftBtn.height = 36;
			leftBtn.x = 0;
			leftBtn.y = 36;
			leftBtn.label = "";
			leftBtn.backgroundImage = MttService.getSubResource("resourceURL") + "/left.png";
			leftBtn.direction = DirectionBtnEvent.LEFT;
			leftBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(leftBtn);
			var rightBtn : DirectionBtn = new DirectionBtn();
			rightBtn.width = 36;
			rightBtn.height = 36;
			rightBtn.y = 36;
			rightBtn.x = 72;
			rightBtn.label = "";
			rightBtn.backgroundImage = MttService.getSubResource("resourceURL") + "/right.png";
			rightBtn.direction = DirectionBtnEvent.RIGHT;
			rightBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(rightBtn);
			
			////////////////////////////////////////////////////////////////
			
			var successPage : SuccessPage = new SuccessPage();
			successPage.percentWidth = 100;
			successPage.percentHeight = 100;
			this.addItem(successPage);
			
			var _backMainBtn3 : BdcButton = new BdcButton();
			_backMainBtn3.width = 90;
			_backMainBtn3.height = 30;
			_backMainBtn3.x = 15;
			_backMainBtn3.y = 300;
//			_backMainBtn3.backgroundAlpha = 0;
			_backMainBtn3.label = "";
			_backMainBtn3.addEventListener(MouseEvent.CLICK,toLevelListPage);
			var _restartBtn2 : BdcButton = new BdcButton();
			_restartBtn2.width = 90;
			_restartBtn2.height = 30;
			_restartBtn2.x = 145;
			_restartBtn2.y = 260;
//			_restartBtn2.backgroundAlpha = 0;
			_restartBtn2.label = "";
			_restartBtn2.addEventListener(MouseEvent.CLICK,restartPlay);
			var _nextLvBtn : BdcButton = new BdcButton();
			_nextLvBtn.width = 90;
			_nextLvBtn.height = 30;
			_nextLvBtn.x = 145;
			_nextLvBtn.y = 300;
//			_nextLvBtn.backgroundAlpha = 0;
			_nextLvBtn.label = "";
			_nextLvBtn.addEventListener(MouseEvent.CLICK,nextLv);
			successPage.addChild(_backMainBtn3);
			successPage.addChild(_restartBtn2);
			successPage.addChild(_nextLvBtn);
			
//			_playBtn.text = "开始"
//			_playBtn.addEventListener(MouseEvent.CLICK,playBtnClickHandle);
//			_playBtn.x = stage.stageWidth - _playBtn.width - 10;
//			_playBtn.y = title.y - _playBtn.height - 2;
//			addChild(_playBtn);
			
//			_timer.addEventListener(TimerEvent.TIMER,timerHandle);
		}
		
		private function directionHandle(event : MouseEvent) : void
		{
			_model.stage.dispatchEvent(new DirectionBtnEvent(event.currentTarget.direction));
		}
		
		private function selectLevelHandle(event : PlayGameEvent) : void
		{
			this.selectedIndex = 1;
			_model.currentLv = event.lv;
			_map.lv = event.lv;
		}
		
		private function restartPlay(event : MouseEvent) : void
		{
			this.selectedIndex = 1;
			_map.lv = _model.currentLv;
//			_role.getPosition();
		}
		
		private function toMainPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent(ChangePageEvent.CHANGE_PAGE_EVENT);
			changePageEvent.data = ChangePageEvent.TO_MAIN_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
		private function toLevelListPage(event : MouseEvent) : void
		{
			this.selectedIndex = 0;
		}
		
		private function successHandle(event : SuccessEvent) : void
		{
			if(_model.scoreArr[_model.currentLv] < 200 - _map.time) {
				_model.scoreArr[_model.currentLv] = 200 - _map.time;
				ModelLocator.saveLv();
			}
			if(_model.unLockedLv < _model.currentLv+1) {
				_model.unLockedLv++;
			}
			_model.stage.dispatchEvent(new OpenLevelEvent(OpenLevelEvent.OPEN_LEVEL_EVENT));
			this.selectedIndex = 2;
		}
		
		private function nextLv(event : MouseEvent) : void
		{
			this.selectedIndex = 1;
			_map.lv = ++_model.currentLv;
		}
	}
}