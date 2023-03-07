<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/snow.js"></script>

<div class="page-main">
	<c:if test="${count == 0}">
	<div class="result-display">
		표시할 물품이 없습니다
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<div id="userList" class="it1">
		<h1 class="align-center">물품 목록</h1>
		<c:forEach var="item" items="${list}">
		<div id="userList-area" class="item-card">
			<a href="userRental.do?item_index=${item.item_index}"><img src="imageView.do?item_num=${item.item_num}" width="250" height="250" class="my-photo">
			<br>
			<h4> ${item.item_title}</h4>
			</a>
		</div>
		</c:forEach>
		<div id="clear"></div>
	</div>
	<div class="it2">
		<h1>물품 목록</h1>
		<c:forEach var="item" items="${list}">
		<div id="userlist" class="item-card">
			<a href="userRental.do?item_index=${item.item_index}"><img src="imageView.do?item_num=${item.item_num}" width="150" height="130" class="my-photo">
			<br>
			<h4> ${item.item_title}</h4>
			</a>
		</div>
		</c:forEach>
		<div id="clear2"></div>
	</div>
	</c:if>
</div>