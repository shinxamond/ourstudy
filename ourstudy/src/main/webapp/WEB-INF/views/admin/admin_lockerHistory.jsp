<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>사물함히스토리목록</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<form class="search-form d-flex align-items-center" action="admin_lockerhistory.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<select class="form-select" id="form-select1" name="keyfield" aria-label="form-select"
									onchange="location.href='admin_lockerhistory.do?keyfield='+this.value">
								<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근시작순</option>
								<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>이름(가나다순)</option>
								<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>종료(임박)순</option>
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
								<th scope="col" width="11%">이용번호<br></th>
								<th scope="col" width="11%">사물함번호</th>
								<th scope="col" width="11%">회원번호</th>
								<th scope="col" width="17%">이름</th>
								<th scope="col" width="25%">시작시간</th>
								<th scope="col" width="25%">종료(예정)시간</th>
							</tr>													
						</thead>
						<tbody class="table-body table-group-divider">
							<c:forEach var="history" items="${adminLockerHistoryList}"><!-- var는 자바빈(VO) -->
							<tr>
								<th scope="row">${history.locker_detail_num}</th>
								<td>${history.locker_num}</td>		
								<td>${history.mem_num}</td>
								<td>${history.mem_name}</td>
								<td>${history.locker_start}</td>
								<c:if test="${history.locker_status == 0}">
								<td><span style="color:red">${history.locker_end}</span></td>
								</c:if>
								<c:if test="${history.locker_status != 0}">
								<td>${history.locker_end}</td>
								</c:if>
							</tr>							
							</c:forEach>						
						</tbody>
					</table>
					<table class="table table-hover table-group-divider" id="t2">
						<c:forEach var="history" items="${adminLockerHistoryList}">
						<tr>
							<td>
								<div>
								${history.locker_num}번 &nbsp;
								${history.mem_name} (${history.mem_num})
								</div>
								<span class="t-sub-info">${history.locker_start}</span> &nbsp;
								<c:if test="${history.locker_status == 0}">
								<span style="color:red" class="t-sub-info">${history.locker_end}</span>
								</c:if>
								<c:if test="${history.locker_status != 0}">
								<span class="t-sub-info">${history.locker_end}</span>
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