package
{
	import cn.bdconsulting.www.core.BdcContainer;
	import cn.bdconsulting.www.core.BdcSprite;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class IntrPage extends BdcContainer
	{
		private var _intr : String = "" +
			"游戏说明：\n" +
			"将所有箱子推到红色圆点的目的地即为过关\n" +
			"使用时间越少，则最后积分越高\n";
		
		private var label : TextField = new TextField();
		
		private var tf : TextFormat = new TextFormat();
		
		public function IntrPage()
		{
			super();
			init();
		}
		
		private function init() : void
		{
			tf.color = 0xff0000;
			tf.size = 13;
			tf.bold = true;
			label.defaultTextFormat = tf;
			label.text = _intr;
			label.wordWrap = true;
			label.width = 200;
			label.height = 90;
			addChild(label);
		}
		
		public function set text(_text : String) : void
		{
			label.text = _intr = _text; 
		}
	}
}