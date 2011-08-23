package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;
	
	public class DirectionButton extends TouchBtn
	{
		
		public static const TOUCH_BTN_EVENT:String = "touchBtnEvent";
		
		private var _direction : String ;
		
//		private var _textFormat : TextFormat = new TextFormat();
		
//		public var _directionText : TextField = new TextField();
		
		public function DirectionButton(_direction : String)
		{
			super();
			text = this._direction = _direction;
//			_textFormat.size = 12;
//			_textFormat.align = TextFormatAlign.CENTER;
//			label.antiAliasType = AntiAliasType.ADVANCED;
			
			if(_direction == DirectionBtnEvent.LEFT) {
				setText("左");
			} else if(_direction == DirectionBtnEvent.RIGHT) {
				setText("右");
			} else if(_direction == DirectionBtnEvent.TOP) {
				setText("上");
			} else if(_direction == DirectionBtnEvent.BOTTOM) {
				setText("下");
			}

//			this.addChild(label);
//			this.graphics.beginFill(0x000000,0.5);
//			this.graphics.drawRoundRect(0,0,25,25,10,10);
//			this.graphics.endFill();
			
//			this.addEventListener(MouseEvent.CLICK,clickHandle);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandle);
//			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandle);
//			this.addEventListener(TouchEvent.
		}
		
		public function setText(_text : String) : void
		{
			text = _text;
//			label.selectable = false;
//			label.setTextFormat(_textFormat);
//			label.width = 25;
//			label.height = label.textHeight + 2;
//			label.x = (25-label.width)/2;
//			label.y = (25 - label.height)/2;
		}
		
		private function clickHandle(event : MouseEvent) : void
		{
		}
		
		private function mouseDownHandle(event : MouseEvent) : void
		{
//			this.graphics.clear();
//			this.graphics.beginFill(0xff0000,0.5);
//			this.graphics.drawRoundRect(0,0,25,25,10,10);
//			this.graphics.endFill();
//			backgroundColor = 0xff0000;
		}
		
		private function mouseUpHandle(event : MouseEvent) : void
		{
//			this.graphics.clear();
//			this.graphics.beginFill(0x000000,0.5);
//			this.graphics.drawRoundRect(0,0,25,25,10,10);
//			this.graphics.endFill();
//			backgroundColor = 0x000000;
			var touchBtnEvent : DirectionBtnEvent = new DirectionBtnEvent(TOUCH_BTN_EVENT);
			touchBtnEvent._direction = _direction;
			this.stage.dispatchEvent(touchBtnEvent);
		}
		
		override public function removeEvent() : void
		{
//			this.removeEventListener(MouseEvent.CLICK,clickHandle);
			super.removeEvent();
			this.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandle);
//			this.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandle);
		}
		
		
	}
}