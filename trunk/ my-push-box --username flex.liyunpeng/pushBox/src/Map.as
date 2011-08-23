package  
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.System;
	
	/**
	 * ...
	 * @author DFdou
	 */
	public class Map extends Sprite
	{
		private var _lv:uint;//关卡
		private var _mapData:Array = [];//map数据
		
		public function Map(lv:uint=0)
		{
//			Sokoban._lv = lv;
			initMapData(lv);
		}
		private function initMapData(lv:uint = 0) : void {
			_mapData = [];
			for (var i :int = 0; i < MapData.MAP[lv].length; i++) {
				_mapData[i] = [];
				for (var j:int = 0; j < MapData.MAP[lv][i].length; j++) {
					_mapData[i][j] = MapData.MAP[lv][i][j];
				}
			}
			drawMap();
		}
		private function drawMap() : void {
			var tile:Tile;
			for (var i:int = 0; i < _mapData.length; i++) {
				for (var j:int = 0; j < _mapData[i].length; j++) {
					if(_mapData[i][j]!=0){
						tile = new Tile();
						tile.x = j * Config.TILE_SIZE;
						tile.y = i * Config.TILE_SIZE;
//						var loader : Loader = new Loader();
//						if(_mapData[i][j]!=0)
//							loader.load(new URLRequest("assets/" + Config.IMG_ARR[_mapData[i][j]-1]));
//						tile.addChild(loader);
						tile.gotoAndStop(_mapData[i][j]);
						addChild(tile);
					}
				}
			}
		}
		private function repaintMap():void {
			clearMap();
			drawMap();
		}
		private function clearMap():void {
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
		private function checkSuccess():void {
			if(isSuccess()){
				trace("Success");
				this.dispatchEvent(new Event(Sokoban.SUCCESS_EVENT));
			}
		}
		private function isSuccess():Boolean {
			var success:Boolean = true;
			for (var i:int = 0; i < MapData.MAP[Sokoban._lv].length; i++) {
				for (var j:int = 0; j < MapData.MAP[Sokoban._lv][i].length; j++) {
					//4是目标点
					if (MapData.MAP[Sokoban._lv][i][j] == MapData.TARGET || MapData.MAP[Sokoban._lv][i][j] == MapData.SPECIAL) {
						if ((_mapData[i][j] == MapData.BOX || _mapData[i][j] == MapData.SPECIAL)) {
							trace(i,j,_mapData[i][j]);
						}
						success = success && (_mapData[i][j]==MapData.BOX || _mapData[i][j]==MapData.SPECIAL);
					}
				}
			}
			return success;
		}
//		private function nextLevel() : void {
//			changeLv(++Sokoban._lv);
//		}
		
		public function setMapData(py:int, px:int, type:int):void {
			_mapData[py][px] = type;
			//trace(py,px,_mapData[py][px]);
			repaintMap();
			checkSuccess();
		}
		public function getMapData():Array {
			return _mapData;
		}
		
		public function changeLv(lv:uint) : void {
			this.x = (stage.stageWidth - MapData.MAP[lv][0].length*Config.TILE_SIZE)/2;
			this.y = (stage.stageHeight - MapData.MAP[lv].length*Config.TILE_SIZE)/2;
			initMapData(lv);
			repaintMap();
		}
	}
}