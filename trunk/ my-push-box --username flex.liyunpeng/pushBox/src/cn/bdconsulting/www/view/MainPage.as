package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.core.BdcButton;
	import cn.bdconsulting.www.core.BdcContainer;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import cn.bdconsulting.www.event.ChangePageEvent;
	
	public class MainPage extends BdcContainer
	{
		public function MainPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			var loader : Loader = new Loader();
			loader.load(new URLRequest("resource/main.png"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
			
			var startGameBtn : BdcButton = new BdcButton();
			startGameBtn.width = 120;
			startGameBtn.height = 35;
			startGameBtn.x = 80;
			startGameBtn.y = 70;
			startGameBtn.addEventListener(MouseEvent.CLICK,toGamePage);
			this.addChild(startGameBtn);
			
			var gameIntrBtn : BdcButton = new BdcButton();
			gameIntrBtn.width = 130;
			gameIntrBtn.height = 35;
			gameIntrBtn.x = 27;
			gameIntrBtn.y = 111;
			gameIntrBtn.addEventListener(MouseEvent.CLICK,toIntrPage);
			this.addChild(gameIntrBtn);
			
			var scoreListBtn : BdcButton = new BdcButton();
			scoreListBtn.width = 130;
			scoreListBtn.height = 35;
			scoreListBtn.x = 90;
			scoreListBtn.y = 157;
			scoreListBtn.addEventListener(MouseEvent.CLICK,toScroeListPage);
			addChild(scoreListBtn);
			
			var exitBtn : BdcButton = new BdcButton();
			exitBtn.width = 130;
			exitBtn.height = 33;
			exitBtn.x = 40;
			exitBtn.y = 200;
			exitBtn.addEventListener(MouseEvent.CLICK,exitGame);
			addChild(exitBtn);
			
		}
		
		private function loadComplete(event : Event) : void
		{
			this.backgroundImage = event.target.loader.content;
		}
		
		private function toGamePage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent(ChangePageEvent.CHANGE_PAGE_EVENT);
			changePageEvent.data = ChangePageEvent.TO_GAME_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
		private function toIntrPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent(ChangePageEvent.CHANGE_PAGE_EVENT);
			changePageEvent.data = ChangePageEvent.TO_INTR_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
		private function toScroeListPage(event : MouseEvent) : void
		{
			var changePageEvent : ChangePageEvent = new ChangePageEvent(ChangePageEvent.CHANGE_PAGE_EVENT);
			changePageEvent.data = ChangePageEvent.TO_SCORELIST_PAGE;
			this.dispatchEvent(changePageEvent);
		}
		
		private function exitGame(event : MouseEvent) : void
		{
			
		}
	}
}