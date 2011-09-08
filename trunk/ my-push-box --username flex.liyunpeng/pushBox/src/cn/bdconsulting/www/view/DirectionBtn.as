package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.event.LightBtnEvent;
	import cn.bdconsulting.www.event.UnLightBtnEvent;
	import cn.bdconsulting.www.model.ModelLocator;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DirectionBtn extends BdcSprite
	{
		public var direction : String;
		
		private var _timer : Timer = new Timer(50);

		private var _btn : BdcButton = new BdcButton();
		
		private var _light : BdcSprite = new BdcSprite();
		
		private var _lightCount : int = 0;
		
		private var _isHideEffect : Boolean = true;
		
		public static var iii : int = 0;
		
		public function DirectionBtn()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			BdcApplication.application.addEventListener(LightBtnEvent.LIGHT_BTN_EVENT,tip);
			BdcApplication.application.addEventListener(UnLightBtnEvent.UNLIGHT_BTN_EVENT,unLightHandle);
			_timer.addEventListener(TimerEvent.TIMER,light);
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandle);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandle);
			
			this.backgroundAlpha = 0;
			_btn.backgroundAlpha = 0;
			_btn.width = 36;
			_btn.height = 36;
			addChild(_btn);
			
//			addChild(_light);
		}
		
		public function set icon(value : *) : void
		{
			_btn.backgroundImage = value;
		}
		
		public function tip(event : LightBtnEvent = null) : void
		{
			this.alpha = 1;
			_lightCount = 0;
			_isHideEffect = true;
			_timer.start();
			this.graphics.clear();
			this.graphics.beginFill(0xffa800,1);
			this.graphics.drawCircle(this.width/2,this.height/2,this.width/2);
			this.graphics.endFill();
		}
		
		private function light(event : TimerEvent) : void
		{
			if(_isHideEffect) {
				this.alpha -= 0.2;
			} else {
				this.alpha += 0.2;
			}
			if(this.alpha >= 1) {
				_isHideEffect = true;
			} else if(this.alpha <= 0.2) {
				_isHideEffect = false;
				_lightCount ++;
			}
			if(_lightCount == 2) {
				_timer.stop();
				_lightCount = 0;
			}
		}
		
		private function unLightHandle(event : UnLightBtnEvent) : void
		{
			_timer.stop();
			this.alpha = 0.2;
		}
		
		private function mouseDownHandle(event : MouseEvent) : void
		{
			BdcApplication.application.dispatchEvent(new UnLightBtnEvent());
			this.alpha = 0.5;
		}
		private function mouseUpHandle(event : MouseEvent) : void
		{
			this.alpha = 0.2;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_btn.x = (value - _btn.width)/2;
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			_btn.y = (value - _btn.height)/2;
		}
		
	}
}