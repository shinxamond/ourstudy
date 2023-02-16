<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/mypage.css">
<!-- 마이페이지 포인트 내역 시작 -->
<div id = "mypage_mem_info">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h1>포인트 내역</h1>
		</div>
		<hr class = "horizontal-line">
		<div class = "point-content">
			<table class = "point-table">
				<tr>
					<th>날짜</th>
					<th>결제내역</th>
					<th>결제방식</th>
					<th>결제금액</th>
					<th>포인트</th>
				</tr>
				
				<tr>
					<td>2023.02.16</td>
					<td>기간권(2주)</td>
					<td>카카오페이 + 포인트</td>
					<td>10,000원</td>
					<td>+ 500point</td>
				</tr>
			</table>
		</div>
		<div style = "text-align : center;">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	
</div>
<!-- 마이페이지 포인트 내역 끝 -->