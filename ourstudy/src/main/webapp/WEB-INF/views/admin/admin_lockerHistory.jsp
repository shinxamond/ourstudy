<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>사물함 히스토리 목록</h2>
	<form action="admin_seathistory.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" onchange="location.href='admin_lockerhistory.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근시작순(시작시간순)</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>가나다순(이름)</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>종료시각순(임박순)</option>
				</select>
			</li>
		</ul>                                   
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 히스토리가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>히스토리번호</th>
			<th>사물함번호</th>
			<th>회원번호</th>
			<th>이름</th>
			<th>시작시간</th>
			<th>종료(예정)시간</th>
		</tr>
	  <c:forEach var="history" items="${adminLockerHistoryList}">
		<tr>
			<td>${history.locker_detail_num}</td>
			<td>${history.locker_num}</td>		
			<td>${history.mem_num}</td>
			<td>${history.mem_name}</td>
			<td>${history.locker_start}</td>
			<c:if test="${history.locker_status == 0}">
			<td><span style="color:red">${history.locker_end}</span></td>
			</c:if>
			<c:if test="${history.locker_status != 0}">
			<td>${history.locker_end}</td>
			</c:if>			
		</tr>
	  </c:forEach>
	</table>
	<br>		
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->

