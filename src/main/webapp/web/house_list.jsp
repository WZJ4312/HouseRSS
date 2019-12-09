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
   	<script type="text/javascript" src="${ctx}/js/calendar/WdatePicker.js"></script>
	<link rel="stylesheet" href="${ctx}/static_shop/style/common.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/person_center.css">
    <link rel="stylesheet" href="${ctx}/static_shop/style/popup.css">
</head>
<body>
			<jsp:include page="/include/checkLogin.jsp" flush="true"></jsp:include>
			<jsp:include page="/include/top.jsp" flush="true"></jsp:include>
<div class="breadcrumbs">
    <div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="#" class="title_hoseType">房源管理</a></div>
</div>
    <div class="wrap clearfix">
		<jsp:include page="/include/left.jsp" flush="true"></jsp:include> 
		<div class="business-right">
          <div class="business-right-comm">
              <div class="business-info">
                <div class="integral-record-hd title_hoseType">房源管理</div>
                    <div class="integral-serch">
                        <div class="clearfix task-list" style="padding:18px 2px">
                            <span>城市：</span>
					<jsp:include page="/include/citys.jsp" flush="true"></jsp:include>
							<span>户型：</span>
							<select id="houseType" name="houseType">
								<option value="">不限</option>
								<option value="0">一室</option>
								<option value="1">二室</option>
								<option value="2">三室</option>
								<option value="3">四室</option>
								<option value="4">五室</option>
								<option value="5">五室以上</option>
							</select>
							<span>地址：</span>
                            <input id="address" name="address" value="" style="width: 200px;" />
                            <br>
                            <br>
							<span>价格：</span>
                            <input id="minPrice" name="minPrice" value="" style="width: 60px;" />
                            -
                            <input id="maxPrice" name="maxPrice" value="" style="width: 60px;" />
							<span>面积：</span>
                            <input id="minArea" name="minArea" value="" style="width: 60px;" />
                            -
                            <input id="maxArea" name="maxArea" value="" style="width: 60px;" />
                            <br>
                            <br>
							<span>审核状态：</span>
							<select id="status" name="status">
								<option value="">不限</option>
								<option value="0">未审核</option>
								<option value="1">已通过</option>
								<option value="2">已拒绝</option>
							</select>
							<span class="hideStatus_select">隐藏状态：</span>
							<select id="isHide" name="isHide" class="hideStatus_select">
								<option value="">不限</option>
								<option value="0">显示</option>
								<option value="1">隐藏</option>
							</select>
                            <a id="J-submiit-btn" class="business-mess-sent-btn" href="javascript:search();" style="margin-left:8px;">搜索</a>
                        </div>
                    </div><br/>
                    <div class="business-tabs-tasklinesheet-more task-list-table" style="margin-top:70px;">
                    	<div id="houseList">
						</div>
						<jsp:include page="/include/pager.jsp" flush="true"></jsp:include>
					</div>
                    
                </div>

              </div>
              
            </div>
      </div>
			<jsp:include page="/include/footer.jsp" flush="true"></jsp:include>
<script type="text/javascript"> 
var sellType = 0;
var curIsAdmin = false;
$(document).ready(function(){
	if(!checkLogin()){
		return;
	}
	if(isAdmin()){//管理员不显示编辑按钮
		$(".eidt_button").remove();
		$(".hideStatus_select").remove();
		curIsAdmin = true;
	}
	var tmpType = getQueryString("sellType");
	if(tmpType != null){
		sellType=tmpType;
	}
    if(sellType == 1){
        $("#zufang_yue").remove();
        $(".title_hoseType").html("售房管理");
    } else {
        $(".title_hoseType").html("租房管理");
    }
	$(".houseSellType_"+sellType).addClass("left_list_dd");
	search();
});

var afterLoadHouse = function(result){
	buildPager(result.data.sumPage, result.data.curPage, result.data.pageSize);
	for (var i = 0; i < result.data.data.length; i++) {
		var houseTmp = $("#house_tmp").html();
		houseTmp = houseTmp.replace(/@@title@@/g, result.data.data[i].title);
		houseTmp = houseTmp.replace(/@@houseId@@/g, result.data.data[i].id);
		houseTmp = houseTmp.replace(/@@time@@/g, result.data.data[i].publishDate);
		houseTmp = houseTmp.replace(/@@houseType@@/g, result.data.data[i].houseType);
		houseTmp = houseTmp.replace(/@@address@@/g, result.data.data[i].address);
		var priceVal = result.data.data[i].price;
		if(sellType == 1 && priceVal > 10000){
			priceVal = parseInt(priceVal/10000) + "万";
		} else {
			priceVal = priceVal + "元";
		}
		houseTmp = houseTmp.replace(/@@price@@/g, priceVal);
		houseTmp = houseTmp.replace(/@@username@@/g, result.data.data[i].publisherName);
		houseTmp = houseTmp.replace(/@@floor@@/g, result.data.data[i].floor);
		houseTmp = houseTmp.replace(/@@area@@/g, result.data.data[i].area);
		if(result.data.data[i].imageInfos != null){
			var img = result.data.data[i].imageInfos.split(",");
			if(img != null & img.length > 0) {
				houseTmp = houseTmp.replace(/@@houseImg@@/g, img[0]);
			}
		}
		var verifiedButton = "";
		var editButton = "";
		if(result.data.data[i].status == 1){
			houseTmp = houseTmp.replace(/@@verifiedName@@/g, "发布中");
			if (curIsAdmin) {
				verifiedButton = verifiedButton + "<a href=\"${ctx}/web/house_verified_fail.jsp?targetId="+result.data.data[i].id+"\" class=\"jx-trade\">不允许发布</a><br>";
			}
		} else if (result.data.data[i].status == 0){
			houseTmp = houseTmp.replace(/@@verifiedName@@/g, "审核中");
			if (curIsAdmin) {
				verifiedButton = "<a href=\"javascript:verifiedPassHouse('"+result.data.data[i].id+"');\" class=\"jx-trade\">允许发布</a><br>";
				verifiedButton = verifiedButton + "<a href=\"${ctx}/web/house_verified_fail.jsp?targetId="+result.data.data[i].id+"\" class=\"jx-trade\">不允许发布</a><br>";
			}
		} else {
			houseTmp = houseTmp.replace(/@@verifiedName@@/g, "不允许发布");
			if (!curIsAdmin) {
				editButton = "<a href=\"${ctx }/web/house_edit.jsp?houseId="+result.data.data[i].id+"\" class=\"jx-trade eidt_button\">编辑</a><br>"
			}
			if (curIsAdmin) {
				verifiedButton = "<a href=\"javascript:verifiedPassHouse('"+result.data.data[i].id+"');\" class=\"jx-trade\">允许发布</a><br>";
				verifiedButton = verifiedButton + "<a href=\"${ctx}/web/house_verified_fail.jsp?targetId="+result.data.data[i].id+"\" class=\"jx-trade\">不允许发布</a><br>";
			}
		}
		
		houseTmp = houseTmp.replace(/@@verifiedButton@@/g, verifiedButton);
		houseTmp = houseTmp.replace(/@@editButton@@/g, editButton);
		var setHideStatusButton = "";
		if (!curIsAdmin) {
			if(result.data.data[i].isHide == 1){
				setHideStatusButton = "<a href=\"javascript:setHideStatus('"+result.data.data[i].id+"', 0);\" class=\"jx-trade\">显示</a><br>";
			} else {
				setHideStatusButton = "<a href=\"javascript:setHideStatus('"+result.data.data[i].id+"', 1);\" class=\"jx-trade\">隐藏</a><br>";
			}
		}
		houseTmp = houseTmp.replace(/@@setHideStatusButton@@/g, setHideStatusButton);
		$("#houseList").append(houseTmp);
	}
}

var currentPage = 1;

function search(){
	searchPage(currentPage)
}

function searchPage(page){
	$("#houseList").html("");
	currentPage = page;
	var paramJo = {pageNum:page};//加载参数
	if(!curIsAdmin){//管理员不显示编辑按钮
		paramJo.isSelf=true;
	}
	if(sellType!=null){
		paramJo.sellType=sellType;
	}
	if($("#zone").val() != ""){
		paramJo.zone = $("#zone").val();
	}
	if($("#houseType").val() != ""){
		paramJo.houseType = $("#houseType").val();
	}
	if($("#address").val() != ""){
		paramJo.address = $("#address").val();
	}
	if($("#minPrice").val() != ""){
		paramJo.minPrice = $("#minPrice").val();
	}
	if($("#maxPrice").val() != ""){
		paramJo.maxPrice = $("#maxPrice").val();
	}
	if($("#minArea").val() != ""){
		paramJo.minArea = $("#minArea").val();
	}
	if($("#maxArea").val() != ""){
		paramJo.maxArea = $("#maxArea").val();
	}
	if($("#verified").val() != ""){
		paramJo.status = $("#status").val();
	}
	if($("#isHide").val() != ""){
		paramJo.isHide = $("#isHide").val();
	}
	//其他参数
	loadHouse("${ctx}", paramJo, afterLoadHouse);
}

/**
 * 删除房源
 * @param paramJo
 * @param successFun
 */
function delHouse(houseId) {
	var url = "${ctx}/house/delete.do";
	var paramJo = {houseId:houseId};
	postUrl(url, paramJo, function(){
		alert("删除成功");
		search();
	});
}
function setHideStatus(houseId, isHide) {
	var url = "${ctx}/house/setHideStatus.do";
	var paramJo = {houseId:houseId,isHide:isHide};
	postUrl(url, paramJo, function(){
		alert("操作成功");
		search();
	});
}
function verifiedPassHouse(houseId) {
	var url = "${ctx}/house/verified.do";
	var paramJo = {houseId:houseId,status:1};
	postUrl(url, paramJo, function(){
		alert("操作成功");
		search();
	});
}
</script>
	<div id="house_tmp" style="display: none">
		<table>
			<tbody>
				<tr>
					<th colspan="6">
						<span><a href="${ctx}/web/house_detail.jsp?houseId=@@houseId@@" class="trade-detail" target="_blank">@@title@@</a></span>
						&nbsp;&nbsp;发布时间：@@time@@
					</th>
				</tr>
				<tr>
					<td class="nb" style="width: 30%;">
						<div class="intableProLists">
							<img src="${ctx}/@@houseImg@@" style="width: 150px;height: 120px;" class="img">
						</div>
					</td>
					<td style="font-size: 14px; width: 15%;">@@houseType@@室 | @@floor@@层 | @@area@@m²</td>
					<td style="font-size: 14px; width: 20%;">@@address@@</td>
					<td style="font-size: 14px; width: 10%;"><span style="color: read">@@price@@</span> <span id="zufang_yue">/月</span></td>
					<td style="font-size: 14px; width: 10%;">@@verifiedName@@</td>
					<td style="font-size: 14px; width: 15%;">
						@@editButton@@
						@@setHideStatusButton@@
						@@verifiedButton@@
						<a href="javascript:delHouse('@@houseId@@');" class="jx-trade">删除</a><br>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>
