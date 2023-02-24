<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사물함 편집 폼</title>
</head>
<body>
	<form:form action="/locker/insert.do" modelAttribute="lockerVO" >
		<form:button>+</form:button>
	</form:form>
</body>
</html>