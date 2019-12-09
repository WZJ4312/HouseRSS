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
    <div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="#">编辑房源</a> </div>
</div>
    <form id="to_step_three" action="${ctx}/house/publish.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" id="houseId" />
    <div class="container">
        <div class="Shadowbox">
            <div class="Shadowboxp"></div>
            <div class="register">
					<div class="register-title">
						<span class="bram-title">编辑房源</span>
					</div>
					<div class="issue-task-two"> 
                    <div class="flow-info checkout-steps">
                        <h1>填写房屋信息</h1>
                        <h3>基础信息</h3>
                        <div>
                            <div class="step-complete-Writ-box-1">
                                <div class="step-item inp">
                                    <strong>类型： </strong>
                                    <select class="w130 sellType_select" style="height: 32px;" disabled="disabled">
                                    	<option value="0">租房</option>
                                    	<option value="1">二手房</option>
                                    </select>
                                    <input type="hidden" id="sellType" name="sellType" value="" />
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>区域： </strong>
					<jsp:include page="/include/citys.jsp" flush="true"></jsp:include>
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>标题： </strong>
                                    <input type="text" id="title" name="title" class="text w460 J_NAME_INPUT" value="">
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>地址： </strong>
                                    <input type="text" id="address" name="address" class="text w460 J_URL_INPUT" value="">
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>价格： </strong>
                                    <input type="text" id="price" name="price" class="text w130 J_URL_INPUT" value="" onchange="value=value.replace(/[^\d]/g,'')"><span id="zufang_yue">元 /月</span>
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>面积： </strong>
                                    <input type="text" id="area" name="area" class="text w130 J_URL_INPUT" value="" onchange="value=value.replace(/[^\d]/g,'')">m²
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>楼层： </strong>
                                    <input type="text" id="floor" name="floor" class="text w130 J_URL_INPUT" value="" onchange="value=value.replace(/[^\d]/g,'')">
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>朝向： </strong>
                                    <select id="orientation" name="orientation" class="w130" style="height: 32px;">
                                    	<option value="0">南</option>
                                    	<option value="1">西南</option>
                                    	<option value="2">西</option>
                                    	<option value="3">西北</option>
                                    	<option value="4">北</option>
                                    	<option value="5">东北</option>
                                    	<option value="6">东</option>
                                    	<option value="7">东西</option>
                                    </select>
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>户型： </strong>
                                    <select id="houseType" name="houseType" class="w130" style="height: 32px;">
                                    	<option value="0">一室</option>
                                    	<option value="1">二室</option>
                                    	<option value="2">三室</option>
                                    	<option value="3">四室</option>
                                    	<option value="4">五室</option>
                                    	<option value="5">五室以上</option>
                                    </select>
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>装修： </strong>
                                    <select id="decorateType" name="decorateType" class="w130" style="height: 32px;">
                                    	<option value="0">毛坯</option>
                                    	<option value="1">普通装修</option>
                                    	<option value="2">精装修</option>
                                    	<option value="3">豪华装修</option>
                                    </select>
                                    <span class="newtips">必填</span>
                                </div>
                                <div class="step-item inp">
                                    <strong>描述： </strong>
                                </div>
                                <div class="step-item inp" style="margin-top: 100">
                                    <strong> </strong>
                                    <textarea id="decoration" name="decoration" class="text w460 J_NAME_INPUT" style="height: 200px;"></textarea>
                                </div>
                            </div>
                        </div>
                        
                        <h3>房屋图片</h3>
                        <h4>已有房源图片列表</h4>
                        <div class="flow-source">
							<div id="houseOldImgList" class="keyword">
							</div>
                        </div>
                        <h4>选择要添加房源图片</h4>
                        <div class="flow-source">
                            <p class="prompt"><label>提示：</label><span>请上传清晰的房屋图片</span></p>
							<div id="houseImgList" class="keyword">
							</div>
							<p class="step-list-add"><a id="add_key_words" href="javascript:addHouseImg();"><img src="${ctx}/static_shop/images/icon_add.gif">添加图片</a></p>
                        </div>
                    </div>
                    
                    <div class="checkout-btnbox">
                        <div class="publish-btnbox">
							<p class="item itembtnp">
								<a href="javascript:next_step();" class="itembtn">确认修改</a>
							</p>
                        </div>
                    </div>
                </div>
                
            </div>
            <div class="Shadowboxb"></div>
        </div>
    </div>
    </form>
	<div id="houseImg_old_tmp" style="display: none;">
		<div>
			@@img@@
			<div style="display: none" class="imgUrl">@@imgUrl@@</div>
			<span class="red"><a style="color: blue;" onclick="javascript:houseOldImgDel(this)">删除</a></span>
		</div>
	</div>
	<div id="houseImg_tmp" style="display: none;">
		<div>
			<input type="file" name="images" class="input_file" >
			<span class="red"><a style="color: blue;" onclick="javascript:houseImgDel(this)">删除</a></span>
		</div>
	</div>
			<jsp:include page="/include/footer.jsp" flush="true"></jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	if(!checkLogin()){
		return;
	}
	var houseId = getQueryString("houseId");
	$("#houseId").val(houseId);
	var paramJo = {houseId:houseId}; 
	detailHouse("${ctx}", paramJo, function(result){
		$("#sellType").val(result.data.sellType); 
		$(".sellType_select").val(sellType);
	    if(result.data.sellType == 1){
	        $("#zufang_yue").html("元");
	    }
		var zoneTmp = result.data.zone.split("_");
		$("#select_province").val(zoneTmp[0]);
		selectProvince();
		$("#zone").val(result.data.zone);
		$("#houseType").val(result.data.houseType); 
		$("#price").val(result.data.price); 
		$("#orientation").val(result.data.orientation); 
		$("#floor").val(result.data.floor); 
		$("#decorateType").val(result.data.decorateType); 
		$("#area").val(result.data.area); 
		$("#address").val(result.data.address); 
		$("#title").val(result.data.title); 
		$("#decoration").val(result.data.decoration); 
        var img = result.data.imageInfos.split(",");
        for (var i = 0; i < img.length; i++) {
            var imgUrl = img[i];
            if(imgUrl==""){
            	continue;
            }
            var tmpImg = $("#houseImg_old_tmp").html();
            tmpImg = tmpImg.replace(/@@img@@/g, '<img alt="房源图片" src="${ctx}/'+imgUrl+'" />');
            tmpImg = tmpImg.replace(/@@imgUrl@@/g, imgUrl);
            $("#houseOldImgList").append(tmpImg);
        }
	});
});

function addHouseImg(){
	$("#houseImgList").append($("#houseImg_tmp").html());
}

function houseImgDel(e){
	$(e).parent().parent().remove();
}
function houseOldImgDel(e){
	var imgUrl = $(e).parent().parent().find(".imgUrl").html();
	$(e).parent().parent().find(".imgUrl").html('<input type="text" name="deletes" value="'+imgUrl+'" />');
	$(e).parent().parent().hide();
}
 
function next_step() {
	if($("#title").val().trim() == ""){
		alert("标题不能为空");
		return;
	}
	if($("#address").val().trim() == ""){
		alert("详细地址不能为空");
		return;
	}
	if($("#price").val().trim() == ""){
		alert("价格不能为空");
		return;
	}
	if(isNaN($("#price").val().trim()) || parseInt($("#price").val().trim()) <= 0){
		alert("价格输入有误");
		return;
	}
	if($("#area").val().trim() == ""){
		alert("面积不能为空");
		return;
	}
	if(isNaN($("#area").val().trim()) || parseInt($("#area").val().trim()) <= 0){
		alert("面积输入有误");
		return;
	}
	if($("#floor").val().trim() == ""){
		alert("楼层不能为空");
		return;
	}
	if(isNaN($("#floor").val().trim()) || parseInt($("#floor").val().trim()) <= 0){
		alert("楼层输入有误");
		return;
	}
	$("#to_step_three").ajaxSubmit({  
        success: function(result){
			if (result.status==0) {
	    		alert("发布成功");
	    		window.location.href = "${ctx}/web/house_list.jsp?sellType="+$("#sellType").val()+"";
			} else {
				alert(result.msg);
			}
        },  
        error: function(XmlHttpRequest, textStatus, errorThrown){  
			alert("请求失败 errorThrown:" + errorThrown);
        }  
    });
}
</script>

</body></html>