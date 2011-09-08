package
{
	import cn.bdconsulting.www.core.BdcLogEvent;
	import cn.bdconsulting.www.event.BdcInitializeDataEvent;
	import cn.bdconsulting.www.event.ChangePageEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.view.BDCLogo;
	import cn.bdconsulting.www.view.BdcAlert;
	import cn.bdconsulting.www.view.BdcApplication;
	import cn.bdconsulting.www.view.BdcContainer;
	import cn.bdconsulting.www.view.BdcLabel;
	import cn.bdconsulting.www.view.BdcSprite;
	import cn.bdconsulting.www.view.BdcTextField;
	import cn.bdconsulting.www.view.BdcViewStack;
	import cn.bdconsulting.www.view.GamePage;
	import cn.bdconsulting.www.view.IntrPage;
	import cn.bdconsulting.www.view.MainPage;
	import cn.bdconsulting.www.view.ScoreListPage;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttService;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import org.osmf.image.ImageLoader;
	
	[SWF(width="240", height="330", backgroundColor="#cccccc")]
	public class PushBox extends BdcApplication
	{
		private var logo : BDCLogo = new BDCLogo();
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var vs : BdcViewStack = new BdcViewStack();
		
		private var mainPage : MainPage ;
		
		private var intrPage : IntrPage ;
		
		private var gamePanel : GamePage ;
		
		private var scoreList : ScoreListPage ;
		
		public function PushBox()
		{
			addChild(logo);
		}
		
		private var timer : Timer = new Timer(5);
		override protected function init() : void
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			MttService.initialize(root, "D5FE393C02DB836FFDE413B8794056ED","133");
			MttService.addEventListener(MttService.ETLOGOUT, onLogout);
			MttService.putSubResource("resourceURL","resource","/pushBox/resource");
			
			timer.addEventListener(TimerEvent.TIMER,hideLogo);
			
			vs.alpha = 0;
			vs.percentWidth = 100;
			vs.percentHeight = 100;
			addChild(vs);
			
			_model.log.width = 240;
			_model.log.height = 320;
			_model.log.wordWrap = true;
			_model.log.x = 10;
			_model.log.y = 10;
			addChild(_model.log);
			_model.log.backgroundAlpha = 1;
			_model.log.backgroundImage = 0xffffff;
			_model.log.addEventListener(MouseEvent.MOUSE_DOWN,function tmp(event : MouseEvent) : void{
				_model.log.visible = false;
			});
			
			initData();
		}
		
		private function initData() : void
		{
			BdcApplication.application.addEventListener(BdcInitializeDataEvent.INITIALIZE_DATA_EVENT,loadResource);
			ModelLocator.initData();
		}
		
		private function loadResource(event : BdcInitializeDataEvent) : void
		{
			BdcApplication.application.removeEventListener(BdcInitializeDataEvent.INITIALIZE_DATA_EVENT,loadResource);
			_model.resourceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadResourceCompleteHandle);
			_model.resourceLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progressHandle);
			_model.resourceLoader.load(new URLRequest(MttService.getSubResource("resourceURL") + "/pushBoxResource.swf"));
		}
		
		private function loadResourceCompleteHandle(event : Event) : void
		{
			var cls : Class = _model.resourceLoader.contentLoaderInfo.applicationDomain.getDefinition("Alert") as Class;
			var cls2 : Class = _model.resourceLoader.contentLoaderInfo.applicationDomain.getDefinition("OKBtn") as Class;
			
			BdcAlert.background = cls;
			BdcAlert.okBtn = cls2;
			BdcAlert.show("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			BdcAlert.show("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			BdcAlert.show("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			BdcAlert.show("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
			timer.start();
			initUI();
			_model.resourceLoader.unload();
			
		}
		
		private function progressHandle(event : ProgressEvent) : void
		{
			var loadPro : int = int(event.bytesLoaded/event.bytesTotal*100);
			if(loadPro > 100) loadPro = 100;
			_model.log.text += "加载资源……  " + loadPro + "%" + "\n";
		}
		
		private function hideLogo(event : TimerEvent) : void
		{
			if(logo.alpha < 0 && vs.alpha > 1) {
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,hideLogo);
				removeChild(logo);
				logo = null;
			} else {
				logo.alpha -=0.2;
				vs.alpha += 0.2;
			}
		}
		
		private function initUI() : void
		{
			
			mainPage = new MainPage();
			mainPage.percentWidth = 100;
			mainPage.percentHeight = 100;
			mainPage.backgroundImage = ModelLocator.getImageResource("main");
			mainPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(mainPage);
			
			gamePanel = new GamePage();
			gamePanel.percentWidth = 100;
			gamePanel.percentHeight = 100;
			gamePanel.backgroundAlpha = 0;
			gamePanel.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(gamePanel);
			
			intrPage = new IntrPage();
			intrPage.percentWidth = 100;
			intrPage.percentHeight = 100;
			intrPage.backgroundAlpha = 0;
			intrPage.backgroundImage = ModelLocator.getImageResource("background");
			intrPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(intrPage);
			
			scoreList = new ScoreListPage();
			scoreList.percentWidth = 100;
			scoreList.percentHeight = 100;
			scoreList.backgroundAlpha = 0;
			scoreList.backgroundImage = ModelLocator.getImageResource("background");
			scoreList.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(scoreList);
		}
		
		public function changePageHandle(event : ChangePageEvent):void
		{
			if(event.data == ChangePageEvent.TO_SCORELIST_PAGE) {
				scoreList.dataProvider = _model.topScoreArr;
			} else if(event.data == ChangePageEvent.EXIT) {
				
			}
			vs.selectedIndex = event.data;
		}
		
		private function onLogout(e:Event):void
		{
			MttService.login();
		}
		
	}
}