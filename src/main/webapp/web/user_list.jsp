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
    <div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="#">用户管理</a></div>
</div>
    <div class="wrap clearfix">
		<jsp:include page="/include/left.jsp" flush="true"></jsp:include> 
		<div class="business-right">
          <div class="business-right-comm">
              <div class="business-info">
                <div class="integral-record-hd">用户管理</div>
                    <div class="integral-serch">
                        <div class="clearfix task-list" style="padding:18px 2px">
                            <a id="J-submiit-btn" class="business-mess-sent-btn" href="javascript:search();" style="margin-left:8px;">刷新</a>
                        </div>
                    </div>
                    <br/>
					<table class="integral-record-table">
						<thead>
							<tr>
								<th width="5%">id</th>
								<th width="10%">账号</th>
								<th width="20%">姓名</th>
								<th width="30%">邮箱</th>
								<th width="20%">手机</th>
								<th width="5%">状态</th>
								<th width="10%">操作</th>
							</tr>
						</thead>
						<tbody id="complaint_user_tbody">
						</tbody>
					</table>
					<jsp:include page="/include/pager.jsp" flush="true"></jsp:include>
                    
                </div>

              </div>
              
            </div>
      </div>
			<jsp:include page="/include/footer.jsp" flush="true"></jsp:include>
<script type="text/javascript"> 
$(document).ready(function(){
	$(".usermanager_dd").addClass("left_list_dd");
	if(!checkLogin()){
		return;
	}
	if(!isAdmin()){//管理员不显示编辑按钮
		alert("没有权限！");
		window.location.href = "${ctx}/web/index.jsp";
		return false;
	}
	search();

// 	var houseTmp = $("#house_tmp").html();
// 	houseTmp = houseTmp.replace(/@@houseId@@/g, "132213132");
// 	houseTmp = houseTmp.replace(/@@name@@/g, "厦门精品房低价急售！");
// 	$("#houseList").append(houseTmp);//先添加空白记录
// 	buildPager(5, 3, 20);
});

var afterLoad = function(result){
	buildPager(result.data.sumPage, result.data.curPage, result.data.pageSize);
	for (var i = 0; i < result.data.data.length; i++) {
		var houseTmp = $("#complaint_user_tr").html();
		console.log(houseTmp);
		houseTmp = houseTmp.replace(/@@id@@/g, result.data.data[i].id);
		houseTmp = houseTmp.replace(/@@username@@/g, result.data.data[i].username);
		houseTmp = houseTmp.replace(/@@name@@/g, result.data.data[i].name);
		houseTmp = houseTmp.replace(/@@email@@/g, result.data.data[i].email);
		houseTmp = houseTmp.replace(/@@phone@@/g, result.data.data[i].phone);
		houseTmp = houseTmp.replace(/@@time@@/g, result.data.data[i].time);
		if(result.data.data[i].status==0){
			houseTmp = houseTmp.replace(/@@status@@/g, "正常");
			houseTmp = houseTmp.replace(/@@changeStatus@@/g, 1);
			houseTmp = houseTmp.replace(/@@opName@@/g, "封禁");
		} else {
			houseTmp = houseTmp.replace(/@@status@@/g, "封禁中");
			houseTmp = houseTmp.replace(/@@changeStatus@@/g, 0);
			houseTmp = houseTmp.replace(/@@opName@@/g, "解封");
		}
		$("#complaint_user_tbody").append(houseTmp);
	}
}

var currentPage = 1;

function search(){
	searchPage(currentPage)
}

function searchPage(page){
	$("#complaint_user_tbody").html("");
	currentPage = page;
	var paramJo = {pageNum:page};//加载参数
	//其他参数
	postUrl("${ctx}/user/userList.do", paramJo, afterLoad)
}

function changeStatus(userId, status){
	var paramJo = {userId:userId,status:status};//加载参数
	//其他参数
	postUrl("${ctx}/user/changeUserStatus.do", paramJo, function(){
		alert("操作成功");
		search();
	});
}

</script>
	<table style="display: none">
	<tbody id="complaint_user_tr">
		<tr>
			<td>@@id@@</td>
			<td>@@username@@</td>
			<td>@@name@@</td>
			<td>@@email@@</td>
			<td>@@phone@@</td>
			<td>@@status@@</td>
			<td>
				<a href="javascript:changeStatus('@@id@@',@@changeStatus@@);" class="jx-trade eidt_button">@@opName@@</a><br/>
			</td>
		</tr>
		</tbody>
	</table>
</body>
</html>