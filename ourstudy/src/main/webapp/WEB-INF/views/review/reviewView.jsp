<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/board.reply.js"></script>
<div class="page-main">
	<h3>제목 : ${review.r_title}</h3>
	<ul class="detail-info">
		<li>
			<c:if test="${!empty review.mem_name}">${review.mem_name}</c:if> |  
			<c:if test="${review.r_rate == 1}">
			<span style="color:#ffc400">★</span> |  
			</c:if>
			<c:if test="${review.r_rate == 2}">
			<span style="color:#ffc400">★★</span> |  
			</c:if>
			<c:if test="${review.r_rate == 3}">
			<span style="color:#ffc400">★★★</span> |  
			</c:if>
			<c:if test="${review.r_rate == 4}">
			<span style="color:#ffc400">★★★★</span> | 
			</c:if>
			<c:if test="${review.r_rate == 5}">
			<span style="color:#ffc400">★★★★★</span> | 
			</c:if>				
			<c:if test="${!empty review.r_mdate}">
			최근 수정일 : ${review.r_mdate}
			</c:if>
			<c:if test="${empty review.r_mdate}">
			작성일 : ${review.r_date}
			</c:if>
		</li>
	</ul>
<%-- 	 
	<c:if test="${!empty review.imgname}">
	<ul>
		<li>
			첨부파일 : <a href="file.do?board_num=${board.board_num}">${board.filename}</a>
		</li>	
	</ul>
	</c:if>
 --%>	
	<hr size="1" width="100%">
<%-- 	
	<c:if test="${fn:endsWith(board.filename,'.jpg') || 
	              fn:endsWith(board.filename,'.JPG') ||
				  fn:endsWith(board.filename,'.jpeg') ||
				  fn:endsWith(board.filename,'.JPEG') ||
				  fn:endsWith(board.filename,'.gif') ||
				  fn:endsWith(board.filename,'.GIF') ||
				  fn:endsWith(board.filename,'.png') ||
				  fn:endsWith(board.filename,'.PNG')}">
	<div class="align-center">
		<img src="imageView.do?board_num=${board.board_num}&board_type=2" class="detail-img">
	</div>	
	</c:if>
 --%>	
	<p>
		${review.r_content}
	</p>
	<hr size="1" width="100%">
	
<%-- 	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == board.mem_num}">
		<input type="button" value="수정" 
		  onclick="location.href='update.do?board_num=${board.board_num}'">
		<input type="button" value="삭제" id="delete_btn"> 
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('delete.do?board_num=${board.board_num}');
				}
			};
		</script> 
		</c:if> 
		<input type="button" value="목록"
		           onclick="location.href='list.do'">
	</div>
	<!-- 댓글 UI 시작 -->
	<div id="reply_div">
		<span class="re-title">댓글 달기</span>
		<form id="re_form">
			<input type="hidden" name="board_num"
			    value="${board.board_num}" id="board_num">
			<textarea rows="3" cols="50" 
			  name="re_content" id="re_content"
			  class="rep-content"
			  <c:if test="${empty user}">disabled="disabled"</c:if>
			  ><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>    
		
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
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" 
		                                height="50">
	</div>
	<!-- 댓글 UI 끝 --> --%>
	
	
</div>
<!-- 중앙 컨텐츠 끝 -->




