<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="sidebars.css" rel="stylesheet">
<!-- 상단 시작 -->
<h2 class="align-center">SpringPage</h2>
<div class="align-right">
	<a href="${pageContext.request.contextPath}/board/list.do">게시판</a>
	
	<c:if test="${!empty user && (user.mem_auth == 1 || user.mem_auth == 2)}">
	<a href="${pageContext.request.contextPath}/mypage/myPageMain.do">MY페이지</a>
	</c:if>
	
	<c:if test="${!empty user}">
	<img src="${pageContext.request.contextPath}/member/photoView.do" width="25" height="25" class="my-photo">
	[<span class="user_name">${user.mem_id}</span>]
	</c:if>
	
	<c:if test="${!empty user}">
	<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
	</c:if>
	<c:if test="${empty user}">
	<a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a>
	<a href="${pageContext.request.contextPath}/member/login.do">로그인</a>
	<a href="${pageContext.request.contextPath}/ticket/ticketList.do">이용권 목록</a>
	</c:if>
	
	<c:if test="${empty user || user.mem_auth < 9}">
	<a href="${pageContext.request.contextPath}/main/main.do">홈으로</a>
	</c:if>
	
	<c:if test="${!empty user && user.mem_auth == 9}">
	<a href="${pageContext.request.contextPath}/main/admin.do">관리자메인</a>
	</c:if>
</div>
<!-- 상단 끝 -->




