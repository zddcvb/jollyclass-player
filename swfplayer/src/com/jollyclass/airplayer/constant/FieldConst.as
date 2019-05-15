package com.jollyclass.airplayer.constant
{
	/**
	 * 特殊字段常量
	 * @author 邹丹丹
	 */
	public class FieldConst
	{
		/**
		 * 标识为家庭端盒子：“familybox”
		 */
		public static const FAMILY_BOX:String="familybox";
		/**
		 * 标识为教学端盒子：“teachingbox”
		 */
		public static const TEACHING_BOX:String="teachingbox";
		/**
		 * 标识为小水滴课堂教学端盒子：xsd_teacherbox
		 */
		public static const XSD_TEACHER_BOX:String="xsd_teacherbox";
		/**
		 * 标识为小水滴课堂家庭端盒子：xsd_familybox
		 */
		public static const XSD_FAMILY_BOX:String="xsd_familybox";
		/**
		 * 标识为威创教学端盒子：wtron_teacherbox
		 */
		public static const WTRON_TEACHER_BOX:String="wtron_teacherbox";
		/**
		 * 标识为威创家庭端盒子：wtron_famimlybox
		 */
		public static const WTRON_FAMILY_BOX:String="wtron_famimlybox";
		/**
		 * 默认的客服电话："13632220258"
		 */
		public static const DEFAULT_TELPHONE:String="13632220258";
		/**
		 * 小水滴售后电话：13632220258
		 */
		public static const XSD_DEFAULT_TELPHONE:String="13632220258";
		/**
		 * 威创售后电话：400-176-7088
		 */
		public static const WTRON_DEFAULT_TELPHONE:String="400-176-7088";
		/**
		 * 标识为第三方资源："other"
		 */
		public static const OTHER_RESOURCES:String="other";
		/**
		 * 标识为小水滴课堂资源："xsd"
		 */
		public static const XSD_RESOURCES:String="xsd";
		/**
		 * 此部分只针对两类课件：
		 * 1、只添加了stop()代码，但总帧数小于50，此时不显示播放进度条。
		 * 2、无代码的课件
		 * 交互课件与无代码课件的标识数字：课件的总帧数大于50，则表示无代码，小于50则表示只添加了stop();
		 */
		public static const INTERACTION_FRAME:Number=50;
		/**
		 * 快进快退的帧数：120
		 */
		public static const FORWARD_REWARD_FRAME:Number=120;
		
		
		public function FieldConst()
		{
		}
	}
}