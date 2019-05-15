package com.jollyclass.airplayer.util
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	public class ImgUtil
	{
		public function ImgUtil()
		{
		}
		public function loadImg(imgPath:String):Loader
		{
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				trace("complete");
			});
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void
			{
				trace("ioerror");
			});
			loader.load(new URLRequest(imgPath));
			return loader;
		}
	}
}