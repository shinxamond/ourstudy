<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/mypage.css">
<!-- 마이페이지 메인 회원정보 시작 -->
<div id = "mypage_mem_info">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h1>회원정보</h1>
		</div>
		<hr class = "horizontal-line">
		<div class = "mem-info-content">
			<table>
				<tr>
					<th>아이디</th>
					<td>sky9999</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>sky9999@test.com</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>010-1111-1111</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>서울시 OO동 OO아파트</td>
				</tr>
				<tr>
					<th>이용권<sub style = "font-size : 4pt;">(최근구매)</sub></th>
					<td>기간권(2주)</td>
				</tr>
			</table>
			
		</div>
	</div>
	
</div>
<!-- 마이페이지 메인 회원정보 끝 -->