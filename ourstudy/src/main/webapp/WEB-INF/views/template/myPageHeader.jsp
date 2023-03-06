<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>     
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage/mypageProfileImg.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage/changePw.js"></script>
<!-- 마이페이지 헤더 시작 -->
<div id = "mypage-header">
	<div class = "element-box">
		<div class = "element">
			<a href="#profile-change" data-bs-toggle="modal"><img src = "${pageContext.request.contextPath}/mypage/photoView.do" class = "profile-photo"></a>
			<a href="#profile-change" data-bs-toggle="modal"><img src = "${pageContext.request.contextPath}/image_bundle/settings.png" class = "settings-img"></a>
				<span class = "span-align">안녕하세요, <strong><a href = "${pageContext.request.contextPath}/mypage/myPageMemInfo.do">${member.mem_name}</a></strong>님</span>
				<br>
				<span class = "welcome-msg">오늘도 아워스터디를 이용해주셔서 감사합니다.</span>
				<p><a href = "${pageContext.request.contextPath}/mypage/myPageModify.do"  class = "link-font small">정보수정 ></a></p>
		</div>
		<div class = "element">
			<p><a href = "${pageContext.request.contextPath}/mypage/studyTimeList.do" class = "link-font big">누적 공부시간 ></a></p>
			<span class = "data-align top"><fmt:parseNumber value = "${member.mem_study / 3600}"  integerOnly="true"/> 시간</span>
		</div>
		<div class = "element">
			<p><a href = "${pageContext.request.contextPath}/mypage/pointList.do" class = "link-font big">포인트 ></a></p>
			<span class = "data-align top"><fmt:formatNumber value = "${pointSum}"/>P</span>
		</div>
		<div class = "element">
			NO.<span class = "data-align" style = "display : inline-block; width : 50px; text-align : right;"> ${seat.seat_name }</span> 번 자리
			<span class = "data-time">잔여시간 : <span class = "data-align">
			<fmt:parseNumber value = "${remainTime / 86400}"  integerOnly="true"/>일 
			<fmt:parseNumber value = "${((remainTime / 3600) % 3600) % 24}"  integerOnly="true"/>시간
			<fmt:parseNumber value = "${(remainTime / 60 % 60)+(((remainTime / 60 % 60)%1>0.5)?(1-((remainTime / 60 % 60)%1))%1:-((remainTime / 60 % 60)%1))}" integerOnly="true"/>분
			
			</span></span>
			<br>
			<div class = "seatcheck-buttons">
				<button class = "seatcheck-button" onclick="location.href='${pageContext.request.contextPath}/seat/in.do'">입실</button>
				<button class = "seatcheck-button" onclick="location.href='${pageContext.request.contextPath}/seat/hold.do?seat_num=${seat.seat_num}'">외출</button>
				<button class = "seatcheck-button" onclick="location.href='${pageContext.request.contextPath}/seat/out.do?seat_num=${seat.seat_num}'">퇴실</button>			
			</div>

			<span><a href = "${pageContext.request.contextPath}/mypage/myPageselectSeat.do" class = "link-font small">좌석선택 ></a></span>
		</div>
	</div>
</div>
<div id="profile-change" class="modal fade" tabindex="-1" data-bs-backdrop="static" class="modal-dialog modal-dialog-centered">
  <div class="modal-dialog modal-width">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" style = "margin-left: 85px;">프로필 사진 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>
			<img src = "${pageContext.request.contextPath}/mypage/photoView.do" class = "profile-photo" width = "150" height = "150">
			<br>
			<br>
			<input type = "file" id = "upload" accept = "image/gif, image/png, image/jpeg" style = "margin-left : 57px;">
		</p>
      </div>
      <div class="modal-footer justify-content-center" style = "align-items: center;">
        <button type="button" class="btn" id = "photo_reset" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn" id = "photo_submit">변경</button>
      </div>
    </div>
  </div>
</div>
<%-- <div id="profile-change" class="modal" style = "text-align : center;">
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
</div> --%>

<!-- 마이페이지 헤더 끝 -->