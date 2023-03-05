<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/locker.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locker.js"></script>
	<h2>섹션D</h2>
	
	<div class="locker-box">
		<c:forEach var="locker" items="${list}" begin="48" end="52">
		<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
		</c:forEach>
	</div>
	<div class="locker-box">
		<c:forEach var="locker" items="${list}" begin="53" end="57">
		<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
		</c:forEach>
	</div>
	<div class="locker-box">
		<c:forEach var="locker" items="${list}" begin="58" end="62">
		<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
		</c:forEach>
	</div>
	<div class="locker-box">
		<c:forEach var="locker" items="${list}" begin="63" end="67">
		<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick="checkSelect(this);" 
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
		</c:forEach>
	</div>
	<button id="empty" class="locker-status">선택가능</button>
	<button id="full" class="locker-status">선택불가</button>