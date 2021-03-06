package com.jollyclass.airplayer.util
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	/**
	 * 图片加载功能，通过loadImg函数，返回一个loader，以供主页面addChild
	 * 此工具类实现了对jpg、png和bmp的查看功能。
	 * @author 邹丹丹
	 */
	public class ImgUtil
	{
		private static var logger:LoggerUtils=new LoggerUtils("ImgUtil");
		public function ImgUtil()
		{
		}
		/**
		 * 图片加载功能
		 * @return Loader 返回个图片加载器。
		 */
		public static function loadImg(imgPath:String):Loader
		{
			var imgLoader:Loader=new Loader();
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				logger.info("load image complete","loadImg");
			});
			imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void
			{
				logger.info("load image error","loadImg");
			});
			imgLoader.load(new URLRequest(imgPath));
			return imgLoader;
		}
	}
}