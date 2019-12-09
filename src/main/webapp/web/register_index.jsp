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
	<link rel="stylesheet" href="${ctx}/static_shop/style/common.css">
	<link rel="stylesheet" href="${ctx}/static_shop/style/register.css">
	<style type="text/css">
	input, button, textarea, fieldset, img {border: 0 none;}
	</style>
	<script type="text/javascript">
	function register() {
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
		if ($("#password_confirm").val().trim() != $("#password").val().trim()) {
			alert("两次密码不一致.");
			scrollAndSelect("password_confirm");
			return;
		}
		if ($("#name").val().trim() == "") {
			alert("名称不能为空.");
			scrollAndSelect("useremail");
			return;
		}
		if ($("#usermobile").val().trim() == "") {
			alert("手机不能为空.");
			scrollAndSelect("usermobile");
			return;
		}
		
		var url = "${ctx}/user/register.do";
		$.ajax({
			url:url,
			type:'post',
			data:{
				username:$("#username").val().trim(),
				password:$("#password").val().trim(),
				name:$("#name").val().trim(),
				phone:$("#usermobile").val().trim(),
				email:$("#email").val().trim(),
			},
			dataType:'json',
			timeout:60000,
			error: function(e) {
				alert("连接服务器超时,请稍后再试.");
			},
			success: function(result){
				if (result.status==0) {
					window.location.href = "${ctx }/web/index.jsp";
				} else {
					alert(result.msg);
				}
			}
		});
	}
	</script>
</head>
<body>
			<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<div class="breadcrumbs">
	<div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="register_index.jsp">注册</a> &gt; <a href="register_index.jsp">填写注册信息</a></div>
</div>
<div class="container">
    <div class="Shadowbox">
        <div class="Shadowboxp"></div>
        <div class="register">
            <div class="register-title">
            	<span class="register-title" style="margin-top:15px;"></span>
                <strong>已有账号?<a href="${ctx}">立即登陆</a></strong>
            </div>    
            <div class="register-main">
            <div class="register-tabs">
				<form autocomplete="off" action="#" method="post">
                <input type="hidden" name="invite_id" value="0">
                <input type="hidden" name="partner" value="0">
                <div class="register-tabs-bd">
                    <div class="register-tabs-main">
                        <div class="register-business clearfix">


                            <div class="register-business-form">                            
                                <div class="item clearfix">
                                    <label class="tit">用户名:</label>
                                    <div class="inp">
                                        <em class="inpbox">
                                            <i class="icon-U"></i>
                                            <input type="text" id="username" name="username" cname="one" placeholder="请输入用户名" warn="用户名4-15个字符，一个汉字为2个字符 " checkurl="ture" class="txt placebox" regname="username" emptyerr="用户名不能为空">
                                        </em>
                                    </div>
                                </div>
                                <div class="item clearfix">
                                    <label class="tit">密码:</label>
                                    <div class="inp">
                                        <em class="inpbox">
                                            <i class="icon-P"></i>
                                            <input type="password" autocomplete="off" placeholder="请输入密码" warn="长度6~16位数字、字母、字符包含两种 " cname="one" class="txt placebox" confirmationpass="password" id="password" name="password" regname="loginpassword" emptyerr="密码不能为空">
                                        </em>                   
                                    </div>
                                </div>  
                                <div class="item clearfix">
                                    <label class="tit">确认密码:</label>
                                    <div class="inp">
                                        <em class="inpbox">
                                            <i class="icon-P"></i>
                                            <input type="password" placeholder="请输入确认密码" warn="请再次确认密码" cname="one" class="txt placebox" name="confirmationpassword" confirmation="password" id="password_confirm" emptyerr="确认密码不能为空" confirmationerr="输入密码不一致,请重新填写">
                                        </em>                   
                                    </div>
                                </div>  
                                <div class="item clearfix">
                                    <label class="tit">名称:</label>
                                    <div class="inp">
                                        <em class="inpbox">
                                            <i class="icon-E"></i>                      
                                            <input type="text" warn="请填写您的名称" cname="one" checkurl="ture" placeholder="请输入名称" name="name" id="name" class="txt placebox" regname="name" emptyerr="名称不能为空">
                                        </em>   
                                    </div>
                                </div>  
                                <div class="item clearfix">
                                    <label class="tit">邮箱:</label>
                                    <div class="inp">
                                        <em class="inpbox">
                                            <i class="icon-Q"></i>                      
                                            <input type="text" warn="便于客服与您联系" cname="one" checkurl="ture" placeholder="请输入邮箱" name="email" class="txt placebox" id="email" regname="email" emptyerr="邮箱不能为空">
                                        </em>   
                                    </div>
                                    <label>
                                    	<span style="color: red; line-height: 30px;">&nbsp;*请填写常用的邮箱，注册后不能修改！</span>
                                    </label>
                                </div>
                                
                                <div class="item clearfix">
                                    <label class="tit">手机:</label>
                                    <div class="inp">
                                        <em class="inpbox">
                                            <i class="icon-M"></i>                      
                                            <input type="text" warn="" cname="one" checkurl="ture" placeholder="请输入手机号" name="usermobile" class="txt placebox" id="usermobile" regname="mobile" emptyerr="手机号不能为空">  
                                        </em>
                                              
                                    </div>
                                    <!-- <a href="javascript:;" class="cord" onclick="javascript:cord();">发送验证码</a> -->
                                    <!-- <span class="cordspan" style="display:none;">60秒后可重新发送</span> -->
                                </div>


<!--                                 <div id="rqftype" class="item clearfix" >
                                    <label class="tit">验证码:</label>
                                    <div class="inp">
                                        <em class="inpbox">
                                            <i class="icon-YZM"></i>                      
                                            <input type="text" warn="无验证码不可注册" cname="one" checkurl="ture" placeholder="请输入验证码" name="code" class="txt placebox" id="code" regname="code" emptyerr="验证码不能为空"/>  
                                        </em>          
                                    </div>
                                </div>   -->                                                                    
                                <p class="item loginsub inp">
                                    <button type="button" onclick="javascript:register();" class="loginbtn" id="submit_btn" name="submit_btn">立即注册</button>
                                </p>                                    
                            </div>
                            
                            <div class="register-business-info">
                                <h3>为什么选择我们？</h3>
                                <p>面对行业“互联网＋”转型的时代趋势，我们在为用户提供一站式服务的同时，我们不断深化行业研究，优化全网资源配置，提升平台价值体量。</p>
                            </div>
                            
                        </div>                
                    </div>
                </div>
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