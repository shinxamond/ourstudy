<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/seat.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/seat_frame.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/seat.js"></script>
<div id="container">
	<div id="canvas_box">
	<canvas id="canvas"></canvas>
	</div>
	<div id="seat_box">
	<%-- <c:forEach var="seat" items="${list}" begin="0" end="3" >
		<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<br>
	<c:forEach var="seat" items="${list}" begin="4" end="${fn:length(list)-1}">
		<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#FEBB97;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status == 0 || seat.seat_status == 2}">disabled</c:if>
				value="<c:out value="${seat.seat_name}"/>"  
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach> --%>
	<%-- A1 - A5 --%>
	<c:forEach var="seat" items="${list}" begin="0" end="4" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- A6 - A10 --%>
	<c:forEach var="seat" items="${list}" begin="5" end="9" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	
	<%-- B1 - B6 --%>
	<c:forEach var="seat" items="${list}" begin="10" end="15" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	
	<%-- C1 - C6 --%>
	<c:forEach var="seat" items="${list}" begin="16" end="21" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- D1 - D5 --%>
	<c:forEach var="seat" items="${list}" begin="22" end="26" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	
	<%-- D6 - D11 --%>
	<c:forEach var="seat" items="${list}" begin="27" end="32" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- D12 - D14 --%>
	<c:forEach var="seat" items="${list}" begin="33" end="35" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- E1 - E5 --%>
	<c:forEach var="seat" items="${list}" begin="36" end="40" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- E6 - E10 --%>
	<c:forEach var="seat" items="${list}" begin="41" end="45" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- F1 - E8 --%>
	<c:forEach var="seat" items="${list}" begin="46" end="53" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- G1 - G2 --%>
	<c:forEach var="seat" items="${list}" begin="54" end="55" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- G3 - G8 --%>
	<c:forEach var="seat" items="${list}" begin="56" end="61" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>
	<%-- G9 - G12 --%>
	<c:forEach var="seat" items="${list}" begin="62" end="65" >
	<input type="button" style="<c:if test="${seat.seat_status == 0 }">background-color:#D7D5D5;</c:if>
					   <c:if test="${seat.seat_status == 1 }">background-color:#BBFE97;</c:if>
					   <c:if test="${seat.seat_status == 2 }">background-color:#F8B1AA;</c:if>"
				class="seat-option" <c:if test="${seat.seat_status != 1}">disabled</c:if> 
				data-num="${seat.seat_name}" 
				value="<c:out value="${seat.seat_name}"/>"
				onclick=<c:if test="${mem_status == 0}">"location.href='${pageContext.request.contextPath}/seat/select.do?seat_num=${seat.seat_num}'"</c:if>
						<c:if test="${mem_status != 0}">"alert('이미 입실중입니다.'); return false;"</c:if> >
	</c:forEach>

	</div>
	<span id="locker_zone" class="guide-letter">L O C K E R &nbsp;&nbsp; Z O N E</span><br>
	<span id="locker" class="guide-letter">L<br>O<br>C<br>K<br>E<br>R</span><br>
	<span id="toilet" class="guide-letter">TOILET</span><br>
	<span id="rent" class="guide-letter">RENT</span><br>
	<span id="info" class="guide-letter">INFO</span><br>
</div>	