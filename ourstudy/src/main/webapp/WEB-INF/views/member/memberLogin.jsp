<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Leckerli+One&display=swap" rel="stylesheet">

<!-- 로그인 모달 시작 -->
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal"
	data-bs-target="#loginModal">이거 누르면 로그인 모달창 나옴</button>

<!-- Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content head">
			<div class="modal-body p-2">
				<div class="row">
					<div class="col-3"></div>
					<div class="col-7">
						<h3 class="modal-title ourstudy mb-3" id="loginModalLabel">OurStudy</h3>
					</div>
					<div class="col-2">
						<%-- x 닫기 --%>
						<button type="button" class="close btn" style="border:none;"
							data-bs-dismiss="modal" aria-label="Close">
							<i class="bi bi-x-lg"></i>
						</button>
					</div>
				</div>
				
				<form:form action="login.do" id="login_form" modelAttribute="memberVO">
					<form:errors element="div" cssClass="error-color" />
						<ul>
							<li><label for="mem_id"></label>
								<form:input path="mem_id" placeholder=" ID"/></li>
							<li><form:errors path="mem_id" cssClass="error-color" /></li>
							<li><label for="mem_pw"></label>
								<form:password path="mem_pw" placeholder=" Password"/></li>
							<li><form:errors path="mem_pw" cssClass="error-color" /></li>
							<li>&nbsp;<input type="checkbox" name="auto" id="auto">&nbsp;로그인 상태 유지
							</li>
						</ul>
					
						<button type="submit" class="btn login-submit 
						text-white rounded submit px-2" style="background-color:#037332;">Login
						</button>
				</form:form>
				
				<ul class="find-id my-3">
					<li>아이디 찾기</li>
					<li>&nbsp;|&nbsp;</li>
					<li>비밀번호 찾기</li>
					<li>&nbsp;|&nbsp;</li>
					<li>회원가입</li>
				</ul>
				<div class="my-4 d-flex justify-content-center">카카오톡 간편로그인</div>
				<div class="my-4 d-flex justify-content-center" style="color:#037332;">비회원으로 계속하기</div>
			</div>
		</div>
	</div>
</div>
<!-- 로그인 모달 끝 -->
