package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.config.MapData;
	import cn.bdconsulting.www.event.PlayGameEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
	
	public class LevelList extends BdcContainer
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _btnArr : Vector.<LevelBtn> = new Vector.<LevelBtn>;
		
		private var lockLvClass : Class;
		private var unlockLvClass : Class;
		
		public function LevelList()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			lockLvClass = ModelLocator.getImageResource("lockLevel")
			unlockLvClass = ModelLocator.getImageResource("unLockLevel");
			
			build();
		}
		
		public function build() : void
		{
			var _lvCount : int = MapData.MAP.length;
			
			var _columnCount : int = 5;
			
			var _horizontalLeading : int = 0;
			var _verticalLeading : int = 3;
			
			var _bodyWidth : int = 43;
			var _bodyHeight : int = 38;
			
			this.width = _columnCount*_bodyWidth + (_columnCount-1)*_horizontalLeading;
			this.height = (int((_lvCount - 1)/_columnCount)+1)*_bodyHeight + ((_lvCount-1)/_columnCount)*_verticalLeading;
			
			clearBuild();
			
			for(var i : int = 0;i < _lvCount; i++) {
				var lvBtn : LevelBtn = new LevelBtn(i);
				lvBtn.width = _bodyWidth;
				lvBtn.height = _bodyHeight;
//				lvBtn.label = "";
				lvBtn.x = (i%_columnCount)*(lvBtn.width+_horizontalLeading);
				lvBtn.y = int(i/_columnCount)*(lvBtn.height + _verticalLeading);
				lvBtn.backgroundImage = i <= _model.unLockedLv?unlockLvClass:lockLvClass;
				lvBtn.addEventListener(MouseEvent.CLICK,playLv);
				_btnArr.push(lvBtn);
				addChild(lvBtn);
			}
			
		}
		
		private function clearBuild() : void
		{
			for each(var lvBtn : LevelBtn in _btnArr) {
				lvBtn.removeEventListener(MouseEvent.CLICK,playLv);
				_btnArr.splice(0,1);
				removeChild(lvBtn);
			}
		}
		
		private function playLv(event : MouseEvent) : void
		{
			var lv : int = event.currentTarget.lv;
			if(lv<=_model.unLockedLv) {
				this.dispatchEvent(new PlayGameEvent(event.currentTarget.lv));
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