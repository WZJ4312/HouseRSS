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
  	<script type="text/javascript" src="${ctx}/js/jquery-form.js"></script>
	<link rel="stylesheet" href="${ctx}/static_shop/style/common.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/person_center.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/popup.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/register.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/release.css">
</head>
<body>
			<jsp:include page="/include/checkLogin.jsp" flush="true"></jsp:include>
			<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<div class="breadcrumbs">
    <div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="#">拒绝审核</a> </div>
</div>
    <div class="container">
        <div class="Shadowbox">
            <div class="Shadowboxp"></div>
            <div class="register">
					<div class="register-title">
						<span id="reportTypeStr" class="bram-title">投诉</span>
					</div>
					<div class="issue-task-two"> 
                    <div class="flow-info checkout-steps">
                                <div class="step-item inp">
                                    <strong id="targetStr"></strong>
                                </div>
                        <h1>填写拒绝通过原因</h1>
                        <div>
                            <div class="step-complete-Writ-box-1">
                                <div class="step-item inp" style="margin-top: 100">
                                    <strong> </strong>
                                    <textarea id="reason" name="reason" class="text w460 J_NAME_INPUT" style="height: 200px;"></textarea>
                                </div>
                            </div>
                        </div>
                    <div class="checkout-btnbox">
                        <div class="publish-btnbox">
							<p class="item itembtnp">
								<a href="javascript:verifiedPassHouse();" class="itembtn">确认</a>
							</p>
                        </div>
                    </div>
                    </div>
                </div>
                
            </div>
            <div class="Shadowboxb"></div>
        </div>
    </div>
			<jsp:include page="/include/footer.jsp" flush="true"></jsp:include>
<script type="text/javascript">
var targetId;
$(document).ready(function(){
	if(!checkLogin()){
		return;
	}
	if(!isAdmin()){
		alert("不是管理员不是进行该操作！");
		return;
	}
	targetId = getQueryString("targetId");
	var targetStr = getQueryString("targetStr");
	$("#targetStr").html(targetStr);
});

function verifiedPassHouse() {
	var url = "${ctx}/house/verified.do";
	var paramJo = {
			houseId:targetId,
			status:2,
			reason:$("#reason").val()
	};
	postUrl(url, paramJo, function(){
		alert("操作成功");
        goback();
	});
}
</script>

</body></html>