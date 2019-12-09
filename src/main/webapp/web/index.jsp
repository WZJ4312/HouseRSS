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
	  	<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
	  	<script type="text/javascript" src="${ctx}/js/api.js"></script>
		<link rel="stylesheet" href="${ctx}/static_shop/style/common.css">
		<link rel="stylesheet" href="${ctx}/static_shop/style/login.css">

	<style type="text/css">
	</style>
   
	<script type="text/javascript">
	function login() {
		if ($("#username").val().trim() == "") {
			alert("用户名不能为空.");
			scrollAndSelect("username");
			return;
		}
		if ($("#password").val().trim() == "") {
			alert("密码不能为空.");
			scrollAndSelect("password");
			return;
		}
		if ($("#uvcode").val().trim() == "") {
			alert("验证码不能为空.");
			scrollAndSelect("uvcode");
			return;
		}
		var url = "${ctx}/user/login.do";
		$.ajax({
			url:url,
			type:'post',
			data:{
				username:$("#username").val().trim(),
				password:$("#password").val().trim(),
				uvcode:$("#uvcode").val().trim()
			},
			dataType:'json',
			timeout:60000,
			error: function(e) {
				alert("连接服务器超时,请稍后再试.");
			},
			success: function(result){
				if (result.status==0) {
					window.location.href = "${ctx}/web/house_list.jsp";
				} else {
					changeCode();
					$("#code").val("");
					alert(result.msg);
				}
			}
		});
	}
	
	function changeCode() {
		document.getElementById("img").src="${ctx}/web/code.jsp?num="+Math.random();
	}
	
	</script>
	</head>
	<body>
		<div class="state" style="background:#F2F2F2;">
		    <div class="wrap">
		        <span class="fr"><a href="${ctx}/help/help_center.jsp?left_list_id=-2" target="_blank">帮助中心</a></span>
	   	        <a href="${ctx }/web/register_index.jsp">注册</a> ｜ <a href="${ctx}/web/index.jsp">登录</a>
	   	    </div>
		</div>

		<div class="header">
			<div class="wrap">
				<a class="logo fl" href="" style="margin-top: 7px;">
					<img src="${ctx}/static_shop/images/logo.png">
				</a>
		        <menu class="business-menu fr" style="width:500px;">
		            <a href="${ctx }">查找房源</a>
		        </menu>
			</div>
		</div>

		<div class="renqifu_con">

			<div class="renqifu_login">
				<div class="imglist">
					<div id="slider3" class="slider">
						<div class="conbox">
							<div style="position: absolute; z-index: 9; opacity: 1;">
								<img src="${ctx}/static_shop/images/imglist1.png"
										height="315" width="513" alt="">
							</div>
						</div>
						<!--div class="switcher">
                       <a href="#" class="cur"></a>
                       <a class="" href="#"></a>
                       <a class="" href="#"></a>
                  </div-->
					</div>
				</div>
				<form action="" method="post" onkeydown="if(event.keyCode==13) {login();}">
					<input type="hidden" name="cnt_num" value="1">
					<div class="login">
						<div class="logintop"></div>
						<div class="logincen">
							<h3>
								用户登录
							</h3>

							<!-- 用户名或密码错误提示 -->
							<span class="login-tpis" id="login-tpis" style="display: none;"></span>

							<div class="login_input inp">
								<label>
									用户名：
								</label>
								<input type="text" cname="one" name="username"
									class="txt placebox" regname="usernameno" placeholder="请输入用户名"
									id="username" value="" emptyerr="用户名不能为空">
							</div>
							<div class="login_input inp">
								<label>
									登录密码：
								</label>
								<input type="password" cname="one" class="txt placebox"
									name="password" id="password" regname="loginpasswordno"
									placeholder="请输入密码" value="" emptyerr="密码不能为空">
							</div>
							<!-- <p id="dianjicishu"><p> -->
							<!-- 验证码 三次错误提示后需要验证码显示此验证码div 并且将button显示下面的隐藏上面的 -->
<!-- 							<div id="code" style="display: none;"> -->
							<div id="code">
								<div class="login_input inp">
			                        <label>验证码：</label>
									<input type="text" class="txt placebox" style="width:100px;" id="uvcode" name="uvcode" placeholder="请输入验证码" value="">
									<img src="${ctx}/web/code.jsp" id="img" onclick="javascript:changeCode();" title="换一张" style="position:relative;top:10px;">
								</div>
						 	</div>

							<div class="login_button">
								<!-- <input type="submit" name="button" id="button" class="loginbtn" value="登录" onclick="javascript:login();" />-->
								<!-- 需要验证码时换为此button  上面的button隐藏 -->
								<input type="button" name="button" class="loginbtn" value="登  录" id="Button1" onclick="javascript:login();">
								<div>
									<a href="${ctx}/web/register_index.jsp">注册账号</a>
									<p></p>
									<a href="${ctx}/web/find_passwd.jsp">忘记密码？</a>
								</div>
							</div>
						</div>
						<div class="loginbott"></div>
					</div>
				</form>

			</div>
		</div>

			<jsp:include page="/include/footer.jsp" flush="true"></jsp:include>
	</body>
</html>