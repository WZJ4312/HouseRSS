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
    <div class="wrap"><a href="${ctx}/web/userinfo.jsp">首页</a> &gt; <a href="#">举报房源管理</a></div>
</div>
    <div class="wrap clearfix">
		<jsp:include page="/include/left.jsp" flush="true"></jsp:include> 
		<div class="business-right">
          <div class="business-right-comm">
              <div class="business-info">
                <div class="integral-record-hd">举报房源管理</div>
                    <div class="integral-serch">
                        <div class="clearfix task-list" style="padding:18px 2px">
                            <a id="J-submiit-btn" class="business-mess-sent-btn" href="javascript:search();" style="margin-left:8px;">刷新</a>
                        </div>
                    </div>
                    <br/>
					<table class="integral-record-table">
						<thead>
							<tr>
								<th width="10%">时间</th>
								<th width="25%">投诉用户</th>
								<th width="25%">被投诉房源</th>
								<th width="30%">投诉原因</th>
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
	$(".complaint_house_list").addClass("left_list_dd");
	if(!checkLogin()){
		return;
	}
	if(!isAdmin()){//管理员不显示编辑按钮
		alert("没有权限！");
		window.location.href = "${ctx}/web/index.jsp";
		return false;
	}
	search();
});

var afterLoad = function(result){
	buildPager(result.data.sumPage, result.data.curPage, result.data.pageSize);
	for (var i = 0; i < result.data.data.length; i++) {
		var houseTmp = $("#complaint_user_tr").html();
		houseTmp = houseTmp.replace(/@@id@@/g, result.data.data[i].id);
		houseTmp = houseTmp.replace(/@@date@@/g, result.data.data[i].reportDate);
		houseTmp = houseTmp.replace(/@@reporterId@@/g, result.data.data[i].reporterId);
		houseTmp = houseTmp.replace(/@@reporter@@/g, result.data.data[i].reporterUsername);
		houseTmp = houseTmp.replace(/@@reporteder@@/g, result.data.data[i].title);
		houseTmp = houseTmp.replace(/@@reportederId@@/g, result.data.data[i].reportederId);
		houseTmp = houseTmp.replace(/@@description@@/g, result.data.data[i].description);
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
	var paramJo = {
		pageNum:page,
		type:1
	};//加载参数
	if($("#zone").val() != ""){
		paramJo.zone = $("#zone").val();
	}
	//其他参数
	postUrl("${ctx}/reportInfo/selectReportInfo.do", paramJo, afterLoad)
}


/**
 * 删除房源
 * @param paramJo
 * @param successFun
 */
function dealReport(id, type) {
	var url = "${ctx}/reportInfo/dealReport.do";
	var paramJo = {
		id:id,
		status:type
	};
	postUrl(url, paramJo, function() {
		alert("处理成功");
		search();
	});
}
</script>
	<table style="display: none">
	<tbody id="complaint_user_tr">
		<tr>
			<td>@@date@@</td>
			<td>@@reporter@@</td>
			<td>
				<span><a href="${ctx}/web/house_detail.jsp?houseId=@@reportederId@@" class="trade-detail" target="_blank">@@reporteder@@</a></span>
			</td>
			<td>@@description@@</td>
			<td>
				<a href="javascript:dealReport('@@id@@',1);" class="jx-trade eidt_button">删除房源</a><br/>
				<a href="javascript:dealReport('@@id@@',0);" class="jx-trade">忽略</a>
			</td>
		</tr>
	</tbody>
	</table>
</body>
</html>