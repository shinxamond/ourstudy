<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 중앙 컨텐츠 시작 -->
<div class="page-main"> 
	<h2>좌석 히스토리 목록</h2>
	<form action="admin_receivehistory.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" onchange="location.href='admin_receivehistory.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>수신시각순(최근순)</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>가나다순(이름)</option>
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
			<th>회원번호</th>
			<th>이름</th>
			<th>수신시각</th>
			<th>내용</th>
		</tr>
	  <c:forEach var="history" items="${adminReceiveHistoryList}">
		<tr>
			<td>${history.talk_num}</td>
			<td>${history.mem_num}</td>
			<td>${history.mem_name}</td>
			<td>${history.chat_date}</td>
			<td>${history.message}</td>
		</tr>			
	  </c:forEach>
	</table>
			
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->

