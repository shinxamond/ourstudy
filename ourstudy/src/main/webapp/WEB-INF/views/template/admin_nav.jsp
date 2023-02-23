<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Admin 메뉴 시작 -->
<div class="side-bar">
	<ul>
		<li>
			<input type="button" class="menu-btn"
			 value="회원관리" 
			 onclick="location.href='${pageContext.request.contextPath}/admin/admin_list.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="이용기록" 
			 onclick="location.href='#'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="좌석 관리" 
			 onclick="location.href='${pageContext.request.contextPath}/seat/insertForm.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="이용권 관리" 
			 onclick="location.href='${pageContext.request.contextPath}/ticket/admin_ticketList.do'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="물품대여기록" 
			 onclick="location.href='#'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="판매기록" 
			 onclick="location.href='#'">
		</li>
		<li>
			<input type="button" class="menu-btn"
			 value="채팅기록" 
			 onclick="location.href='#'">
		</li>						
	</ul>
</div>
<!-- Admin 메뉴 끝 -->