<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 마이페이지 회원탈퇴 시작 -->
<div class = "mypage_mem_delete">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h3>회원탈퇴</h3>
		</div>
		<hr class = "horizontal-line">
		<form:form action = "myPagedeleteMember.do" id = "myPagedeleteMember_form" modelAttribute="memberVO">
		<form:errors element="div" cssClass="error-color"/>
		<div class = "mem-info-content">
			<table>
				<tr>
					<th>아이디</th>
					<td>
						<form:input path="mem_id" class = "input-textbox"/>
						<form:errors path="mem_id" cssClass="error-color"/>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td>
						<form:password path="mem_pw" class = "input-textbox"/>
						<form:errors path="mem_pw" cssClass="error-color"/>
					</td>
				</tr>
			</table>
		</div>
		<div style = "text-align : center;">
			<form:button>탈퇴</form:button>
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		</form:form>
	</div>
	
</div>
<!-- 마이페이지 회원탈퇴 끝 -->