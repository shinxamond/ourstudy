<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/findIdPw.js"></script>

<!-- 중앙 컨텐츠 시작 -->
<div class="find_all">
<div class="find_left">
	<a href="${pageContext.request.contextPath}/main/main.do">
		<img src="${pageContext.request.contextPath}/image_bundle/writelogo.png" class="find-logo" id="writelogo">
		<img src="${pageContext.request.contextPath}/image_bundle/whitelogo.png" class="find-logo" id="whitelogo">
	</a>
</div>
	<form:form action="findId.do" class="find_form" modelAttribute="memberVO" method="post">
		<div class="find-content">
		<span class="find-text">아이디 찾기</span>
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<br>
				<label for="mem_name">이름</label><br><br>
				<form:input path="mem_name"/>
				<div id="message_name"></div> <!-- js를 위한 태그 -->
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
			<li>
				<label for="user_email">본인확인 이메일</label><br><br>
				<input type="text" id="user_email" required>
				<span id="middle">@</span>
				<select id="email_address" name="email_address" title="이메일 선택" class="email_address">
					<option value="naver.com">naver.com</option>
					<option value="gmail.com">gmail.com</option>
					<option value="daum.net">daum.net</option>
					<option value="hanmail.net">hanmail.net</option>
					<option value="nate.com">nate.com</option>
					<option value="direct">직접입력</option>
				</select>
				<input type="text" id="email_direct" name="email_direct" placeholder="이메일 입력"/>
				<input type="hidden" id="mem_email" name="mem_email" value="">
			</li>
			
			
			<%--=======================이메일 인증코드 구현 시작========================  --%>
			<li>
				<div class="mail-check-box">
					<input class="form-control mail-check-input" placeholder="인증번호 6자리 입력" disabled="disabled" maxlength="6">
					<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
				</div>
				<div id="mail-check-warn"></div>
			</li>
			 <%-- =======================이메일 인증코드 구현 끝========================  --%>
			
		</ul>
		</div>
		<div>
			<form:button class="find-submit-btn">아이디 찾기</form:button>
		</div>
	</form:form>
</div>
<!-- 중앙 컨텐츠 끝 -->

