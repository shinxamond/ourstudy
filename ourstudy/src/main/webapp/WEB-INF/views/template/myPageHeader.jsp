<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage/mypageProfileImg.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/mypage/changePw.js"></script>
<!-- 마이페이지 헤더 시작 -->
<div id = "mypage-header">
	<div class = "element-box">
		<div class = "element">
			<a href="#profile-change" data-bs-toggle="modal"><img src = "${pageContext.request.contextPath}/mypage/photoView.do" class = "profile-photo"></a>
			<a href="#profile-change" data-bs-toggle="modal"><img src = "${pageContext.request.contextPath}/image_bundle/settings.png" class = "settings-img"></a>
				<span class = "span-align">안녕하세요, <strong><a href = "${pageContext.request.contextPath}/mypage/myPageMemInfo.do" id = "mem_info_btn">${member.mem_name}</a></strong>님</span>
				<br>
				<span class = "welcome-msg">오늘도 아워스터디를 이용해주셔서 감사합니다.</span>
				<c:if test="${empty locker_num}">
				<button class = "locker-btn" onclick = "location.href = '${pageContext.request.contextPath}/ticket/locker_ticketList.do'">사물함 <b>등록</b></button>
				</c:if>
				<c:if test="${!empty locker_num}">
				<button class = "locker-btn" onclick = "location.href = '${pageContext.request.contextPath}/ticket/locker_ticketList.do?locker_num=${locker_num}'">사물함 <b>연장</b></button>
				</c:if>
				<p class = "firstclass-p"><a href = "${pageContext.request.contextPath}/mypage/myPageModify.do" id = "mem_modify_btn" class = "link-font small">정보수정 ></a></p>
		</div>
		
		<div id = "insert_content_info">
		
		</div>
		
		<div class = "element">
			<p><a href = "${pageContext.request.contextPath}/mypage/studyTimeList.do" id ="mem_studyTime_btn" class = "link-font big">누적 공부시간 ></a></p>
			<span class = "data-align top"><fmt:parseNumber value = "${member.mem_study / 3600}"  integerOnly="true"/> 시간</span>
		</div>
		
		<div id = "insert_content_time">
		
		</div>		
		
		<div class = "element">
			<p><a href = "${pageContext.request.contextPath}/mypage/pointList.do" id = "mem_point_btn" class = "link-font big">포인트 ></a></p>
			<span class = "data-align top"><fmt:formatNumber value = "${pointSum}"/>P</span>
		</div>
				
		<div id = "insert_content_point">
		
		</div>		
		
		<div class = "element">
			<c:if test="${member.mem_status == 0}"><span>이용중인 좌석이 없습니다.</span></c:if>
			<c:if test="${member.mem_status == 2}">현재 외출중입니다.</c:if>
			<c:if test="${!empty seat.seat_name}"><span>NO. <b>${seat.seat_name}</b>번 자리</span></c:if>
			<span class = "data-time">잔여시간 : <span class = "data-align" id = "remainTimeZone">
			<c:if test="${remainTime != 0}">
			<fmt:parseNumber value = "${remainTime < 120 ? 0 : remainTime / 86400}"  integerOnly="true"/>일 
			<fmt:parseNumber value = "${((remainTime / 3600) % 3600) % 24}"  integerOnly="true"/>시간
			<fmt:parseNumber value = "${(remainTime / 60 % 60)+(((remainTime / 60 % 60)%1>0.5)?(1-((remainTime / 60 % 60)%1))%1:-((remainTime / 60 % 60)%1))}" integerOnly="true"/>분
			</c:if>
			<c:if test="${!empty remainTerm}">
			<fmt:parseNumber value = "${remainTerm < 120 ? 0 : remainTerm / 86400}"  integerOnly="true"/>일 
			<fmt:parseNumber value = "${((remainTerm / 3600) % 3600) % 24}"  integerOnly="true"/>시간
			<fmt:parseNumber value = "${(remainTerm / 60 % 60)+(((remainTerm / 60 % 60)%1>0.5)?(1-((remainTerm / 60 % 60)%1))%1:-((remainTerm / 60 % 60)%1))}" integerOnly="true"/>분
			</c:if>
			</span></span>
			<br>
			<div class = "seatcheck-buttons">
				<button class = "seatcheck-button"<c:if test="${member.mem_status == 1}">style = "background : #e65962; border : none; color : white;"</c:if> onclick=<c:if test="${member.mem_status == 1}">"alert('이미 입실중입니다.');"</c:if>
														   <c:if test="${member.mem_status != 1}">"location.href='${pageContext.request.contextPath}/seat/in.do'"</c:if>>입실</button>
				<button class = "seatcheck-button"<c:if test="${member.mem_status == 2}">style = "background : #384048;border : none; color : white;"</c:if> onclick="location.href='${pageContext.request.contextPath}/seat/hold.do?seat_num=${seat.seat_num}'">외출</button>
				<button class = "seatcheck-button"<c:if test="${member.mem_status == 0}">style = "background : #b4aab1;border : none; color : white;"</c:if> onclick="location.href='${pageContext.request.contextPath}/seat/out.do?'">퇴실</button>			
			</div>

			<span class = "lastchild-span"><a href = "${pageContext.request.contextPath}/seat/selectForm.do" class = "link-font small">좌석선택 ></a></span>
		</div>
						
		<div id = "insert_content_seat">
		
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
<c:if test = "${remainTerm == 0}">
<span id="${mem_statusForCheckIn}" class = "setCheckInStatus"></span>
<span id="${mem_numForCheckIn}" class = "setCheckInMemnum"></span>
<span id="${seat.seat_num}" class = "setCheckSeatNum"></span>
</c:if>
<!-- 마이페이지 헤더 끝 -->