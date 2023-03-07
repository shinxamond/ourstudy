<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  채팅방 생성 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/talk.css">
<div class="page-main">
	<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>채팅방생성</b></h3>
	
			<form action="talkRoomWrite.do" method="post" id="talk_form" class="room_t1">
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
				<div style="text-align:center"><b>회원목록</b></div>
				<br>
				<div class="table-wrapper">
				<table class="table table-hover align-center" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="11%">회원번호<br></th>
								<th scope="col" width="11%">이름</th>
								<th scope="col" width="11%">아이디</th>
								
							</tr>							
						</thead>
				<tbody class="table-body table-group-divider">
				<c:forEach var="member" items="${list}">
					<tr class="choice" id="${member.mem_num}" data-num="${member.mem_num }">
						<td class="c1">${member.mem_num}</td>
						<td class="c2">${member.mem_name}</td>
						<td class="c3">${member.mem_id}</td>
					</tr>
				</c:forEach>
				</tbody>
				</table>
				</div>
				<br>
				<div class="align-center">
					<input type="submit" value="전송">
					<input type="button" value="목록" onclick="location.href='talkList.do'">
				</div>
			</form>
			<!-- -----------------------------------반응형------------------------- -->
			<form action="talkRoomWrite.do" method="post" id="talk_form2" class="room_t2">
				<input type="hidden" name="members" id="user" data-id="${user.mem_id}" value="${user.mem_num}">
				
						<label style="font-size:15px;">채팅방 이름</label><br>
						<input type="hidden" name="talkroom_name" id="talkroom_name"><br>
						<span id="name_span2"></span>
						<!-- <input type="checkbox" checked id="name_checked2">(자동생성) <br> -->
					
						<div id="talk_member2"></div><br>
						<!-- <label style="font-size:20px;">채팅회원검색</label><br>
						<input type="text" id="member_search" autocomplete="off" placeholder="아이디 검색">
						<div class="table-wrapper-search">
						<table class="striped-talk-search-table" id="search_area1">
						</table>
						</div> -->
				
				<br>
				<hr size="1" noshade="noshade" width="100%">
				<br>
				<div style="text-align:center"><b>회원목록</b></div>
				<br>
				<div class="table-wrapper2">
				<table class="table table-hover align-center" id="t2">
						
				<tbody class="table-body table-group-divider">
				<c:forEach var="member" items="${list}">
					<div class="choice" id="${member.mem_num}" data-num="${member.mem_num }">
						<span class="t-sub-info c1">${member.mem_num}</span>
						<span class="t-sub-info c2">${member.mem_name}</span>
						<span class="t-sub-info c3">${member.mem_id}</span>
					</div>
				</c:forEach>
				</tbody>
				</table>
				</div>
				<br>
				<div class="align-center">
					<input type="submit" value="전송">
					<input type="button" value="목록" onclick="location.href='talkList.do'">
				</div>
			</form>
			
			
		</div>
	</div>
</div>
<!-- 채팅방 생성 끝 -->