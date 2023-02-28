<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사물함 선택</title>
</head>
<body>
<c:forEach var="locker" items="${list}">
	<a href="${pageContext.request.contextPath}/locker/select.do?locker_num=${locker.locker_num}">${locker.locker_num}</a><br>
</c:forEach>
</body>
</html>