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
		 * callback_activity_name= com.ishuidi.boxproject.module.index.OpenServiceActivity&family_media_id=1234&family_material_id=123456&resource_info=托班上-课程中心-整合课程-我来啦-幼儿园里真快乐！
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
				if(realDatas.length==12){
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
					dataInfo.resource_info=realDatas[11].split("=")[1];
					return dataInfo;
				}
			}
			return null;
		}
		
		
		public static function parse2DataInfo(args:Array):JollyClassDataInfo
		{
			var dataInfo:JollyClassDataInfo=new JollyClassDataInfo();
			var datas:String=args[0] as String;
			var resultIndex:int = datas.indexOf("result=");
			if(resultIndex==-1){
				return dataInfo;
			}
			var fullDatas:String = datas.substr(resultIndex);
			if(isEmpty(fullDatas)){
				return dataInfo;
			}
			var realDatas:Array = fullDatas.split("&");
			if(realDatas.length<1){
				return dataInfo;
			}
			for(var i:int=0;i<realDatas.length;i++){
				var values:Array = realDatas[i].split("=");
				switch(values[0]){
					case "result":
						dataInfo.swfPath=values[1];
						break;
					case "product_type":
						dataInfo.product_type=values[1];
						break;
					case "resource_type":
						dataInfo.resource_type=values[1];
						break;
					case "customer_service_tel":
						dataInfo.customer_service_tel=values[1];
						break;
					case "play_scene":
						dataInfo.play_scene=values[1];
						break;
					case "teaching_resource_id":
						dataInfo.teaching_resource_id=values[1];
						break;
					case "teaching_play_trial_duration":
						dataInfo.teaching_play_trial_duation=values[1];
						break;
					case "package_name":
						dataInfo.package_name=values[1];
						break;
					case "callback_activity_name":
						dataInfo.callback_activity_name=values[1];
						break;
					case "family_media_id":
						dataInfo.family_material_id=values[1];
						break;
					case "family_material_id":
						dataInfo.family_media_id=values[1];
						break;
					case "resource_info":
						dataInfo.resource_info=values[1];
						break;
					default:
						trace(values[0]);
						break;
				}
			}
			return dataInfo;
		}
		
		public static function isEmpty(str:String):Boolean{
			if(str=="null"||str==null||str==""){
				return true;
			}
			return false;
		}
	}
}