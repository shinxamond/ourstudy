<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon" sizes="16x16" />
<meta charset="UTF-8">
<title><tiles:getAsString name="title"/></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/mypage.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/mypage_again.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/makeEmail.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage/forResponsive.js"></script>
<script>
$(document).on("keyup", ".mem_phone", function() {
	$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
});
function numberphone(e){
	if(e.value.length>11){
		e.value=e.value.slice(0,11);
	}
}
</script>
</head>
<body> <!-- style = "padding-left : 240px;" -->
	<tiles:insertAttribute name="sidebar"/>
<div id="main"><!--  style = "margin : 0 auto; width : 100%;" -->
	<div id="main_header">
		<tiles:insertAttribute name="myPageHeader" />
	</div>
	<div id="main_body">
		<tiles:insertAttribute name="body"/>
	</div>
	
</div>
<div id="main_footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>