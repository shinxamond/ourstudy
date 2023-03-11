<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 마이페이지 비밀번호 변경 시작 -->
<div class = "mypage_mem_changePasswd">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h3>비밀번호변경</h3>
		</div>
		<hr class = "horizontal-line">
		<form:form action = "myPagechangePasswd.do" id = "myPagechangePasswd_form" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/>
		<div class = "mem-info-content">
			<table>
				<tr>
					<th>현재 비밀번호</th>
					<td>
						<form:password path="now_passwd" class = "input-textbox"/>
						<form:errors path="now_passwd" cssClass="error-color"/>
					</td>
				</tr>
				<tr>
					<th>새비밀번호</th>
					<td>
						<form:password path="mem_pw" class = "input-textbox"/>
						<form:errors path="mem_pw" cssClass="error-color"/>
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" id="confirm_passwd" class = "input-textbox"/>
						<span id="message_id"></span>
					</td>
				</tr>
			</table>
		</div>
		<div style = "text-align : center; margin-bottom: 30px;">
			<form:button class="btn" id="modify_btn">변경</form:button>
			<input type="button" class="btn" id="home_btn" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/mypage/myPageMain.do'">
		</div>
		</form:form>
	</div>
	
</div>
<!-- 마이페이지 비밀번호변경 끝 -->