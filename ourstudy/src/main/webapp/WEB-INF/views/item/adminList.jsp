<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<div class="page-main">
	<div class="align-center">
	<h2>물품목록(관리자)</h2>
	</div><br>
	<form action="adminList.do" id="item_search_form" method="get">
		<ul class="item_search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>이름</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>물품명 식별 번호</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>상태(표시:1/미표시:2)</option>
					<option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>대여(기본:1/대여:2/반납:3)</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul>
	</form>
	<div class="align-right">
	<input type="button" value="물품생성" onclick="location.href='itemWrite.do'">
	<input type="button" value="목록" onclick="location.href='adminList.do'">
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">
		표시할 물품이 없습니다
	</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-item-table">
		<tr>
			<th>물품번호</th>
			<th>물품명번호</th>
			<th>물품이름</th>
			<th>상태</th>
			<th>대여상태</th>
		</tr>
		<c:forEach var="item" items="${list}">
		<tr>
			<td>
				<a href="itemModify.do?item_num=${item.item_num}">${item.item_num}</a>
			</td>
			<td>${item.item_index}</td>
			<td>${item.item_title}</td>
			<td>
			<c:if test="${item.item_p_status == '1' }">표시</c:if>
			<c:if test="${item.item_p_status == '2' }">미표시</c:if>
			</td>
			<td>
				<c:if test="${item.item_r_status == '1' }">기본</c:if>
				<c:if test="${item.item_r_status == '2' }">대여</c:if>
				<c:if test="${item.item_r_status == '3' }"><a href="adminItemReturn.do?item_num=${item.item_num}">반납</a></c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<br>
	<div class="align-center">${page}</div>
	</c:if>
</div>