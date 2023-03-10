<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 상단 시작 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<%-- Bootstrap core CSS --%>
<link href="/docs/5.0/dist/css/bootstrap.min.css" rel="stylesheet" 
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<%--아이콘--%>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<%--폰트 --%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Leckerli+One&display=swap" rel="stylesheet">
<%--로그인 유효성 체크 --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/logincheck.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sidebar.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/checkDeadlineTime.js"></script>

<%--네이버 --%>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"></script>

<%--카카오톡 로그아웃 --%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>


<script>
Kakao.init('29a4ee7bbc4eb20216c3708400363a9a'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단


function kakaoLogout() {
	Kakao.API.request({
		  url: '/v1/user/logout',
	})
		  .then(function(response) {
		    console.log(response);
		  })
		  .catch(function(error) {
		    console.log(error);
		  });
}
</script>

<%-- 사이드바 시작 --%>

<%-- 로그인 모달 시작 --%>
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content head">
			<div class="modal-body p-2">
				<div class="row">
					<div class="col-3"></div>
					<div class="col-7">
						<h3 class="modal-title ourstudy my-3" id="loginModalLabel">OurStudy</h3>
					</div>
					<div class="col-2">
						<%-- x 닫기 --%>
						<button type="button" class="close btn" style="border:none;"
							data-bs-dismiss="modal" aria-label="Close">
							<i class="bi bi-x-lg"></i>
						</button>
					</div>
				</div>
				
				<c:if test="${empty user}">
				<form action="${pageContext.request.contextPath}/member/login.do" method="post" id="login_form">
						<ul>
							<li><label for="mem_id"></label>
								<input type="text" name="mem_id" id="mem_id" placeholder=" ID"/></li>
								<li><span id="login_Id"></span></li>
							<li><label for="mem_pw"></label>
								<input type="password" name="mem_pw" id="mem_pw" placeholder=" Password"/></li>
								<li><span id="login_Pw"></span></li>
							<li>&nbsp;<input type="checkbox" name="auto" id="auto">&nbsp;로그인 상태 유지
							</li>
						</ul>
					
						<button type="submit" class="btn login-submit 
						text-white rounded submit p-2" style="background-color:#e65962;">Login
						</button>
				</form>
				</c:if>
				<ul class="find-id my-3">
					<li><a href="${pageContext.request.contextPath}/member/findId.do">아이디 찾기</a></li>
					<li>&nbsp;|&nbsp;</li>
					<li><a href="${pageContext.request.contextPath}/member/findPw.do">비밀번호 찾기</a></li>
					<li>&nbsp;|&nbsp;</li>
					<li><a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a></li>
				</ul>
				
				<div class="mt-4 text-center" style="color:gray">――――――― 간편 로그인 ―――――――</div>
				
				<%--카카오(Rest API) --%>
				<div class="mt-3 mb-4 d-flex justify-content-center">
					<a href="https://kauth.kakao.com/oauth/authorize?client_id=0ed971182cc827fbd73de790073ac06a&redirect_uri=http://localhost:8001/member/kakaoLogin
						&response_type=code">
   					<img src="${pageContext.request.contextPath}/image_bundle/kakao.PNG" class="my-photo" style="width:51px; height:51px;"></a>&nbsp;&nbsp;&nbsp;&nbsp;
					
					<%--네이버(네아로 API) --%>
					<a href="${urlNaver}">
	   				<img src="${pageContext.request.contextPath}/image_bundle/naver.png" style="width:50px;"></a>
				</div>
				
			</div>
		</div>
	</div>
</div>
<%-- 로그인 모달 끝 --%>
<div class="origin-side">
	<div class="main-side">
		
		<nav id="main-sidebar">
			<div class="shadow p-1 sidescroll" style="width:240px; height:100%; background-color:white;">
				<div style="text-align:center;">
					<a href="${pageContext.request.contextPath}/main/main.do"
						class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
						<svg class="bi pe-none me-2" width="30" height="24"></svg>
							<span class="fw-semibold ourstudy">OurStudy</span>
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
						<button class="btn text-white mt-4 mb-4 rounded" data-bs-toggle="modal" data-bs-target="#loginModal" 
						style="background-color:#e65962;">로그인 | 회원가입</button>
					</c:if>
						
					<%--임시로 넣어둠--%>
					<c:if test="${!empty user && user.mem_status == 0}">
						<button class="btn text-white mt-4 mb-4 rounded" style="background-color:#b4aab1">퇴실</button>
					</c:if>
					<c:if test="${!empty user && user.mem_status == 1}">
						<button class="btn text-white mt-4 mb-4 rounded" style="background-color:#e65962">입실중</button>
					</c:if>
					<c:if test="${!empty user && user.mem_status == 2}">
						<button class="btn text-white mt-4 mb-4 rounded" style="background-color:#384048">외출중</button>
					</c:if>
				</div>
				</div>
				
				<div class="side-bottom">
       				<button class="btn btn-toggle d-inline-flex  align-items-center rounded collapsed border-white" 
        				data-bs-toggle="collapse" data-bs-target="#item-collapse" aria-expanded="false">
          				&nbsp;<i class="bi bi-ticket-perforated"></i>
          				<span class="innerhome">이용권 구매</span>
        			</button>
        			<div class="collapse" id="item-collapse">
         		 	<ul class="btn-toggle-nav fw-normal pb-1 small collapsed">
           				<li>
           					<a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/ticket/study_ticketList.do"</c:if> class="d-inline-flex rounded"
           					<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="rounded" id="item-collapsed1">좌석 이용권</a>
           					
           				</li>
            			<li>
	            			<a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/ticket/locker_ticketList.do"</c:if> class="d-inline-flex rounded"
							<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="rounded" id="item-collapsed2">사물함 이용권</a>
            			</li>
          			</ul>
        			</div>
        		</div>
				
				<div class="side-inline chair-bottom" style="cursor: pointer;">
					<ul>
						<li><i class="fas fa-regular fa-chair"></i></li>
						<li class="chair"><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/seat/selectForm.do"</c:if> class="side-main-link"
						<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="side-main-link">좌석 선택</a></li>

					</ul>
				</div>
				
				<div class="side-inline laptop-bottom" style="cursor: pointer;">
					<ul>
						<li><i class="fas fa-regular fa-laptop"></i></li>
						<li class="laptop"><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/item/userList.do"</c:if> class="side-main-link"
						<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="side-main-link">물품 대여</a></li>
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
	           				<li><a href="${pageContext.request.contextPath}/info/informationList.do" class="d-inline-flex rounded">안내사항</a></li>
	            			<li><a href="${pageContext.request.contextPath}/info/faq.do" class="d-inline-flex rounded">자주 묻는 질문</a></li>
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
           				<li><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/community/lostList.do"</c:if> class="d-inline-flex rounded"
           				<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="rounded">분실물 찾기</a></li>
            			<li><a href="${pageContext.request.contextPath}/review/list.do" class="d-inline-flex rounded">이용후기</a></li>
          			</ul>
        			</div>
        		</div>
        		<c:if test="${!empty user && user.mem_auth == 1}">
				<div>
					<ul	class="side-inline" style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/mypage/myPageMain.do'">
						<li><i class="fas fa-light fa-id-card"></i></li>
						<li class="myp side-main-link">마이페이지</li>
					</ul>
				</div>
				</c:if>
        		<c:if test="${!empty user && user.mem_auth == 9}">
				<div class="side-bottom">
       				<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
        				data-bs-toggle="collapse" data-bs-target="#admin-collapse" aria-expanded="false">
          				&nbsp;<i class="fas fa-light fa-id-card"></i>
          				<span class="comm-span side-main-link">관리페이지</span>
        			</button>
        			<div class="collapse" id="admin-collapse">
         		 	<ul class="btn-toggle-nav fw-normal pb-1 small">
         		 		<li>
	         		 		<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
	        					data-bs-toggle="collapse" data-bs-target="#admin-collapse1" aria-expanded="false">
	        					<i class="bi bi-plus-circle-fill"></i>
	          					<span class="comm-span side-main-link">관리자추가</span>
	        				</button>
	        				<div class="collapse" id="admin-collapse1">
	        				<ul class="btn-toggle-nav fw-normal pb-1 small">
            					<li><a href="${pageContext.request.contextPath}/ticket/admin_ticketList.do" class="d-inline-flex rounded">이용권추가</a></li>
            					<li><a href="${pageContext.request.contextPath}/item/adminList.do" class="d-inline-flex rounded">물품추가</a></li>        					
	        				</ul>
	        				</div>
         		 		</li>     		 		         		 	
         		 		<li>
         		 		&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-person-fill-gear" style="font-size:13pt;"></i>
         		 		<a href="${pageContext.request.contextPath}/admin/admin_list.do" class="d-inline-flex rounded" style="font-size:12pt; margin-left:0pt; margin-top:0;">회원관리</a>
         		 		</li>
         		 		<li>
	         		 		<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
	        					data-bs-toggle="collapse" data-bs-target="#admin-collapse2" aria-expanded="false">
	        					<i class="bi bi-database-fill"></i>
	          					<span class="comm-span side-main-link">이용기록</span>
	        				</button>
	        				<div class="collapse" id="admin-collapse2">
	        				<ul class="btn-toggle-nav fw-normal pb-1 small">
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_seathistory.do" class="d-inline-flex rounded">좌석기록</a></li>
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_lockerhistory.do" class="d-inline-flex rounded">사물함기록</a></li>
	        				</ul>
	        				</div>
         		 		</li>     		 		
         		 		<li>
	         		 		<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
	        					data-bs-toggle="collapse" data-bs-target="#admin-collapse3" aria-expanded="false">
	        					<i class="bi bi-inboxes-fill"></i>  
	          					<span class="comm-span side-main-link">물품기록</span>
	        				</button>
	        				<div class="collapse" id="admin-collapse3">
	        				<ul class="btn-toggle-nav fw-normal pb-1 small">
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_itemhistory.do" class="d-inline-flex rounded">대여히스토리</a></li>
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_unreturnlist.do" class="d-inline-flex rounded">미반납자</a></li>	        					
	        				</ul>
	        				</div>
         		 		</li>	
         		 		<li>
         		 		&nbsp;&nbsp;&nbsp;&nbsp;<i class="bi bi-piggy-bank-fill" style="font-size:13pt;"></i>
         		 		<a href="${pageContext.request.contextPath}/admin/admin_saleslist.do" class="d-inline-flex rounded" style="font-size:12pt; margin-left:0pt; margin-top:0;">판매기록</a>
         		 		</li>         		 		 			
           				<li>
	         		 		<button class="btn btn-toggle  d-inline-flex  align-items-center rounded collapsed border-white" 
	        					data-bs-toggle="collapse" data-bs-target="#admin-collapse4" aria-expanded="false">
          						<i class="bi bi-chat-left-dots-fill"></i>	        					
	          					<span class="comm-span side-main-link">채팅기록</span>
	        				</button>
	        				<div class="collapse" id="admin-collapse4">
	        				<ul class="btn-toggle-nav fw-normal pb-1 small">
	        					<li><a href="${pageContext.request.contextPath}/talk/talkList.do" class="d-inline-flex rounded">채팅목록</a></li>
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_receivehistory.do" class="d-inline-flex rounded">수신채팅</a></li>
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_sendhistory.do" class="d-inline-flex rounded">발신채팅</a></li>	        					
	        				</ul>
	        				</div>
         		 		</li>           		 		         		 		
           			</ul>
        			</div>        		 		
        		</div>       				
				</c:if>
				<br>				
				<c:if test="${!empty user}">
						<button class="btn text-white rounded logout-btn" style="background-color:#E65962;"
						onclick="location.href='https://kauth.kakao.com/oauth/logout?client_id=29a4ee7bbc4eb20216c3708400363a9a&logout_redirect_uri=http://localhost:8001/main/main.do';location.href='${pageContext.request.contextPath}/member/logout.do';">
						로그아웃</button>
				</c:if>
				<br><br>
			</div>
		</nav>
	</div>
</div>
<%-- 사이드바 끝 --%>


<%-- 축소하면 보이는 nav 메뉴 --%>
<nav class="navbar navbar-expand-lg navbar-light" id="navbar">
				<a href="${pageContext.request.contextPath}/main/main.do"
						class="link-dark text-decoration-none">
						<svg class="bi pe-none me-5" width="30" height="24"></svg>
							<span class="fw-semibold ourstudy" style="margin-left:100px;">OurStudy</span>
				</a>
				<button class="navbar-toggler" type="button" 
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button> 
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav">
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">이용권구매</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/ticket/study_ticketList.do"</c:if> class="d-inline-flex rounded" 
           							<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="rounded">좌석 이용권</a></li>
			       				<li><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/ticket/locker_ticketList.do"</c:if> class="d-inline-flex rounded"
									<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="rounded">사물함 이용권</a></li>
							</ul>
						</li>
						
						<li class="nav-item py-2"><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/seat/selectForm.do"</c:if> class="side-main-link"
							<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="side-main-link">좌석 선택</a></li>
						
						<li class="nav-item py-2"><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/item/userList.do"</c:if> class="side-main-link"
							<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="side-main-link">물품 대여</a></li>
						
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">시설안내</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a href="${pageContext.request.contextPath}/info/informationList.do" class="d-inline-flex rounded">안내사항</a></li>
								<li><a href="${pageContext.request.contextPath}/info/faq.do" class="d-inline-flex rounded">자주 묻는 질문</a></li>
							</ul>
						</li>
						
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a href=<c:if test="${!empty user}">"${pageContext.request.contextPath}/community/lostList.do"</c:if> class="d-inline-flex rounded"
           							<c:if test="${empty user}">data-bs-toggle="modal" data-bs-target="#loginModal"</c:if> class="rounded">분실물 찾기</a></li>
								<li><a href="${pageContext.request.contextPath}/review/list.do" class="d-inline-flex rounded">이용후기</a></li>
							</ul>
						</li>
						
					<c:if test="${!empty user && user.mem_auth == 1}">
						<li class="nav-item py-2"><a href="${pageContext.request.contextPath}/mypage/myPageMain.do" class="side-main-link">마이페이지</a></li>
					</c:if>
						
					<c:if test="${!empty user && user.mem_auth == 9}">
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">관리페이지</a>
							<ul class="dropdown-menu">
								<li><h6 class="dropdown-header">관리자추가</h6></li>
            						<li><a href="${pageContext.request.contextPath}/ticket/admin_ticketList.do" class="d-inline-flex rounded">이용권추가</a></li>
            						<li><a href="${pageContext.request.contextPath}/item/adminList.do" class="d-inline-flex rounded">물품추가</a></li>
								<li><hr class="dropdown-divider"></li>
								
			       				<li><a href="${pageContext.request.contextPath}/admin/admin_list.do" class="d-inline-flex rounded">회원관리</a></li>
			       				<li><hr class="dropdown-divider"></li>
			       				
			       				<li><h6 class="dropdown-header">이용기록</h6></li>
			       					<li><a href="${pageContext.request.contextPath}/admin/admin_seathistory.do" class="d-inline-flex rounded">좌석기록</a></li>
	        						<li><a href="${pageContext.request.contextPath}/admin/admin_lockerhistory.do" class="d-inline-flex rounded">사물함기록</a></li>
			       				<li><hr class="dropdown-divider"></li>
			       				
			       				<li><h6 class="dropdown-header">물품기록</h6></li>
			       				<li><a href="${pageContext.request.contextPath}/admin/admin_itemhistory.do" class="d-inline-flex rounded">대여히스토리</a></li>
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_unreturnlist.do" class="d-inline-flex rounded">미반납자</a></li>
			       				<li><hr class="dropdown-divider"></li>
			       				
			       				<li><a href="${pageContext.request.contextPath}/admin/admin_saleslist.do" class="d-inline-flex rounded">판매기록</a></li>
			       				<li><hr class="dropdown-divider"></li>
			       				
			       				<li><h6 class="dropdown-header">채팅기록</h6></li>
			       				<li><a href="${pageContext.request.contextPath}/talk/talkList.do" class="d-inline-flex rounded">채팅목록</a></li>
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_receivehistory.do" class="d-inline-flex rounded">수신채팅</a></li>
	        					<li><a href="${pageContext.request.contextPath}/admin/admin_sendhistory.do" class="d-inline-flex rounded">발신채팅</a></li>
			       			</ul>	
						</li>				
					</c:if>						
				</ul>
				
					<c:if test="${empty user}">
						<button class="btn text-white rounded" data-bs-toggle="modal" data-bs-target="#loginModal" 
						style="background-color:#e65962;  margin:10px 0 0 320px;">로그인 | 회원가입</button>
					</c:if>
					<c:if test="${!empty user}">
						<button class="btn text-white rounded logout-btn" style="background-color:#E65962; margin:10px 0 0 380px;"
						onclick="location.href='https://kauth.kakao.com/oauth/logout?client_id=29a4ee7bbc4eb20216c3708400363a9a&logout_redirect_uri=http://localhost:8001/main/main.do';location.href='${pageContext.request.contextPath}/member/logout.do';">
						로그아웃</button>
					</c:if>

				</div>
			</nav>



