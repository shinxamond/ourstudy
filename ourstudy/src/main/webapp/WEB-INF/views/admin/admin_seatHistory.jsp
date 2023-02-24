<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
var seatnum ="";

$(document).ready(function() {     
    $('#exampleModal').on('show.bs.modal', function(event) {          
        seatnum = $(event.relatedTarget).data('seat_num');
        $('#seat').innerHTML = seatnum;
    });
});
</script>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>좌석 히스토리 목록</h2>
	<form action="admin_seathistory.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" onchange="location.href='admin_seathistory.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근시작순(시작시간순)</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>가나다순(이름)</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>이용시간순(많은순)</option>
				</select>
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
			<th>좌석번호</th>
			<th>회원번호</th>
			<th>이름</th>
			<th>시작시간</th>
			<th>종료시간</th>
			<th>이용시간</th>
		</tr>
		<c:forEach var="history" items="${adminUseHistoryList}">
		<tr>
			<td>${history.seat_detail_num}</td>
			<td><a class="open_modal" data-bs-toggle="modal" href="#exampleModal" data-seat="${history.seat_num}">
				<span class="seatnum" style="color:blue">${history.seat_num}</span></a></td>			
			<td>${history.mem_num}</td>
			<td>${history.mem_name}</td>
			<td>${history.in_time}</td>
			<td>${history.out_time}</td>
			<c:if test="${history.out_time == null}">
			<td><span style="color:red">현재이용중</span></td>
			</c:if>
			<c:if test="${history.out_time != null}">
			<td>${history.total_time}</td>
			</c:if>			
		</tr>
		</c:forEach>
	</table>
	
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">
				<span id="seat"></span>번 좌석
			</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      정말 퇴실처리 하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary">확인(퇴실처리)</button>
	      </div>
	    </div>
	  </div>
	</div>	
			
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->

