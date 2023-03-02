<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 결제 페이지 시작 -->
<!-- iamport.payment.js -->
<script type="text/javascript" 	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<script>
$(function(){
	var ticket_data = "${ticket}";
	
	$('#ticket_num').val("$ticket.ticket_num");
	

	
});
</script>
<div class="container">
<h4>${user.mem_id}님의 이용권 선택내역</h4>
<input type="hidden" name="mem_num"
		 data-memnum="${user.mem_num}" id="mem_num">
		<input type="hidden" name="ticket_num"
		 data-ticketnum="${ticket.ticket_num}" id="ticket_num">
		 <input type ="hidden" id="ticket_total_price" value ="${ticket.ticket_price}"></input>
		 <input type ="hidden" id="org_point"></input>

		<%--<div class="container border border-primary" style="background-color: #E4F7BA;">
		<!-- <div id = "ticket_name">${ticket.ticket_name}</div> -->
		<div style="float:left">
			<div id="ticket_name" style="width: 800px;margin-right: 0px;">독서실 2시간 이용권</div>
			<div style="width: 100px;">2000원</div>
		</div>
		<div>
			<h6 style="margin-top:5px;"><span id="ticket_name" data-ticketname="${ticket.ticket_name}">${ticket.ticket_name}</span>
			<span style="float:right;"><fmt:formatNumber value="${ticket.ticket_price}"/>원</span></h6>
			<h6 style="margin-top:5px;">현재 보유 중인 포인트<span id="my_point" style="float:right;">P</span></h6>
			<h6 style="margin-top:5px;">포인트 사용(1000P 이상 사용 가능)
			<input type="text" id="use_point" class="form-control form-control-sm" style="float:right; width:100px;" placeholder="포인트 입력">
			<Button type="button" id="minus_btn" class="btn btn-primary">포인트 사용</Button>
			</h6>
			<hr>
			<h6>결제 금액 <span id="final_price" style="float:right;" data-pricenum="${ticket.ticket_price}">${ticket.ticket_price}</span>
			<span id="total_price" style="display:none;"></span>
			</h6>
			<input type="button" id="pay_kakao" type="button" class="btn btn-primary" style="margin-left: 428px; margin-bottom: 3px;"
				onclick="requestKakaoPay()" name="pay_plan" value="카카오">
			<input type="button" id="pay_card" type="button" class="btn btn-primary" style="margin-bottom: 3px;" name="pay_plan"
				onclick="requestCardPay()" value="카드">
		</div>
		</div> --%>

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
			<input type="hidden" id="point_point">
			<Button type="button" id="minus_btn" class="btn btn-primary">포인트 사용</Button>
			</h6>
			<hr>
			<h6>결제 금액 <span id="final_price" style="float:right;" data-pricenum="${ticket.ticket_price}">${ticket.ticket_price}</span>
			</h6>
			<input type="button" id="pay_kakao" type="button" class="btn btn-primary" style="margin-left: 428px; margin-bottom: 3px;"
				onclick="requestKakaoPay()" name="pay_plan" value="카카오">
			<input type="button" id="pay_card" type="button" class="btn btn-primary" style="margin-bottom: 3px;" name="pay_plan"
				onclick="requestCardPay()" value="카드">
		</div>
	</form>
	
	
<script src="${pageContext.request.contextPath}/js/pay.js"></script>

</div>
<!-- 결제 페이지 끝 -->