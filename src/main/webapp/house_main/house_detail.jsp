<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<title>房屋租赁平台</title>
	<script type="text/javascript" src="${ctx}/js/base.js"></script>
	<script type="text/javascript" src="${ctx}/js/api.js"></script>
  	<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<link rel="stylesheet" rev="stylesheet" href="${ctx}/house_main/house_detail_files/Zufang_Web_View_Broker.css" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
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
		$("#houseType_" + result.data.houseType).show();
		$("#orientation_" + result.data.orientation).show();
		$("#decorateType_" + result.data.decorateType).show();
		$("#zone").html(result.data.zone);
		$("#floor").html(result.data.floor); 
		$("#area").html(result.data.area); 
		$("#address").html(result.data.address); 
		$("#title").html(result.data.title); 
		$("#decoration").html(result.data.decoration.replace(/\\n/g, "<br />")); 
		$("#publishDate").html(result.data.publishDate); 
		$("#publisherName").html(result.data.publisherName); 
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
</head>
<body>
	<div class="navhead">
		<div class="header-center clearfix">
		</div>
	</div>

	<div class="wrapper">
		<h3 id="title" class="house-title">这是一个房源信息标题</h3>
		<div class="mainbox cf">
			<div class="lbox">
				<!--轮播组件-->
				<div class="switch_warpper">
					<!--室内图-->
					<div class="switch_list" id="houseOldImgList">
					</div>
				</div>

				<!--房屋信息-->
				<div class="mod-title bottomed">
					<h3 id="houseInfo" class="title nav-scroll">房屋信息</h3>
					<div class="right-info">
						<span id="zone" style="color: red;">厦门</span>&nbsp;&nbsp;&nbsp;
						发布时间：<span id="publishDate">2019年03月08日</span>
					</div>
				</div>

				<ul class="house-info-zufang cf">
					<li class="house-info-item"><span class="type">发布人：</span> <span class="info"><span id="publisherName">xxx</span></span></li>
					<li class="house-info-item"><span class="type">电话：</span> <span class="info"><span id="publishPhone">1500000000</span></span></li>
				</ul>

				<ul class="house-info-zufang cf">
					<li class="full-line cf"><span class="price"><em id="price">1600</em></span> <span class="type">面议</span></li>
					<li class="house-info-item l-width"><span class="type">户型：</span>                                    	<span style="display: none;" id="houseType_0">一室</span>
                                   	<span style="display: none;" id="houseType_1">二室</span>
                                   	<span style="display: none;" id="houseType_2">三室</span>
                                   	<span style="display: none;" id="houseType_3">四室</span>
                                   	<span style="display: none;" id="houseType_4">五室</span>
                                   	<span style="display: none;" id="houseType_5">五室以上</span></li>
					<li class="house-info-item"><span class="type">面积：</span> <span class="info"><span id="area">35</span>平方米</span></li>
					<li class="house-info-item"><span class="type">朝向：</span><span style="display: none;" id="orientation_0">南</span><span style="display: none;" id="orientation_1">西南</span><span style="display: none;" id="orientation_2">西</span><span style="display: none;" id="orientation_3">西北</span><span style="display: none;" id="orientation_4">北</span><span style="display: none;" id="orientation_5">东北</span><span style="display: none;" id="orientation_6">东</span><span style="display: none;" id="orientation_7">东西</span></li>
					<li class="house-info-item l-width"><span class="type">楼层：</span> <span id="floor" class="info"></span></li>
					<li class="house-info-item"><span class="type">装修：</span> 
                                   	<span style="display: none;" id="decorateType_0">毛坯</span>
                                   	<span style="display: none;" id="decorateType_1">普通装修</span>
                                   	<span style="display: none;" id="decorateType_2">精装修</span>
                                   	<span style="display: none;" id="decorateType_3">豪华装修</span></li>
				</ul>
				<ul class="house-info-zufang cf">
					<li class="full-line cf"><span class="type">地址：</span> <span class="info"><span id="address">xxx</span></span></li>
				</ul>
				<!--房屋配套-->
				<div class="mod-title bottomed">
					<h3 class="title">房源概况</h3>
				</div>
				<div id="decoration" class="auto-general">
				</div>
			</div>
		</div>
	</div>
</body>
</html>
