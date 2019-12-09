<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="location" content="province=福建;city=厦门;coord=118.132632,24.511853">
<title>房屋租赁平台</title>
<meta name="keywords" content="房产网，租房，二手房">
<meta name="description" content="房屋租赁平台">
<script type="text/javascript" src="${ctx}/js/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/api.js"></script>
<link rel="stylesheet" rev="stylesheet" href="${ctx}/house_main/main_page_files/Ershou_Web_Home_Home.css" type="text/css">
<link type="text/css" rel="stylesheet" href="${ctx}/house_main/main_page_files/a3b553063d7ab45b780700cb45429573.css">
<link type="text/css" rel="stylesheet" href="${ctx}/house_main/main_page_files/a3b553063d7ab45b780700cb45429573(1).css">
<link type="text/css" rel="stylesheet" href="${ctx}/house_main/main_page_files/a3b553063d7ab45b780700cb45429573(2).css">
<script type="text/javascript">
$(function(){
	var currentUser = "${currentUser.username}";
	if(currentUser == null || currentUser == ""){
		$("#has_login").hide();
		$("#un_login").show();
	} else {
		$("#un_login").hide();
		$("#has_login").show();
	}
})
function searchHouse(sellType) {
	window.location.href = "${ctx }/house_main/main_list.jsp?sellType=" + sellType + "&address="+$("#search-esf").val();
}

function logout() {
	var url = "${ctx}/user/logout.do";
	postUrl(url, {}, function(){
		window.location.href = "${ctx}/web/index.jsp";
	});
}
</script>
</head>
<body data-page="Ershou_Web_Home_HomePage">
	<div id="container">
		<div id="header">
			<div class="glbLogo">
				<div class="glbL clearfix">
				</div>
				<div class="clear"></div>
			</div>
			<div id="glbNavigation" class="  glbNavNone ">
				<div class="glbNavigation1180 clearfix">
					<ul class="L_tabsnew">
						<li class="li_single  li_selected"><a class="a_navnew a_curr" hidefocus="true" href="${ctx }" _soj="navigation">首 页</a></li>
						<li class="li_single li_itemsnew li_unselected"><a class="a_navnew" hidefocus="true" href="${ctx }/house_main/main_list.jsp?sellType=1" _soj="navigation">二手房</a></li>
						<li class="li_single li_itemsnew li_unselected"><a class="a_navnew" hidefocus="true" href="${ctx }/house_main/main_list.jsp?sellType=0" _soj="navigation">租 房</a></li>
					</ul>
					<!-- 用户信息 TabBarNew pmt-38357 -->
					<div class="R_user" style="height: 48px; float: right;">
						<div class="login_info">
							<div class="l" id="login_l">
								<div id="un_login" class="m">
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
			<!-- 左侧内容展示 -->
			<div align="center">
				<!-- 首屏搜索框 -->
				<div class="cont-wrap m-t-box">
					<div class="box search-cont p-none clearfix">
						<div class="right-conts" style="float: none; padding-top: 70px;">
							<form class="search search-form" method="GET" action="#" target="_self" id="search-form">
								<input type="hidden" name="t" value="1" id="iptHidden" class="iptHidden">
								<div class="fd1 clearfix" id="searchIpt">
									<input type="text" name="kw" class="kw" id="search-esf" maxlength="100" autocomplete="off" placeholder="请输入小区名称、地址…" value=""> <i class="home-icon search-close"
										data-tracker="delete-kw" id="search-close" style="display: none;"></i>
									<!--搜索关闭按钮-->
									<a href="javascript:searchHouse(1);"><i class="btn-icon" id="btnIcon"></i><input id="btnSubmit" type="button" class="btn btnSubmit" value="买房"></a> 
									<a href="javascript:searchHouse(0);" id="xfLink"><i class="btn-icon icon-xfzf"></i><input style="" type="button" id="otherBtn" class="btn-bg-xf btn otherBtn" value="租房"></a>
									<div class="auto-wrap"></div>
								</div>
							</form>
						</div>
					</div>
					<a style="display: block; height: 0px; font-size: 0px; line-height: 0px" data-trace="{Anjuke_home_Property_viewed_SearchBar:1}" pos="413"></a>
				</div>
			</div>
		<!-- 底部活动banner -->
		</div>
		<div id="footer-mod">
			<div id="footer" class="footer">
				<div class="cp-mod">
					Copyright&nbsp;©&nbsp;2007-2019 www.xxxxx.com All Rights Reserved <a href="#" rel="nofollow">ICP号：闽 B2-2019000000</a>
				</div>
				<div class="gov-mod">
					<a target="_blank" rel="nofollow" href="#"> 闽公网安备 201900000000号 </a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>