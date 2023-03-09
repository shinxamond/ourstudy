<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/locker_sectionAC.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/locker.js"></script>
	<h2>섹션C</h2>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="36" end="39">
	<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick= <c:if test="${locker_count < 1}"> "checkSelect(this);" </c:if>
    				 <c:if test="${locker_count == 1 }">"hello();"</c:if>
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
	</c:forEach>
	</div>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="40" end="43">
	<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick= <c:if test="${locker_count < 1}"> "checkSelect(this);" </c:if>
    				 <c:if test="${locker_count == 1 }">"hello();"</c:if>
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
	</c:forEach>
	</div>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="44" end="47">
	<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick= <c:if test="${locker_count < 1}"> "checkSelect(this);" </c:if>
    				 <c:if test="${locker_count == 1 }">"hello();"</c:if>
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
	</c:forEach>
	</div>
	<div class="locker-box">
	<c:forEach var="locker" items="${list}" begin="48" end="51">
	<button id="${locker.locker_num}" class="locker-option btn hover-filled-opacity"
			onclick= <c:if test="${locker_count < 1}"> "checkSelect(this);" </c:if>
    				 <c:if test="${locker_count == 1 }">"hello();"</c:if>
			<c:if test="${locker.locker_status == 0}">
			style="background-color:#D7D5D5;" disabled</c:if>><span>${locker.locker_num}</span></button>
	</c:forEach>
	</div>
	<button id="empty" class="locker-status">선택가능</button>
	<button id="full" class="locker-status">선택불가</button>
