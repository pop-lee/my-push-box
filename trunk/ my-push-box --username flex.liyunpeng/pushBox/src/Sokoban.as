package {
	import com.qq.openapi.MttScore;
	import com.qq.openapi.MttService;
	import com.qq.openapi.ScoreInfo;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author LiYunpeng
	 */

	public class Sokoban extends Sprite {
		public static var _lv:int = 0;
		private var _map:Map;
		
		private var _role:Role ;
		
		private var _scoreBar : TextField = new TextField();
		
		private var _playBtn : PlayButton = new PlayButton();
		
		private var _restartBtn : TouchBtn = new TouchBtn();
		
//		private var _scoreList : ScoreList;
		
//		private var _intr : IntrPage ;
		
		private var _timer : Timer = new Timer(1000);
		
		private var _sec : int = 0;
		
		private var topBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.TOP);
		private var bottomBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.BOTTOM);
		private var leftBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.LEFT);
		private var rightBtn : DirectionButton = new DirectionButton(DirectionBtnEvent.RIGHT);
		
		private static const SCORE : int = 800;
		
		private var currentScore : int = 0; 
		
		private var lastTotalScore : int = 0;
		
		public static const SUCCESS_EVENT : String = "successEvent";
		
		public function Sokoban() {
			
			init();
//			MttService.initialize(root, "AZf8bFKto0iDMBYXBb34sPJA");
//			MttService.addEventListener(MttService.ETLOGOUT, onLogout);
//			onQuery();
//			this.x = this.stage.stageWidth;
//			this.y = this.stage.stageHeight/2;
//			this.rotation  = 90; 
			/////////////////////////////////////////////////////////////////
			
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.addEventListener(Event.RESIZE,resizeHandle);
			
		}
		
		private function resizeHandle(event : Event) : void
		{
			this.graphics.beginFill(0xcccccc,0.5);
			this.graphics.drawRect(0,0,this.stage.stageWidth,this.stage.stageHeight);
			this.graphics.endFill();
//			this.width = this.stage.stageWidth;
//			this.height = this.stage.stageHeight;
		}
		private function init():void {
			_map = new Map(_lv);
			_map.addEventListener(SUCCESS_EVENT,successHandle);
			addChild(_map);
			_map.changeLv(_lv);
			
			_role = new Role(stage,_map,_lv);
			addChild(_role);
			
			var title : TextField = new TextField();
			title.text = "大连尚嘉";
			title.width = title.textWidth + 10;
			title.x = stage.stageWidth - title.width;
			title.y = stage.stageHeight - title.textHeight - 2;
			addChild(title);
			
			_scoreBar.text = "0秒";
			_scoreBar.width = _scoreBar.textWidth + 10;
			_scoreBar.x = stage.stageWidth - _scoreBar.width;
			_scoreBar.y = 5;
			addChild(_scoreBar);
			
			_scoreList = new ScoreList(this.stage);
			_scoreList.visible = true;
			addChild(_scoreList);
			
			_intr = new IntrPage();
			_intr.x = (stage.stageWidth - _intr.width)/2;
			_intr.y = stage.stageHeight - 40 - _intr.height;
			addChild(_intr);
			
			topBtn.x = (stage.stageWidth - topBtn.width)/2;
			topBtn.y = 5;
			topBtn.visible = false;
			addChild(topBtn);
			bottomBtn.x = (stage.stageWidth - bottomBtn.width)/2;
			bottomBtn.y = title.y - bottomBtn.height - 2;
			bottomBtn.visible = false;
			addChild(bottomBtn);
			leftBtn.y = (stage.stageHeight - leftBtn.height)/2;
			leftBtn.x = 5;
			leftBtn.visible = false;
			addChild(leftBtn);
			rightBtn.y = (stage.stageHeight - rightBtn.height)/2;
			rightBtn.x = stage.stageWidth - rightBtn.width - 5;
			rightBtn.visible = false;
			addChild(rightBtn);
			
			_playBtn.text = "开始"
			_playBtn.addEventListener(MouseEvent.CLICK,playBtnClickHandle);
			_playBtn.x = stage.stageWidth - _playBtn.width - 10;
			_playBtn.y = title.y - _playBtn.height - 2;
			addChild(_playBtn);
			
			_restartBtn.text = "重玩此关";
			_restartBtn.x = 5;
			_restartBtn.y = _playBtn.y;
			_restartBtn.addEventListener(MouseEvent.CLICK,restartPlay);
			_restartBtn.visible = false;
			addChild(_restartBtn);

			_timer.addEventListener(TimerEvent.TIMER,timerHandle);
		}
		
		private function playBtnClickHandle(event : MouseEvent) : void
		{
			playStart();
			
			if(_playBtn.text == "开始") {
//				_map.removeEventListener(SUCCESS_EVENT,successHandle);
//				_map = new Map(_lv);
//				_map.addEventListener(SUCCESS_EVENT,successHandle);
				_lv = 0;
				lastTotalScore = 0;
				currentScore = 0;
//				_map.changeLv(_lv);
			} else {
//				_map.removeEventListener(SUCCESS_EVENT,successHandle);
//				_map = new Map(_lv);
//				_map.addEventListener(SUCCESS_EVENT,successHandle);
//				_map.changeLv(_lv);
				_lv ++;
			}
			_map.changeLv(_lv);
			
//			_role = new Role(stage,_map,_lv);
			_role.addEvent();
			_role.getPosition();
			_restartBtn.visible = true;
//			addChild(_restartBtn);
			topBtn.visible = true;
//			addChild(topBtn);
			bottomBtn.visible = true;
//			addChild(bottomBtn);
			leftBtn.visible = true;
//			addChild(leftBtn);
			rightBtn.visible = true;
//			addChild(rightBtn);
			_playBtn.removeEventListener(MouseEvent.CLICK,playBtnClickHandle);
//			this.removeChild(event.currentTarget as PlayButton);
			_intr.visible = _scoreList.visible = false;
			_playBtn.visible = false;
			_restartBtn.visible = false;
		}
		
		private function playStart() : void
		{
			_timer.start();
		}
		
		private function restartPlay(event : MouseEvent) : void
		{
			_sec = 0;
			currentScore = lastTotalScore;
			_scoreBar.text = "0秒";
			_timer.reset();
			
			topBtn.visible = true;
			bottomBtn.visible = true;
			leftBtn.visible = true;
			rightBtn.visible = true;
//			removeChild(_role);
			_map.changeLv(_lv);
//			_role = new Role(stage,_map,_lv);
			_role.removeEvent();
			_role.getPosition();
			_role.addEvent();
			_timer.start();
//			addChild(_role);
			
			_intr.visible = _scoreList.visible = false;
			_playBtn.visible = false;
			_restartBtn.visible = false;
		}
		
		private function timerHandle(event : TimerEvent=null) : void
		{
			if(_sec == SCORE) {
				_timer.removeEventListener(TimerEvent.TIMER,timerHandle);
				return;
			}
			_sec ++;
			_scoreBar.text = _sec.toString() + "秒";
			_scoreBar.x = stage.stageWidth - _scoreBar.textWidth - 10;
		}
		
		private function successHandle(event : Event) : void
		{
			_timer.stop();
			_intr.visible = _scoreList.visible = true;
			lastTotalScore = currentScore;
			currentScore = lastTotalScore + SCORE - _sec;
			_intr.text = "您的当前积分是" + currentScore;
			onSubmit(currentScore);
			if(_lv == MapData.MAP.length -1) {
				_playBtn.text = "开始";
//				_restartBtn.visible = false;
//				removeChild(_restartBtn);
			} else {
				_playBtn.text = "下一关"
				_playBtn.x = stage.stageWidth - _playBtn.width - 10;
			}
			_playBtn.visible = true;
			_restartBtn.visible = true;
			_playBtn.addEventListener(MouseEvent.CLICK,playBtnClickHandle);
			
			_role.removeEvent();
//			removeChild(_role);
			
//			topBtn.removeEvent();
			topBtn.visible = false;
//			removeChild(topBtn);
//			bottomBtn.removeEvent();
			bottomBtn.visible = false;
//			removeChild(bottomBtn);
//			leftBtn.removeEvent();
			leftBtn.visible = false;
//			removeChild(leftBtn);
//			rightBtn.removeEvent();
			rightBtn.visible = false;
//			removeChild(rightBtn);
//			_restartBtn.removeEvent();
//			removeChild(_restartBtn);
			
//			_lv ++;
			_sec = 0;
			_scoreBar.text = "0秒";
		}
		
		
		////////////////////////////////////////////////////////////////////////
		private function onLogout(e:Event):void
		{
			MttService.login();
		}
		
		private function onSubmit(score : uint):void
		{
			MttScore.submit(score, onFinishSubmit);
		}
		
		private function onFinishSubmit(result:Object):void
		{
			var sInfo:String = "返回码:" + result.code + "\n";
			
			if (result.code == 0)
			{
				var score:ScoreInfo = result.score as ScoreInfo;
				var time :Date = new Date(score.playTime * 1000);
				
				sInfo += "\n我的昵称：" + score.nickName + "\n最高积分：" + score.score + "\n创建时间：" + time.toLocaleString() + "\n我的排名：" + score.rank;
			}
			onQuery();
			
		}
		
		private function onQuery():void
		{
			MttScore.query(onFinishQuery);
		}
		
		private function onFinishQuery(result:Object):void
		{
			var sInfo:String = "调用查询积分接口反馈：\n\n返回码:" + result.code;
			if (result.code != 0)
			{
				sInfo += "\n结果描述：调用接口失败";
				return ;
			}
			sInfo += "\n结果描述：调用接口成功";
			
			var items:Array = result.board as Array;
			var _dataArr : Array = new Array();
			sInfo += "\n好友列表:" + items.length + "个";
			for (var i:int = 0; i < items.length; i++)
			{
//				sInfo += "\n好友[" + (i + 1) + "]:" + items[i].nickName + " " + items[i].score + " " + items[i].playTime;
				sInfo = items[i].score;
				_dataArr.push(sInfo);
			}
			
			_scoreList.dataProvider = _dataArr;
			
			var score:ScoreInfo = result.score as ScoreInfo;
			var time :Date = new Date(score.playTime * 1000);
			
			sInfo += "\n\n我的昵称：" + score.nickName + "\n最高积分：" + score.score + "\n创建时间：" + time.toLocaleString() + "\n我的排名：" + score.rank;
			
		}
		
	}
}