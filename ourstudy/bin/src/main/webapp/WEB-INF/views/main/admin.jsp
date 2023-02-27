<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>최근회원목록(5명)</h2>
	<table class="striped-table">
		<tr>
			<th>회원번호</th>
			<th>이름</th>
			<th>아이디</th>
			<th>가입일</th>
			<th>전화번호</th>
			<th>이메일</th>
		</tr>
		<c:forEach var="member" items="${adminMemberList}">
		<tr>
			<td>${member.mem_num}</td>
			<td>${member.mem_name}</td>
			<td>${member.mem_id}</td>
			<td>${member.mem_reg_date}</td>
			<td>${member.mem_phone}</td>
			<td>${member.mem_email}</td>
		</tr>
		</c:forEach>
	</table>
</div>
<!-- 중앙 컨텐츠 끝 -->




