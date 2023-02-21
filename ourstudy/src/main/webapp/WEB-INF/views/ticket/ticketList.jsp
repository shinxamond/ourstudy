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
							<div style="float: right;">
								<fmt:formatNumber value="${ticket.ticket_price}" />
								원
							</div>
							<div style="margin-top: 5px;">
								<button id="buy_btn" type="button" class="btn btn-primary"
									style="float: right;">구매하기</button>
							</div>
						</div>
					</div>
					<div id="ticket_pay" style="background-color: pink;">
						현재 보유중인 포인트 <span style="float: right;">${point.point}</span><br>
						${ticket.ticket_name} <span style="float: right;">
						<fmt:formatNumber value="${ticket.ticket_price}" />원</span><br>
						<button id="pay_card" type="button" class="btn btn-primary"
							onclick="requestCardPay()">카드 결제</button>
						<script type="text/javascript">
							IMP.init("imp36873723"); // 예: imp00000000 

							function requestCardPay() {
								IMP.request_pay({
									pg : "html5_inicis.INIpayTest",
									pay_method : "card",
									merchant_uid : "ourstudy002", // 주문번호
									name : "독서실 4시간 이용권",
									amount : 500, // 숫자 타입
									buyer_email : "pandasticday@gmail.com",
									buyer_name : "김테스트",
									buyer_tel : "010-4242-4242",
									buyer_addr : "서울특별시 강남구 역삼동",
									buyer_postcode : "01181"
								}, function(rsp) { // callback
									console.log(rsp);
									if (rsp.success) {
										var msg = '결제가 완료되었습니다.';
										alert(msg);
										location.href = "결제 완료 후 이동할 페이지 url"
									} else {
										var msg = '결제에 실패하였습니다.';
										msg += '에러내용 : ' + rsp.error_msg;
										alert(msg);
									}
								});
							}
						</script>
						<button id="pay_kakao" type="button" class="btn btn-primary"
							onclick="requestKaKaoPay()">카카오페이</button>
						<script type="text/javascript">
							IMP.init("imp36873723"); // 예: imp00000000 

							function requestKaKaoPay() {
								IMP.request_pay({
									pg : "kakaopay.TC0ONETIME",
									pay_method : "card",
									merchant_uid : "ourstudy0004", // 주문번호
									name : "독서실 12시간 이용권",
									amount : 8000, // 숫자 타입
									buyer_email : "pandasticday@gmail.com",
									buyer_name : "박테스트",
									buyer_tel : "010-4242-4242",
									buyer_addr : "서울특별시 강남구 역삼동",
									buyer_postcode : "01181"
								}, function(rsp) { // callback
									console.log(rsp);
									if (rsp.success) {
										var msg = '결제가 완료되었습니다.';
										alert(msg);
										location.href = "결제 완료 후 이동할 페이지 url"
									} else {
										var msg = '결제에 실패하였습니다.';
										msg += '에러내용 : ' + rsp.error_msg;
										alert(msg);
									}
								});
							}
						</script>
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->