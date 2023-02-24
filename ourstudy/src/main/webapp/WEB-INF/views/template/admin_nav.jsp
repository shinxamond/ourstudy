<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Admin 메뉴 시작 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<%-- Bootstrap core CSS --%>
<link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" 
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<%--아이콘--%>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<%--폰트 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Leckerli+One&display=swap" rel="stylesheet">
<div class="side-bar">
	<ul>
		<li>
			<input type="button" class="menu-btn"
			 value="회원관리" 
			 onclick="location.href='${pageContext.request.contextPath}/admin/admin_list.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="이용기록(좌석)" 
			 onclick="location.href='${pageContext.request.contextPath}/admin/admin_seathistory.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="이용기록(사물함)" 
			 onclick="location.href='${pageContext.request.contextPath}/admin/admin_lockerhistory.do'">
		</li>		
		<li>
			<input type="button" class="menu-btn"
			 value="좌석 관리" 
			 onclick="location.href='${pageContext.request.contextPath}/seat/insertForm.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="사물함 관리" 
			 onclick="location.href='${pageContext.request.contextPath}/locker/editForm.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="이용권 관리" 
			 onclick="location.href='${pageContext.request.contextPath}/ticket/admin_ticketList.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="물품대여기록(히스토리)" 
			 onclick="location.href='${pageContext.request.contextPath}/admin/admin_itemhistory.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="물품대여기록(미반납자)" 
			 onclick="location.href='#'">
		</li>		
		<li>
			<input type="button" class="menu-btn"
			 value="판매기록" 
			 onclick="location.href='#'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="채팅기록(수신)" 
			 onclick="location.href='#'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="채팅기록(발신)" 
			 onclick="location.href='#'">
		</li>								
	</ul>
</div>
<!-- Admin 메뉴 끝 -->