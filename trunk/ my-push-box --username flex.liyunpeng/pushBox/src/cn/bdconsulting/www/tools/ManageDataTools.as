package cn.bdconsulting.www.tools
{
	import cn.bdconsulting.www.config.MapData;
	import cn.bdconsulting.www.core.FunctionStack;
	import cn.bdconsulting.www.event.BdcInitializeDataEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.view.BdcApplication;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttScore;
	import com.qq.openapi.MttService;
	
	import flash.utils.ByteArray;

	public class ManageDataTools
	{
		private static var _model : ModelLocator = ModelLocator.getInstance();
		
		private static var initDataFg : int = 0;
		
		private static var inited : Boolean = false;
		
		private static var _queryCount : uint = 0;
		
		public function ManageDataTools()
		{
		}
		
		public static function set queryCount(count : uint) : void
		{
			_queryCount = count;
			if(_queryCount > 2) MttService.exit();
		}
		public static function get queryCount() : uint
		{
			return _queryCount;
		}
		
		
		public static function initData() : void
		{
			var init : ByteArray = new ByteArray();
			init.writeBoolean(true);
			MttGameData.put("initialized",init,initializedHandle);
			
			
//			MttGameData.get("unLockedLevel",getUnLockLevel);
//			MttGameData.get("scoreData",getScore);
//			MttScore.query(onFinishQuery);
		}
		
		private static function initializedHandle(result:Object) : void
		{
			if(result.code == 0) {
				MttGameData.get("unLockedLevel",getUnLockLevel);
			}
		}
		
		public static function getUnLockLevel(result:Object) : void
		{
			if(result.code == 0) {
				_model.unLockedLv = int(result.value.readObject());
				validInit();
//				_model.log.text += "unlockedLv" + initDataFg + "\n";
				_model.log.text = "加载资源……  " + 10 + "%" + "\n";
				queryCount = 0;
				MttGameData.get("scoreData",getScore);
			} else {
//				_model.log.visible = true;
//				_model.log.text += "getUnLockError" + result.code + "\n";
				if(inited) {
					queryCount ++;
					MttGameData.get("unLockedLevel",getUnLockLevel);
				} else {
					saveLv();
				}
			}
		}
		
		public static function getScore(result: Object) : void
		{
			if(result.code == 0) {
				_model.scoreArr = Vector.<int>(result.value.readObject());
				validInit();
//				_model.log.text += "getScore" + initDataFg + "\n";
				_model.log.text = "加载资源……  " + 20 + "%" + "\n";
				MttScore.query(onFinishQuery);
			} else {
//				_model.log.visible = true;
//				_model.log.text += "getScoreError" + result.code + "\n";
				if(inited) {
					queryCount ++;
					MttGameData.get("scoreData",getScore);
				} else {
					saveScoreData();
				}
			}
		}
		
		public static function saveLv() : void
		{
			if(_model.currentLv+1 != MapData.MAP.length && _model.unLockedLv < _model.currentLv+1) {
				_model.unLockedLv++;
				var lvData : ByteArray = new ByteArray();
				lvData.writeObject(_model.unLockedLv);
				MttGameData.put("unLockedLevel",lvData,saveLvFinished);
//				saveScoreData();
			}
		}
		
		private static function saveLvFinished(result:Object) : void
		{
			if(result.code == 0) {
//				_model.log.visible = true;
//				_model.log.text += "save1" + "\n";
				saveScoreData();
			} else {
				queryCount ++;
				saveLv();
//				_model.log.visible = true;
//				_model.log.text += "  saveLvError  " + result.code + "\n";
			}
		}
		
		public static function saveScoreData() : void
		{
			if(_model.scoreArr[_model.currentLv] < _model.currentLvScore) {
				_model.scoreArr[_model.currentLv] = _model.currentLvScore;
				
				var scoreData : ByteArray = new ByteArray();
				scoreData.writeObject(_model.scoreArr);
				MttGameData.put("scoreData",scoreData,saveScoreFinished);
//				submitScore();
			}
		}
		private static function saveScoreFinished(result:Object) : void
		{
			if(result.code == 0) {
//				_model.log.visible = true;
//				_model.log.text += "save2" + "\n";
				submitScore();
			} else {
				queryCount ++;
				saveScoreData();
//				_model.log.visible = true;
//				_model.log.text += "  saveScoreError  " + result.code + "\n";
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
		
		private static function onFinishSubmit(result:Object) : void
		{
			if(result.code == 0) {
				MttGameData.get("unLockedLevel",getUnLockLevel);
//				MttScore.query(onFinishQuery);
			} else {
//				_model.log.visible = true;
//				_model.log.text += "  submitError  " + result.code + "\n";
			}
		}
		
		private static function onFinishQuery(result:Object):void
		{
			if (result.code != 0) {
//				_model.log.visible = true;
//				_model.log.text += "  queryError  " + result.code + "\n";
				return;
			}
			
			//			_model.topScoreArr = new Vector.<int>;
			var items:Array = result.board as Array;
			for (var i:int = 0; i < items.length; i++)
			{
				//				sInfo += "\n好友[" + (i + 1) + "]:" + items[i].nickName + " " + items[i].score + " " + items[i].playTime;
				var _score: int = items[i].score;
				_model.topScoreArr[i] = _score;
			}
			validInit();
			_model.log.text = "加载资源……  " + 30 + "%" + "\n";
//			_model.log.text += "queryFinished" + initDataFg + "\n";
			BdcApplication.application.dispatchEvent(new BdcInitializeDataEvent());
			inited = true;
		}
		
		private static function validInit() : void
		{
			initDataFg ++ ;
//			if(initDataFg == 1) {
//				BdcApplication.application.dispatchEvent(new BdcInitializeDataEvent());
//			}
		}
	}
}