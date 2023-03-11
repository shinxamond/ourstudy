<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<!DOCTYPE html>
<body> 
	<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>분실물 찾기</b></h3>
				<!-- 검색폼 시작 -->
				<form  class="search-form" action="lostList.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<span class="d-flex align-items-center">
							<select class="form-select" id="form-select1" name="keyfield" aria-label="form-select">
								<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
								<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
							</select> 
							<!--                            //검색했을 때 값이 남아있게 하기 위해서 -->
							<!--                            //자기자신에게 값을 보내기 때문에 param 이용 -->
							<input type="text" name="keyword" value="${param.keyword}" placeholder="제목 또는 내용 검색">
							<button type="submit" title="Search"><i class="bi bi-search"></i></button>
						</span>
					</div>
				</div>
				<div class="btn-group align-left" role="group" aria-label="Basic radio toggle button group" style="float:left;">
					<input type="radio" class="btn-check" name="cat" id="btnradio1" autocomplete="off" value=1
							onclick="location.href='lostList.do?cat=1'" 
							<c:if test="${param.cat==1 || param.cat==null}">checked</c:if>>
					<label class="btn btn-outline-secondary btn-sm" for="btnradio1">전체</label>
								
					<input type="radio" class="btn-check" name="cat" id="btnradio2" autocomplete="off" value=2
							onclick="location.href='lostList.do?cat=2'" 
							<c:if test="${param.cat==2}">checked</c:if>>
					<label class="btn btn-outline-secondary btn-sm" for="btnradio2">분실</label>
								
					<input type="radio" class="btn-check" name="cat" id="btnradio3" autocomplete="off" value=3
							onclick="location.href='lostList.do?cat=3'" 
							<c:if test="${param.cat==3}">checked</c:if>>
					<label class="btn btn-outline-secondary btn-sm" for="btnradio3">습득</label>
				</div>
				</form>					
				<!-- 검색폼 끝 -->
				<div class="align-right" style="float:right;">
					<c:if test="${!empty user}">
					<button type="button" class="btn btn-secondary btn-sm"   
							onclick="location.href='lostWrite.do'">글쓰기</button>
					</c:if>
				</div>								
				<!-- table 시작 -->
				<div class="content-margin my-5">
				<c:if test="${count == 0}">
				<table class="table table-group-divider align-center">
					<tr>
						<td>표시할 분실물목록이 없습니다</td>
					</tr>
				</table>
				</c:if>
				<c:if test="${count>0}">
					<table class="table table-hover align-center" id="t1">
						<thead class="table-head">
							<tr>
								<th scope="col" width="15%">카테고리<br></th>
								<th scope="col" width="35%">제목</th>
								<th scope="col" width="20%">작성자</th>
								<th scope="col" width="30%">작성일</th>						
							</tr>							
						</thead>
						<tbody class="table-body table-group-divider">			
							<c:forEach var="lost" items="${lostList}"><!-- var는 자바빈(VO) -->
							<tr>
								<c:if test="${lost.lf_type == 0}">
								<th scope="row">분실</th>
								</c:if>
								<c:if test="${lost.lf_type == 1}">
								<th scope="row">습득</th>
								</c:if>		
								<td class="text-left">
									<c:if test="${lost.lf_type==1}">
										<c:if test="${lost.f_condition==0}"><span style="color:#e32930">[보관중] </span></c:if>
										<c:if test="${lost.f_condition==1}"><span style="color:#097bd9">[수령완료] </span></c:if>
									</c:if>
									<a href="lostDetail.do?lf_num=${lost.lf_num}" class="truncate-text">${lost.lf_title}</a>
								</td>
								<td>${lost.mem_name}</td>
								<td>${lost.lf_date}</td> 								 
							</tr>							
							</c:forEach>					
						</tbody>
					</table>
					
					<table class="table table-hover table-group-divider" id="t2">
						<c:forEach var="lost" items="${lostList}">
						<tr>
							<td>
								<div>
								<c:if test="${lost.lf_type == 0}">
								<b>분실</b> &nbsp;
								</c:if>
								<c:if test="${lost.lf_type == 1}">
								<b>습득</b> &nbsp;
								</c:if>		
								<c:if test="${lost.lf_type==1}">
									<c:if test="${lost.f_condition==0}"><span style="color:#e32930">[보관중] </span></c:if>
									<c:if test="${lost.f_condition==1}"><span style="color:#097bd9">[수령완료] </span></c:if>
								</c:if>
								<a href="lostDetail.do?lf_num=${lost.lf_num}" class="truncate-text">${lost.lf_title}</a>																
								</div>
								<span class="t-sub-info">${lost.mem_name}</span> &nbsp;
								<span class="t-sub-info">${lost.lf_date}</span> &nbsp;
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