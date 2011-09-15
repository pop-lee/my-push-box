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
		
		private var stepBar : BdcTextField = new BdcTextField();
		private var timeBar : BdcTextField = new BdcTextField();
		private var scoreBar : BdcTextField = new BdcTextField();
		private function init() : void
		{
			this.backgroundImage = ModelLocator.getImageResource("successPage");
			
//			stepBar.textAlign = TextAlign.RIGHT;
//			stepBar.text = " ";
//			stepBar.size = 20;
			stepBar.width = 95;
			stepBar.height = 26;
			stepBar.x = 20;
			stepBar.y = 105;
			addChild(stepBar);
			
//			timeBar.textAlign = TextAlign.RIGHT;
//			timeBar.text = " ";
//			timeBar.size = 20;
			timeBar.width = 95;
			timeBar.height = 26;
			timeBar.x = 20;
			timeBar.y = 153;
			addChild(timeBar);
			
//			scoreBar.textAlign = TextAlign.RIGHT;
//			timeBar.text = " ";
//			scoreBar.size = 20;
			scoreBar.width = 50;
			scoreBar.height = 26;
			scoreBar.x = 65;
			scoreBar.y = 203;
			addChild(scoreBar);
			
		}
		
		public function setData(time : int,step : int,score : int) : void {
			stepBar.text = step.toString();
			timeBar.text = time.toString();
			scoreBar.text = score.toString();
//			timeBar.drawBackgroundImage(NumberImage.getNumberImage(time).bitmapData);
//			stepBar.drawBackgroundImage(NumberImage.getNumberImage(step).bitmapData);
//			scoreBar.drawBackgroundImage(NumberImage.getNumberImage(score).bitmapData);
//			stepBar.x = 112 - NumberImage.getNumberImage(step).width;
//			timeBar.x = 112 - NumberImage.getNumberImage(time).width;
//			scoreBar.x = 112 - NumberImage.getNumberImage(score).width;
		}
	}
}