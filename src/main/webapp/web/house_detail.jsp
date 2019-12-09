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
    <link rel="stylesheet" href="${ctx}/static_shop/style/person_center.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/popup.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/register.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/release.css">
</head>
<body>
			<jsp:include page="/include/checkLogin.jsp" flush="true"></jsp:include>
			<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<div class="breadcrumbs">
    <div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="#">房源详情</a> </div>
</div>
    <input type="hidden" name="houseId" id="houseId" />
    <div class="container">
        <div class="Shadowbox">
            <div class="Shadowboxp"></div>
            <div class="register">
					<div class="register-title">
						<span class="bram-title">房源详情</span>
					</div>
					<div class="issue-task-two"> 
                    <div class="flow-info checkout-steps">
                        <h1>填写房屋信息</h1>
                        <h3>基础信息</h3>
                        <div>
                            <div class="step-complete-Writ-box-1" style="font-size: 15px;">
                                <div class="step-item inp">
                                    <label>类型： </label>
                                    <span style="display: none;" id="sellType_0">租房</span>
                                    <span style="display: none;" id="sellType_1">二手房</span>
                                </div>
                                <div id="publishUser_div" class="step-item inp" style="display: none;">
                                    <label>发布人： </label>
                                   	<span id="publishUser"></span>
                                </div>
                                <div id="publishPhone_div" class="step-item inp" >
                                    <label>电话： </label>
                                   	<span id="publishPhone"></span>
                                </div>
                                <div class="step-item inp">
                                    <label>区域： </label>
                                   	<span id="zone"></span>
                                </div>
                                <div class="step-item inp">
                                    <label>标题： </label>
                                    <span id="title"></span>
                                </div>
                                <div class="step-item inp">
                                    <label>地址： </label>
                                    <span id="address"></span>
                                </div>
                                <div class="step-item inp">
                                    <label>价格： </label>
                                    <span id="price"></span>
                                </div>
                                <div class="step-item inp">
                                    <label>面积： </label>
                                    <span id="area"></span>m²
                                </div>
                                <div class="step-item inp">
                                    <label>楼层： </label>
                                    <span id="floor"></span>
                                </div>
                                <div class="step-item inp">
                                    <label>朝向： </label>
                                   	<span style="display: none;" id="orientation_0">南</span>
                                   	<span style="display: none;" id="orientation_1">西南</span>
                                   	<span style="display: none;" id="orientation_2">西</span>
                                   	<span style="display: none;" id="orientation_3">西北</span>
                                   	<span style="display: none;" id="orientation_4">北</span>
                                   	<span style="display: none;" id="orientation_5">东北</span>
                                   	<span style="display: none;" id="orientation_6">东</span>
                                   	<span style="display: none;" id="orientation_7">东西</span>
                                </div>
                                <div class="step-item inp">
                                    <label>户型： </label>
                                   	<span style="display: none;" id="houseType_0">一室</span>
                                   	<span style="display: none;" id="houseType_1">二室</span>
                                   	<span style="display: none;" id="houseType_2">三室</span>
                                   	<span style="display: none;" id="houseType_3">四室</span>
                                   	<span style="display: none;" id="houseType_4">五室</span>
                                   	<span style="display: none;" id="houseType_5">五室以上</span>
                                </div>
                                <div class="step-item inp">
                                    <label>装修： </label>
                                   	<span style="display: none;" id="decorateType_0">毛坯</span>
                                   	<span style="display: none;" id="decorateType_1">普通装修</span>
                                   	<span style="display: none;" id="decorateType_2">精装修</span>
                                   	<span style="display: none;" id="decorateType_3">豪华装修</span>
                                </div>
                                <div class="step-item inp">
                                    <label>描述： </label>
                                </div>
                                <div class="step-item inp" style="margin-top: 100">
                                    <textarea id="decoration" name="decoration" readonly="readonly" class="text w460 J_NAME_INPUT" style="height: 200px;"></textarea>
                                </div>
                                <div class="step-item inp">
                                    <label>状态： </label>
                                   	<span style="display: none;" id="status_0">审核中</span>
                                   	<span style="display: none;" id="status_1">审核通过</span>
                                   	<span style="display: none;" id="status_2">审核失败</span>
                                </div>
                                <div class="step-item inp verified_fail_reason" style="display: none;">
                                    <label style="color: red;">审核失败原因*： </label>
                                </div>
                                <div class="step-item inp verified_fail_reason" style="margin-top: 100; display: none;">
                                    <textarea id="reason" name="reason" readonly="readonly" class="text w460 J_NAME_INPUT" style="height: 200px; color: red;"></textarea>
                                </div>
                            </div>
                        </div>
                        
                        <h3>房屋图片</h3>
                        <h4>已有房源图片列表</h4>
                        <div class="flow-source">
							<div id="houseOldImgList" class="keyword">
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
$(document).ready(function(){
	if(!checkLogin()){
		return;
	}
	if(isAdmin()){//管理员查看房源详情才显示发布人和电话
		$(".publishUser_div").show();
		$(".publishPhone_div").show();
	}
	var houseId = getQueryString("houseId");
	$("#houseId").val(houseId);
	var paramJo = {houseId:houseId}; 
	detailHouse("${ctx}", paramJo, function(result){
        if(result.data.sellType == 1){
    		if(result.data.price > 10000){
    			$("#price").html(parseInt(result.data.price/10000)+"万"); 
    		} else {
    			$("#price").html(result.data.price + "元"); 
    		}
        } else {
			$("#price").html(result.data.price + "元/月"); 
        }
		$("#sellType_" + result.data.sellType).show();
		$("#houseType_" + result.data.houseType).show();
		$("#orientation_" + result.data.orientation).show();
		$("#decorateType_" + result.data.decorateType).show();
		$("#status_" + result.data.status).show();
		if(result.data.status == 2){
			$(".verified_fail_reason").show();
		}
		$("#zone").html(result.data.zone);
		$("#floor").html(result.data.floor); 
		$("#area").html(result.data.area); 
		$("#address").html(result.data.address); 
		$("#title").html(result.data.title); 
		$("#decoration").html(result.data.decoration); 
		$("#reason").html(result.data.reason); 
		$("#publishUser").html(result.data.publishUser); 
		$("#publishPhone").html(result.data.publishPhone); 
        var img = result.data.imageInfos.split(",");
		for (var i = 0; i < img.length; i++) {
            if(img[i]==""){
                continue;
            }
			var tmpImg = '<div><img alt="房源图片" src="${ctx}/'+img[i]+'" /></div>';
			$("#houseOldImgList").append(tmpImg);
		}
	});
});
</script>

</body></html>