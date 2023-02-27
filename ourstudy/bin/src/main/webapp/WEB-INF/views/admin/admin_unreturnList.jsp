<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>미반납자 목록</h2>
	
	<form action="admin_unreturnlist.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" onchange="location.href='admin_unreturnlist.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근대여순(시작시간순)</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>대여시간순(많은순)</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="물품명 검색" style="width:100px;">
			</li>
			<li>
				<input type="submit" value="찾기">
			</li>			
		</ul>                                   
	</form>
	
	<c:if test="${count == 0}">
	<div class="result-display">표시할 히스토리가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>히스토리번호<br>(대여번호)</th>
			<th>물품명</th>
			<th>물품번호</th>
			<th>회원번호</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>대여시간</th>
			<th>반납시간</th>
		</tr>
	  <c:forEach var="history" items="${adminUnreturnList}">
		<tr>
			<td>${history.item_rnum}</td>
			<td>${history.item_title}</td>		
			<td>${history.item_index}</td>
			<td>${history.mem_num}</td>
			<td>${history.mem_name}</td>
			<td>${history.mem_phone}</td>
			<td><span style="color:red">${history.item_start}</span></td>
			<c:if test="${history.item_end == null}">
			<td><span style="color:blue">현재대여중</span></td>
			</c:if>
			<c:if test="${history.item_end != null}">
			<td>${history.item_end}</td>
			</c:if>			
		</tr>			
	  </c:forEach>
	</table>
			
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->

