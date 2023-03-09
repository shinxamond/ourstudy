<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>일별 판매 정산판</b></h3><br>
				<table class="table table-hover align-center" id="t1">
					<thead class="table-head">
					<tr>
						<th scope="col" width="33">이용권 판매 금액</th>
						<th scope="col" width="33%">사물함 판매 금액</th>
						<th scope="col" width="34%">총 합계 금액</th>
					</tr>
					</thead>
					<tbody class="table-body table-group-divider">
					<tr>
						<td scope="row"><span style="color:red">${ticketsales}</span>원</td>
						<td><span style="color:red">${lockersales}</span>원</td>
						<td><span style="color:red">${totalsales}</span>원</td>
					</tr>
					</tbody>
				</table><br>				
				<table class="table table-hover table-group-divider" id="t2">
					<tr>
						<th scope="col" width="33">이용권 판매</th>
						<th scope="col" width="33%">사물함 판매</th>
						<th scope="col" width="34%">총합계 판매</th>
					</tr>
					<tr>
						<td><span class="t-sub-info" style="color:red">${ticketsales}</span>원</td>
						<td><span class="t-sub-info" style="color:red">${lockersales}</span>원</td>
						<td><span class="t-sub-info" style="color:red">${totalsales}</span>원</td>
					</tr>
				</table>
									
				<h3 style="text-align:center"><b>판매기록목록</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar2">
						<form class="search-form d-flex align-items-center" action="admin_saleslist.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<select class="form-select" id="form-select2" name="keyfield" aria-label="form-select"
									onchange="location.href='admin_saleslist.do?keyfield='+this.value">
								<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>최근판매순</option>
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
						<td>표시할 목록이 없습니다</td>
					</tr>
				</table>
				</c:if>		
				<c:if test="${count>0}">
					<table class="table table-hover align-center" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="10%">회원번호<br></th>
								<th scope="col" width="15%">이름</th>
								<th scope="col" width="15%">판매상품</th>
								<th scope="col" width="20%">구매방법</th>
								<th scope="col" width="20%">구매금액</th>
								<th scope="col" width="20%">판매시각</th>					
							</tr>							
						</thead>
						<tbody class="table-body table-group-divider">
							<c:forEach var="sales" items="${adminSalesList}"><!-- var는 자바빈(VO) -->
							<tr>
								<th scope="row">${sales.mem_num}</th>
								<td>${sales.mem_name}</td>
								<td>${sales.ticket_name}</td>
								<c:if test="${sales.pay_plan == 0}">
									<td>현금</td>
								</c:if>
								<c:if test="${sales.pay_plan == 1}">
									<td>카카오페이</td>
								</c:if>
								<c:if test="${sales.pay_plan == 2}">
									<td>카드</td>
								</c:if>
								<td>${sales.pay_price}원</td>					
								<td>${sales.pay_date}</td>								
							</tr>
							</c:forEach>											
						</tbody>
					</table>
					<table class="table table-hover table-group-divider" id="t2">
						<c:forEach var="sales" items="${adminSalesList}">
						<tr>
							<td>
								<div>
								${sales.mem_name} (${sales.mem_num}) &nbsp;
								</div>							
								<span class="t-sub-info">${sales.ticket_name} </span>&nbsp;<br>
								<span class="t-sub-info">
								<c:if test="${sales.pay_plan == 0}">
								현금 
								</c:if>
								<c:if test="${sales.pay_plan == 1}">
								카카오페이 
								</c:if>
								<c:if test="${sales.pay_plan == 2}">
								카드 
								</c:if>								
								</span>&nbsp;
								<span class="t-sub-info">${sales.pay_price}원</span>&nbsp;
								<br>
								<span class="t-sub-info">${sales.pay_date}원</span>&nbsp;
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