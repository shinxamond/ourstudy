<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<style>
.truncate-text {
    max-width: 270px; /** 현재 한글 기준 약 20글자 정도로 설정됨 */
    display:inline-block;
    vertical-align: middle;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
</style>
<!DOCTYPE html>
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>수신채팅히스토리</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<form class="search-form d-flex align-items-center" action="admin_receivehistory.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<select class="form-select" id="form-select1" name="keyfield" aria-label="form-select"
									onchange="location.href='admin_receivehistory.do?keyfield='+this.value">
								<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>최근수신순</option>
								<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>이름(가나다순)</option>
							</select> 
							<!--                            //검색했을 때 값이 남아있게 하기 위해서 -->
							<!--                            //자기자신에게 값을 보내기 때문에 param 이용 -->
							<input type="text" name="keyword" value="${param.keyword}" placeholder="이름 또는 회원번호 검색">
							<button type="submit" title="Search"><i class="bi bi-search"></i></button>
						</form>
					</div>
				</div>
				<!-- 검색폼 끝 -->
				
				<!-- table 시작 -->
				<div class="content-margin">
				<c:if test="${count == 0}">
				<table class="table table-group-divider align-center">
					<tr>
						<td>표시할 수신채팅이 없습니다</td>
					</tr>
				</table>
				</c:if>
				<c:if test="${count>0}">
					<table class="table table-hover align-center" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="12.5%">채팅번호<br></th>
								<th scope="col" width="12.5%">회원번호</th>
								<th scope="col" width="15%">이름</th>
								<th scope="col" width="25%">수신시각</th>
								<th scope="col" width="35%">내용</th>
							</tr>							
						</thead>
						<tbody class="table-body table-group-divider">
							<c:forEach var="history" items="${adminReceiveList}" varStatus="status"><!-- var는 자바빈(VO) -->
							<tr>
								<th scope="row">${history.talk_num}</th>
								<td>${history.mem_num}</td>
								<td>${history.mem_name}</td>
								<td>${history.chat_date}</td>
								<td><a class="open_modal" data-bs-toggle="modal" data-bs-target="#exampleModal${status.count}">
									<span class="truncate-text">${history.message}</span></a></td>	
							</tr>
							
							<!-- Modal -->
							<div class="modal fade" id="exampleModal${status.count}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-scrollable">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="exampleModalLabel">
										<span id="seat_num" style="color:blue;">${history.mem_name}님</span><br>[${history.chat_date}]
									</h1>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							      ${history.message}
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							      </div>
							    </div>
							  </div>
							</div>											
							</c:forEach>						
						</tbody>
					</table>
					<br>
					<table class="table table-hover table-group-divider" id="t2">
						<c:forEach var="history" items="${adminReceiveList}">
						<tr>
							<td>
								<div>
								${history.mem_name} (${history.mem_num})
								</div>							
								<span class="t-sub-info truncate-text">${history.message}</span> <br>
								<span class="t-sub-info truncate-text">${history.chat_date}</span>
							</td>
						</tr>
						</c:forEach>
					</table>
				</c:if>
				</div><!-- table 끝 -->
				
				<!-- 페이지 번호 시작 -->
				<c:if test="${count>0}">
				<div class="align-center">${page}</div>
				</c:if>
			</div><!-- 사이드바 오른쪽 화면 끝 -->	
		</div><!-- 컨텐트 메인 끝 -->
	</div><!-- 페이지 메인 끝 -->
</body>