<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>좌석히스토리목록</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<form class="search-form d-flex align-items-center" action="admin_seathistory.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<select class="form-select" id="form-select1" name="keyfield" aria-label="form-select"
									onchange="location.href='admin_seathistory.do?keyfield='+this.value">
								<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근시작순</option>
								<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>이름(가나다순)</option>
								<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>이용시간순</option>
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
						<td>표시할 목록이 없습니다</td>
					</tr>
				</table>
				</c:if>
				<c:if test="${count>0}">
					<table class="table table-hover align-center" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="9%">이용번호<br></th>
								<th scope="col" width="9%">좌석번호</th>
								<th scope="col" width="9%">회원번호</th>
								<th scope="col" width="13%">이름</th>
								<th scope="col" width="20%">시작시간</th>
								<th scope="col" width="20%">종료시간</th>
								<th scope="col" width="20%">이용시간</th>
							</tr>							
						</thead>
						<tbody class="table-body table-group-divider">
							<c:forEach var="history" items="${adminUseHistoryList}" varStatus="status"><!-- var는 자바빈(VO) -->
							<tr>
								<th scope="row">${history.seat_detail_num}</th>
								<c:if test="${history.out_time == null}">
								<td><a class="open_modal" data-bs-toggle="modal" data-bs-target="#exampleModal${status.count}">
									${history.seat_num}</a></td>
								</c:if>
								<c:if test="${history.out_time != null}">
								<td><a class="open_modal" data-bs-toggle="modal" data-bs-target="#">
									${history.seat_num}</a></td>
								</c:if>	
								<td>${history.mem_num}</td>
								<td>${history.mem_name}</td>
								<td>${history.in_time}</td>
								<td>${history.out_time}</td>
								<c:if test="${history.out_time == null}">
								<td><span style="color:red">현재이용중</span></td>
								</c:if>
								<c:if test="${history.out_time != null}">
								<td>${history.total_time}</td>
								</c:if>
							</tr>
							
							<!-- Modal -->
							<div class="modal fade" id="exampleModal${status.count}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog">
							    <div class="modal-content">
							      <div class="modal-header">
							        <h1 class="modal-title fs-5" id="exampleModalLabel">
										<span id="seat_num">${history.mem_name}</span>님 (${history.seat_num}번 좌석)
									</h1>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							      </div>
							      <div class="modal-body">
							      정말 퇴실처리 하시겠습니까?
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							        <!-- 추후 퇴실처리 완료 후, 확인버튼 재확인 필요!! -->
							        <button type="button" class="btn btn-primary" 
							        	onclick="alert('퇴실처리를 완료했습니다'); location.href='/seat/out.do?seat_num='+${history.seat_num}">확인(퇴실처리)</button>
							      </div>
							    </div>
							  </div>
							</div>								
							</c:forEach>						
						</tbody>
					</table>
					<table class="table table-hover table-group-divider" id="t2">
						<c:forEach var="history" items="${adminUseHistoryList}">
						<tr>
							<td>
								<div>
								${history.seat_detail_num}번 &nbsp;
								${history.mem_name} (${history.mem_num})
								</div>
								<span class="t-sub-info">${history.in_time}</span> &nbsp;
								<span class="t-sub-info">${history.out_time}</span> &nbsp;
								<c:if test="${history.out_time == null}">
								<span style="color:red" class="t-sub-info">현재이용중</span>
								</c:if>
								<c:if test="${history.out_time != null}">
								<span class="t-sub-info">${history.total_time}</span>
								</c:if>
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