# jollyclass-player
##	
##1.2019-04-18第一次改版，增加以下内容
		1）支持有代码的交互课件，不显示进度条。
	2）增加自动返回、退出功能。

##2、2019-05-15第二次改版，增加以下内容：
	1）增加mp4、flv播放功能，实现了播放暂停快进快退；
	2）重新定义了宿主app所发送的数据格式。
	3）增设动态修改dailog、error、loading和play等ui的功能。
	4）实现了加载图片的功能。
	5）解决家庭端模式动画播放完成自动返回的问题。
	
##3.2019-05-23第三次改版，增加以下内容：
	1）增设了新的error提示，当宿主app发送的数据不对或者不完整时显示错误对话框。

##4.2019-06-15第四次改版，增加以下内容：
	。	将家庭端和教学端整合成一个播放器。
	。	播放器支持多客户模式，根据宿主app发送的数据，判断播放器当前模式，调用对应的ui文件。

##5.2019-9-24第五次改版，增加以下内容：
	。	宿主app增加新的字段：resourceInfo，将当前课件的课件名称路径以及信息发送至播放器
	。	播放器错误提示页面发生改变，增加resourceInfo字段至错误页面，完整的错误字段表述如下
		。	托班上-课程中心-整合课程-我来啦-幼儿园里真快乐！ 错误代码（jx01），联系客服13632220258