package com.jollyclass.airplayer.util
{
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	/**
	 * 视频播放器
	 * 1、播放flv和mp4文件；
	 * 2、实现视频的播放、暂停、停止功能；
	 */
	public class VideoUtil
	{
		private var ns:NetStream;
		private var play_state:Boolean=true;
		private var _video_url:String;
		private var _video:Video;
		private var totalTime:Number;
		
		public function VideoUtil()
		{
			
		}
		
		public function initVedioPlayer(video:Video,video_url:String):void
		{
			trace("init");
			var client:Object=new Object();
			client.onMetaData=onMetaDataHandler;
			var nc:NetConnection=new NetConnection();
			nc.connect(null);
			ns=new NetStream(nc);
			ns.client=client;
			ns.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
			ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler); 
			ns.play(video_url);
			video.attachNetStream(ns);
		}
		
		public function initVideo(width:Number,height:Number):Video{
			var video:Video=new Video(width,height);
			video.smoothing=true;
			return video;
		}
		
		public function onMetaDataHandler(metaData:Object):void
		{
			trace("onMetaDataHandler");
			for(var key:Object in metaData){
				//trace(key+":"+metaData[key]);
				if(key as String =="duration"){
					totalTime=metaData[key] as Number;
					trace(totalTime);
				}
			}
			
		}
		
		protected function asyncErrorHandler(event:AsyncErrorEvent):void
		{
			trace("play error");	
		}
		
		protected function netStatusHandler(event:NetStatusEvent):void
		{
			var player_code:String=event.info.code;
			switch(player_code){
				case "NetStream.Play.Start":
					trace("start");
					break;
				case "NetStream.Play.Stop":
					trace("Stop");
					ns.close();
					break;
				default:
					break;
			}
		}
		public function play(video_url:String):void
		{
			if(!play_state){
				ns.seek(0);
				ns.play(video_url);
			}
			play_state=!play_state;
		}
		public function pause():void
		{
			if(play_state){
				ns.pause();
			}
			play_state=!play_state;
		}
		public function resume():void
		{
			if(!play_state){
				ns.resume();
			}
			play_state=!play_state;
		}
		public function stop():void
		{
			ns.seek(0);
			ns.close();
			play_state=false;
		}
		
		public function getCurrentTime():Number
		{
			return ns.time;
		}
		
		public function getTotalTime():Number
		{
			return totalTime;
		}
		public function seek(position:Number):void
		{
			ns.seek(position);
			ns.play();
		}
	}
}