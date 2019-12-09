<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<meta http-equiv="X-UA-Compatible"content="IE=10; IE=9; IE=8; IE=7; IE=EDGE">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
		<meta http-equiv="expires" content="0">
		<title>房屋租赁平台</title>
		<meta name="keywords" content="房屋租赁平台">
		<meta name="description" content="房屋租赁平台">
		<link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen">
		<script type="text/javascript" src="${ctx}/js/base.js"></script>
		<script type="text/javascript" src="${ctx}/js/api.js"></script>
	  	<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
		<link rel="stylesheet" href="${ctx}/static_shop/style/common.css">
		<link rel="stylesheet" href="${ctx}/static_shop/style/login.css">
		<link rel="stylesheet" href="${ctx}/static_shop/style/register.css">

	<style type="text/css">
	</style>
   
	<script type="text/javascript">
	</script>
	</head>
	<body>
			<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<div class="breadcrumbs">
    <div class="wrap"><a href="${ctx}">首页</a> &gt; <a href="#">找回登陆密码</a></div>
</div>
<div class="container">
    <div class="Shadowbox">
        <div class="Shadowboxp"></div>
        <div class="register">
            <div class="passwd-title">
            	<span>找回登录密码</span>
                <a href="${ctx}/web/index.jsp">返回登录</a>
            </div>
            
            <div class="inputBox">
            	<div class="pwdtwo">
                	<h3>请到邮箱查收确认邮件，单击相应链接完成验证（48小时有效）</h3>
                    <p>未收到邮件？</p>
                    <p>请先检查是否在垃圾邮件中</p>
                   <!--  <p>十分钟内未收到验证邮件，请点击&nbsp;&nbsp;<a href="/user/find_passwd">重新发送邮件</a></p> -->
                </div>
            	
            </div>
            
        </div>
        <div class="Shadowboxb"></div>
    </div>
</div>
			<jsp:include page="/include/footer.jsp" flush="true"></jsp:include>
	</body>
</html>