<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.truncate-text {
    max-width: 270px; /** 현재 한글 기준 10글자 정도로 설정됨 */
    display:inline-block;
    vertical-align: middle;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
</style>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main"> 
	<h2>발신 채팅 히스토리</h2>
	<form action="admin_sendhistory.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" onchange="location.href='admin_sendhistory.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근발신순</option>
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
	<div class="result-display">표시할 히스토리가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>히스토리번호</th>
			<th>회원번호</th>
			<th>이름</th>
			<th>발신시각</th>
			<th>내용</th>
		</tr>
	  <c:forEach var="history" items="${adminSendList}" varStatus="status">
		<tr>
			<td>${history.talk_num}</td>
			<td>${history.mem_num}</td>
			<td>${history.mem_name}</td>
			<td>${history.chat_date}</td>
			<td><a class="open_modal" data-bs-toggle="modal" data-bs-target="#exampleModal${status.count}">
				<span class="truncate-text">${history.message}</span></a></td>
		</tr>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal${status.count}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-scrollable">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">
					관리자-><span id="seat_num" style="color:blue;">${history.mem_name}님</span><br>[${history.chat_date}]
				</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		      ${history.message}
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      </div>
		    </div>
		  </div>
		</div>					
	  </c:forEach>
	</table>
			
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->

