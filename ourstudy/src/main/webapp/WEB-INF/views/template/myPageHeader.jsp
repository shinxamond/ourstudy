<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage/mypageProfileImg.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage/changePw.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

<!-- 마이페이지 헤더 시작 -->
<div id = "mypage-header">
	<div class = "element-box">
		<div class = "element">
			<a href="#profile_modal" rel="modal:open"><img src = "${pageContext.request.contextPath}/mypage/photoView.do" class = "profile-photo"></a>
				<span class = "span-align">안녕하세요, <strong><a href = "${pageContext.request.contextPath}/mypage/myPageMain.do">${member.mem_name}</a></strong>님</span>
				<br>
				<span style = "padding-left: 110px;">오늘도 아워스터디를 이용해주셔서 감사합니다.</span>
				<p><a href = "${pageContext.request.contextPath}/mypage/myPageModify.do"  class = "link-font small">정보수정 ></a></p>
		</div>
		<div class = "element">
			<p><a href = "${pageContext.request.contextPath}/mypage/pointList.do" class = "link-font big">포인트 ></a></p>
			<span class = "data-align top">1300p</span>
		</div>
		<div class = "element">
			<p><a href = "${pageContext.request.contextPath}/mypage/studyTimeList.do" class = "link-font big">누적 공부시간 ></a></p>
			<span class = "data-align top">73 시간</span>
		</div>
		<div class = "element">
			NO.<span class = "data-align"> 33</span> 번 자리
			<span style = "margin-left : 110px;">잔여시간 : <span class = "data-align">00일 00시간 00분</span></span>
			<br>
			<br>
			<br>
			<button class = "seatcheck-button">입실</button>
			<button class = "seatcheck-button">외출</button>
			<button class = "seatcheck-button">퇴실</button>
			<span><a href = "${pageContext.request.contextPath}/mypage/myPageselectSeat.do" class = "link-font small">좌석선택 ></a></span>
		</div>
	</div>
</div>
<div id="profile_modal" class="modal" style = "text-align : center;">
	<h4>프로필사진 변경</h4>
	<br><br>
  	<img src = "${pageContext.request.contextPath}/mypage/photoView.do" class = "profile-photo" width = "150" height = "150">
  	<br>
  	<br>
  	<input type = "file" id = "upload" accept = "image/gif, image/png, image/jpeg" style = "margin-left : 70px;">
 	<br>
 	<br>
 	<a href="#" rel="modal:close" id = "photo_submit">변경</a>&nbsp;
 	<a href="#" rel="modal:close" id = "photo_reset">닫기</a>
</div>
<!-- 마이페이지 헤더 끝 -->