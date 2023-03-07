<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/js/lf.reply.js"></script>
<div class="page-main">
	<h2>분실물 찾기</h2>
		<ul class="view-info">
		<li>
			<h4>${lost.lf_title}</h4>
		</li>
		<li>
			작성자 : ${lost.mem_name} |
			<c:if test="${!empty lost.lf_modify_date}">
			최근 수정일 : ${lost.lf_modify_date}
			</c:if>
			<c:if test="${empty lost.lf_modify_date}">
			작성일 : ${lost.lf_date}
			</c:if>
		</li>
	</ul>
	<hr size="1" width="100%">
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
	<hr size="1" width="100%">
	<p>
		${lost.lf_content}
	</p>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == lost.mem_num}">
		<input type="button" value="수정" 
			onclick="location.href='lostUpdate.do?lf_num=${lost.lf_num}'">
		<input type="button" value="삭제" id="delete_btn"> 
		</c:if>
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('lostDelete.do?lf_num=${lost.lf_num}');
				}
			};
		</script>
		
		<input type="button" value="목록"
		           onclick="location.href='lostList.do'">
	</div>
	<!-- 댓글 -->
	<div id="reply_div">
		<span class="re-title">댓글</span>
			<form id="re_form">
			<input type="hidden" name="lf_num" value="${lost.lf_num}" id="lf_num">
			<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content" 
			  		<c:if test="${empty user}">disabled="disabled"</c:if>>
			<c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>    	
			<c:if test="${!empty user}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>
			<div id="re_second">
				<input type="submit" value="전송">
			</div>
			</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
	</div>
	<div id="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
	</div>
</div>