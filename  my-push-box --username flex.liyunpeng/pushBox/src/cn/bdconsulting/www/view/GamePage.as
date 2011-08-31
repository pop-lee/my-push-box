package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.config.MapData;
	import cn.bdconsulting.www.event.ChangePageEvent;
	import cn.bdconsulting.www.event.DirectionBtnEvent;
	import cn.bdconsulting.www.event.LightBtnEvent;
	import cn.bdconsulting.www.event.OpenLevelEvent;
	import cn.bdconsulting.www.event.PlayGameEvent;
	import cn.bdconsulting.www.event.SuccessEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.object.Role;
	
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
		
		private var _levelList : LevelList;
		
		private var successPage : SuccessPage;
		
		public function GamePage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			this.backgroundImage = ModelLocator.getImageResource("levelBackground");
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
//			_backMainBtn1.label = "";
			_backMainBtn1.backgroundImage = ModelLocator.getImageResource("returnBtn");
//			_backMainBtn1.backgroundAlpha = 0;
			_backMainBtn1.addEventListener(MouseEvent.CLICK,toMainPage);
			
			_levelListPanel.addChild(_levelList);
			_levelListPanel.addChild(_backMainBtn1);
			
			BdcApplication.application.dispatchEvent(new OpenLevelEvent(OpenLevelEvent.OPEN_LEVEL_EVENT));
			
			
			
			var _gamePanel : BdcContainer = new BdcContainer();
			_gamePanel.percentWidth = 100;
			_gamePanel.percentHeight = 100;
			_gamePanel.backgroundImage = ModelLocator.getImageResource("gameBackground");
			this.addItem(_gamePanel);
//			
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
			_return2Btn.backgroundImage = ModelLocator.getImageResource("return_restart");
			var _backMainBtn2 : BdcButton = new BdcButton();
			_backMainBtn2.width = 90;
			_backMainBtn2.height = 30;
			_backMainBtn2.x = 15;
			_backMainBtn2.y = 300;
			_backMainBtn2.backgroundAlpha = 0;
//			_backMainBtn2.label = "";
			_backMainBtn2.addEventListener(MouseEvent.CLICK,toLevelListPage);
			var _restartBtn : BdcButton = new BdcButton();
			_restartBtn.width = 90;
			_restartBtn.height = 30;
			_restartBtn.x = 145;
			_restartBtn.y = 300;
			_restartBtn.backgroundAlpha = 0;
//			_restartBtn.label = "";
			_restartBtn.addEventListener(MouseEvent.CLICK,restartPlay);
			_gamePanel.addChild(_return2Btn);
			_gamePanel.addChild(_backMainBtn2);
			_gamePanel.addChild(_restartBtn);
			
			//方向键
//			var directionBtn : BdcSprite = new BdcSprite();
//			directionBtn.backgroundImage = ModelLocator.getImageResource("direction");
//			_gamePanel.addChild(directionBtn);
			
			var size : int = 80;
			
			
			var topBtn : DirectionBtn = new DirectionBtn();
			topBtn.width = size;
			topBtn.height = size;
			topBtn.x = 80;
			topBtn.y = 0;
//			topBtn.label = "";
//			topBtn.backgroundAlpha = 0;
			topBtn.icon = ModelLocator.getImageResource("Up");
			topBtn.direction = DirectionBtnEvent.TOP;
			topBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(topBtn);
			var bottomBtn : DirectionBtn = new DirectionBtn();
			bottomBtn.width = size;
			bottomBtn.height = size;
			bottomBtn.x = 80;
			bottomBtn.y = 220;
//			bottomBtn.label = "";
//			bottomBtn.backgroundAlpha = 0;
			bottomBtn.icon = ModelLocator.getImageResource("Down");
			bottomBtn.direction = DirectionBtnEvent.BOTTOM;
			bottomBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(bottomBtn);
			var leftBtn : DirectionBtn = new DirectionBtn();
			leftBtn.width = size;
			leftBtn.height = size;
			leftBtn.x = 0;
			leftBtn.y = 110;
//			leftBtn.label = "";
//			leftBtn.backgroundAlpha = 0;
			leftBtn.icon = ModelLocator.getImageResource("Left");
			leftBtn.direction = DirectionBtnEvent.LEFT;
			leftBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(leftBtn);
			var rightBtn : DirectionBtn = new DirectionBtn();
			rightBtn.width = size;
			rightBtn.height = size;
			rightBtn.x = 160;
			rightBtn.y = 110;
//			rightBtn.label = "";
//			rightBtn.backgroundAlpha = 0;
			rightBtn.icon = ModelLocator.getImageResource("Right");
			rightBtn.direction = DirectionBtnEvent.RIGHT;
			rightBtn.addEventListener(MouseEvent.MOUSE_DOWN,directionHandle);
			_gamePanel.addChild(rightBtn);
//			
//			////////////////////////////////////////////////////////////////
			
			successPage = new SuccessPage();
			successPage.percentWidth = 100;
			successPage.percentHeight = 100;
			this.addItem(successPage);
			
			var _backMainBtn3 : BdcButton = new BdcButton();
			_backMainBtn3.width = 49;
			_backMainBtn3.height = 24;
			_backMainBtn3.x = 23;
			_backMainBtn3.y = 293;
			_backMainBtn3.backgroundAlpha = 0;
//			_backMainBtn3.label = "";
			_backMainBtn3.addEventListener(MouseEvent.CLICK,toLevelListPage);
			var _restartBtn2 : BdcButton = new BdcButton();
			_restartBtn2.width = 97;
			_restartBtn2.height = 35;
			_restartBtn2.x = 113;
			_restartBtn2.y = 240;
			_restartBtn2.backgroundAlpha = 0;
//			_restartBtn2.label = "";
			_restartBtn2.addEventListener(MouseEvent.CLICK,restartPlay);
			var _nextLvBtn : BdcButton = new BdcButton();
			_nextLvBtn.width = 97;
			_nextLvBtn.height = 35;
			_nextLvBtn.x = 113;
			_nextLvBtn.y = 283;
			_nextLvBtn.backgroundAlpha = 0;
//			_nextLvBtn.label = "";
			_nextLvBtn.addEventListener(MouseEvent.CLICK,nextLv);
			successPage.addChild(_backMainBtn3);
			successPage.addChild(_restartBtn2);
			successPage.addChild(_nextLvBtn);
			
		}
		
		private function directionHandle(event : MouseEvent) : void
		{
			BdcApplication.application.dispatchEvent(new DirectionBtnEvent(event.currentTarget.direction));
		}
		
		private function selectLevelHandle(event : PlayGameEvent) : void
		{
			this.selectedIndex = 1;
			BdcApplication.application.dispatchEvent(new LightBtnEvent());
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
			var lvScore : int = 200 - _map.time;
			if(_model.currentLv+1 != MapData.MAP.length && _model.unLockedLv < _model.currentLv+1) {
				_model.unLockedLv++;
			}
			if(_model.scoreArr[_model.currentLv] < lvScore) {
				_model.scoreArr[_model.currentLv] = lvScore;
				ModelLocator.saveLv();
				ModelLocator.submitScore();
			}
			BdcApplication.application.dispatchEvent(new OpenLevelEvent(OpenLevelEvent.OPEN_LEVEL_EVENT));
			successPage.setData(_map.time,_map.step,lvScore);
			this.selectedIndex = 2;
		}
		
		private function nextLv(event : MouseEvent) : void
		{
			this.selectedIndex = 1;
			BdcApplication.application.dispatchEvent(new LightBtnEvent());
			if(_model.currentLv + 1 == MapData.MAP.length) {
				_map.lv = _model.currentLv = 0;
			} else {
				_map.lv = ++_model.currentLv;
			}
		}
	}
}