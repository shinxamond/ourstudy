<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 중앙 컨텐츠 시작 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/admin.ticketList.js"></script>
<div class="container">
	<h3>이용권 목록</h3>
	<c:if test="${count == 0}">
		<table class="table table-group-divider align-center">
			<tr>
				<td>표시할 이용권이 없습니다</td>
			</tr>
		</table>
	</c:if>
	<c:if test="${count > 0}">
	<form id="ticket_list" method="post" style="border:none;">
	<div class="container" style="margin-bottom: 5px;">
		<input type="checkbox" id="chk_all" style="margin-left: 5px;">
		<button type="button" id="del_btn" class="btn btn-danger"
			disabled="disabled" onclick="location.href='deleteTicket.do'">삭제</button>
		<button type="button" class="btn"
			style="background-color: #037332; color: #FFF;"
			onclick="location.href='admin_write.do'">등록</button>
	</div>
		<c:forEach var="ticket" items="${ticket}">
			<div class="card" style="width: 40rem;">
				<div class="card-body">
					<input type="checkbox" class="choice-btn" style="margin-right: 3px;">
					<input type="hidden" data-ticketnum="${ticket.ticket_num}">
					<a href="admin_ticketModify.do?ticket_num=${ticket.ticket_num}">${ticket.ticket_name}</a>
					<div style="float: right;">
						<fmt:formatNumber value="${ticket.ticket_price}" />
						원
					</div>
				</div>
			</div>
		</c:forEach>
		</form>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->