<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 메인 시작 -->
<!-- Bootstrap core CSS -->
<link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" 
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Leckerli+One&display=swap" rel="stylesheet">
<div>
	<div class="main-side">
		<nav id="main-sidebar">
			<div class="flex-shrink-0 shadow p-1 sidescroll" style="width:230px; height:100%;">
				<div style="text-align:center;">
					<a href="${pageContext.request.contextPath}/main/main.do"
						class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
						<svg class="bi pe-none me-2" width="30" height="24"></svg>
							<span class="fs-3 fw-semibold text-center ourstudy">OurStudy</span>
					</a>
				<c:if test="${empty user}">
					<img src="${pageContext.request.contextPath}/image_bundle/face.png" width="130" height="130" class="my-photo">
				</c:if>
				<c:if test="${!empty user} && ${empty member.mem_photo}">
					<img src="${pageContext.request.contextPath}/image_bundle/face.png" width="130" height="130" class="my-photo">
				</c:if>
				<c:if test="${!empty user}">
					<img src = "${pageContext.request.contextPath}/mypage/photoView.do" width="130" height="130" class="my-photo">
				</c:if>
				<div>
					<c:if test="${empty user}">
						<button class="btn text-white mt-4 mb-4 rounded" style="background-color:#037332;">로그인 | 회원가입</button>
					</c:if>
					<%--임시로 넣어둠--%>
					<c:if test="${user.mem_status == 0}">
						<button class="btn text-white mt-4 mb-4 rounded" style="background-color:gray">퇴실</button>
					</c:if>
					<c:if test="${user.mem_status == 1}">
						<button class="btn text-white mt-4 mb-4 rounded" style="background-color:red">입실중</button>
					</c:if>
					<c:if test="${user.mem_status == 2}">
						<button class="btn text-white mt-4 mb-4 rounded" style="background-color:blue">외출중</button>
					</c:if>
				</div>
				</div>
				
				<div class="side-bottom">
       				<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
        				data-bs-toggle="collapse" data-bs-target="#item-collapse" aria-expanded="false">
          				&nbsp;<i class="bi bi-ticket-perforated"></i>
          				<span class="innerhome">이용권 구매</span>
        			</button>
        			<div class="collapse" id="item-collapse">
         		 	<ul class="btn-toggle-nav fw-normal pb-1 small">
           				<li><a href="#" class="link-dark d-inline-flex rounded">좌석 이용권</a></li>
            			<li><a href="#" class="link-dark d-inline-flex rounded">사물함 이용권</a></li>
          			</ul>
        			</div>
        		</div>
				
				<div class="side-inline chair-bottom" style="cursor: pointer;" onclick="location.href=''">
					<ul>
						<li><i class="fas fa-regular fa-chair"></i></li>
						<li class="chair">좌석 선택</li>
					</ul>
				</div>
				
				<div class="side-inline laptop-bottom" style="cursor: pointer;" onclick="location.href=''">
					<ul>
						<li><i class="fas fa-regular fa-laptop"></i></li>
						<li class="laptop">물품 대여</li>
					</ul>
				</div>
				
				<div class="side-bottom">
       				<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
        				data-bs-toggle="collapse" data-bs-target="#notice-collapse" aria-expanded="false">
          				&nbsp;<i class="fas fa-regular fa-bullhorn equal-left"></i>
          				<span class="notice-span">시설 안내</span>
        			</button>
        			<div class="collapse" id="notice-collapse">
         		 	<ul class="btn-toggle-nav fw-normal pb-1 small">
           				<li><a href="#" class="link-dark d-inline-flex rounded">안내사항</a></li>
            			<li><a href="#" class="link-dark d-inline-flex rounded">자주 묻는 질문</a></li>
          			</ul>
        			</div>
        		</div>
				
				<div class="side-bottom">
       				<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
        				data-bs-toggle="collapse" data-bs-target="#comm-collapse" aria-expanded="false">
          				&nbsp;<i class="bi bi-people-fill equal-left"></i>
          				<span class="comm-span">커뮤니티</span>
        			</button>
        			<div class="collapse" id="comm-collapse">
         		 	<ul class="btn-toggle-nav fw-normal pb-1 small">
           				<li><a href="#" class="link-dark d-inline-flex rounded">분실물 찾기</a></li>
            			<li><a href="#" class="link-dark d-inline-flex rounded">이용후기</a></li>
          			</ul>
        			</div>
        		</div>
		
				<div>
					<ul	class="side-inline" style="cursor: pointer;" onclick="location.href=''">
						<li><i class="fas fa-light fa-id-card"></i></li>
						<li class="myp">마이페이지</li>
					</ul>
				</div>
				<br>
				<c:if test="${!empty user}">
						<button class="btn text-white rounded logout-btn" style="background-color:#037332;">로그아웃</button>
				</c:if>
				<br><br>
			</div>
		</nav>
	</div>
</div>
<!-- 메인 끝 -->
