<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>물품대여기록</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<form class="search-form d-flex align-items-center" action="admin_itemhistory.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<select class="form-select" id="form-select1" name="keyfield" aria-label="form-select"
									onchange="location.href='admin_itemhistory.do?keyfield='+this.value">
								<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>최근대여순</option>
								<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>가나다순(이름)</option>
							</select> 
							<!--                            //검색했을 때 값이 남아있게 하기 위해서 -->
							<!--                            //자기자신에게 값을 보내기 때문에 param 이용 -->
							<input type="text" name="keyword" value="${param.keyword}" placeholder="물품명 검색">
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
						<td>표시할 대여기록이 없습니다</td>
					</tr>
				</table>
				</c:if>
				<c:if test="${count>0}">
					<table class="table table-hover align-center" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="9%">대여번호<br></th>
								<th scope="col" width="11%">물품명</th>
								<th scope="col" width="9%">물품번호</th>
								<th scope="col" width="9%">회원번호</th>
								<th scope="col" width="11%">이름</th>
								<th scope="col" width="15%">전화번호</th>
								<th scope="col" width="18%">대여시간</th>
								<th scope="col" width="18%">반납시간</th>
							</tr>							
						</thead>
						<tbody class="table-body table-group-divider">
							<c:forEach var="history" items="${adminItemHistoryList}"><!-- var는 자바빈(VO) -->
							<tr>
								<th scope="row">${history.item_rnum}</th>
								<td>${history.item_title}</td>		
								<td>${history.item_index}</td>
								<td>${history.mem_num}</td>
								<td>${history.mem_name}</td>
								<td>${history.mem_phone}</td>
								<td>${history.item_start}</td>
								<c:if test="${history.item_end == null}">
								<td><span style="color:red">현재대여중</span></td>
								</c:if>
								<c:if test="${history.item_end != null}">
								<td>${history.item_end}</td>
								</c:if>	
							</tr>
							</c:forEach>						
						</tbody>
					</table>
					<table class="table table-hover table-group-divider" id="t2">
						<c:forEach var="history" items="${adminItemHistoryList}">
						<tr>
							<td>
								<div>${history.item_title}</div>
								<span class="t-sub-info">${history.item_title}</span> &nbsp; 
								<span class="t-sub-info">${history.item_index}</span> &nbsp;
								<span class="t-sub-info">${history.mem_num}</span> &nbsp;
								<span class="t-sub-info">${history.mem_name}</span> &nbsp;
								<span class="t-sub-info">${history.mem_phone}</span> &nbsp;
								<span class="t-sub-info">${history.item_start}</span> &nbsp;
								<c:if test="${history.item_end == null}">
								<span class="t-sub-info" style="color:red">현재대여중</span>
								</c:if>
								<c:if test="${history.item_end != null}">
								<span class="t-sub-info">${history.item_end}</span>
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