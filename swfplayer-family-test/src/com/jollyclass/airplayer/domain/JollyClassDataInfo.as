package com.jollyclass.airplayer.domain
{
	
	/**
	 * 小水滴课堂独有的属性字段
	 * @author 邹丹丹
	 */
	public class JollyClassDataInfo
	{
		/**
		 * swf文件的绝对路径
		 */
		private var _swfPath:String;
		/**
		 * 定义使用播放器的产品类型
		 * 小水滴教学端:xsd_teachingbox
		 * 小水滴家庭端:xsd_familybox
		 * 威创教学端:wtron_familybox
		 * 威创家庭端:wtron_familybox
		 */
		private var _product_type:String;
		/**
		 * 定义播放的资源是小水滴自有的还是其他第三方的。这个参数只适用于所有产品
		 * 播放的资源是小水滴的，则值为xsd；如果是第三方的，则值为other
		 */
		private var _resource_type:String;
		/**
		 * 定义产品的客服电话
		 * 小水滴教学端、家庭端：13632220258
		 * 威创教学端、家庭端：400-176-7088
		 */
		private var _customer_service_tel:String;
		/**
		 * 定义播放场景以及播放器需要执行的动作：
		 * 0:已付费会员可以正常播放
		 * 1:绑定激活码，盒子当前日期不在服务有效期内（播放10s,弹出开通服务窗口）
		 * 2:未开通服务（播放10s,弹出开通服务窗口）
		 */
		private var _play_scene:int;
		/**
		 * 教学端盒子的资源id(课件id或者素材id)。这个参数只适用于教学端盒子
		 */
		private var _teaching_resource_id:String;
		/**
		 * 定义在未开通会员下播放体验时长，以秒为单位。这个参数只适用于教学端盒子
		 */
		private var _teaching_play_trial_duation:int;
		/**
		 * 宿主应用app的包名，这个参数适用于所有产品。
		 */
		private var _package_name:String;
		/**
		 * 在某些播放场景下，在播放过程中需要跳转到宿主app功能页面的页面名称。这个参数目前只适用于教学盒子产品。
		 */
		private var _callback_activity_name:String;
		/**
		 * 播放的媒资id。这个参数只适用于家庭端盒子
		 */
		private var _family_media_id:String;
		/**
		 * 播放的素材id。这个参数只适用于家庭端盒子
		 */
		private var _family_material_id:String;
		
		public function JollyClassDataInfo()
		{
		}
		
		public function get customer_service_tel():String
		{
			return _customer_service_tel;
		}
		
		public function set customer_service_tel(value:String):void
		{
			_customer_service_tel = value;
		}
		
		public function get swfPath():String
		{
			return _swfPath;
		}
		
		public function set swfPath(value:String):void
		{
			_swfPath = value;
		}
		
		public function get family_material_id():String
		{
			return _family_material_id;
		}
		
		public function set family_material_id(value:String):void
		{
			_family_material_id = value;
		}
		
		public function get family_media_id():String
		{
			return _family_media_id;
		}
		
		public function set family_media_id(value:String):void
		{
			_family_media_id = value;
		}
		
		public function get teaching_resource_id():String
		{
			return _teaching_resource_id;
		}
		
		public function set teaching_resource_id(value:String):void
		{
			_teaching_resource_id = value;
		}
		
		public function get play_scene():int
		{
			return _play_scene;
		}
		
		public function set play_scene(value:int):void
		{
			_play_scene = value;
		}
		
		public function get resource_type():String
		{
			return _resource_type;
		}
		
		public function set resource_type(value:String):void
		{
			_resource_type = value;
		}
		
		public function get product_type():String
		{
			return _product_type;
		}
		
		public function set product_type(value:String):void
		{
			_product_type = value;
		}
		
		public function toString():String
		{
			return "JollyClassDataInfo[swfPath:"+_swfPath+",product_type:"+_product_type+",resource_type:"+_resource_type+",customer_service_tel"+_customer_service_tel+
				",play_scene:"+_play_scene+",teaching_resource_id:"+_teaching_resource_id+",teaching_play_trial_duation:"+teaching_play_trial_duation+",package_name:"+package_name+",callback_activity_name:"+_callback_activity_name+",family_media_id:"+_family_media_id+",family_material_id:"+_family_material_id+"]";
		}

		public function get teaching_play_trial_duation():int
		{
			return _teaching_play_trial_duation;
		}

		public function set teaching_play_trial_duation(value:int):void
		{
			_teaching_play_trial_duation = value;
		}

		public function get package_name():String
		{
			return _package_name;
		}

		public function set package_name(value:String):void
		{
			_package_name = value;
		}

		public function get callback_activity_name():String
		{
			return _callback_activity_name;
		}

		public function set callback_activity_name(value:String):void
		{
			_callback_activity_name = value;
		}

		
	}
}