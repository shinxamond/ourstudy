<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>물품목록</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<form class="search-form d-flex align-items-center" action="adminList.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<select class="form-select" id="form-select1" name="keyfield" aria-label="form-select"
									onchange="location.href='adminList.do?keyfield='+this.value">
								<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>이름</option>
								<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>물품명 식별 번호</option>
								<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>상태(표시:1/미표시:2)</option>
								<option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>대여(기본:1/대여:2/반납:3)</option>
							</select> 
							<!--                            //검색했을 때 값이 남아있게 하기 위해서 -->
							<!--                            //자기자신에게 값을 보내기 때문에 param 이용 -->
							<input type="text" name="keyword" value="${param.keyword}">
							<button type="submit" title="Search"><i class="bi bi-search"></i></button>
						</form>
					</div>
				</div>
				<!-- 검색폼 끝 -->
				<div class="align-right">
				<input type="button" class="itemButton" value="물품생성" onclick="location.href='itemWrite.do'">
				<input type="button" class="itemButton" value="목록" onclick="location.href='adminList.do'">
				</div>
				<!-- table 시작 -->
				<div class="content-margin">
				<c:if test="${count == 0}">
				<table class="table table-group-divider align-center">
					<tr>
						<td>표시할 물품이 없습니다</td>
					</tr>
				</table>
				</c:if>
				<c:if test="${count>0}">
					<table class="table table-hover align-center al" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="20%">물품번호<br></th>
								<th scope="col" width="20%">물품명번호</th>
								<th scope="col" width="20%">물품이름</th>
								<th scope="col" width="20%">상태</th>
								<th scope="col" width="20%">대여상태</th>
								
							</tr>							
						</thead>
						<tbody class="table-body table-group-divider">
							<c:forEach var="item" items="${list}">
							<tr>
								<td>
									<a href="itemModify.do?item_num=${item.item_num}">${item.item_num}</a>
								</td>
								<td>${item.item_index}</td>
								<td>${item.item_title}</td>
								<td>
								<c:if test="${item.item_p_status == '1' }">표시</c:if>
								<c:if test="${item.item_p_status == '2' }">미표시</c:if>
								</td>
								<td>
									<c:if test="${item.item_r_status == '1' }">기본</c:if>
									<c:if test="${item.item_r_status == '2' }">대여</c:if>
									<c:if test="${item.item_r_status == '3' }"><a href="adminItemReturn.do?item_num=${item.item_num}">반납</a></c:if>
								</td>
							</tr>
							</c:forEach>					
						</tbody>
					</table>
					<table class="table table-hover table-group-divider al" id="t2">
						<c:forEach var="item" items="${list}">
							<tr>
								<td>
								<a href="itemModify.do?item_num=${item.item_num}">${item.item_num}</a> &nbsp;
								<div>
								${item.item_index} &nbsp;
								${item.item_title} &nbsp;
								</div>
								<span class="t-sub-info"><c:if test="${item.item_p_status == '1' }">표시</c:if></span>
								<span class="t-sub-info"><c:if test="${item.item_p_status == '2' }">미표시</c:if></span>
								
								
								<span class="t-sub-info"><c:if test="${item.item_r_status == '1' }">기본</c:if></span>
								<span class="t-sub-info"><c:if test="${item.item_r_status == '2' }">대여</c:if></span>
								<span class="t-sub-info"><c:if test="${item.item_r_status == '3' }"><a href="adminItemReturn.do?item_num=${item.item_num}">반납</a></c:if></span>
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