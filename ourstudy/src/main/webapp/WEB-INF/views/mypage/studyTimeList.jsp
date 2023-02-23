<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 마이페이지 공부시간 내역 시작 -->
<div id = "mypage_mem_info">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h1>공부시간 내역</h1>
		</div>
		<hr class = "horizontal-line">
		<div class = "point-content">
			<table class = "point-table">
				<tr>
					<th>입실시간</th>
					<th>퇴실시간</th>
					<th>합계 공부시간</th>
				</tr>
				<c:if test="${count == 0}">
					입/퇴실 내역이 없습니다.
				</c:if>
				<c:if test="${count > 0}">
				<c:forEach var = "study" items = "${list}">
				
				<td>${study.in_time}</td>
				
				<c:if test = "${empty study.out_time}">
				<td>입실중</td>
				</c:if>
				
				<c:if test="${!empty study.out_time}">
				<td>${study.out_time}</td>
				</c:if>
				
				<c:if test = "${empty study.total_time}">
				<td>입실중</td>
				</c:if>
				
				<c:if test="${!empty study.total_time}">
				<td>${study.total_time}</td>
				</c:if>
				${page }
				
				</c:forEach>				
				</c:if>
			</table>
		</div>
		<div style = "text-align : center;">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	
</div>
<!-- 마이페이지 공부시간 내역 끝 -->