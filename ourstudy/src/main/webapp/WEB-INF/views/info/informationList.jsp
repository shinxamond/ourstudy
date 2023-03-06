<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>안내사항</h2>
	<form action="informationList.do" id="infoSearch" method="get">
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
			<c:if test="${!empty user && user.mem_auth == 9}">
			<input type="button" value="글쓰기" 
				onclick="location.href='infoWrite.do'">
			</c:if>
		</div>
		<c:if test="${count == 0 && countimport}">
		<div class="result-display">표시할 안내사항이 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>번호</th>
				<th width="500">제목</th>
				<th>작성일</th>
			</tr>
	 		<c:if test="${countimport > 0}">
			<c:forEach var="importinfo" items="${informationImportList}">
			<tr>
				<c:if test="${importinfo.info_pin == 0}">
				<td>${importinfo.info_num}</td>
				</c:if>	
				<c:if test="${importinfo.info_pin == 1}">
				<td><span style="color:#ffc400">★★★</span><span style="color:#097bd9">필독</span><span style="color:#ffc400">★★★</span></td>
				</c:if>	
				<td>
					<a href="infoDetail.do?info_num=${importinfo.info_num}">${importinfo.info_title}</a>
				</td>
				<td>${importinfo.info_date}</td> 		
			</tr>
			</c:forEach>			
			</c:if>
			
			<c:forEach var="info" items="${informationList}">
			<tr>
				<c:if test="${info.info_pin == 0}">
				<td>${info.info_num}</td>
				</c:if>	
				<c:if test="${info.info_pin == 1}">
				<td><span style="color:blue">필독</span></td>
				</c:if>	
				<td>
					<a href="infoDetail.do?info_num=${info.info_num}">${info.info_title}</a>
				</td>
				<td>${info.info_date}</td> 
			
			</tr>
			</c:forEach>
		</table>
			 <div class="align-center">${page}</div> 
		</c:if>
</div>
