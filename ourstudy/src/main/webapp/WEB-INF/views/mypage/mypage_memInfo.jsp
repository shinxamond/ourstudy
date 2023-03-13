<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style>
/*필독 깜박이게 */
@keyframes blink-effect {
  50% {
    opacity: 0;
  }
}

.blink {
  animation: blink-effect 1s step-end infinite;
  animation-iteration-count:infinite;
  animation-duration: 0.8s;
  /*
  animation-name: blink-effect;
  animation-duration: 1s;
  animation-iteration-count:infinite;
  animation-timing-function:step-end;
  */
}
</style>
<!-- 마이페이지 메인 회원정보 시작 -->
<div class = "mypage_mem_info">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h3>회원정보</h3>
		</div>
		<hr class = "horizontal-line">
		<div class = "mem-info-content">
			<table>
				<tr>
					<th>아이디</th>
					<td>${member.mem_id}</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>${member.mem_email}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${member.mem_phone}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${member.mem_address1} ${member.mem_address2}</td>
				</tr>
				<tr>
					<th>사물함</th>
					<td>
					<c:if test="${!empty locker_num}"><span class="blink" style="color:blue">${locker_num}번 (${locker_end} 종료)</span></c:if>
					<c:if test="${empty locker_num}">이용중인 사물함이 없습니다.</c:if>
					</td>
				</tr>
			</table>
			
		</div>
	</div>
	
</div>
<!-- 마이페이지 메인 회원정보 끝 -->