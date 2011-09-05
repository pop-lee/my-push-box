package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.tools.NumberImage;
	
	import com.qq.openapi.MttService;
	
	import flashx.textLayout.formats.TextAlign;
	
	public class SuccessPage extends BdcContainer
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _time : int = 0;
		private var _step : int = 0;
		private var _score : int = 0;
		
		public function SuccessPage()
		{
			super();
			init();
		}
		
		private var stepBar : BdcSprite = new BdcSprite();
		private var timeBar : BdcSprite = new BdcSprite();
		private var scoreBar : BdcSprite = new BdcSprite();
		private function init() : void
		{
			this.backgroundImage = ModelLocator.getImageResource("successPage");
			
//			stepBar.textAlign = TextAlign.RIGHT;
//			stepBar.size = 20;
//			stepBar.x = 20;
			stepBar.y = 123;
//			stepBar.width = 95;
//			stepBar.height = 26;
			addChild(stepBar);
			
//			timeBar.textAlign = TextAlign.RIGHT;
//			timeBar.size = 20;
//			timeBar.x = 20;
			timeBar.y = 156;
//			timeBar.width = 95;
//			timeBar.height = 26;
			addChild(timeBar);
			
//			scoreBar.textAlign = TextAlign.RIGHT;
//			scoreBar.size = 20;
//			scoreBar.x = 65;
			scoreBar.y = 192;
//			scoreBar.width = 50;
//			scoreBar.height = 26;
			addChild(scoreBar);
			
		}
		
		public function setData(time : int,step : int,score : int) : void {
//			timeBar.text = time.toString();
//			stepBar.text = step.toString();
//			scoreBar.text = score.toString();
			timeBar.drawBackgroundImage(NumberImage.getNumberImage(time).bitmapData);
			timeBar.x = 112 - NumberImage.getNumberImage(time).width;
			stepBar.drawBackgroundImage(NumberImage.getNumberImage(step).bitmapData);
			stepBar.x = 112 - NumberImage.getNumberImage(step).width;
			scoreBar.drawBackgroundImage(NumberImage.getNumberImage(score).bitmapData);
			scoreBar.x = 112 - NumberImage.getNumberImage(score).width;
		}
	}
}