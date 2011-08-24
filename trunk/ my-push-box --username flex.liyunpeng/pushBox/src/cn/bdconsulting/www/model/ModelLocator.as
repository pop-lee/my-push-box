package cn.bdconsulting.www.model
{
	import flash.display.Stage;
	import flash.errors.IllegalOperationError;

	public class ModelLocator
	{
		private static var _model : ModelLocator = new ModelLocator();
		
		public var stage : Stage;
		
		public var lv:int = 0;
		
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
	}
}