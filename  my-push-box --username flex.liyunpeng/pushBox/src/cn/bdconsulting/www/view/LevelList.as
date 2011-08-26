package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.core.BdcButton;
	import cn.bdconsulting.www.core.BdcContainer;
	import cn.bdconsulting.www.event.OpenLevelEvent;
	import cn.bdconsulting.www.event.PlayGameEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
	
	public class LevelList extends BdcContainer
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _btnArr : Vector.<LevelBtn> = new Vector.<LevelBtn>;
		
		public function LevelList()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			_model.stage.addEventListener(OpenLevelEvent.OPEN_LEVEL_EVENT,openLevelHandle);
			
			var _lvCount : int = MapData.MAP.length;
			
			var _columnCount : int = 5;
			
			var _horizontalLeading : int = 0;
			var _verticalLeading : int = 3;
			
			var _bodyWidth : int = 43;
			var _bodyHeight : int = 38;
			
			this.width = _columnCount*_bodyWidth + (_columnCount-1)*_horizontalLeading;
			this.height = ((_lvCount/_columnCount)+1)*_bodyHeight + (_lvCount/_columnCount)*_verticalLeading;
			
			for(var i : int = 0;i < _lvCount; i++) {
				var lvBtn : LevelBtn = new LevelBtn(i);
				lvBtn.width = _bodyWidth;
				lvBtn.height = _bodyHeight;
				lvBtn.label = "";
				lvBtn.x = (i%_columnCount)*(lvBtn.width+_horizontalLeading);
				lvBtn.y = int(i/_columnCount)*(lvBtn.height + _verticalLeading);
				lvBtn.addEventListener(MouseEvent.CLICK,playLv);
				_btnArr.push(lvBtn);
				addChild(lvBtn);
			}
			
		}
		
		private function playLv(event : MouseEvent) : void
		{
			var lv : int = event.currentTarget.lv;
			if(lv<=_model.unLockedLv) {
				this.dispatchEvent(new PlayGameEvent(event.currentTarget.lv));
			}
		}
		
		public function openLevelHandle(event : OpenLevelEvent) : void
		{
			for(var i : int = 0; i <= _model.unLockedLv;i++) {
				_btnArr[i].openLvBtn();
			}
		}
		
		override public function set parentWidth(value:Number):void
		{
			super.parentWidth = value;
			this.x = (value - this.width)/2;
		}
		override public function set parentHeight(value:Number):void
		{
			super.parentHeight = value;
			this.y = (value - this.height)/2;
		}
	}
	
}