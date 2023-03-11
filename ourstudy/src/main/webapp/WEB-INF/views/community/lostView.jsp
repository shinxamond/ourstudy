<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- 중앙 컨텐츠 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information.css">
<script src="${pageContext.request.contextPath}/js/lf.reply.js"></script>
<!DOCTYPE html>
<body> 
<div class="page-main">
<div class="content-main">
<div class="content-right"> 
		<h3 style="text-align:center"><b>분실물찾기</b></h3><br>
		<div class="card d-flex justify-content-center" id="card-view" >
		<ul class="card-head">
		
			<li>
				<c:if test="${lost.lf_type==1}">
					<c:if test="${lost.f_condition==0}"><span style="color:#e32930">[보관중] </span></c:if>
					<c:if test="${lost.f_condition==1}"><span style="color:#097bd9">[수령완료] </span></c:if>
				</c:if>
				<h3><b>${lost.lf_title}</b></h3>
			</li>
			<li>
				<c:if test="${lost.mem_auth == 9}">
				<b>${lost.mem_name}</b> <img src="/images/favicon.ico">
				</c:if>
				<c:if test="${lost.mem_auth != 9}">
				<b>${lost.mem_name}</b> 
				</c:if>
			 
			</li>
			<li style="color : #868E96; font-size:10pt;"> 
			<c:if test="${!empty lost.lf_modify_date}">
			작성일 : ${lost.lf_date} · 최근 수정일 : ${lost.lf_modify_date}
			</c:if>
			<c:if test="${empty lost.lf_modify_date}">
			작성일 : ${lost.lf_date}
			</c:if>
				<div style="display:inline-block; float:right;">
				<c:if test="${!empty user && user.mem_num == lost.mem_num}">
					<input type="button" value="수정"
							class="btn btn-secondary btn-sm"
								onclick="location.href='lostUpdate.do?lf_num=${lost.lf_num}'">
									<input type="button" value="삭제"
										class="btn btn-outline-secondary btn-sm" id="delete_btn">
									</c:if>
									<script type="text/javascript">
										let delete_btn = document
												.getElementById('delete_btn');
										delete_btn.onclick = function() {
											let choice = confirm('삭제하시겠습니까?');
											if (choice) {
												location
														.replace('lostDelete.do?lf_num=${lost.lf_num}');
											}
										};
									</script>
								
						</div>
				</li>		
		</ul>
	<hr size="1" width="90%" style="margin: 0px auto;">
	<ul class="card-content">
		<li style="padding: 0px 30px;">
			<c:if test="${lost.lf_type == 0}">
			<p>분실 물품 : ${lost.lf_item}</p>
			<p>분실 위치 : ${lost.lf_loc}</p>
			<p>분실 시간 : ${fn:replace(lost.lf_time,'T',' ')}</p>
			</c:if>
			<c:if test="${lost.lf_type == 1}">
			<p>습득 물품 : ${lost.lf_item}</p>
			<p>습득 위치 : ${lost.lf_loc}</p>
			<p>습득 시간 : ${fn:replace(lost.lf_time,'T',' ')}</p>
			</c:if>	
		</li>
		<br><br><br>
		<li>
			${lost.lf_content}
		</li>
	</ul>
	
	<hr size="1" width="90%" style="margin: 10px auto;">
	
	<!-- 댓글 UI 시작-->
	<!-- 댓글 목록 출력 시작 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="댓글 더보기" class="btn btn-outline-secondary mt2"  style="margin-right:395px;">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
	</div>
	<!-- 댓글 목록 출력 끝 -->
	
	<div id="reply_div">
		<span class="re-title" style="font-size: 15pt">댓글</span>&nbsp;
		<span id="re_first">
			<span class="letter-count">300/300</span>
		</span>
		<form id="re_form">
			<input type="hidden" name="lf_num" value="${lost.lf_num}" id="lf_num">
			<div class="inner-text">
			<textarea class="content form-control rep-content inner-text"
				name="re_content" id="re_content"
				<c:if test="${empty user}">disabled="disabled"</c:if>><c:if
					test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>    	
			<c:if test="${!empty user}">
				<button type="submit" class="btn" id="inner-submit">
					<i class="fas fa-solid fa-paper-plane"></i>
				</button>
			</c:if>
			</div>
		</form>
	</div>
	
	<div class="card-foot">
		<div class="align-center"> 
			<input type="button" value="목록" id="list_btn" class="btn btn-secondary mb-5"
			           onclick="location.href='lostList.do'">
		 </div> 
	</div>
	<!-- 댓글 UI 끝 -->
	</div>
</div>
</div>
<!-- 컨텐츠 메인 끝 -->
</div>
<!-- 페이지 메인 끝 -->
</body>