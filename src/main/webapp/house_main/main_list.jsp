<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="location" content="province=福建;city=厦门;coord=118.132632,24.511853">
<title>房屋租赁平台</title>
<meta name="keywords" content="房屋租赁平台">
<meta name="description" content="房屋租赁平台">
<meta name="apple-itunes-app" content="app-id=527806786">
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
	<script type="text/javascript" src="${ctx}/js/base.js"></script>
	<script type="text/javascript" src="${ctx}/js/api.js"></script>
<link rel="stylesheet" rev="stylesheet" href="${ctx}/house_main/main_list_files/Ershou_Web_Property_List_Search.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${ctx}/house_main/main_list_files/a3b553063d7ab45b780700cb45429573.css">
<script type="text/javascript">
var sellType=0;
var orderType=0;
$(document).ready(function(){
	var currentUser = "${currentUser.username}";
	if(currentUser == null || currentUser == ""){
		$("#has_login").hide();
		$("#un_login").show();
	} else {
		$("#un_login").hide();
		$("#has_login").show();
	}
	var address = getQueryString("address");
	var tmpType = getQueryString("sellType");
	if(tmpType != null){
		sellType=tmpType;
	}
	if(sellType == 1){
		$("#sellTypeTitle").html("二手房");
		$("#sell_price_0").remove();
		$("#preMPrice_span").show();
		$("#zufang_yue").remove();
	} else {
		$("#sell_price_1").remove();
	}
	search();
});

var afterLoadHouse = function(result){
	buildPager(result.data.sumPage, result.data.curPage, result.data.pageSize);
	if(result.data.data.length == 0){
		$("#result_find_desc").html("没有符合要求的房源...");
	} else {
		$("#result_find_desc").html("为您找到以下房源");
		for (var i = 0; i < result.data.data.length; i++) {
			var houseTmp = $("#house_tmp").html();
			houseTmp = houseTmp.replace(/@@title@@/g, result.data.data[i].title);
			houseTmp = houseTmp.replace(/@@houseId@@/g, result.data.data[i].id);
			houseTmp = houseTmp.replace(/@@time@@/g, result.data.data[i].time);
			houseTmp = houseTmp.replace(/@@houseType@@/g, result.data.data[i].houseType);
			houseTmp = houseTmp.replace(/@@address@@/g, result.data.data[i].address);
			houseTmp = houseTmp.replace(/@@publishPhone@@/g, result.data.data[i].publishPhone);
			houseTmp = houseTmp.replace(/@@publisherName@@/g, result.data.data[i].publisherName);
			var priceVal = result.data.data[i].price;
			var areaVal = result.data.data[i].area;
			var preMPrice = parseInt(priceVal / areaVal);
			if(sellType == 1 && priceVal > 10000){
				priceVal = parseInt(priceVal/10000) + "万";
			} else {
				priceVal = priceVal + "元";
			}
			houseTmp = houseTmp.replace(/@@price@@/g, priceVal);
			houseTmp = houseTmp.replace(/@@preMPrice@@/g, preMPrice);
			houseTmp = houseTmp.replace(/@@floor@@/g, result.data.data[i].floor);
			houseTmp = houseTmp.replace(/@@area@@/g, areaVal);
			houseTmp = houseTmp.replace(/@@userId@@/g, result.data.data[i].userId);
			if(result.data.data[i].imageInfos != null){
				var img = result.data.data[i].imageInfos.split(",");
				if(img != null & img.length > 0) {
					houseTmp = houseTmp.replace(/@@houseImg@@/g, img[0]);
				}
			}
			$("#houselist-mod-new").append(houseTmp);
		}
	}
}

function logout() {
	var url = "${ctx}/user/logout.do";
	postUrl(url, {}, function(){
		alert("操作成功");
		window.location.href = "${ctx}/web/index.jsp";
	});
}

var currentPage = 1;

function search(){
	searchPage(currentPage)
}

function searchPage(page){
	$("#houselist-mod-new").html("");
	currentPage = page;
	var paramJo = {//加载参数
		pageNum:page,
		sellType:sellType,
		status:1,//已通过
		isHide:0//不隐藏
	};
	if($("#zone").val() != ""){
		paramJ.zone = $("#zone").val();
	}
	if($("#houseType").val() != ""){
		paramJo.houseType = $("#houseType").val();
	}
	if($("#address").val() != ""){
		paramJo.address = $("#address").val();
	}
	if($("#minPrice").val() != ""){
		paramJo.minPrice = $("#minPrice").val();
		if(sellType==1&&paramJo.minPrice!=""){
			paramJo.minPrice = paramJo.minPrice+"0000";
		}
	}
	if($("#maxPrice").val() != ""){
		paramJo.maxPrice = $("#maxPrice").val();
		if(sellType==1&&paramJo.maxPrice!=""){
			paramJo.maxPrice = paramJo.maxPrice+"0000";
		}
	}
	if($("#minArea").val() != ""){
		paramJo.minArea = $("#minArea").val();
	}
	if($("#maxArea").val() != ""){
		paramJo.maxArea = $("#maxArea").val();
	}
	if(orderType > 0){//orderType, 0默认，1面积降序，2价格升序，3时间降序（最新）
		paramJo.orderType = orderType;
	}
	//其他参数
	loadHouse("${ctx}", paramJo, afterLoadHouse);
}

function changePrice(minPrice, maxPrice, e){
	$("#minPrice").val(minPrice);
	$("#maxPrice").val(maxPrice);
	$(e).parent().find(".selected-item").removeClass("selected-item");
	$(e).addClass("selected-item");
}

function changeArea(minArea, maxArea, e){
	$("#minArea").val(minArea);
	$("#maxArea").val(maxArea);
	$(e).parent().find(".selected-item").removeClass("selected-item");
	$(e).addClass("selected-item");
}

function selectOrder(e, type){
	orderType=type;
	$(e).parent().find(".cur").removeClass("cur");
	$(e).addClass("cur");
	search();
}
</script>
</head>
<body data-page="Ershou_Web_Property_List_SearchPage">
	<div id="container">
		<div id="header">
			<div class="top-nav  glbNavigation ">
				<div class="glbListNavigation1180 nav-content">
					<ul class="L_tabsnew">
						<li class="li_single first-child li_unselected"><a class="a_navnew" href="${ctx}">首 页</a></li>
					</ul>
					<!-- 用户信息 theme TabBarNew -->
					<div class="R_user">
						<div class="login_info">
							<div class="dropdown user-login l" id="login_l">
								<div id="un_login" class="title m">
									<a href="${ctx }/web/index.jsp" class="u_l" rel="nofollow">登录</a> 
									<a href="${ctx }/web/register_index.jsp" class="u_r" rel="nofollow">注册</a>
								</div>
								<div id="has_login" class="m" style="display: none;">
									<a href="${ctx }/web/userinfo.jsp" id="username_a" class="u_l" rel="nofollow">${currentUser.name}</a> 
									<a href="javascript:logout();">退出</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="content">
			<!-- 搜索框-->
			<div class="div-border items-list">
				<!-- 从区域开始区域 begin-->

				<!-- 区域 begin-->
				<div class="items">
					<span class="item-title">城市：</span>
					<jsp:include page="/include/citys.jsp" flush="true"></jsp:include>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="item-title">地址：</span>
					<form>
						<input type="text" id="address" name="address" value="" style="width: 240px;text-align: left;" />
					</form>
				</div>
				<!-- 区域 end-->

				<!--  户型 begin-->
				<!-- 售价 begin-->
				<div id="sell_price_1" class="items ">
				<span class="item-title">售价：</span><span class="elems-l">
						<a href="javascript:void(0);" onclick="javascript:changePrice('','',this);" class="selected-item">全部</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice('',100,this);">100万以下</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(100,150,this);">100-150万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(150,200,this);">150-200万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(200,250,this);">200-250万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(250,300,this);">250-300万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(300,400,this);">300-400万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(400,500,this);">400-500万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(500,700,this);">500-700万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(700,1000,this);">700-1000万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(1000,1500,this);">1000-1500万</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(1500,'',this);">1500万以上</a>
				        <div class="pricecond">
				        <form>
				            <input class="from-price " type="text" name="minPrice" maxlength="5" id="minPrice" autocomplete="off" value=""> -
				            <input class="to-price " type="text" name="maxPrice" maxlength="5" id="maxPrice" autocomplete="off" value="">&nbsp;<span class="">万</span>
				        </form>
				    </div>
				</span></div>
				<div id="sell_price_0" class="items ">
					<span class="item-title">租金：</span><span class="elems-l">
						<a href="javascript:void(0);" onclick="javascript:changePrice('','',this);" class="selected-item">全部</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice('',500,this);">500以下</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(500,800,this);">500-800元</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(800,1000,this);">800-1000元</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(1000,1500,this);">1000-1500元</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(1500,2000,this);">1500-2000元</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(2000,3000,this);">2000-3000元</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(3000,5000,this);">3000-5000元</a>
						<a href="javascript:void(0);" onclick="javascript:changePrice(5000,'',this);">5000元以上</a>
				        <div class="pricecond">
				        <form>
				            <input class="from-price " type="text" name="minPrice" maxlength="6" id="minPrice" autocomplete="off" value=""> -
				            <input class="to-price " type="text" name="maxPrice" maxlength="6" id="maxPrice" autocomplete="off" value="">
				        </form>
				    </div>
				</span></div>

				<!-- 面积 begin-->
				<div class="items">
					<span class="item-title">面积：</span><span class="elems-l">
						<a href="javascript:void(0);" onclick="javascript:changeArea('','',this);" class="selected-item">全部</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea('',50,this);">50m²以下</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea(50,70,this);">50-70m²</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea(70,90,this);">70-90m²</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea(90,110,this);">90-110m²</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea(110,130,this);">110-130m²</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea(130,150,this);">130-150m²</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea(150,200,this);">150-200m²</a>
						<a href="javascript:void(0);" onclick="javascript:changeArea(200,'',this);">200m²以上</a>
				        <div class="areacond" style="display: inline">
				        <form>
				            <input class="from-area " type="text" maxlength="5" name="minArea" id="minArea" value=""> -
				            <input class="to-area " type="text" maxlength="5" name="maxArea" id="maxArea" value="">&nbsp;<span class="">m²</span>
				        </form>
				    </div>
				    
				
				</span></div>
				<!--  房型 begin-->
				<div class="items ">
					<span class="item-title">房型：</span>
					<select id="houseType" name="houseType">
						<option value="">不限</option>
						<option value="0">一室</option>
						<option value="1">二室</option>
						<option value="2">三室</option>
						<option value="3">四室</option>
						<option value="4">五室</option>
						<option value="5">五室以上</option>
					</select>
				</div>
				
				<!-- 特色 begin-->

				<div class="search_bottom clearfix">
					<div id="condmenu">
						<ul class="condul clearfix">
							<li class="condlist_tip"><span>更多：</span></li>
							<!-- house age start -->
							
							<li id="condarrow_id">
                                <select id="orientation" name="orientation">
                                	<option value="">朝向-请选择</option>
                                	<option value="0">南</option>
                                	<option value="1">西南</option>
                                	<option value="2">西</option>
                                	<option value="3">西北</option>
                                	<option value="4">北</option>
                                	<option value="5">东北</option>
                                	<option value="6">东</option>
                                	<option value="7">东西</option>
                                </select>
							</li>
							<li id="conddecorateType_id">
                                <select id="decorateType" name="decorateType">
                                	<option value="">装修-请选择</option>
                                	<option value="0">毛坯</option>
                                	<option value="1">普通装修</option>
                                	<option value="2">精装修</option>
                                	<option value="3">豪华装修</option>
                                </select>
							</li>
						</ul>
					</div>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" onclick="javascript:search();" id="search-button" class="searchbar-button" style="margin-top: 10px;" value="搜索">
				</div>
			</div>
			<!-- left content begin -->
			<div class="sale-left">
				<div class="tab-wrap">
					<a href="#" id="sellTypeTitle" class="list-tab all-tab slted">租房</a>
<!-- 					<a href="https://xm.anjuke.com/sale/rd1-v1/" class="list-tab all-tab" id="j-video-tab"><i class="iconfont"></i>视频看房</a> -->
<!-- 					<a href="https://xm.anjuke.com/sale/rd1-v2/" title="全景看房" class="list-tab"><i class="iconfont"></i>全景看房</a> -->
				</div>
				<!-- 搜索无结果-->
				<div class="sortby clearfix sortby-top-v2" id="filtersort">
					<span><span id="result_find_desc">没有符合要求的房源...</span><span> 
						<span class="sort-con">排序： 
							<a class="fst cur" href="javascript:void(0);" onclick="javascript:selectOrder(this,0);" rel="nofollow">默认</a> 
							<a class="down" href="javascript:void(0);" onclick="javascript:selectOrder(this,1);" rel="nofollow">面积</a> 
							<a class="up" href="javascript:void(0);" onclick="javascript:selectOrder(this,2);" rel="nofollow">价格</a> 
							<a class="down" href="javascript:void(0);" onclick="javascript:selectOrder(this,3);" rel="nofollow">最新</a>
						</span>
					</span>
					</span>
				</div>
				<ul id="houselist-mod-new" class="houselist-mod houselist-mod-new">
				</ul>
				<jsp:include page="/include/pager_main.jsp" flush="true"></jsp:include>
			</div>
		</div>
		<div id="footer-mod">
			<div id="footer" class="footer">
				<div class="cp-mod">
					Copyright&nbsp;©&nbsp;2007-2019 www.xxxxx.com All Rights Reserved <a href="#"
						rel="nofollow">ICP号：闽 B2-2019000000</a>
				</div>
				<div class="gov-mod">
					<a target="_blank" rel="nofollow" href="#"> 闽公网安备 201900000000号 </a>
				</div>
			</div>
		</div>
	</div>
	<div id="house_tmp" style="display: none;">
		<li class="list-item" data-from="">
			<div class="item-img">
				<img src="${ctx}/@@houseImg@@" width="180" height="135">
			</div>
			<div class="house-details">
				<div class="house-title">
					<a title="@@title@@"
						href="${ctx }/house_main/house_detail.jsp?houseId=@@houseId@@" target="_blank" class="houseListTitle">
						@@title@@</a> <i class="house-icon house-icon-anxuan" style="font-weight: normal;">安选</i> <i class="house-icon house-icon-default border-line"> 真实在售 </i>
				</div>
				<div class="details-item">
					<span>@@houseType@@</span><em class="spe-lines">|</em><span>@@area@@m²</span><em class="spe-lines">|</em><span>@@floor@@层</span>
					<span class="brokername"><i class="iconfont"></i>@@publisherName@@</span><em class="spe-lines"> </em><span>@@publishPhone@@</span>
				</div>

				<div class="details-item">
					<span class="comm-address" title="@@address@@"> @@address@@ </span>
				</div>
			</div>
			<div class="pro-price">
				价格<span class="price-det"><strong>@@price@@</strong> <span id="zufang_yue">/月</span></span>
				<span id="preMPrice_span" class="unit-price" style="display: none;">@@preMPrice@@元/m²</span>
				<br>
				<a style="color: darkorange; font-size: 12px;" href='${ctx}/house_main/complaint.jsp?reportType=0&targetId=@@userId@@&targetStr=@@publisherName@@'>投诉发布者</a>
				<a style="color: darkorange; font-size: 12px;" href='${ctx}/house_main/complaint.jsp?reportType=1&targetId=@@houseId@@&targetStr=@@title@@'>投诉房源</a>
			</div>
		</li>
	</div>
</body>
</html>
