package cn.bdconsulting.www.view
{
	import cn.bdconsulting.www.model.ModelLocator;
	import cn.bdconsulting.www.tools.NumberImage;
	
	import com.qq.openapi.MttService;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class LevelBtn extends BdcButton
	{
		private var lockLvClass : Class;
		private var unlockLvClass : Class;
		
		private var _lv : int;
		
		private var _loader : Loader = new Loader();
		
		private var lvNum : BdcSprite = new BdcSprite();
		
		public function LevelBtn(lv : int) : void
		{
			super();
			_lv = lv;
			
			lockLvClass = ModelLocator.getImageResource("lockLevel")
			unlockLvClass = ModelLocator.getImageResource("unLockLevel");
			this.backgroundImage = lockLvClass;
			
			var bitmapData : BitmapData = NumberImage.getNumberImage(_lv + 1).bitmapData;
			lvNum.graphics.beginBitmapFill(bitmapData);
			lvNum.graphics.drawRect(0,0,bitmapData.width,bitmapData.height);
			lvNum.graphics.endFill();
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
			this.backgroundImage = unlockLvClass;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			lvNum.x = (value - lv.toString().length*14)/2;
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			lvNum.y = (value - 19)/2;
		}
	}
}