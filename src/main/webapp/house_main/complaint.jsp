<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>房屋租赁平台</title>
	<script type="text/javascript" src="${ctx}/js/base.js"></script>
	<script type="text/javascript" src="${ctx}/js/api.js"></script>
  	<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
	<link rel="stylesheet" href="${ctx}/static_shop/style/common.css" />
    <link rel="stylesheet" href="${ctx}/static_shop/style/person_center.css" />
    <link rel="stylesheet" href="${ctx}/static_shop/style/popup.css" />
    <link rel="stylesheet" href="${ctx}/static_shop/style/register.css" />
    <link rel="stylesheet" href="${ctx}/static_shop/style/release.css" />
<link rel="stylesheet" rev="stylesheet" href="${ctx}/house_main/house_detail_files/Zufang_Web_View_Broker.css" type="text/css" />

			<jsp:include page="/include/checkLogin.jsp" flush="true"></jsp:include>
<script type="text/javascript">
var targetId;
var reportType;
$(document).ready(function(){
	if(!checkLogin()){
		return;
	}
	targetId = getQueryString("targetId");
	reportType = getQueryString("reportType");
	if(reportType==0){
		$("#reportTypeStr").val("投诉用户");
	} else {
		$("#reportTypeStr").val("投诉房源");
	}
	var targetStr = getQueryString("targetStr");
	$("#targetStr").html(targetStr);
});

function complaint(){
	var paramJo = {
			reporterId:"${currentUser.id}",
			reportederId:targetId,
			type:reportType,
			description:$("#description").val()
	}; 
	postUrl("${ctx}/reportInfo/report.do", paramJo, function(result){
		alert("投诉成功");
		goback();
	});
}
</script>
</head>
<body>
	<div class="navhead">
		<div class="header-center clearfix">
		</div>
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
                        <h1>填写投诉原因</h1>
                        <div>
                            <div class="step-complete-Writ-box-1">
                                <div class="step-item inp" style="margin-top: 100">
                                    <strong> </strong>
                                    <textarea id="description" name="description" class="text w460 J_NAME_INPUT" style="height: 200px;"></textarea>
                                </div>
                            </div>
                        </div>
                    <div class="checkout-btnbox">
                        <div class="publish-btnbox">
							<p class="item itembtnp">
								<a href="javascript:complaint();" class="itembtn">确认</a>
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
</body>
</html>