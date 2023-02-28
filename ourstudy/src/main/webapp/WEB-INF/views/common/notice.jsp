<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안내</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/memberRegister.css">
</head>

<div>
<div class="find_left">
	<a href="${pageContext.request.contextPath}/main/main.do">
		<img src="${pageContext.request.contextPath}/image_bundle/writelogo.png" class="find-logo" style="margin-top:165px; height:37px;" >
		<img src="${pageContext.request.contextPath}/image_bundle/whitelogo.png" class="find-logo" style="margin-top:30px;">
	</a>
</div>
	<div class="find_form">
		<div class="notice-content">
		<span class="find-text"></span>
			<c:if test="${!empty accessMsg}">
				${accessMsg}
			</c:if>
			<c:if test="${empty accessMsg}">
				잘못된 접속입니다.
			</c:if>
			<p>
			<c:if test="${!empty accessUrl}">
			<button type="button" class="btn btn-primary notice-btn"
			  onclick="location.href='${accessUrl}'">${accessBtn}</button>
			</c:if>
			<c:if test="${empty accessUrl}">
			<button type="button" class="btn btn-primary notice-btn"
			  onclick="location.href='${pageContext.request.contextPath}/main/main.do'">홈으로</button>
			</c:if>
		</div>
	</div>
</div>
</body>
</html>