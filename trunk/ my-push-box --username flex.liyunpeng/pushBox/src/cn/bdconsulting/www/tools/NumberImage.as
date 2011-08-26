package cn.bdconsulting.www.tools
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class NumberImage
	{
		[Embed(source="resource/number.png")]
		private static var imageData : Class;
		
		private static const charWidth : Number = 14;
		private static const charHeight : Number = 19;
		
		private static var numArr : Vector.<int> = new Vector.<int>;
		
		public function NumberImage()
		{
		}
		
		public static function getNumberImage(value : int) : Bitmap
		{
			var image : Bitmap = new imageData();
			var chars : String = value.toString();
			var disData : BitmapData = new BitmapData(charWidth*chars.length,charHeight);
			for(var i : int = 0;i < chars.length;i++) {
				var n : int = int(chars.substr(i,1));
				numArr.push(n);
				var rectDis : Rectangle = new Rectangle(charWidth*n, 0, charWidth, charHeight);
				disData.copyPixels(image.bitmapData, rectDis, new Point(charWidth*i,0));
			}
			return new Bitmap(disData);
		}
		
//		private function getCharImage(value : int) : void
//		{
//		}
	}
}