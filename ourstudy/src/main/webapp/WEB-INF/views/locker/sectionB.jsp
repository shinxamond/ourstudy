<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/locker.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locker.js"></script>
<body>
	<h2>섹션B</h2>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="16" end="20">
	<button id="${locker.locker_num}" class="locker-option"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;"</c:if>>${locker.locker_num}</button>
	</c:forEach>
	</div>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="21" end="25">
	<button id="${locker.locker_num}" class="locker-option"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;"</c:if>>${locker.locker_num}</button>
	</c:forEach>
	</div>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="26" end="30">
	<button id="${locker.locker_num}" class="locker-option"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;"</c:if>>${locker.locker_num}</button>
	</c:forEach>
	</div>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="31" end="35">
	<button id="${locker.locker_num}" class="locker-option"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;"</c:if>>${locker.locker_num}</button>
	</c:forEach>
	</div>
	<button id="empty" class="locker-status">선택가능</button>
	<button id="full" class="locker-status">선택불가</button>