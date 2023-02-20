<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<div class="page-main">
	<h1 class="align-center">대여 목록</h1>
	<c:if test="${count == 0}">
	<div class="result-display">
		대여한 물품이 없습니다
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<div id="userItemList">
		<c:forEach var="item" items="${list}">
		<div id="userItemList-area">
			<img src="imageView.do?item_num=${item.item_num}" width="250" height="250" class="my-photo">
			<br>
			<h4> ${item.item_title}</h4><br>
			<span>기간 : ${item.item_utime}</span><br>
			<c:if test="${item.item_r_status==2}">
			<span>대여 상태 : 대여중</span>
			</c:if>
			<c:if test="${item.item_r_status==3}">
			<span>대여 상태 : 반납</span>
			</c:if>
			
		</div>
		</c:forEach>
		<div id="clear"></div>
	</div>
	</c:if>
</div>