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
	function find_passwd(){
		var paramJo = {
				email:$("#email").val(),
				username:$("#username").val(),
				code:$("#code").val()
		}; 
		postUrl("${ctx}/user/sendResetPwdMail.do", paramJo, function(result){
			window.location.href = "${ctx}/web/send_success.jsp";
		});
	}
	
	function changeCode() {
		document.getElementById("img").src="${ctx}/web/code.jsp?num="+Math.random();
	}
	</script>
	</head>
	<body>
			<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<div class="breadcrumbs">
    <div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="#">找回登陆密码</a></div>
</div>
<div class="container">
    <div class="Shadowbox">
        <div class="Shadowboxp"></div>
        <div class="register">
            <div class="passwd-title">
            	<span>找回登录密码</span>
                <a href="${ctx}/web/index.jsp">返回登录</a>
            </div>
            <div class="inputBox ModifyEmail">
                <div class="inputMain">
                <form name="from" id="from">
                    <div class="item clearfix">
                        <label class="tit">请输入您注册的账号:</label>
                        <div class="inp">
                            <em class="inpbox" style="position: relative;">
                                <i class="icon-E"></i>                      
                                <input type="text" cname="one" placeholder="请输入账号" id="username" name="username" class="txt placebox" regname="username" emptyerr="账号不能为空" value=""> 
							</em>
                        </div>
                    </div>
                    <div class="item clearfix">
                        <label class="tit">请输入您注册的邮箱:</label>
                        <div class="inp">
                            <em class="inpbox" style="position: relative;">
                                <i class="icon-E"></i>                      
                                <input type="text" cname="one" placeholder="请输入邮箱地址" id="email" name="email" class="txt placebox" regname="email" emptyerr="邮箱地址不能为空" value=""> 
							</em>
                        </div>
                    </div>
					<div class="item clearfix">
						<label class="tit">
							<i>*</i>验证码:
						</label>
						<div class="inp">
							<em class="inpbox" style="position: relative;"> 
							<i class="icon-Y"></i> 
							<input name="code" style="width: 115px;" type="text" class="txt placebox" id="code" size="15" maxlength="6" cname="one" placeholder="请输入验证码" regname="code" emptyerr="验证码不能为空" value="">
							</em>
							<em style="cursor: pointer; vertical-align: middle; display: inline-block; margin-left: 5px;">
								<img src="${ctx}/web/code.jsp" id="img" onclick="javascript:changeCode();" title="换一张" class="yz_img">
							</em>
							<a href="javascript:changeCode();"
								style="font-size: 12px; color: #07d; margin-left: 5px;"
								class="yz_a">看不清，换一张</a>
							<!-- <span class="error">验证码输入有误，请重新输入</span> -->
						</div>
					</div>
					<p class="item Emailsub">
                        <a href="javascript:find_passwd();" class="Emailsubbtn">确认修改</a>
                    </p>
                     </form>
                 </div>
            </div>
            
        </div>
        <div class="Shadowboxb"></div>
    </div>
</div>
			<jsp:include page="/include/footer.jsp" flush="true"></jsp:include>
	</body>
</html>