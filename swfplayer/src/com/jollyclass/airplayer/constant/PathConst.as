package com.jollyclass.airplayer.constant
{
	/**
	 * 管理应用所有用到的路径、包名、类名的字段
	 * @author 邹丹丹
	 */
	public class PathConst
	{
		/**
		 * 关联园所、开通服务默认对话框路径：/swf/dailog.swf
		 */
		public static const DAILOG_SWF:String="/swf/dailog.swf";
		/**
		 * 小水滴教学端开通服务的对话框swf路径：/swf/dailog_xsd_teacherbox.swf
		 */
		public static const DAILOG_XSD_TEACHERBOX_SWF:String="/swf/dailog_xsd_teacherbox.swf";
		/**
		 * 威创教学端开通服务的对话框swf路径：/swf/dailog_wtron_teacherbox.swf
		 */
		public static const DAILOG_WTRON_TEACHERBOX_SWF:String="/swf/dailog_wtron_teacherbox.swf";
		/**
		 * 课件打开、播放失败默认对话框路径：/swf/error.swf
		 */
		public static const ERROR_SWF:String="/swf/error.swf";
		/**
		 * 小水滴教学端错误提示框swf路径：/swf/error_xsd_teacherbox.swf
		 */
		public static const ERROR_XSD_TEACHERBOX_SWF:String="/swf/error_xsd_teacherbox.swf";
		/**
		 * 小水滴家庭端错误提示框swf路径：/swf/error_xsd_familybox.swf
		 */
		public static const ERROR_XSD_FAMILYBOX_SWF:String="/swf/error_xsd_familybox.swf";
		/**
		 * 威创教学端错误提示框swf路径：/swf/error_wtron_teacherbox.swf
		 */
		public static const ERROR_WTRON_TEACHERBOX_SWF:String="/swf/error_wtron_teacherbox.swf";
		/**
		 * 威创家庭端错误提示框swf路径：/swf/error_wtron_familybox.swf
		 */
		public static const ERROR_WTRON_FAMILYBOX_SWF:String="/swf/error_wtron_familybox.swf";
		/**
		 * 教学端 默认加载动画路径：/swf/loading-teacher.swf
		 */
		public static const LOADING_TEACHING_SWF:String="/swf/loading-teacher.swf";
		/**
		 * 小水滴教学端 加载动画路径：/swf/loading_xsd_teacherbox.swf
		 */
		public static const LOADING_XSD_TEACHING_SWF:String="/swf/loading_xsd_teacherbox.swf";
		/**
		 * 威创教学端 加载动画路径：/swf/loading_wtron_teacherbox.swf
		 */
		public static const LOADING_WTRON_TEACHING_SWF:String="/swf/loading_wtron_teacherbox.swf";
		/**
		 * 家庭端默认加载动画路径：/swf/loading-family.swf
		 */
		public static const LOADING_FAMILY_SWF:String="/swf/loading-family.swf";
		/**
		 * 小水滴家庭端家在动画路径：/swf/loading_xsd_familybox.swf
		 */
		public static const LOADING_XSD_FAMILY_SWF:String="/swf/loading_xsd_familybox.swf";
		/**
		 * 威创家庭端家在动画路径：/swf/loading_wtron_familybox.swf
		 */
		public static const LOADING_WTRON_FAMILY_SWF:String="/swf/loading_wtron_familybox.swf";
		/**
		 * 家庭端默认播放器皮肤路径：/swf/player.swf
		 */
		public static const PLAYER_SWF:String="/swf/player.swf";
		/**
		 * 小水滴家庭端播放器皮肤路径：/swf/player_xsd_familybox.swf
		 */
		public static const PLAYER_XSD_FAMILYBOX_PATH:String="/swf/player_xsd_familybox.swf";
		/**
		 * 威创家庭端播放器皮肤路径：/swf/player_wtron_familybox.swf
		 */
		public static const PLAYER_WTRON_FAMILYBOX_PATH:String="/swf/player_wtron_familybox.swf";
		/**
		 * 家庭端纯播放swf文件播放结束后的重播页面
		 */
		public static const REPLAY_PNG:String="/swf/replay.png";
		/**
		 * 关联园所和开通服务包名：com.ishuidi.boxproject
		 */
		public static const PACKAGE_NAME:String="com.ishuidi.boxproject";
		/**
		 * 关联园所类名：com.ishuidi.boxproject.module.more.accountaManage.ActivationProcessActivity
		 */
		public static const CONNECT_CLASS_NAME:String="com.ishuidi.boxproject.module.more.accountaManage.ActivationProcessActivity";
		/**
		 * 开通服务类名：com.ishuidi.boxproject.module.more.open_servers.OpenServiceActivity
		 */
		public static const SERVER_OPEN_NAME:String="com.ishuidi.boxproject.module.index.OpenServiceActivity";
		/**
		 * 播放器发送的广播：android.intent.action.SWF_ISPLAYING
		 */
		public static const APK_BROADCAST:String="android.intent.action.SWF_ISPLAYING";
		/**
		 * 绑定激活码，盒子当前日期不在服务有效期内,开通服务，跳转至此activity：com.ishuidi.boxproject.module.more.open_servers.SetMalRenewActivity
		 */;
		public static const MAL_RENEW_NAME:String="com.ishuidi.boxproject.module.more.open_servers.SetMalRenewActivity";
		
		public function PathConst()
		{
		}
	}
}