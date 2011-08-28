package
{
	import cn.bdconsulting.www.core.BdcLogEvent;
	import cn.bdconsulting.www.event.ChangePageEvent;
	import cn.bdconsulting.www.model.ModelLocator;
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
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import org.osmf.image.ImageLoader;
	
	[SWF(width="240", height="330", backgroundColor="#cccccc")]
	public class PushBox extends BdcApplication
	{
		[Embed(source="resource/logo.png")]
		private var logo : Class;
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var vs : BdcViewStack = new BdcViewStack();;
		
		private var mainPage : MainPage ;
		
		private var intrPage : IntrPage ;
		
		private var gamePanel : GamePage ;
		
		private var scoreList : ScoreListPage ;
		
		
		public function PushBox()
		{
		}
		
		private var _logo : BdcSprite = new BdcSprite();
		private var timer : Timer = new Timer(10);
		override protected function init() : void
		{
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			MttService.initialize(root, "D5FE393C02DB836FFDE413B8794056ED","133");
			MttService.addEventListener(MttService.ETLOGOUT, onLogout);
			MttService.putSubResource("resourceURL","resource","/pushBox/resource");
			
			_logo.percentWidth = 100;
			_logo.percentHeight = 100;
			_logo.backgroundImage = (new logo()) as Bitmap;
			addChild(_logo);
			timer.addEventListener(TimerEvent.TIMER,hideLogo);
			
			
			_model.resourceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadResourceCompleteHandle);
			_model.resourceLoader.load(new URLRequest(MttService.getSubResource("resourceURL") + "/pushBoxResource.swf"));
			
//			var log : BdcTextField = new BdcTextField();
//			log.text = ModelLocator.getImageResource("logo.png");
//			log.width = 240;
//			log.height = 20;
//			log.x = 0;
//			log.y = 100;
//			addChild(log);
			
		}
		
		private function loadResourceCompleteHandle(event : Event) : void
		{
			timer.start();
			initData();
			initUI();
		}
		
		private function initData() : void
		{
			ModelLocator.initData();
		}
		
		private function hideLogo(event : TimerEvent) : void
		{
			if(_logo.alpha < 0 && vs.alpha > 1) {
				timer.stop();
				removeChild(_logo);
			} else {
				_logo.alpha -=0.1;
				vs.alpha += 0.1;
			}
		}
		
		private function initUI() : void
		{
			vs.alpha = 0;
			vs.percentWidth = 100;
			vs.percentHeight = 100;
			addChild(vs);
			
			mainPage = new MainPage();
			mainPage.percentWidth = 100;
			mainPage.percentHeight = 100;
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
			intrPage.backgroundImage = ModelLocator.getImageResource("background.png");
			intrPage.addEventListener(ChangePageEvent.CHANGE_PAGE_EVENT,changePageHandle);
			vs.addItem(intrPage);
			
			scoreList = new ScoreListPage();
			scoreList.percentWidth = 100;
			scoreList.percentHeight = 100;
			scoreList.backgroundAlpha = 0;
			scoreList.backgroundImage = ModelLocator.getImageResource("background.png");
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