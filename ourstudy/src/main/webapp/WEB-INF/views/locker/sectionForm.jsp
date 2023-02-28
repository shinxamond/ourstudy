<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Locker Section</title>
</head>
<body>
<div id="sectionA" class="section"><input type="button" value="A" onclick=""></div>
<div id="sectionB" class="section"><input type="button" value="B" onclick=""></div>
<div id="sectionC" class="section"><input type="button" value="C" onclick=""></div>
<div id="sectionD" class="section"><input type="button" value="D" onclick=""></div>

<c:forEach var="locker" items="${list}">
	<p><a href="${pageContext.request.contextPath}/locker/select.do?locker_num=${locker.locker_num}">${locker.locker_num}</a></p>
</c:forEach>
</body>
</html>