<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>분실물 찾기</h2>
	<form action="lostList.do" id="lostSearch" method="get">
		<ul class="search">
			<li>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
					</select>
			</li>
			<li>
				<input type="search" name="keyword" 
				id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색">
			</li>	
		</ul>
	</form>
	<div class="align-right">
		<c:if test="${!empty user}">
		<input type="button" value="글쓰기" 
			onclick="location.href='lostWrite.do'">
		</c:if>
	</div>
	<c:if test="${count == 0}">
		<div class="result-display">표시할 안내사항이 없습니다.</div>
	</c:if>	
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
				<th>카테고리</th>
				<th width="500">제목</th>
				<th>작성일</th>
				<th>작성자</th>
		</tr>
		<c:forEach var="lost" items="${lostList}">
		<tr>
			<c:if test="${lost.lf_type == 0}">
			<td>분실</td>
			</c:if>
			<c:if test="${lost.lf_type == 1}">
			<td>습득</td>
			</c:if>
			
			<td>
				<a href="lostDetail.do?lf_num=${lost.lf_num}">${lost.lf_title}</a>
			</td>
			<td>${lost.lf_date}</td> 
			<td>${lost.mem_name}</td> 
			
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div> 
	</c:if>

</div>