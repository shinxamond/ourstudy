<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>   
<!-- 중앙 컨텐츠 시작 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	/*
	RedirectAttributes 객체를 이용해서 리다이렉트한 후 데이터를
	표시하기 위해 자바스크립트로 View에서 메시지 처리를 함.
	이럴 때 다른 페이지로 이동한 후 브라우저 back button를
	누르고 다시 돌아오면 메시지가 사라지지 않고 그대로 다시 노출됨.
	이런 현상을 방지하기 위해 값이 남아 있어도 hash 값이 달라지게
	함으로서 메시지가 다시 호출되지 않도록 처리
	*/
	let result = '${result}';
	if(!location.hash && result == 'success'){
		alert('글쓰기 완료!!');
		history.replaceState('','','#rs');
	}	
</script>
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>이용후기</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<form class="search-form d-flex align-items-center" action="list.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<select class="form-select" id="form-select1" name="keyfield" aria-label="form-select"
									onchange="location.href='list.do?keyfield='+this.value">
								<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>최근작성일순</option>
								<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>가나다순(이름)</option>
							</select> 
							<!--                            //검색했을 때 값이 남아있게 하기 위해서 -->
							<!--                            //자기자신에게 값을 보내기 때문에 param 이용 -->
							<input type="text" name="keyword" value="${param.keyword}" placeholder="제목 또는 작성자 검색">
							<button type="submit" title="Search"><i class="bi bi-search"></i></button>
						</form>
					</div>
				</div>
				<!-- 검색폼 끝 -->
				<div class="align-right">
					<c:if test="${!empty user}">
					<button type="button" class="btn btn-secondary btn-sm"   
							onclick="location.href='write.do'">글쓰기</button>
					</c:if>
				</div>								
				<!-- table 시작 -->
				<div class="content-margin">
				<c:if test="${count == 0}">
				<table class="table table-group-divider align-center">
					<tr>
						<td>표시할 이용후기가 없습니다</td>
					</tr>
				</table>
				</c:if>
				<c:if test="${count>0}">
					<table class="table table-hover align-center" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="10%">번호<br></th>
								<th scope="col" width="30%">제목</th>
								<th scope="col" width="20%">작성자</th>								
								<th scope="col" width="20%">별점</th>
								<th scope="col" width="20%">등록일</th>
								
							</tr>							
						</thead>
						<tbody class="table-body table-group-divider">
							<c:forEach var="review" items="${list}">
							<tr>
								<th scope="row">${review.r_num}</th>
								<td><span class="truncate-text">
								<a href="detail.do?r_num=${review.r_num}">${review.r_title}</a>
								</span></td>
								<td>${review.mem_name}</td>
								<c:if test="${review.r_rate == 1}">
								<td><span style="color:#ffc400">★</span></td>
								</c:if>
								<c:if test="${review.r_rate == 2}">
								<td><span style="color:#ffc400">★★</span></td>
								</c:if>
								<c:if test="${review.r_rate == 3}">
								<td><span style="color:#ffc400">★★★</span></td>
								</c:if>
								<c:if test="${review.r_rate == 4}">
								<td><span style="color:#ffc400">★★★★</span></td>
								</c:if>
								<c:if test="${review.r_rate == 5}">
								<td><span style="color:#ffc400">★★★★★</span></td>
								</c:if>			
								<td>${review.r_date}</td> 
							</tr>							
							</c:forEach>						
						</tbody>
					</table>
					
					<table class="table table-hover table-group-divider" id="t2">
						<c:forEach var="review" items="${list}">
						<tr>
							<td>
								<div class="truncate-text">
								<a href="detail.do?r_num=${review.r_num}">${review.r_title}</a>
								</div><br>
								<span class="t-sub-info">${review.mem_name}</span> &nbsp;
								<span class="t-sub-info" style="color:#ffc400">
								<c:if test="${review.r_rate == 1}">
								★
								</c:if>
								<c:if test="${review.r_rate == 2}">
								★★
								</c:if>
								<c:if test="${review.r_rate == 3}">
								★★★
								</c:if>
								<c:if test="${review.r_rate == 4}">
								★★★★
								</c:if>
								<c:if test="${review.r_rate == 5}">
								★★★★★
								</c:if>									
								</span> &nbsp;
								<span class="t-sub-info">${review.r_date}</span>
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
