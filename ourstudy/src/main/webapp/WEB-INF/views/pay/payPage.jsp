<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 결제 페이지 시작 -->
<script src="${pageContext.request.contextPath}/js/pay/pay.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<div>
	<form>
		<div>
			현재 보유중인 포인트 <span style="float: right;">${point.point}</span><br>
			${ticket.ticket_name} <span style="float: right;"> <fmt:formatNumber
					value="${ticket.ticket_price}" />원
			</span><br> --%>
			<button id="pay_card" type="button" class="btn btn-primary"
				onclick="requestCardPay()">카드 결제</button>
			<button id="pay_kakao" type="button" class="btn btn-primary"
				onclick="requestKakaoPay()">카카오페이</button>
		</div>
	</form>
</div>
<!-- 결제 페이지 끝 -->