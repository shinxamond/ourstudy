<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 결제 페이지 시작 -->
<!-- iamport.payment.js -->
<script type="text/javascript" 	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<div class="container">
<h4>이용권 선택내역</h4>
<input type="hidden" name="mem_num"
		 data-memnum="${user.mem_num}" id="mem_num">
		<input type="hidden" name="ticket_num"
		 data-ticketnum="${ticket.ticket_num}" id="ticket_num">
		 <input type ="hidden" id="ticket_total_price" value ="${ticket.ticket_price}"></input>
		 <input type ="hidden" id="org_point"></input>
	<form id="ticketDetail" action="payPage.do" method="post">
		<input type="hidden" name="mem_num"
		 data-memnum="${user.mem_num}" id="mem_num">
		<input type="hidden" name="ticket_num"
		 data-ticketnum="${ticket.ticket_num}" id="ticket_num">
		<div class="container border border-primary" style="background-color: #E4F7BA;">
			<h6 style="margin-top:5px;"><span id="ticket_name" data-ticketname="${ticket.ticket_name}">${ticket.ticket_name}</span>
			<span style="float:right;"><input type ="hidden" id="ticket_total_price" value ="${ticket.ticket_price}"><fmt:formatNumber value="${ticket.ticket_price}"/>원</span></h6>
			<h6 style="margin-top:5px;">현재 보유 중인 포인트<span id="my_point" style="float:right;">P</span></h6>
			<h6 style="margin-top:5px;">포인트 사용(1000P 이상 사용 가능)
			<input type="text" id="use_point" class="form-control form-control-sm" style="float:right; width:100px;" placeholder="포인트 입력">
			<span id="p_point" data-pointnum="${point.point_point}"></span>
			<Button type="button" id="minus_btn" class="btn btn-primary">포인트 사용</Button>
			</h6>
			<hr>
			<h6>결제 금액 <span id="final_price" style="float:right;" data-pricenum="${ticket.ticket_price}">${ticket.ticket_price}</span>
			</h6>
			<input type="button" id="pay_kakao" type="button" class="btn btn-primary" style="margin-left: 428px; margin-bottom: 3px;"
				onclick="requestKakaoPay()" name="pay_plan" value="카카오" data-lockernum="${locker_num}">
			<input type="button" id="pay_card" type="button" class="btn btn-primary" style="margin-bottom: 3px;" name="pay_plan"
				onclick="requestCardPay()" value="카드" data-lockernum="${locker_num}">
		</div>
	</form>
	
	
<script src="${pageContext.request.contextPath}/js/pay.js"></script>

</div>
<!-- 결제 페이지 끝 -->