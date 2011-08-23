package
{
	import cn.bdconsulting.www.core.BdcContainer;
	import cn.bdconsulting.www.core.BdcScoreList;
	import cn.bdconsulting.www.core.BdcSprite;
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;

	public class ScoreList extends BdcContainer
	{
		private var _scoreCount : int = 5;
		
		private var _dataProvider : Array = new Array();
		
		private var _scoreListView : Array = new Array();
		
		public function ScoreList()
		{
			super();
//			this.width = stage.width;
//			this.height = stage.height;
//			this.graphics.beginFill(0xcccccc,0.8);
//			this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
//			this.graphics.endFill();
			
			
			var textFieldY : int = 5;
			for(var i: int = 0;i<_scoreCount;i++) {
				var _textField : TextField = new TextField();
				_textField.text = "第" + (i+1) + "名";
				_textField.x = 20;
				_textField.y = textFieldY ;
				textFieldY = _textField.y + _textField.textHeight + 10;
				_scoreListView.push(_textField);
				this.addChild(_textField);
			}
		}
		
		public function set dataProvider(_arr : Array) : void
		{
			_dataProvider = _arr;
			updateData();
		}
		
		private function updateData() : void
		{
			for(var k:int = 0;k<_scoreCount;k++) {
				(_scoreListView[k] as TextField).text ="第" + (k+1) + "名" + "   " + ((_dataProvider.length<k+1)?0:_dataProvider[k]) + "分";
			}
		}
	}
}