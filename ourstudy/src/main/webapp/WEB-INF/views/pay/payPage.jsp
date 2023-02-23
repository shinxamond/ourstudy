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
	<form id="payinfo" method="post">
		<div class="sm-3 border border-primary" style="background-color: pink;">
			<h6>선택한 이용권 <span style="float:right;"></span></h6>
			<button id="pay_card" type="button" class="btn btn-primary"
				onclick="requestCardPay()">카드 결제</button>
			<button id="pay_kakao" type="button" class="btn btn-primary"
				onclick="requestKakaoPay()">카카오페이</button>
		</div>
	</form>	
<script src="${pageContext.request.contextPath}/js/pay/pay.js"></script>
</div>
<!-- 결제 페이지 끝 -->