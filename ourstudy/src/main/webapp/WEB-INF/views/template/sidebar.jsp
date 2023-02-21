<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 메인 시작 -->
<!-- Bootstrap core CSS -->
<link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" 
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<div>
	<div class="main-side">
		<nav id="main-sidebar">
			<div class="flex-shrink-0 p-3 shadow p-3" style="width: 220px; height: 100%">
				<div style="text-align:center;">
					<a href="${pageContext.request.contextPath}/main/main.do"
						class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
						<svg class="bi pe-none me-2" width="30" height="24"></svg>
							<span class="fs-5 fw-semibold">OurStudy</span>
					</a>
				<c:if test="${empty user}">
					<img src="${pageContext.request.contextPath}/image_bundle/face.png" width="120" height="120" class="my-photo">
				</c:if>
				<c:if test="${!empty user}">
					<img src="${pageContext.request.contextPath}/member/photoView.do" width="130" height="130" class="my-photo">
				</c:if>
					<button class="btn text-white mt-4 mb-4 rounded" style="background-color:#037332;">로그인 | 회원가입</button>
				</div>
				<div>
				<ul class="list-unstyled ps-0">
					<li class="mb-2">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#item-collapse"
							aria-expanded="false">이용권 구매</button>
						<div class="collapse" id="item-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="#"
									class="link-dark d-inline-flex text-decoration-none rounded">좌석
										이용권</a></li>
								<li><a href="#"
									class="link-dark d-inline-flex text-decoration-none rounded">사물함
										이용권</a></li>
							</ul>
						</div>
					</li>
					<li class="mb-3"><a href="#" class="rounded p-1">좌석 선택</a></li>
					<li class="mb-3"><a href="#" class="rounded p-1">물품 대여</a></li>
					<li class="mb-2">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#notice-collapse"
							aria-expanded="false">시설안내</button>
						<div class="collapse" id="notice-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="#"
									class="link-dark d-inline-flex text-decoration-none rounded">안내사항</a></li>
								<li><a href="#"
									class="link-dark d-inline-flex text-decoration-none rounded">자주
										묻는 질문</a></li>
							</ul>
						</div>
					</li>
					<li class="mb-2">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#comm-collapse"
							aria-expanded="false">커뮤니티</button>
						<div class="collapse" id="comm-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="#"
									class="link-dark d-inline-flex text-decoration-none rounded">분실물
										찾기</a></li>
								<li><a href="#"
									class="link-dark d-inline-flex text-decoration-none rounded">이용후기</a></li>
							</ul>
						</div>
					</li>
					<li class="mb-3"><a href="#" class="rounded p-1">마이페이지</a></li>
				</ul>
				</div>
			</div>
		</nav>
	</div>
</div>
<!-- 메인 끝 -->
