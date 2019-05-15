package com.jollyclass.airplayer.domain
{
	public class DataInfo
	{
		/**
		 * swf路径
		 */
		protected  var _swfPath:String;
		
		/**
		 * 产品类型：teacherbox和familybox
		 */
		protected  var _product_type:String;
		
		/**
		 * 如果播放的资源是小水滴的，则值为xsd；如果是第三方的，则值为other,这个参数只适用于所有产品
		 参数取值
		 */
		protected  var _resource_type:String;
		
		/**
		 *参数描述：定义产品的客服电话。这个参数适用于所有产品
		 */
		protected  var _customer_service_tel:String;
		
		
		public  function fname():void
		{
			trace();
		}
		public function DataInfo()
		{
		}
		
		public function get swfPath():String
		{
			return _swfPath;
		}


		public function set swfPath(value:String):void
		{
			_swfPath = value;
		}

	
		public function get product_type():String
		{
			return _product_type;
		}

		public function set product_type(value:String):void
		{
			_product_type = value;
		}


		public function get resource_type():String
		{
			return _resource_type;
		}

		public function set resource_type(value:String):void
		{
			_resource_type = value;
		}

		
		public function get customer_service_tel():String
		{
			return _customer_service_tel;
		}

		public function set customer_service_tel(value:String):void
		{
			_customer_service_tel = value;
		}
		public function toString():String
		{
			return "DataInfo[swfPath:"+_swfPath+",product_type:"+_product_type+",resource_type:"+_resource_type+",customer_service_tel"+_customer_service_tel+"]";
		}

	}
}