<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<c:forEach var="seat" items="${list}">
			<tr>
				<td><a href="selectSeat.do?seat_num=${seat.seat_num}">${seat.seat_name}</a></td>
			</tr>
		</c:forEach>
	</table>
	<button>선택</button>
</body>
</html>