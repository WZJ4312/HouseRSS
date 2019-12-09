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
                <div class="integral-record-hd">被删除的记录</div>
                    <div class="integral-serch">
                        <div class="clearfix task-list" style="padding:18px 2px">
<!--                             <a id="J-submiit-btn" class="business-mess-sent-btn" href="javascript:search();" style="margin-left:8px;">刷新</a>
 -->                        </div>
                    </div>
                    <br/>
					<table class="integral-record-table">
						<thead>
							<tr>
								<th width="25%">房源title</th>
								<th width="25%">删除时间</th>
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
	$(".complaint_user_message").addClass("left_list_dd");
	if(!checkLogin()){
		return;
	}
	search();
});

var afterLoad = function(result){
	buildPager(result.data.sumPage, result.data.curPage, result.data.pageSize);
	for (var i = 0; i < result.data.data.length; i++) {
		var houseTmp = $("#complaint_user_tr").html();
		houseTmp = houseTmp.replace(/@@id@@/g, result.data.data[i].id);
		houseTmp = houseTmp.replace(/@@houseTitle@@/g, result.data.data[i].houseTitle);
		houseTmp = houseTmp.replace(/@@deleteDate@@/g, result.data.data[i].deleteDate);
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
	postUrl("${ctx}/user/getDeleteHouseMessge.do", paramJo, afterLoad)
}


/**
 * 删除房源
 * @param paramJo
 * @param successFun
 */
function deleteMessage(id) {
	var url = "${ctx}/user/deleteMessage.do";
	var paramJo = {
		id:id,
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
			<td>@@houseTitle@@</td>
			<td>@@deleteDate@@</td>
			<td>
				<a href="javascript:deleteMessage('@@id@@',1);" class="jx-trade eidt_button">删除</a><br/>
			</td>
		</tr>
	</tbody>
	</table>
</body>
</html>