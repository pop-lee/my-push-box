package
{
	import cn.bdconsulting.www.core.BdcContainer;
	import cn.bdconsulting.www.core.BdcViewStack;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	[SWF(width="240", height="320", backgroundColor="#cccccc")]
	public class PushBox extends BdcContainer
	{
		private var mainPage : BdcViewStack = new BdcViewStack()
		
		private var intrPage : IntrPage = new IntrPage();
		
		private var gamePanel : BdcContainer = new BdcContainer();
		
		private var scoreList : ScoreList = new ScoreList();
		
		
		public function PushBox()
		{
			init();
		}
		
		private function init() : void
		{
			this.addEventListener(MouseEvent.CLICK,clickHandle);
			
			this.width = stage.stageWidth;
			this.height = stage.stageHeight;
			mainPage.percentWidth = 100;
			mainPage.percentHeight = 100;
			this.addChild(mainPage);
			
			intrPage.percentWidth = 100;
			intrPage.percentHeight = 100;
			intrPage.backgroundColor = 0xff0000;
			mainPage.addItem(intrPage);
			
			gamePanel.percentWidth = 100;
			gamePanel.percentHeight = 100;
			gamePanel.backgroundColor = 0x00ff00;
			mainPage.addItem(gamePanel);
			
			scoreList.percentWidth = 100;
			scoreList.percentHeight = 100;
			scoreList.backgroundColor = 0x0000ff;
			mainPage.addItem(scoreList);
		}
		
		private function clickHandle(event : MouseEvent) : void
		{
			if(mainPage.selectedIndex < mainPage.children.length-1) {
				mainPage.selectedIndex ++;
			}
		}
	}
}