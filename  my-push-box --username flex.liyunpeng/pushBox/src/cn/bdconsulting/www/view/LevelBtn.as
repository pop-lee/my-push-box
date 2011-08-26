package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.event.BdcButton;
	import cn.bdconsulting.www.event.BdcSprite;
	import cn.bdconsulting.www.tools.NumberImage;
	
	import com.qq.openapi.MttService;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class LevelBtn extends BdcButton
	{
		private var _lv : int;
		
		private var _loader : Loader = new Loader();
		
		private var lvNum : BdcSprite = new BdcSprite();
		
		public function LevelBtn(lv : int) : void
		{
			super();
			_lv = lv;
			
			this.backgroundImage = MttService.getSubResource("resourceURL") + "/lockLevel.png";
			
			lvNum.backgroundBitmap = NumberImage.getNumberImage(_lv + 1);
			addChild(lvNum);
		}
		
		public function get lv() : int
		{
			return _lv;
		}
		
		public function openLv() : void
		{
			
		}
		
		public function openLvBtn() : void
		{
			this.backgroundImage = MttService.getSubResource("resourceURL") + "/unLockLevel.png";
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			lvNum.x = (value - lvNum.backgroundBitmap.width)/2;
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			lvNum.y = (value - lvNum.backgroundBitmap.height)/2;
		}
	}
}