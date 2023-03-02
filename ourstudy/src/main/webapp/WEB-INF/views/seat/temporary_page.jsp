<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시 페이지</title>
</head>
<body>
<h1>걍 임시로 만들어준 페이지임</h1>
	${seat_num}번 좌석 선택됨. <br>
	<button onclick="location.href='${pageContext.request.contextPath}/locker/section.do'">사물함 고고</button>
</body>
</html>