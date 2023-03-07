<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 중앙 컨텐츠 시작 -->
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/ticket.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<div class="container">
	<h4>이용권 목록</h4>
	<div class="container d-flex justify-content-center">
		<c:if test="${count == 0}">
			<table class="table table-group-divider align-center">
				<tr>
					<td>표시할 이용권이 없습니다</td>
				</tr>
			</table>
		</c:if>
		<c:set var="second_kind" value="0" />
		<c:forEach var="ticket" items="${ticket}">
			<c:if test="${ticket.ticket_kind == 2}">
				<div class="card-group" style="margin-top: 30px;">
					<div class="card" id="ticket_card">
						<form action="/ticket/locker_check.do" method="post">
							<input type="hidden" name="ticket_num"
								value="${ticket.ticket_num}">
							<c:if test="${!empty param.locker_num}">
								<input type="hidden" name="locker_num"
									value="${param.locker_num}">
							</c:if>
							<div class="card-body">
								${ticket.ticket_name}
								<div style="float: right;">
									<fmt:formatNumber value="${ticket.ticket_price}" />
									원
								</div>
							</div>
							<input type="submit" id="lock_buy_btn" value="구매하기"
								class="btn btn-primary" style="float: right;">
						</form>
					</div>
				</div>
				<c:set var="second_kind" value="${second_kind + 1}" />
			</c:if>
		</c:forEach>
		<c:if test="${second_kind == 0}">
			<table class="table table-group-divider align-center" id="no_ticket">
				<tr>
					<td>표시할 이용권이 없습니다</td>
				</tr>
			</table>
		</c:if>
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->