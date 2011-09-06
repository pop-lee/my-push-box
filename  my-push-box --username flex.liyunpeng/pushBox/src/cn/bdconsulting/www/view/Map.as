package cn.bdconsulting.www.view  
{
	import cn.bdconsulting.www.config.Config;
	import cn.bdconsulting.www.config.MapData;
	import cn.bdconsulting.www.event.SuccessEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.object.Role;
	import cn.bdconsulting.www.object.Tile;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author DFdou
	 */
	public class Map extends BdcContainer
	{
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _lv:uint;//关卡
		private var _mapData:Array = [];//map数据
		
		private var _step : int = 0;
		private var _time : int = 0;
		
		private var _role : Role;
		
		private var _timer : Timer = new Timer(1000);
		
		public function Map(lv:uint=0)
		{
			super();
			_lv = lv;
			_timer.addEventListener(TimerEvent.TIMER,timerHandle);
			_role = new Role(this);
			this.addChild(_role);
//			initMapData();
		}
		private function initMapData() : void {
			_mapData = [];
			for (var i :int = 0; i < MapData.MAP[_lv].length; i++) {
				_mapData[i] = [];
				for (var j:int = 0; j < MapData.MAP[_lv][i].length; j++) {
					_mapData[i][j] = MapData.MAP[_lv][i][j];
				}
			}
//			drawMap();
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
						addChildAt(tile,0);
//						_childArr.push(tile);
					}
				}
			}
		}
		private function repaintMap():void {
			clearMap();
			drawMap();
		}
		private var i : int = 0;
		private function clearMap():void {
			while(numChildren - 1 > 0) {
				removeChildAt(0);
			}
			System.gc();
		}
		public function checkSuccess():void {
			if(isSuccess()){
				trace("Success");
				_timer.stop();
				_role.removeEvent();
				this.dispatchEvent(new SuccessEvent(SuccessEvent.SUCCESS_EVENT));
			}
		}
		private function isSuccess():Boolean {
			var success:Boolean = true;
			for (var i:int = 0; i < MapData.MAP[_model.currentLv].length; i++) {
				for (var j:int = 0; j < MapData.MAP[_model.currentLv][i].length; j++) {
					//4是目标点
					if (MapData.MAP[_model.currentLv][i][j] == MapData.TARGET || MapData.MAP[_model.currentLv][i][j] == MapData.SPECIAL) {
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
			repaintMap();
		}
		public function getMapData():Array {
			return _mapData;
		}
		
		private function timerHandle(event : TimerEvent) : void
		{
			_time++;
		}
		
		public function set lv(lv:uint) : void {
			_lv = lv;
			this.width = MapData.MAP[_lv][0].length*Config.TILE_SIZE;
			this.height = MapData.MAP[_lv].length*Config.TILE_SIZE;
			this.x = (this.parent.width - MapData.MAP[_lv][0].length*Config.TILE_SIZE)/2;
			this.y = (this.parent.height - MapData.MAP[_lv].length*Config.TILE_SIZE)/2;
			initMapData();
			repaintMap();
			_step = 0;
			_time = 0;
			_timer.stop();
			_timer.start();
			_role.getPosition();
			_role.addEvent();
		}
		
		public function get lv() : uint
		{
			return _lv;
		}
		
		public function set step(value : int) : void
		{
			_step = value;
			trace(_step);
		}
		public function get step() : int 
		{
			return _step;
		}
		
		public function get time() : int
		{
			return _time;
		}
		
		override public function set parentWidth(value:Number):void
		{
			super.parentWidth = value;
			this.x = (value - MapData.MAP[_lv][0].length*Config.TILE_SIZE)/2;
		}
		override public function set parentHeight(value:Number):void
		{
			super.parentHeight = value;
			this.y = (value - MapData.MAP[_lv].length*Config.TILE_SIZE)/2;
		}
	}
}