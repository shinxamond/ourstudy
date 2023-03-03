<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>현재고객현황판</h2>
	<table class="striped-table">
		<tr>
			<th>현재 이용중인 회원수</th>
			<th>현재 외출중인 회원수</th>
			<th>기간권 회원수</th>
			<th>시간권 회원수</th>
			<th>전체 회원수</th>
		</tr>
		<tr>
			<td><span style="color:red">${usingnum}</span>명</td>
			<td><span style="color:red">${gooutnum}</span>명</td>
			<td><span style="color:red">${periodnum}</span>명</td>
			<td><span style="color:red">${timenum}</span>명</td>
			<td><span style="color:red">${totalnum}</span>명</td>
		</tr>
	</table><br>
	<h2>회원목록</h2>
	<form action="admin_list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" onchange="location.href='admin_list.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근가입일순</option>
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
	<br>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->



