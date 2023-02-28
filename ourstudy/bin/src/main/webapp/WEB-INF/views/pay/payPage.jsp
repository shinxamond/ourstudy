<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 결제 페이지 시작 -->
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<div class="container">
<h4>이용권 선택내역</h4>
	<form id="ticketDetail" action="payPage.do" method="post">
		<input type="hidden" name="ticket_num"
		 value="${ticket.ticket_num}" id="ticket_num">
		<div class="container border border-primary" style="background-color: #E4F7BA;">
			<h6 style="margin-top:5px;">${ticket.ticket_name}<span style="float:right;"><fmt:formatNumber value="${ticket.ticket_price}"/>원</span></h6>
			<h6 style="margin-top:5px;">현재 보유 중인 포인트<span id="my_point" style="float:right;">P</span></h6>
			<h6 style="margin-top:5px;">포인트 사용(1000P 이상 사용 가능)
			<input type="text" id="use_point" class="form-control form-control-sm" style="float:right; width:100px;" placeholder="포인트 입력">
			<Button type="button" id="minus_btn" class="btn btn-primary">포인트 사용</Button>
			</h6>
			<hr>
			<h6>결제 금액 <span id="final_price" style="float:right;">${ticket.ticket_price}원</span></h6>
			<button id="pay_cash" type="button" class="btn btn-primary"
				 	value="0" style="margin-left: 428px; margin-bottom: 3px;"
				 	onclick="location.href='updatePoint.do'">현금 결제</button>
			<button id="pay_card" type="button" class="btn btn-primary" style="margin-bottom: 3px;"
				onclick="requestCardPay()" value="1">카드 결제</button>
			<button id="pay_kakao" type="button" class="btn btn-primary" style="margin-bottom: 3px;"
				onclick="requestKakaoPay()" value="2">카카오페이</button>
		</div>
	</form>
<script src="${pageContext.request.contextPath}/js/pay.js"></script>
</div>
<!-- 결제 페이지 끝 -->