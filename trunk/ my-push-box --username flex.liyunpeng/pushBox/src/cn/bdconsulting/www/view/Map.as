package cn.bdconsulting.www.view  
{
	import cn.bdconsulting.www.config.Config;
	import cn.bdconsulting.www.config.MapData;
	import cn.bdconsulting.www.event.SuccessEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.object.Box;
	import cn.bdconsulting.www.object.Destination;
	import cn.bdconsulting.www.object.Road;
	import cn.bdconsulting.www.object.Role;
	import cn.bdconsulting.www.object.Roles;
	import cn.bdconsulting.www.object.Wall;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
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
		public var mapData:Array = [];//map数据
		public var mapTileType:Array = [];
		public var rolesData:Array = [];
		
		private var _model : ModelLocator = ModelLocator.getInstance();
		
		private var _lv:uint;//关卡
		
		private var _step : int = 0;
		private var _time : int = 0;
		
		private var mapLayer : BdcContainer = new BdcContainer();
		private var rolesLayer : BdcContainer = new BdcContainer();
		
		public var role : Role;
		
		private var _timer : Timer = new Timer(1000);
		
		public function Map(lv:uint=0)
		{
			super();
			_lv = lv;
			_timer.addEventListener(TimerEvent.TIMER,timerHandle);
			mapLayer.percentWidth = 100;
			mapLayer.percentHeight = 100;
			mapLayer.backgroundAlpha = 0;
			rolesLayer.percentWidth = 100;
			rolesLayer.percentHeight = 100;
			rolesLayer.backgroundAlpha = 0;
			this.addChild(mapLayer);
			this.addChild(rolesLayer);
		}
		private function initMapData() : void {
			mapData = [];
			mapTileType = [];
			rolesData = [];
			for (var i :int = 0; i < MapData.MAP[_lv].length; i++) {
				mapData[i] = [];
				mapTileType[i] = [];
				for (var j:int = 0; j < MapData.MAP[_lv][i].length; j++) {
					mapData[i][j] = MapData.MAP[_lv][i][j];
					mapTileType[i][j] = mapData[i][j];
				}
			}
			drawMap();
		}
		private function drawMap() : void {
			for (var i:int = 0; i < mapData.length; i++) {
				rolesData[i] = [];
				for (var j:int = 0; j < mapData[i].length; j++) {
					var mapMC : MovieClip = null;
					var roleMC : Roles = null;
					switch(mapData[i][j]) {
						case MapData.WALL:mapMC = new Wall();break;
						case MapData.ROAD:mapMC = new Road();break;
						case MapData.TARGET:mapMC = new Destination();break;
						
						case MapData.BOX:{
							mapMC = new Road();
							roleMC = new Box();
							mapTileType[i][j] = MapData.ROAD;
							break;
						}
						case MapData.SPECIAL:{
							mapMC = new Destination();
							roleMC = new Box();
							(roleMC as Box).toTarget();
							mapTileType[i][j] = MapData.TARGET;
							break;
						}
						case MapData.ROLE:{
							mapMC = new Road();
							roleMC = role = new Role(this);
							(roleMC as Role).indexX = j;
							(roleMC as Role).indexY = i;
							mapTileType[i][j] = MapData.ROAD;
							break;
						}
					}
					if(mapMC) {
						mapMC.x = j * Config.TILE_SIZE;
						mapMC.y = i * Config.TILE_SIZE;
						mapLayer.addChild(mapMC);
					}
					if(roleMC) {
						roleMC.x = j * Config.TILE_SIZE;
						roleMC.y = i * Config.TILE_SIZE;
						roleMC.oriIndexX = j;
						roleMC.oriIndexY = i;
						rolesLayer.addChild(roleMC);
						rolesData[i][j] = roleMC;
					}
					
				}
			}
		}
		public function restart():void {
			clearMap();
			initMapData();
		}
		
		public function clearMap():void {
			while(mapLayer.numChildren> 0) {
				mapLayer.removeChildAt(0);
			}
			while(rolesLayer.numChildren> 0) {
				rolesLayer.removeChildAt(0);
			}
			mapData = [];//map数据
			mapTileType = [];
			rolesData = [];
			System.gc();
		}
		public function checkSuccess():void {
			if(isSuccess()){
				trace("Success");
				_timer.stop();
				clearMap();
				this.dispatchEvent(new SuccessEvent(SuccessEvent.SUCCESS_EVENT));
			}
		}
		private function isSuccess():Boolean {
			var success:Boolean = true;
			for (var i:int = 0; i < mapData.length; i++) {
				for (var j:int = 0; j < mapData[i].length; j++) {
					//4是目标点
					if(mapData[i][j] == MapData.BOX&&mapTileType[i][j] != MapData.TARGET) return false;
				}
			}
			return success;
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
//			repaintMap();
			_step = 0;
			_time = 0;
			_timer.stop();
			_timer.start();
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