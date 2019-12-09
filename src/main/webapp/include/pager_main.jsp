<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>	
<div id="pager" class="multi-page">
</div>
<script type="text/javascript"> 
function buildPager(totalPage, currentPage, pageSize){
	var sb = new StringBuilder();
	if(currentPage > 1){
		sb.append("<a class='aNxt' href='javascript:searchPage(" + (currentPage - 1) + ")'>&lt;&nbsp;上一页</a>");
	} else {
		sb.append("<a class='aNxt' href='javascript:void(0);'>&lt;&nbsp;上一页</a>");
	}
	for(var i=1;i<totalPage+1;i++){
		if(i==currentPage){
			sb.append("<i class='curr'>"+i+"</i>");
		} else {
			sb.append("<a href='javascript:searchPage(" + i + ")'>" + i + "</a>");
		}
	}
	if(currentPage < totalPage){
		sb.append("<a class='aNxt' href='javascript:searchPage(" + (currentPage + 1) + ")'>下一页 &gt;</a>&nbsp;");
	} else {
		sb.append("<a class='aNxt' href='javascript:void(0);'>下一页 &gt;</a>&nbsp;");
	}
	$("#pager").html(sb.toString());
}
</script>