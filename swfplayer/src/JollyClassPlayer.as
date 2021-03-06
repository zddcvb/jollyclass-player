package
{
	import com.jollyclass.airplayer.constant.ErrorMsgNumber;
	import com.jollyclass.airplayer.constant.FieldConst;
	import com.jollyclass.airplayer.constant.PathConst;
	import com.jollyclass.airplayer.constant.SwfKeyCode;
	import com.jollyclass.airplayer.domain.JollyClassDataInfo;
	import com.jollyclass.airplayer.domain.SwfInfo;
	import com.jollyclass.airplayer.factory.KeyCodeServiceFactory;
	import com.jollyclass.airplayer.factory.impl.CommonKeyCodeFactoryImpl;
	import com.jollyclass.airplayer.factory.impl.JollyClassKeyCodeFactoryImpl;
	import com.jollyclass.airplayer.service.KeyCodeService;
	import com.jollyclass.airplayer.util.AneUtils;
	import com.jollyclass.airplayer.util.ImgUtil;
	import com.jollyclass.airplayer.util.LoggerUtils;
	import com.jollyclass.airplayer.util.ParseDataUtils;
	import com.jollyclass.airplayer.util.PathUtil;
	import com.jollyclass.airplayer.util.ShapeUtil;
	import com.jollyclass.airplayer.util.SwfInfoUtils;
	import com.jollyclass.airplayer.util.VideoUtil;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.InvokeEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.media.Video;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	/**
	 * 小水滴课堂主类，启动类，通过onstart方法启动。
	 * @author 邹丹丹
	 */
	public class JollyClassPlayer extends Sprite
	{
		private static var logger:LoggerUtils=new LoggerUtils("JollyClassPlayer");
		/**
		 * 主swf文件的加载器
		 */
		private var _loader:Loader=new Loader();
		/**
		 * 开通服务对话框的加载器
		 */
		private var _dialog_loader:Loader=new Loader();
		/**
		 * 家庭端播放器进度条皮肤的加载器
		 */
		private var _player_loading:Loader=new Loader();
		/**
		 * 图片加载的loader，用于加载jpg、png、bmp文件
		 */
		private var imgLoader:Loader;
		/**
		 * 加载的主swf文件的元件
		 */
		private var course_mc:MovieClip;
		/**
		 * 加载的播放器皮肤元件，里面封装了控制播放器皮肤显示等各种方法
		 */
		private var player_mc:MovieClip;
		/**
		 * 加载的开通服务的对话框元件
		 */
		private var dialog_mc:MovieClip;
		/**
		 * 教学端计时器，间隔的时长由系统传递的参数_teaching_play_trial_duation决定
		 */
		private var teacherTimer:Timer;
		/**
		 * 家庭端显示播放条的计时器：间隔时长3s
		 */
		private var familyTimer:Timer;
		/**
		 * 两个内嵌的加载动画
		 */
		[Embed(source="/swf/loading-teacher.swf")]
		private var LoadingTeacherUI:Class;
		[Embed(source="/swf/loading-family.swf")]
		private var LoadingFamilyUI:Class;
		private var loading_obj:DisplayObject;
		/**
		 * 接收从系统发送的数据
		 */
		private var dataInfo:JollyClassDataInfo;
		/**
		 * swf文件类，保存swf文件的相关信息
		 */
		private var swfInfo:SwfInfo;
		/**
		 * 播放器启动时的黑屏，随着swf文件加载成功和开始播放而卸载
		 */
		private var blackShape:Shape;
		/**
		 * 是否显示进度条
		 */
		private var isShowing:Boolean=false;
		/**
		 * 视频加载和播放工具类
		 */
		private var video_util:VideoUtil;
		/**
		 * mp4、flv视频的播放暂停控制，true为播放，false为暂停
		 */
		private var video_play_status:Boolean=true;
		/**
		 * mp4、flv视频全部停止和重新开始播放控制：true为停止，false为播放
		 */
		private var video_stop_status:Boolean=true;
		public function JollyClassPlayer()
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			this.onStart();
		}
		/**
		 * 启动应用
		 */
		public function onStart():void{
			showBlackUI();
			addMainApplicationKeyEvent();
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE,onInvokeHandler);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE,onDeactivateHandler);
		}
		/**
		 * 开启主swf的键盘事件和循环事件
		 */
		private function addMainApplicationKeyEvent():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
		}
		/**
		 * 接收android系统发送的消息
		 */
		protected function onInvokeHandler(event:InvokeEvent):void
		{
			var args:Array=event.arguments;
			if (args.length>0) 
			{
				dataInfo=ParseDataUtils.parse2DataInfo(args);
				//AneUtils.showShortToast(dataInfo.toString());
				//	if(dataInfo!=null){
				showLoadingUI(dataInfo.product_type);
				removeChild(blackShape);
				var path:String=dataInfo.swfPath;
				if(path.indexOf(".mp4")!=-1||path.indexOf(".flv")!=-1){
					//打开视频播放器
					initPlayer();
				}else if(path.indexOf(".swf")!=-1){
					//AneUtils.showShortToast(dataInfo.swfPath);
					readFileFromAndroidDIC(dataInfo.swfPath);
				}else if(path.lastIndexOf(".jpg")!=-1||path.lastIndexOf(".png")!=-1||path.lastIndexOf(".bmp")!=-1){
					//打开图片查看器
					loadImg(dataInfo.swfPath);
				}else{
					sendAndShowErrorMsg(ErrorMsgNumber.FILE_FORMAT_NOT_WRONG,FieldConst.DEFAULT_TELPHONE);
				}				
				//}
				//				else{
				//					sendAndShowErrorMsg(ErrorMsgNumber.PARSE_DATA_ERROR,FieldConst.DEFAULT_TELPHONE);
				//				}
			}else{
				sendAndShowErrorMsg(ErrorMsgNumber.INOVKE_DATA_LENGTH_ERROR,FieldConst.DEFAULT_TELPHONE);
			}
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE,onInvokeHandler);
		}
		/**
		 * 监听应用状态为不激活状态时，则直接退出应用。
		 */
		protected function onDeactivateHandler(event:Event):void
		{
			NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE,onDeactivateHandler);
			NativeApplication.nativeApplication.exit(0);
		}
		/**
		 * 显示首屏的黑屏画面，避免flash加载的白屏出现
		 */
		private function showBlackUI():void
		{
			blackShape=ShapeUtil.createShape();
			addChild(blackShape);
		}
		/**
		 * 添加加载动画,根据type值判定加载哪个加载动画
		 */
		private function showLoadingUI(type:String):void
		{
			//	AneUtils.showShortToast(type);
			switch(type){
				case FieldConst.FAMILY_BOX:
				case FieldConst.XSD_FAMILY_BOX:
				case FieldConst.WTRON_FAMILY_BOX:
					loading_obj=new LoadingFamilyUI();
					break;
				case FieldConst.TEACHING_BOX:
				case FieldConst.XSD_TEACHER_BOX:
				case FieldConst.WTRON_TEACHER_BOX:
					loading_obj=new LoadingTeacherUI();
					break;
				default:
					loading_obj=new LoadingTeacherUI();
					break;
			}
			addChild(loading_obj);	
		}
		/**
		 * 加载图片查看器
		 */
		private function loadImg(imgPath:String):void
		{
			imgLoader = ImgUtil.loadImg(imgPath);
			addChild(imgLoader);
		}
		/**
		 * 加载视频播放器
		 */
		private function initPlayer():void
		{
			video_util=new VideoUtil();
			var video:Video=video_util.initVideo(1920,1080);
			addChild(video);
			video_util.initVedioPlayer(video,dataInfo.swfPath);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onVideoKeyDown);			
		}
		
		protected function onVideoKeyDown(event:KeyboardEvent):void
		{
			var code:int=event.keyCode;
			code=switchKeyCode(code,dataInfo.resource_type);
			var nowTime:Number;
			switch(code){
				case SwfKeyCode.ENTER_XSD_CODE:
					//视频播放暂停
					if(video_play_status){
						video_util.pause();
					}else{
						video_util.resume();
					}
					video_play_status=!video_play_status;
					break;
				case SwfKeyCode.RIGHT_XSD_CODE:
					//视频快进
					nowTime=video_util.getCurrentTime()+5;
					if(nowTime>=video_util.getTotalTime()){
						nowTime=video_util.getTotalTime();
						video_util.stop();
						video_stop_status=true;
					}else{
						video_util.seek(nowTime);
						video_play_status=true;
					}
					break;
				case SwfKeyCode.LEFT_XSD_CODE:
					//视频快退
					nowTime=video_util.getCurrentTime()-5;
					if(nowTime<=0){
						nowTime=0;
					}
					if(video_stop_status){
						video_stop_status=false;
					}
					video_util.seek(nowTime);
					video_play_status=true;
					break;
				case SwfKeyCode.BACK_XSD_CODE:
					onDestroy();
					break;
				default:
					break;
			}			
		}
		/**
		 * 显示错误对话框，提示用户拨打客服电话
		 * @param info 需要显示的错误代码
		 * @param telNum 动态指定客服电话
		 */
		private function showErroMsg( info:String,telNum:String):void
		{
			var _error_loading:Loader=new Loader();
			_error_loading.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				addChild(_error_loading);
				var error_mc:MovieClip=event.target.content as MovieClip;
				if(telNum==null||telNum==""){
					telNum=FieldConst.DEFAULT_TELPHONE;
				}
				var error_msg:String=info.substr(0,info.indexOf(":"));
				error_mc.setText(dataInfo.resource_info,error_msg,"");
				initErrorKeyEvent();
			});
			_error_loading.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void{
				sendAndShowErrorMsg(ErrorMsgNumber.ERROR_LOADING_FAILED,dataInfo.customer_service_tel);
			});
			var type:String;
			if(dataInfo!=null){
				type=dataInfo.product_type;
			}
			var error_swf_path:String=PathUtil.selectErrorPath(type);
			_error_loading.load(new URLRequest(error_swf_path));
			
			
		}
		/**
		 * 添加播放器皮肤，获得皮肤的影片剪辑,显示到界面中，但是visible属性为fasle，hiderPlayer方法即为隐藏，具体的方法执行在player.swf文件中。
		 */
		private function addPlayer():void
		{
			_player_loading.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				player_mc=event.target.content as MovieClip;
				//添加播放器皮肤，并隐藏
				player_mc.hidePlayer();
				addChild(_player_loading);
			});
			_player_loading.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void{
				sendAndShowErrorMsg(ErrorMsgNumber.PLAYER_LOADING_FAILED,dataInfo.customer_service_tel);
			});
			var player_swf:String=PathUtil.selectPlayerPath(dataInfo.product_type);
			_player_loading.load(new URLRequest(player_swf));
		}
		/**
		 * 卸载播放进度条
		 */
		private function unloadPlayer():void
		{
			if(_player_loading!=null){
				_player_loading.unload();
			}
		}
		/**
		 * 上报错误信息以及显示错误ui
		 * @param info 需要显示的错误代码
		 * @param telNum 动态指定客服电话
		 */
		private function sendAndShowErrorMsg(info:String,telNum:String):void
		{
			AneUtils.sendErrorMsg(info);
			showErroMsg(info,telNum);
		}
		
		private function initErrorKeyEvent():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onErrorKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);			
		}
		protected function onErrorKeyDown(event:KeyboardEvent):void
		{
			var keycode:int=event.keyCode;
			switch(keycode){
				case SwfKeyCode.BACK_CODE:
				case SwfKeyCode.BACK_DEFAULT_CODE:
				case SwfKeyCode.ENTER_CODE:
					AneUtils.sendData(false);
					onDestroy();
					break;
				default:
					logger.info(keycode+"","");
					break;
			}
		}
		/**
		 * 从android目录下读取文件
		 * @param swfPath swf课件的绝对路径
		 */
		private function readFileFromAndroidDIC(swfPath:String):void
		{
			//AneUtils.showShortToast(swfPath);
			if (swfPath!=null) 
			{/**/
				var file:File=new File(swfPath);
				if(file.exists){
					file.addEventListener(Event.COMPLETE,onFileCompleteHandler);
					file.addEventListener(IOErrorEvent.IO_ERROR,onFileErrorHandler);
					try
					{
						file.load();//load方法是异步加载，只有等load完成才能获取子swf文件的数据
					} 
					catch(error:Error) 
					{
						sendAndShowErrorMsg(ErrorMsgNumber.MEMORY_ERROR,dataInfo.customer_service_tel);
					}
				}else{
					sendAndShowErrorMsg(ErrorMsgNumber.FILE_NOT_EXITS,dataInfo.customer_service_tel);
				}
			}
		}
		protected  function onFileErrorHandler(event:IOErrorEvent):void
		{
			sendAndShowErrorMsg(ErrorMsgNumber.FILE_READ_ERROR,dataInfo.customer_service_tel);
			event.currentTarget.addEventListener(IOErrorEvent.IO_ERROR,onFileErrorHandler);
		}
		
		protected  function onFileCompleteHandler(event:Event):void
		{
			var fileData:ByteArray=event.currentTarget.data;
			loadSwfFileFromBytes(fileData);
			event.currentTarget.removeEventListener(Event.COMPLETE,onFileCompleteHandler);
		}
		/**
		 * 加载swf文件，通过bytearray方式
		 */
		private  function loadSwfFileFromBytes(fileDataByteArray:ByteArray):void
		{
			
			var _context:LoaderContext=new LoaderContext();
			_context.allowCodeImport=true;
			_context.applicationDomain=ApplicationDomain.currentDomain;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);	
			try
			{
				_loader.loadBytes(fileDataByteArray,_context);	
			} 
			catch(error:Error) 
			{
				sendAndShowErrorMsg(ErrorMsgNumber.SWF_BYTE_LENGTH_ERROR,dataInfo.customer_service_tel);
			}			
		}
		protected function onIOErrorHandler(event:IOErrorEvent):void
		{
			sendAndShowErrorMsg(ErrorMsgNumber.LOAD_SWF_ERROR,dataInfo.customer_service_tel);
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			course_mc = event.target.content as MovieClip;
			addChild(_loader);
			removeChild(loading_obj);
			AneUtils.sendData(true);
			switchPlayerByProductType(dataInfo.product_type);
			swfInfo=SwfInfoUtils.getSwfInfo(dataInfo,course_mc);
			swfInfo.isPlaying=true;
			//实现自动返回功能
			if(course_mc.getParentMethod){
				//通过子swf文件调用父类的方法
				course_mc.getParentMethod(this);
			}
		}
		/**
		 * 根据产品类型切换对应的播放器，执行相应的操作
		 * @param type 
		 * 			familybox:添加家庭端播放器皮肤，
		 * 			teachingbox:根据teaching_status值判定是否已经开通服务和关联园所了
		 */
		private function switchPlayerByProductType(type:String):void
		{
			switch(type)
			{
				case FieldConst.FAMILY_BOX:
				case FieldConst.XSD_FAMILY_BOX:
				case FieldConst.WTRON_FAMILY_BOX:
					if(course_mc.totalFrames<=FieldConst.INTERACTION_FRAME){
						//当swf文件的总帧数小于50，则return，不执行onEnterFrameHandler事件
						return;
					}else{
						addPlayer();
					}
					stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
					break;
				case FieldConst.TEACHING_BOX:
				case FieldConst.XSD_TEACHER_BOX:
				case FieldConst.WTRON_TEACHER_BOX:
					if(dataInfo.play_scene==0){
						stopTeachingTimer();
					}else{
						startTeachingTimer();
					}
					break;
				default:
					break;
			}
		}
		
		/**
		 * 循环获取当前swf文件的帧数
		 */
		protected function onEnterFrameHandler(event:Event):void
		{
			if(course_mc!=null){
				var _currentFrame:int=course_mc.currentFrame;
				if(_currentFrame>=course_mc.totalFrames){
					course_mc.gotoAndStop(course_mc.totalFrames);
					swfInfo.isPlaying=false;
					stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
					//onDestoryAndSendData();
					onPauseAndReplay();
				}else{
					if(player_mc){
						player_mc.setNowTime(SwfInfoUtils.getSwfTimeFormatter(_currentFrame));
						player_mc.setTotalTime(swfInfo.total_time);
						var _rate:int=SwfInfoUtils.getSwfProgressRate(course_mc);;
						player_mc.setProgressTxPlay(_rate);
					}
				}
			}		
		}
		/**
		 * 1、播放状态，执行ok键，则swf文件暂停，画面显示暂停标志和进度条、课件名称。
		 * 2、播放状态下，执行左右按钮，快进快退功能，进度条和时间也进行相应的变化，不进行任何操作3s后，进度条消失。
		 * 3、播放状态下，执行上下操作显示进度条，不操作3s后，自动消失。
		 * 4、暂停状态下，执行左右按钮快进快退，进度条和时间相应变化，动画播放。若不进行任何操作3s后，进度条和时间消失。
		 * 5、打开flash课件时，首先播放加载动画，flash课件加载完成后，加载动画消失。
		 * 6、打开flash课件失败时，则显示失败的对话框。
		 */
		protected function onKeyDownHandler(event:KeyboardEvent):void
		{
			var keyCode:int=event.keyCode;
			//映射代码
			event.keyCode=switchKeyCode(keyCode,dataInfo.resource_type);
			if (event.keyCode==SwfKeyCode.BACK_XSD_CODE) 
			{
				onDestoryAndSendData();	
			}
			switch(dataInfo.product_type){
				case FieldConst.FAMILY_BOX:
				case FieldConst.XSD_FAMILY_BOX:
				case FieldConst.WTRON_FAMILY_BOX:
					if(course_mc.ENTER_CODE||course_mc.INTERACTION_FLAG){
						//卸载播放进度条
						unloadPlayer();
						stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
						return;
					}
					if(course_mc.totalFrames<=FieldConst.INTERACTION_FRAME){
						stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
						return;
					}
					player_mc.setSwfNameText(swfInfo.resource_name);
					player_mc.setTotalTime(swfInfo.total_time);
					switch(event.keyCode)
					{					
						case SwfKeyCode.ENTER_XSD_CODE:
							swfPlayAndPauseController();
							break;
						case SwfKeyCode.LEFT_XSD_CODE:
							playRewind();
							break;
						case SwfKeyCode.RIGHT_XSD_CODE:
							playForward();
							break;
						case SwfKeyCode.UP_XSD_CODE:
							showPg();
							break;
						case SwfKeyCode.DOWN_XSD_CODE:
							hidePg();
							break;
						default:
							break;
					}
					break;
				default:
					break;
			}
		}
		/**
		 * 执行遥控器键值映射
		 * @param keyCode 遥控器传递的键值
		 * @param resource_type 资源类型，xsd表示小水滴课堂资源，other表示第三方资源，如果是第三方资源采用通用的键盘映射
		 */
		private function switchKeyCode(keyCode:int,resource_type:String):int
		{
			var keyCodeServiceFactory:KeyCodeServiceFactory=null;
			switch(resource_type){
				case FieldConst.XSD_RESOURCES:
					keyCodeServiceFactory=new JollyClassKeyCodeFactoryImpl();
					break;
				case FieldConst.OTHER_RESOURCES:
					keyCodeServiceFactory=new CommonKeyCodeFactoryImpl();
					break;
				default:
					keyCodeServiceFactory=new CommonKeyCodeFactoryImpl();
					break;
			}
			var keyCodeService:KeyCodeService=keyCodeServiceFactory.build();
			return keyCodeService.switchKeyCode(keyCode);
		}
		/**
		 * 控制播放器的播放暂停，针对家庭端纯播放的课件
		 */
		private function swfPlayAndPauseController():void
		{
			setProgress();
			if(swfInfo.isPlaying){
				course_mc.stop();
				player_mc.showPlayer();
				isShowing=true;
				startPlayerTimer();
			}else{
				if(course_mc.currentFrame==course_mc.totalFrames){
					course_mc.gotoAndStop(course_mc.totalFrames);
					//onDestoryAndSendData();
					onPauseAndReplay();
				}else{
					course_mc.play();
					player_mc.hidePlayer();
					isShowing=false;
					stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				}
				stopPlayerTimer();
			}
			swfInfo.isPlaying=!swfInfo.isPlaying;
		}
		/**
		 * 设置进度条
		 */
		private function setProgress():void{
			var _now_time:String=SwfInfoUtils.getSwfTimeFormatter(course_mc.currentFrame);
			var _now_rate:int=SwfInfoUtils.getSwfProgressRate(course_mc);
			player_mc.setNowTime(_now_time);
			player_mc.setProgressTxStop(_now_rate);
		}
		/**
		 * 快进功能
		 */
		private function playForward():void
		{
			stopPlayerTimer();
			var nextFrame:int=course_mc.currentFrame+FieldConst.FORWARD_REWARD_FRAME;
			if(nextFrame>=course_mc.totalFrames){
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				nextFrame=course_mc.totalFrames;
				course_mc.gotoAndStop(nextFrame);
				swfInfo.isPlaying=false;
				setProgress();
				onPauseAndReplay();
				//onDestoryAndSendData();
			}else{
				setForwardAndRewind(nextFrame);
			}
		}
		/**
		 * 快退功能
		 */
		private function playRewind():void
		{
			stopPlayerTimer();
			var preFrame:int=course_mc.currentFrame-FieldConst.FORWARD_REWARD_FRAME;
			if(preFrame<=0){
				preFrame=1;
			}
			setForwardAndRewind(preFrame);
		}
		private function setForwardAndRewind(frame:int):void
		{
			var _rate:int=SwfInfoUtils.getSwfProgressRate(course_mc);
			var _time:String=SwfInfoUtils.getSwfTimeFormatter(frame);
			player_mc.setNowTime(_time);
			course_mc.gotoAndPlay(frame);
			player_mc.setProgressTxPlay(_rate);
			player_mc.showPg();
			swfInfo.isPlaying=true;
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
			isShowing=true;
			startPlayerTimer();
		}
		/**
		 * 显示进度条
		 */
		private function showPg():void
		{
			stopPlayerTimer();
			//开启循环获取时间
			if(!isShowing){
				player_mc.showNameAndProgress();
				if(swfInfo.isPlaying){
					stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				}else{
					var _rate:int=SwfInfoUtils.getSwfProgressRate(course_mc);
					player_mc.setProgressTxStop(_rate);
					stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				}
				isShowing=!isShowing;
			}
			startPlayerTimer();
		}
		/**
		 * 隐藏进度条
		 */
		private function hidePg():void
		{
			stopPlayerTimer();
			if(isShowing){
				player_mc. hideNameAndProgress();
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				isShowing=!isShowing;
			}
		}
		/**
		 * 开启关联和开通服务计时
		 */
		private function startTeachingTimer():void
		{
			teacherTimer=new Timer(10000,1);
			teacherTimer.addEventListener(TimerEvent.TIMER_COMPLETE,function(event:TimerEvent):void{
				loadDialogSwf(PathConst.DAILOG_SWF);
				stopTeachingTimer();
			});
			teacherTimer.start();	
		}
		/**
		 * 停止计时
		 */
		private  function stopTeachingTimer():void
		{
			if (teacherTimer!=null) 
			{
				teacherTimer.stop();
			}	
		}
		/**
		 * 开启家庭端播放计时
		 */
		private function startPlayerTimer():void
		{
			familyTimer=new Timer(3000,1);
			familyTimer.addEventListener(TimerEvent.TIMER_COMPLETE,function(event:TimerEvent):void{
				if(isShowing){
					player_mc.hideNameAndProgress();
					//stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
					isShowing=false;
					stopPlayerTimer();
				}
			});
			familyTimer.start();
		}
		/**
		 * 停止familyTimer
		 */
		private function stopPlayerTimer():void
		{
			if(familyTimer!=null){
				familyTimer.stop();
			}
		}
		/**
		 * 加载内置的对话框界面
		 */
		private function loadDialogSwf(swfPath:String):void
		{
			_dialog_loader.load(new URLRequest(swfPath));
			_dialog_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				dialog_mc=event.target.content as MovieClip;
				addChild(_dialog_loader);
				pauseMainSwf();
				initDialogSwf();
				stopTeachingTimer();
				switchConnectOrService(dataInfo.play_scene);
			});
			_dialog_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function(event:IOErrorEvent):void{
				sendAndShowErrorMsg(ErrorMsgNumber.DIALOG_LAODING_ERROR,dataInfo.customer_service_tel);
			});
		}
		/**
		 * 根据账户的类型,显示关联园所，还是开启服务。
		 * @param status 账户的状态码
		 * 			0：已付费会员可以正常播放
		 * 			1:绑定激活码，盒子当前日期不在服务有效期内（播放10s,弹出开通服务窗口）
		 * 			2：未开通服务（播放10s,弹出开通服务窗口）
		 * 现有的状态码只有这三种，其中0状态码不会执行此方法，只接受1/2以及其他的状态码，除了1/2状态码之外，系统暂无规定其他的状态码。
		 */
		private function switchConnectOrService(status:int):void
		{
			switch(status)
			{
				case 1:
				case 2:
					dialog_mc.goServiceUI();
					break;
				default:
					break;
			}
			
		}
		/**
		 * 暂停主swf的播放，移除键盘事件和循环事件
		 */
		private function pauseMainSwf():void
		{
			course_mc.stopAllMovieClips();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
		}
		
		private function initDialogSwf():void{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onDialogKeyDown);
		}
		private function removeDialgoSwfEvent():void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onDialogKeyDown);
		}
		protected function onDialogKeyDown(event:KeyboardEvent):void
		{
			event.keyCode=switchKeyCode(event.keyCode,dataInfo.resource_type);
			if (event.keyCode==SwfKeyCode.BACK_XSD_CODE) 
			{
				onDestoryAndSendData();
			}
			dialog_mc.getParentMethod(this);
		}
		/**
		 * 打开系统扫码注册页面
		 */
		public function openConnectApk():void{
			unloadDialogUI();
			AneUtils.openApk(PathConst.PACKAGE_NAME,PathConst.CONNECT_CLASS_NAME);
			onDestroy();
		}
		/**
		 * 不注册时，退出对话框
		 */
		public function unloadDialogUI():void{
			removeDialgoSwfEvent()
			_dialog_loader.unloadAndStop(true);
			onDestroy();
		}
		/**
		 * 开通服务页面
		 */
		public function openServiceApk():void{
			unloadDialogUI();
			switch(dataInfo.play_scene){
				case 1:
				case 2:
					AneUtils.openApk(dataInfo.package_name,dataInfo.callback_activity_name);
					break;
				default:
					break;
			}
			//			if(dataInfo.play_scene==1){
			//				AneUtils.openApk(PathConst.PACKAGE_NAME,PathConst.MAL_RENEW_NAME);
			//			}else{
			//				AneUtils.openApk(PathConst.PACKAGE_NAME,PathConst.SERVER_OPEN_NAME);
			//			}
			onDestroy();
		}
		/**
		 * 销毁当前应用之前广播数据
		 */
		public function onDestoryAndSendData():void
		{
			var exitInfo:SwfInfo=SwfInfoUtils.getSwfInfo(dataInfo,course_mc);
			switch(dataInfo.product_type){
				case FieldConst.TEACHING_BOX:
				case FieldConst.XSD_TEACHER_BOX:
				case FieldConst.WTRON_TEACHER_BOX:
					AneUtils.sendTeachingData(PathConst.APK_BROADCAST,exitInfo.isPlaying,exitInfo.isEnd,exitInfo.teaching_resource_id,exitInfo.play_time,exitInfo.total_time);
					break;
				case FieldConst.FAMILY_BOX:
				case FieldConst.XSD_FAMILY_BOX:
				case FieldConst.WTRON_FAMILY_BOX:
					AneUtils.sendFamilyData(PathConst.APK_BROADCAST,exitInfo.isPlaying,exitInfo.isEnd,exitInfo.family_media_id,exitInfo.family_material_id,exitInfo.play_time,exitInfo.total_time);
					break;
				default:
					break;
			}
			NativeApplication.nativeApplication.exit(0);
		}
		/**
		 * 直接销毁应用
		 */
		public function onDestroy():void
		{
			NativeApplication.nativeApplication.exit(0);
		}
		private function onPauseAndReplay():void
		{
			player_mc.hidePlayer();
			isShowing=false;
			stopPlayerTimer();
			showReplay();
			var exitInfo:SwfInfo=SwfInfoUtils.getSwfInfo(dataInfo,course_mc);
			var type:String=dataInfo.product_type;
			if(type.indexOf(FieldConst.TEACHING_BOX)!=-1){
				AneUtils.sendTeachingData(PathConst.APK_BROADCAST,exitInfo.isPlaying,exitInfo.isEnd,exitInfo.teaching_resource_id,exitInfo.play_time,exitInfo.total_time);
			}else if(type.indexOf(FieldConst.FAMILY_BOX)!=-1){
				AneUtils.sendFamilyData(PathConst.APK_BROADCAST,exitInfo.isPlaying,exitInfo.isEnd,exitInfo.family_media_id,exitInfo.family_material_id,exitInfo.play_time,exitInfo.total_time);
			}
		}
		/**
		 * 显示重播页面
		 */
		private function showReplay():void
		{
			//增加重播建，开启重播功能，卸载原有的按键事件
			loadImg(PathConst.REPLAY_PNG);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onReplayLoaderHandler);
		}
		/**
		 * 增加重播按键功能
		 */
		protected function onReplayLoaderHandler(event:KeyboardEvent):void
		{
			var code:int=switchKeyCode(event.keyCode,dataInfo.resource_type);
			if(code==SwfKeyCode.ENTER_XSD_CODE){
				course_mc.gotoAndPlay(1);
				swfInfo.isPlaying=true;
				imgLoader.unload();
				stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,onReplayLoaderHandler);
			}
		}
	}
}