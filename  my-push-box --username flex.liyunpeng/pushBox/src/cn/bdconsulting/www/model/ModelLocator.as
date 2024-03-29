package cn.bdconsulting.www.model
{
	import cn.bdconsulting.www.config.MapData;
	import cn.bdconsulting.www.event.BdcInitializeDataEvent;
	import cn.bdconsulting.www.view.BdcApplication;
	import cn.bdconsulting.www.view.BdcLabel;
	import cn.bdconsulting.www.view.BdcTextField;
	
	import com.qq.openapi.MttGameData;
	import com.qq.openapi.MttScore;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		public var log : BdcLabel = new BdcLabel();
		
		public var resourceLoader : Loader = new Loader();
		
		public var stage : Stage;
		
		public var currentLv:int = 0;
		
		public var unLockedLv : int = 0;
		
		public var currentLvScore : int = 10;
		
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
		
		public static function getImageResource(symbol : String) : Class
		{
			var resource : Class = _model.resourceLoader.contentLoaderInfo.applicationDomain.getDefinition(symbol) as Class;
//			var cls : * = new resource();
//			var bitmap : Bitmap = new Bitmap();
//			if(cls is MovieClip) {
////				var bitmapData : BitmapData = new BitmapData(cls.width,330,true,0x0) ;
////				bitmapData.draw(cls,new Matrix(),null,null,new Rectangle(0,0,cls.width,cls.height));
////				bitmap = new Bitmap(bitmapData);
//				bitmap = (cls as MovieClip).getChildAt(0) as Bitmap;
//			} else if(cls is BitmapData) {
//				bitmap = new Bitmap(cls);
//			}
			return resource;
		}

	}
}