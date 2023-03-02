<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div id="main" class="container">
	<div class="row">
		<div id="main_side" class="col">
			<tiles:insertAttribute name="sidebar"/>
		</div>
	<div id="main_content" class="col-9">
		<div id="main_body">
			<tiles:insertAttribute name="body"/>
		</div>
		<div id="main_footer">
			<tiles:insertAttribute name="footer"/>
		</div>
	</div>
	</div>
</div>
</body>
</html>




