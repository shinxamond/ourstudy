<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 중앙 컨텐츠 시작 -->
<script type="text/javascript">
	$(function(){
		$('#buy_btn').onclick(function(){
			$('#ticket_pay').attr('display','block');
		});
	});
</script>
<div class="container">
	<h3>이용권 목록</h3>
	<div class="container d-flex justify-content-center">
		<div class="d-flex flex-column mb-3">
			<c:if test="${count == 0}">
				<table class="table table-group-divider align-center">
					<tr>
						<td>표시할 이용권이 없습니다</td>
					</tr>
				</table>
			</c:if>
			<c:if test="${count > 0}">
				<c:forEach var="ticket" items="${list}">
					<div class="card" style="width: 40rem;">
						<div class="card-header">독서실 이용권(시간제)</div>
						<div class="card-body">
							${ticket.ticket_name}
							<div style="float: right;"><fmt:formatNumber value="${ticket.ticket_price}"/>원</div>
							<div style="margin-top: 5px;">
								<button id="buy_btn" type="button" class="btn btn-primary"
									style="float: right;">구매하기</button>
							</div>
						</div>
					</div>
					<div id="ticket_pay" style="background-color:pink;display:none;">
						현재 보유중인 포인트		<span style="float:right;">${point.point}</span><br>
						${ticket.ticket_name} <span style="float:right;"><fmt:formatNumber value="${ticket.ticket_price}"/>원</span>
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->