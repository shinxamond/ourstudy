<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 결제 페이지 시작 -->
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/pay.css">
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<div class="container">
		<div class="col-sm-8" id="card_top">
			<div class="card sm-5">
				<div class="card-body p-4">
					<input type="hidden" name="mem_num" data-memnum="${user.mem_num}"
						id="mem_num"> <input type="hidden" name="ticket_num"
						data-ticketnum="${ticket.ticket_num}" id="ticket_num"> <input
						type="hidden" id="ticket_total_price"
						value="${ticket.ticket_price}"> <input type="hidden"
						id="org_point">
						<%--중복코드
						<input type="hidden" name="mem_num"
						data-memnum="${user.mem_num}" id="mem_num"> <input
						type="hidden" name="ticket_num"
						data-ticketnum="${ticket.ticket_num}" id="ticket_num"> --%>
					<div class="row align-items-center">
						<div class="col-sm-6" style="margin-right:">
							<p class="lead text-mute mb-4 pb-2">선택한 이용권</p>
							<p class="lead fw-normal mb-0" id="ticket_name"
								data-ticketname="${ticket.ticket_name}">${ticket.ticket_name}</p>
						</div>
						<div class="col-sm-6 d-flex justify-content-end">
							<div>
								<p class="lead text-mute mb-4 pb-2">금액</p>
								<p class="lead fw-normal mb-0">
									<input type="hidden" id="ticket_total_price"
										value="${ticket.ticket_price}">
									<fmt:formatNumber value="${ticket.ticket_price}" />
									원
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="card sm-5" id="point_pay">
				<div class="card-body p-8">
					<div>
						<p class="lead text-mute mb-4 pb-2">
							<span>현재 보유 중인 포인트</span> <span class="lead fw-normal mb-0"
								id="my_point" style="float: right;"></span>
						</p>
					</div>
					<div class="col mb-3 d-flex">
						<span id="p_point" data-pointnum="${point.point_point}"></span>
							<div>
								<span class="lead text-mute mb-6 pb-2"
									style="margin-right: 100px;"> 포인트 사용(1000P 이상 사용 가능)</span>
							</div>
							<div class="col mb-3 d-flex justify-content-end" id="input_point">
								<div class="input-group row-mb-3">
									<input type="text" id="use_point" class="form-control"
										style="float: right; width: 100px;" placeholder="포인트 입력">
									<button type="button" id="minus_btn" class="btn btn-primary">포인트
										사용</button>
								</div>
							</div>
					</div>
					<hr>
					<div>
					<span class="lead text-mute mb-6 pb-2">결제 금액</span>
					<span class="lead fw-normal mb-0" id="final_price" style="float: right;"
						data-pricenum="${ticket.ticket_price}">${ticket.ticket_price}</span>
					</div>
					<div class="d-flex justify-content-end" id="payment">
						<input type="image" id="pay_kakao"
							src="${pageContext.request.contextPath}/image_bundle/payment_icon_yellow_small.png"
							style="margin-bottom: 3px;"
							onclick="requestKakaoPay()" name="pay_plan" value="카카오" data-lockernum = "${locker_num}">
							<input type="button" id="pay_card" type="button" class="btn btn-primary"
							style="margin-bottom: 3px;" name="pay_plan"
							onclick="requestCardPay()" value="카드" data-lockernum = "${locker_num}">
					</div>
				</div>
			</div>
			<script src="${pageContext.request.contextPath}/js/locker_pay.js"></script>
		</div>
	</div>

<!-- 결제 페이지 끝 -->