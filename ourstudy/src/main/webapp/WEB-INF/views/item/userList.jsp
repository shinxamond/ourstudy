<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">


<div class="container">
	<c:if test="${count == 0}">
	<div class="result-display">
		표시할 물품이 없습니다
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<div id="userList" class="it1">
		<br><h1 class="align-center">물품 목록</h1><br><br>
		<c:forEach var="item" items="${list}">
		<div id="userList-area" class="card">
			<a href="userRental.do?item_index=${item.item_index}"><img src="imageView.do?item_num=${item.item_num}" width="250" height="250" class="my-photo">
			<br>
			<span id="item_name" style="font-size:17px;"> ${item.item_title}</span>
			</a>
		</div>
		</c:forEach>
		<div id="clear"></div>
	</div>
	<div class="it2">
		<br><h1 id="itemlist">물품 목록</h1><br>
		<c:forEach var="item" items="${list}">
		<div id="userlist" class="card">
			<a href="userRental.do?item_index=${item.item_index}"><img src="imageView.do?item_num=${item.item_num}" width="150" height="130" class="my-photo">
			<br>
			<span id="item_name" style="font-size:17px;"> ${item.item_title}</span>
			</a>
		</div>
		</c:forEach>
		<div id="clear2"></div>
	</div>
	</c:if>
</div>