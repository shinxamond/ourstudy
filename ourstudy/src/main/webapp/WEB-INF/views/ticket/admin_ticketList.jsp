<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 중앙 컨텐츠 시작 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/admin.ticketList.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/admin_ticket.css">
<div class="container" style="margin-top: 60px;">
<div class="mb-3 d-flex justify-content-end">
		<button type="button" class="btn" id="ticket_register"
			style="background-color: #384048; color: #FFF;"
			onclick="location.href='admin_write.do'">이용권 등록</button>
		</div>
	<div class="container d-flex justify-content-center">
		<c:if test="${count == 0}">
			<table class="table table-group-divider align-center">
				<tr>
					<td>표시할 이용권이 없습니다</td>
				</tr>
			</table>
		</c:if>
		<c:if test="${count > 0}">
			<form id="ticket_list" method="post" style="border: none;">
				
				<c:forEach var="ticket" items="${ticket}">
					<div class="card-group">
						<div class="card" id="ticket_card">
							<input type="hidden" value="${ticket.ticket_num}">
							<div class="card-body">
								<a href="admin_ticketModify.do?ticket_num=${ticket.ticket_num}">${ticket.ticket_name}</a>
								<div style="float: right;">
									<fmt:formatNumber value="${ticket.ticket_price}" />
									원
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</form>
		</c:if>
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->