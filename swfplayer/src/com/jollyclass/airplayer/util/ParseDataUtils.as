package com.jollyclass.airplayer.util
{
	import com.jollyclass.airplayer.domain.JollyClassDataInfo;
	
	/**
	 * 数据解析工具类
	 * @author 邹丹丹
	 */
	public class ParseDataUtils
	{
		public function ParseDataUtils()
		{
		}
		/**
		 * @param args my-customuri://result=" + resourceUri+”&product_type=xsd_teachingbox&resource_type=xsd&customer_service_tel=13632220258&
		 * play_scene=0&teaching_resource_id=123456&teaching_play_trial_duration=10&package_name=com.ishuidi.boxproject&
		 * callback_activity_name= com.ishuidi.boxproject.module.index.OpenServiceActivity&family_media_id=1234&family_material_id=123456
		 */
		public static function parseDataInfo(args:Array):JollyClassDataInfo
		{
			var dataInfo:JollyClassDataInfo=new JollyClassDataInfo();
			var datas:String=args[0] as String;
			var resultIndex:int=datas.indexOf("result=");
			var productIndex:int=datas.indexOf("product_type=");
			var resourceIndex:int=datas.indexOf("resource_type=");
			var serviceIndex:int=datas.indexOf("customer_service_tel=");
			if(resultIndex!=-1&&productIndex!=-1&&resourceIndex!=-1&&serviceIndex!=-1)
			{
				var fullDatas:String = datas.substr(datas.indexOf("result"));
				var realDatas:Array = fullDatas.split("&");
				if(realDatas.length==11){
					dataInfo.swfPath=realDatas[0].split("=")[1];
					dataInfo.product_type=realDatas[1].split("=")[1];
					dataInfo.resource_type=realDatas[2].split("=")[1];
					dataInfo.customer_service_tel=realDatas[3].split("=")[1];
					dataInfo.play_scene=realDatas[4].split("=")[1];
					dataInfo.teaching_resource_id=realDatas[5].split("=")[1];
					dataInfo.teaching_play_trial_duation=realDatas[6].split("=")[1];
					dataInfo.package_name=realDatas[7].split("=")[1];
					dataInfo.callback_activity_name=realDatas[8].split("=")[1];
					dataInfo.family_media_id=realDatas[9].split("=")[1];
					dataInfo.family_material_id=realDatas[10].split("=")[1];
					return dataInfo;
				}
			}
			return null;
		}
	}
}