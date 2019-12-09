<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function(){
	var currentUser = "${currentUser.username}";
	if(currentUser == null || currentUser == ""){
		$("#has_login").hide();
		$("#un_login").show();
	} else {
		$("#un_login").hide();
		$("#has_login").show();
		var roleType = "${currentUser.roleType}";
		if(roleType == 1){
			$(".top_menu_admin_hide").hide();
		}
	}
})

function logout() {
	var url = "${ctx}/user/logout.do";
	postUrl(url, {}, function(){
		alert("操作成功");
		window.location.href = "${ctx}/web/index.jsp";
	});
}

function isOutTime(result) {
	if (result.indexOf("win.location.href='${ctx}/web/index.jsp'") > 0) {
		alert("登录超时,请重新登录.");
		var win = window;
		while (win != window.parent) {
			win = window.parent;
		}
		win.location.href='${ctx}/web/index.jsp';
		return true;
	}
	return false;
}
</script>           

<div>
	<div class="state" style="background:#F2F2F2;">
	    <div class="wrap">
<%-- 	        <span class="fr"><a href="${ctx}/help/help_center.jsp?left_list_id=-2" target="_blank">帮助中心</a></span> --%>
			<div id="un_login">
	   	        <a href="${ctx }/web/register_index.jsp">注册</a> ｜ <a href="${ctx}/web/index.jsp">登录</a>
			</div>
			<div id="has_login" style="display: none;">
				你好： ${currentUser.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:logout();">退出</a>
			</div>
   	    </div>
	</div>
</div>
	
<div class="header">
    <div class="wrap">
		<a class="logo fl" href="" style="margin-top: 7px;">
			<img src="${ctx}/static_shop/images/logo.png">
		</a>
        <menu class="business-menu fr" style="width:500px;">
            <a class="top_menu_admin_hide" href="${ctx }/web/house_add.jsp?sellType=0" target="_blank">发布租房</a>
            <a class="top_menu_admin_hide" href="${ctx }/web/house_add.jsp?sellType=1" target="_blank">发布售房</a>
            <a href="${ctx }/web/userinfo.jsp">个人中心</a>
            <a class="top_menu_admin_hide" href="${ctx }">查找房源</a>
        </menu>
    </div>
</div>

<%-- <iframe width="121" height="277" scrolling="no" frameborder="0" allowtransparency="true" src="${ctx}/include/qq_button.jsp" style="display: block; position: fixed; z-index: 2147483646 !important; left: auto; right: 8px; margin-left: 0px; top: 50%; bottom: auto; margin-top: -138px;"> --%>
<!-- </iframe> -->