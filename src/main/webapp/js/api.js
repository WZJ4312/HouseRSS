/**
 * 发送ajax请求
 * @param url
 * @param paramJo
 * @param successFun
 */
function postUrl(url, paramJo, successFun) {
	$.ajax( {
		url : url,
		type : 'post',
		data: paramJo,
		dataType:'json',
		timeout : 60000,
		error : function(e) {
			alert("连接服务器超时,请稍后再试.");
		},
		success : function(result) {
			if (result.status==0) {
				successFun(result);
			} else {
				alert(result.msg);
			}
		}
	});
}

/**
 * 加载房源信息
 * @param paramJo
 * @param successFun
 */
function loadHouse(ctx, paramJo, successFun) {
	var url = ctx + "/house/houseList.do";
	postUrl(url, paramJo, successFun)
}

/**
 * 加载房源详情
 * @param paramJo
 * @param successFun
 */
function detailHouse(ctx, paramJo, successFun) {
	var url = ctx + "/house/detailHouse.do";
	postUrl(url, paramJo, successFun)
}