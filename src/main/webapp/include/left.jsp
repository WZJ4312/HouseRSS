<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="left">
	<dl style="border-top: none;">
		<dt>帐号管理</dt>
		<dd class="userinfo_dd">
			<a target="_self" href="${ctx }/web/userinfo.jsp">基本信息</a>
		</dd>
		<dd class="usermanager_dd admin_user_dd" style="display: none;">
			<a target="_self" href="${ctx }/web/user_list.jsp">用户管理</a>
		</dd>
	</dl>
	<dl>
		<dt>平台管理</dt>
		<dd class="houseSellType_0">
			<a target="_self" href="${ctx }/web/house_list.jsp?sellType=0">租房管理</a>
		</dd>
		<dd class="houseSellType_1">
			<a target="_self" href="${ctx }/web/house_list.jsp?sellType=1">售房管理</a>
		</dd>
		<dd class="complaint_user_message houseSellType_2" style="display: none;">
			<a target="_self" href="${ctx }/web/complaint_user_message.jsp?">消息通知</a>
		</dd>
		<dd class="report_records" style="display: none;">
			<a target="_self" href="${ctx }/web/complaint_report_records.jsp">被举报记录</a>
		</dd>
		<dd class="complaint_user_list admin_user_dd" style="display: none;">
			<a target="_self" href="${ctx }/web/complaint_user_list.jsp">举报用户管理</a>
		</dd>
		<dd class="complaint_house_list admin_user_dd" style="display: none;">
			<a target="_self" href="${ctx }/web/complaint_house_list.jsp">举报房源管理</a>
		</dd>
	</dl>
</div>

<script type="text/javascript"> 
function initLeft(){
	if(isAdmin()){
		$(".admin_user_dd").show();
	} else {
		$(".houseSellType_2").show();
		$(".report_records").show();
		$(".admin_user_dd").hide();
	}
}
</script>
