<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>일별 판매 정산판</h2>
	<table class="striped-table">
		<tr>
			<th>이용권 판매 금액</th>
			<th>사물함 판매 금액</th>
			<th>총 합계 금액</th>
		</tr>
		<tr>
			<td><span style="color:red">${ticketsales}</span>원</td>
			<td><span style="color:red">${lockersales}</span>원</td>
			<td><span style="color:red">${totalsales}</span>원</td>
		</tr>
	</table><br>
	<h2>판매기록목록</h2>
	<form action="admin_saleslist.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" onchange="location.href='admin_saleslist.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근판매순</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>가나다순(이름)</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="이름 또는 회원번호 검색" style="width:170px;">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>
		</ul>                                   
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 회원정보가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>회원번호</th>
			<th>이름</th>
			<th>판매상품</th>
			<th>구매방법</th>
			<th>판매시각</th>
		</tr>
		<c:forEach var="sales" items="${adminSalesList}">
		<tr>
			<td>${sales.mem_num}</td>
			<td>${sales.mem_name}</td>
			<td>${sales.ticket_name}</td>
			<c:if test="${sales.pay_plan == 0}">
				<td>현금</td>
			</c:if>
			<c:if test="${sales.pay_plan == 1}">
				<td>카카오페이</td>
			</c:if>
			<c:if test="${sales.pay_plan == 2}">
				<td>카드</td>
			</c:if>						
			<td>${sales.pay_date}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->

