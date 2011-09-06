package cn.bdconsulting.www.object  
{
	import cn.bdconsulting.www.event.DirectionBtnEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import cn.bdconsulting.www.view.BdcApplication;
	import cn.bdconsulting.www.view.BdcSprite;
	import cn.bdconsulting.www.view.Map;
	import cn.bdconsulting.www.config.Config;
	import cn.bdconsulting.www.config.MapData;
	
	/**
	 * ...
	 * @author 
	 */
	[Embed(source="/lib/Role.swf", symbol="Role")]
	public class Role extends BdcSprite
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _map:Map;
		
		public function Role(map:Map) 
		{
			_map = map;
//			this.graphics.beginFill(0xff0000,0.5);
//			this.graphics.drawRect(0,0,Config.TILE_SIZE,Config.TILE_SIZE);
//			this.graphics.endFill();
			getPosition();
			addEvent();
		}
		
		public function addEvent() : void
		{
			this.addEventListener(Event.REMOVED,removedHandle);
			BdcApplication.application.addEventListener(KeyboardEvent.KEY_DOWN, moveRole);
			BdcApplication.application.addEventListener(DirectionBtnEvent.DIRECTION_EVENT,directionHandle);
		}
		
		private function removedHandle(event : Event) : void
		{
			removeEvent();
		}
		
		public function removeEvent() : void
		{
			if(this.hasEventListener(Event.REMOVED)) {
				this.removeEventListener(Event.REMOVED,removedHandle);
			}
			if(stage.hasEventListener(KeyboardEvent.KEY_DOWN)) {
				BdcApplication.application.removeEventListener(KeyboardEvent.KEY_DOWN, moveRole);
			}
			if(stage.hasEventListener(DirectionBtnEvent.DIRECTION_EVENT)) {
				BdcApplication.application.removeEventListener(DirectionBtnEvent.DIRECTION_EVENT,directionHandle);
			}
		}
		
		private function directionHandle(event : DirectionBtnEvent) : void {
			if(event.direction == DirectionBtnEvent.LEFT) {
				move( -1, 0);
			} else if(event.direction == DirectionBtnEvent.RIGHT) {
				move(1, 0);
			} else if(event.direction == DirectionBtnEvent.TOP) {
				move(0, -1);
			} else if(event.direction == DirectionBtnEvent.BOTTOM) {
				move(0, 1);
			}
		}
		
		public function getPosition():void {
			for (var i:int = 0; i < MapData.MAP[_model.currentLv].length; i++) {
				for (var j:int = 0; j < MapData.MAP[_model.currentLv][i].length; j++) {
					//6是role位置
					if(MapData.MAP[_model.currentLv][i][j]==MapData.ROLE){
						x = j * Config.TILE_SIZE;
						y = i * Config.TILE_SIZE;
					}
				}
			}
		}
		private function moveRole(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37://left
					move( -1, 0);
					break;
				case 38://top
					move(0, -1);
					break;
				case 39://right
					move(1, 0);
					break;
				case 40://down
					move(0, 1);
					break;
				default:
					break;
			}
		}
		private function move(px:int, py:int):void {
			if (canMove(px,py)) {
				x += px * Config.TILE_SIZE;
				y += py * Config.TILE_SIZE;
				
				_map.step++;
			}
			_map.checkSuccess();
		}
		//1是墙壁,2是路,3是箱子,4是目的地
		private function canMove(px:int, py:int):Boolean {
			var nextPx:int = x / Config.TILE_SIZE + px;
			var nextPy:int = y / Config.TILE_SIZE + py;
			//移动范围超出和碰壁的情况
			if (isRoad(nextPy, nextPx)) {
				return true;
			}
			//前边是箱子
			else if (_map.getMapData()[nextPy][nextPx] == MapData.BOX || _map.getMapData()[nextPy][nextPx] == MapData.SPECIAL) {
				if (canBoxMove(nextPy, nextPx, py, px)) {
					moveBox(nextPy,nextPx,py,px);
					return true;
				}
			}
			return false;
		}
		private function canBoxMove(basePy:int, basePx:int, py:int, px:int):Boolean {
			var nextPx:int = basePx+px;
			var nextPy:int = basePy+py;
			if (isRoad(nextPy, nextPx)) {
				return true;
			}
			return false;
		}
		private function isRoad(nextPy:int, nextPx:int):Boolean {
			if (nextPy >= 0 && nextPx >= 0 && nextPy <= _map.getMapData().length && nextPx <= _map.getMapData()[0].length && (_map.getMapData()[nextPy][nextPx] == MapData.ROAD || _map.getMapData()[nextPy][nextPx] == MapData.TARGET || _map.getMapData()[nextPy][nextPx] == MapData.ROLE)) {
				return true;
			}
			return false;
		}
		private function moveBox(basePy:int, basePx:int, py:int, px:int):void {
			//如果当前格子不是目标点
			switch(MapData.MAP[_model.currentLv][basePy][basePx]) {
				//目标点
				case MapData.SPECIAL:
				case MapData.TARGET:
					_map.setMapData(basePy, basePx, MapData.TARGET);
					break;
				default:
					_map.setMapData(basePy, basePx, MapData.ROAD);
					break;
			}
			if(MapData.MAP[_model.currentLv][basePy+py][basePx+px]==MapData.TARGET||MapData.MAP[_model.currentLv][basePy+py][basePx+px]==MapData.SPECIAL) {
				_map.setMapData(basePy+py,basePx+px,MapData.SPECIAL);
			} 
			else {
				_map.setMapData(basePy+py,basePx+px,MapData.BOX);
			}
		}
		
	}

}