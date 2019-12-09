<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<script type="text/javascript"> 
function checkLogin(){
	var currentUser = "${currentUser.username}";
	if(currentUser == null || currentUser == ""){
		alert("您还未登入，请先登入！");
		window.location.href = "${ctx}/web/index.jsp";
		return false;
	}
	
	if(typeof(initLeft)=="function")
	{
	//存在
	   initLeft();
	}
	
	return true;
}

function isAdmin(){
	var currentUser = "${currentUser.username}";
	if(currentUser == null || currentUser == ""){
		return false;
	} else {
		var roleType = "${currentUser.roleType}";
		return roleType == 1;
	}
}
</script>
