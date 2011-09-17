package cn.bdconsulting.www.object  
{
	import cn.bdconsulting.www.config.Config;
	import cn.bdconsulting.www.config.MapData;
	import cn.bdconsulting.www.event.DirectionBtnEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.view.BdcApplication;
	import cn.bdconsulting.www.view.BdcSprite;
	import cn.bdconsulting.www.view.Map;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author LiYunpeng
	 */
	[Embed(source="/lib/Roles.swf", symbol="Role")]
	public class Role extends Roles
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _map:Map;
		
		public var indexX : uint;
		public var indexY : uint;
		
		public function Role(map : Map) 
		{
			_map = map;
//			this.graphics.beginFill(0xff0000,0.5);
//			this.graphics.drawRect(0,0,Config.TILE_SIZE,Config.TILE_SIZE);
//			this.graphics.endFill();
			this.addEventListener(Event.ADDED_TO_STAGE,addEvent);
//			getPosition();
		}
		
		public function addEvent(event : Event) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,addEvent);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeEvent);
			BdcApplication.application.addEventListener(KeyboardEvent.KEY_DOWN, moveRole);
		}
		
		public function removeEvent(event : Event) : void
		{
			if(this.hasEventListener(Event.REMOVED_FROM_STAGE)) {
				this.removeEventListener(Event.REMOVED_FROM_STAGE,removeEvent);
			}
			if(stage.hasEventListener(KeyboardEvent.KEY_DOWN)) {
				BdcApplication.application.removeEventListener(KeyboardEvent.KEY_DOWN, moveRole);
			}
		}
		
		public function directionHandle(direction : uint) : void {
			switch(direction) {
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
				var baseIndexX:int = indexX;
				var baseIndexY:int = indexY;
				var nextIndexX:int = baseIndexX + px;
				var nextIndexY:int = baseIndexY + py;
				x += px*Config.TILE_SIZE;
				y += py*Config.TILE_SIZE;
				_map.rolesData[nextIndexY][nextIndexX] = _map.rolesData[baseIndexY][baseIndexX];
				_map.rolesData[baseIndexY][baseIndexX] = null;
				_map.mapData[nextIndexY][nextIndexX] = _map.mapData[baseIndexY][baseIndexX];
				_map.mapData[baseIndexY][baseIndexX] = _map.mapTileType[baseIndexY][baseIndexX];
				indexX = nextIndexX;
				indexY = nextIndexY;
				
				_map.step++;
				_map.checkSuccess();
			}
		}
		//1是墙壁,2是路,3是箱子,4是目的地
		private function canMove(px:int, py:int):Boolean {
			var nextIndexX:int = indexX + px;
			var nextIndexY:int = indexY + py;
			switch(_map.mapData[nextIndexY][nextIndexX]) {
				case MapData.WALL:return false;
				case MapData.ROAD:return true;
				case MapData.TARGET:return true;
				
				case MapData.BOX:{
					if(canBoxMove(nextIndexX,nextIndexY,px,py)) {
						moveBox(nextIndexX,nextIndexY,px,py);
						return true;
					}
				}
				case MapData.SPECIAL:{
					if(canBoxMove(nextIndexX,nextIndexY,px,py)) {
						moveBox(nextIndexX,nextIndexY,px,py);
						return true;
					}
				}
//				case MapData.ROLE:{}break;
			}
			return false;
		}
		private function canBoxMove(baseIndexX:int, baseIndexY:int, px:int, py:int):Boolean {
			var nextIndexX:int = baseIndexX + px;
			var nextIndexY:int = baseIndexY + py;
			switch(_map.mapData[nextIndexY][nextIndexX]) {
				case MapData.WALL:return false;
				case MapData.ROAD:return true;
				case MapData.TARGET:return true;
					
				case MapData.BOX:return false;
				case MapData.SPECIAL:return false;
//				case MapData.ROLE:{}break;
			}
			return false;
		}
		
		private function moveBox(baseIndexX:int, baseIndexY:int, px:int, py:int):void {
			var nextIndexX:int = baseIndexX + px;
			var nextIndexY:int = baseIndexY + py;
			_map.rolesData[baseIndexY][baseIndexX].x += px*Config.TILE_SIZE;
			_map.rolesData[baseIndexY][baseIndexX].y += py*Config.TILE_SIZE;
			_map.rolesData[nextIndexY][nextIndexX] = _map.rolesData[baseIndexY][baseIndexX];
			_map.rolesData[baseIndexY][baseIndexX] = null;
			_map.mapData[nextIndexY][nextIndexX] = _map.mapData[baseIndexY][baseIndexX];
			_map.mapData[baseIndexY][baseIndexX] = _map.mapTileType[baseIndexY][baseIndexX];
			if(_map.mapTileType[nextIndexY][nextIndexX] == MapData.TARGET) {
				(_map.rolesData[nextIndexY][nextIndexX] as Box).toTarget();
			}
		}
		
	}

}