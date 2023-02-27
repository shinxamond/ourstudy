<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 중앙 컨텐츠 시작 -->
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<div class="container">
	<h4>이용권 목록</h4>
	<div class="container d-flex justify-content-center">
		<div class="row">
			<c:if test="${count == 0}">
				<table class="table table-group-divider align-center">
					<tr>
						<td>표시할 이용권이 없습니다</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${count > 0}">
				<c:forEach var="ticket" items="${ticket}">
					<div class="card-group" style="margin-top: 30px;">
						<div class="card" style="width: 20rem;">
							<input type="hidden" value="${ticket.ticket_num}">
							<div class="card-body">
								${ticket.ticket_name}
								<div style="float: right;">
									<fmt:formatNumber value="${ticket.ticket_price}" />
									원
								</div>
								<div style="margin-top: 5px;">
									<button id="buy_btn" type="button" class="btn btn-primary"
										style="float: right;" onclick="location.href='${pageContext.request.contextPath}/pay/payPage.do?ticket_num=${ticket.ticket_num}'">구매하기</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->

