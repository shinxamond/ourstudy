<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  채팅방 생성 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/talk.css">
<div class="page-main">
	<div class="align-center">
	<h2>채팅방 생성</h2>
	</div><br>
	
	<form action="talkRoomWrite.do" method="post" id="talk_form">
		<input type="hidden" name="members" id="user" data-id="${user.mem_id}" value="${user.mem_num}">
		<ul id="RoomWrite">
			<li>
				<label style="font-size:20px;">채팅방 이름</label>
				<input type="hidden" name="talkroom_name" id="talkroom_name">
				<span id="name_span"></span>
				<input type="checkbox" checked id="name_checked">(자동생성) 
			</li>
			<li>
				<div id="talk_member"></div>
				<label style="font-size:20px;">채팅회원검색</label>
				<input type="text" id="member_search" autocomplete="off" placeholder="아이디 검색">
				<div class="table-wrapper-search">
				<table class="striped-talk-search-table" id="search_area1">
				</table>
				</div>
			</li>
		</ul>
		<br>
		<hr size="1" noshade="noshade" width="100%">
		<br>
		<div class="align-center"><b>전체 회원</b></div>
		<br>
		<div class="table-wrapper">
		<table class="striped-talk-table">
			<tr>
				<th>회원번호</th>
				<th>이름</th>
				<th>아이디</th>
			</tr>
		<c:forEach var="member" items="${list}">
			<tr class="choice" id="${member.mem_num}" data-num="${member.mem_num }">
				<td class="c1">${member.mem_num}</td>
				<td class="c2">${member.mem_name}</td>
				<td class="c3">${member.mem_id}</td>
			</tr>
		</c:forEach>
		</table>
		</div>
		<br>
		<div class="align-center">
			<input type="submit" value="전송">
			<input type="button" value="목록" onclick="location.href='talkList.do'">
		</div>
	</form>
</div>
<!-- 채팅방 생성 끝 -->