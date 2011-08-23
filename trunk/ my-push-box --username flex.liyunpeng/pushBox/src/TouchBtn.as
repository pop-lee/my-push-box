package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class TouchBtn extends Sprite
	{
		private var _text : String = "";
		
		private var _label : TextField = new TextField();
		
		private var _textFormat : TextFormat = new TextFormat();
		
		public function TouchBtn()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			_textFormat.size = 12;
			_textFormat.align = TextFormatAlign.CENTER;
			_label.antiAliasType = AntiAliasType.ADVANCED;
			_label.selectable = false;
			_label.defaultTextFormat = _textFormat;
//			_label.setTextFormat(_textFormat);
			this.addChild(_label);
			
			addEvent();
		}
		
		private function updateDisplay() : void
		{
			_label.x = 1;
			_label.y = 1;
			_label.width = _label.textWidth + 5;
			_label.height = _label.textHeight + 5;
		}
			
		public function set text(_text : String) : void
		{
			_label.text = this._text = _text;
			updateDisplay();
			this.graphics.clear();
			this.graphics.beginFill(0x000000,0.5);
			this.graphics.drawRoundRect(0,0,_label.width,_label.height,10,10);
			this.graphics.endFill();
		}
		
		public function get text() : String
		{
			return _text;
		}
		
//		private function get label() : TextField
//		{
//			return _label;
//		}
		
		public function set backgroundColor(color : uint) : void
		{
			this.graphics.clear();
			this.graphics.beginFill(color,0.5);
			this.graphics.drawRoundRect(0,0,_label.width,_label.height,10,10);
			this.graphics.endFill();
		}
		
		private function mouseDownEffect(event : MouseEvent) : void 
		{
			backgroundColor = 0xff0000;
		}
		
		private function mouseUpEffect(event : MouseEvent) : void
		{
			backgroundColor = 0x000000;
		}
		
		private function addEvent() : void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDownEffect);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUpEffect);
		}
		public function removeEvent() : void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownEffect);
			this.removeEventListener(MouseEvent.MOUSE_UP,mouseUpEffect);
		}
	}
}