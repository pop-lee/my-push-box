package cn.bdconsulting.www.model
{
	import cn.bdconsulting.www.event.OpenLevelEvent;
	import cn.bdconsulting.www.view.BdcApplication;
	import cn.bdconsulting.www.view.BdcTextField;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttScore;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	import cn.bdconsulting.www.config.MapData;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		public var resourceLoader : Loader = new Loader();
		
		public var stage : Stage;
		
		public var currentLv:int = 0;
		
		public var unLockedLv : int = 0;
		
		public var scoreArr : Vector.<int> = new Vector.<int>(MapData.MAP.length);
		
		public var topScoreArr : Vector.<int> = new Vector.<int>;
		
		public function ModelLocator()
		{
			if(_model != null) {
				throw new IllegalOperationError("这是一个单例类，请使用getInstance方法来获取对象");
			}
		}
		
		public static function getInstance() : ModelLocator
		{
			return _model;
		}
		
		public static function initData() : void
		{
			MttGameData.get("unLockedLevel",getUnLockLevel);
			MttScore.query(onFinishQuery);
		}
		
		public static function getImageResource(symbol : String) : Bitmap
		{
			var img : Class = _model.resourceLoader.contentLoaderInfo.applicationDomain.getDefinition(symbol) as Class;
			return new Bitmap(new img() as BitmapData);
		}
		
		public static function getUnLockLevel(result:Object) : void
		{
			if(result.code == 0) {
				_model.unLockedLv = result.value.readObject();
				BdcApplication.application.dispatchEvent(new OpenLevelEvent(OpenLevelEvent.OPEN_LEVEL_EVENT));
			}
		}
		
		public static function submitScore() : void
		{
			var _totleScore : int = 0;
			for each(var i : int in _model.scoreArr) {
				_totleScore += i;
			}
			MttScore.submit(_totleScore, onFinishSubmit);
		}
		
		public static function saveLv() : void
		{
			var lvData : ByteArray = new ByteArray();
			lvData.writeObject(_model.unLockedLv);
			var scoreData : ByteArray = new ByteArray();
			scoreData.writeObject(_model.scoreArr);
			MttGameData.put("unLockedLevel",lvData,saveFinished);
			MttGameData.put("unLockedLevel",scoreData,saveFinished);
		}
		
		private static function saveFinished(result:Object) : void
		{
			if(result != 0) {
				trace("saveError");
			}
		}
		
		private static function onFinishSubmit(result:Object) : void
		{
			if(result != 0) {
				trace("submitError");
			}
		}
		
		private static function onFinishQuery(result:Object):void
		{
			if (result.code != 0) {
				trace("queryError");
				return;
			}
			
			var items:Array = result.board as Array;
			for (var i:int = 0; i < items.length; i++)
			{
//				sInfo += "\n好友[" + (i + 1) + "]:" + items[i].nickName + " " + items[i].score + " " + items[i].playTime;
				var _score: int = items[i].score;
				_model.topScoreArr.push(_score);
			}
		}
	}
}