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
				
				<tr>
					<td>2023.02.16 09:00</td>
					<td>2023.02.16 18:00</td>
					<td>9시간</td>
				</tr>
			</table>
		</div>
		<div style = "text-align : center;">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	
</div>
<!-- 마이페이지 공부시간 내역 끝 -->