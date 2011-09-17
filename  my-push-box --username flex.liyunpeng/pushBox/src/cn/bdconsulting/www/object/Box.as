package cn.bdconsulting.www.object
{
	import flash.display.MovieClip;
	
	[Embed(source="/lib/Roles.swf", symbol="Box")]
	public class Box extends Roles
	{
		public function Box()
		{
			super();
			stop();
		}
		
		public function toTarget() : void
		{
			this.gotoAndStop(2);
		}
	}
}