package com.jollyclass.airplayer.util
{
	import com.jollyclass.airplayer.constant.FieldConst;
	import com.jollyclass.airplayer.constant.PathConst;
	/**
	 * swf路径选择工具类，根据不同的product_type进行选择，主要针对以下几种swf文件进行选择：
	 * 1、error信息的swf文件，根据不同的type，选择不同的error文件。
	 * 2、player播放器皮肤swf文件，根据不同的type，显示不同的player。
	 * 3、dailog信息的swf文件，根据不同的type，显示不同的开通服务dailgo文件。
	 * @author 邹丹丹
	 */
	public class PathUtil
	{
		public function PathUtil()
		{
		}
		/**
		 * error信息的swf文件，根据不同的type，选择不同的error文件。
		 * @return 返回所需的error文件路径
		 */
		public static function selectErrorPath(type:String):String
		{
			var error_swf:String;
			switch(type){
				case FieldConst.XSD_TEACHER_BOX:
					error_swf=PathConst.ERROR_XSD_TEACHERBOX_SWF;
					break;
				case FieldConst.XSD_FAMILY_BOX:
					error_swf=PathConst.ERROR_XSD_FAMILYBOX_SWF;
					break;
				case FieldConst.WTRON_TEACHER_BOX:
					error_swf=PathConst.ERROR_WTRON_TEACHERBOX_SWF;
					break;
				case FieldConst.WTRON_FAMILY_BOX:
					error_swf=PathConst.ERROR_WTRON_FAMILYBOX_SWF;
					break;
				default:
					error_swf=PathConst.ERROR_SWF;
					break;
			}
			return error_swf;
		}
		/**
		 * player播放器皮肤swf文件，根据不同的type，显示不同的player。
		 * @return 返回所需的player播放器皮肤文件路径
		 */
		public static function selectPlayerPath(type:String):String{
			var player_swf:String;
			switch(type){
				case FieldConst.XSD_FAMILY_BOX:
					player_swf=PathConst.PLAYER_XSD_FAMILYBOX_PATH;
					break;
				case FieldConst.WTRON_FAMILY_BOX:
					player_swf=PathConst.PLAYER_WTRON_FAMILYBOX_PATH;
					break;
				default:
					player_swf=PathConst.PLAYER_SWF;
					break;
			}
			return player_swf;
		}
		/**
		 * dailog信息的swf文件，根据不同的type，显示不同的开通服务dailgo文件。
		 * @return 返回所需的dailog文件路径
		 */
		public static function selectDialogPath(type:String):String
		{
			var dailog_swf:String;
			switch(type){
				case FieldConst.XSD_TEACHER_BOX:
					dailog_swf=PathConst.DAILOG_XSD_TEACHERBOX_SWF;
					break;
				case FieldConst.WTRON_TEACHER_BOX:
					dailog_swf=PathConst.DAILOG_WTRON_TEACHERBOX_SWF;
					break;
				default:
					dailog_swf=PathConst.DAILOG_SWF;
					break;
			}
			return dailog_swf;
		}
	}
}