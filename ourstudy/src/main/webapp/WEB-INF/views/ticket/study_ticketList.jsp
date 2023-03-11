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
<div id="main_content_body" class="container" style="height: 80vh;">
	<div class="container d-flex justify-content-center">
	<div class="row-sm-4">
		<c:set var="first_kind" value="0" />
		<c:forEach var="ticket" items="${ticket}">
			<c:if test="${ticket.ticket_kind == 1}">
				<div class="card-group" style="margin-top: 30px;">
					<div class="card" id="ticket_card">
						<form action="/pay/study_pay.do" id="study_ticket" method="post" class="form-inline">
							<input type="hidden" name="ticket_num"
								value="${ticket.ticket_num}">${ticket.ticket_num}		
								<input type="hidden" name="seat_num"
									value="${seat_num}">${seat_num}
							<div class="card-body">
								${ticket.ticket_name}
								<div style="float: right;">
									<fmt:formatNumber value="${ticket.ticket_price}" />
									원
								</div>
							</div>
							<input type="submit" id="study_buy_btn" value="구매하기"
								class="btn btn-primary" style="float: right;">
						</form>
					</div>
				</div>
				<c:set var="first_kind" value="${first_kind + 1}" />
			</c:if>
		</c:forEach>
		<c:if test="${first_kind == 0}">
			<table class="table table-group-divider align-center" id="no_ticket">
				<tr>
					<td>표시할 이용권이 없습니다</td>
				</tr>
			</table>
		</c:if>
	</div>
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->

