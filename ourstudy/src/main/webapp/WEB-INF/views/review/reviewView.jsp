<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information.css">
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script src="${pageContext.request.contextPath}/js/review.reply.js"></script>
<!DOCTYPE html>
<body> 
<div class="page-main">
<div class="content-main">
<div class="content-right"> 
		<h3 style="text-align:center"><b>이용후기</b></h3>
		<div class="card d-flex justify-content-center" id="card-view" >
	<ul class="card-head">
		<li>
			<h3><b>${review.r_title}</b></h3>
		</li>
		<li>
			<c:if test="${!empty review.mem_name}"><b>${review.mem_name}</b></c:if> ·  
			<c:if test="${review.r_rate == 1}">
			<span style="color:#ffc400">★</span>  
			</c:if>
			<c:if test="${review.r_rate == 2}">
			<span style="color:#ffc400">★★</span>  
			</c:if>
			<c:if test="${review.r_rate == 3}">
			<span style="color:#ffc400">★★★</span>  
			</c:if>
			<c:if test="${review.r_rate == 4}">
			<span style="color:#ffc400">★★★★</span> 
			</c:if>
			<c:if test="${review.r_rate == 5}">
			<span style="color:#ffc400">★★★★★</span> 
			</c:if>	
		</li>
		<li style="color : #868E96; font-size:10pt;"> 			
			<c:if test="${!empty review.r_mdate}">
			작성일 : ${review.r_date} · 최근 수정일 : ${review.r_mdate}
			</c:if>
			<c:if test="${empty review.r_mdate}">
			작성일 : ${review.r_date}
			</c:if>
			<div style="display:inline-block; float:right;">
			<c:if test="${!empty user && user.mem_num == review.mem_num}">
			<input type="button" value="수정" class="btn btn-secondary btn-sm"
				onclick="location.href='update.do?r_num=${review.r_num}'">
			<input type="button" value="삭제" class="btn btn-secondary btn-sm" id="delete_btn"> 
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('delete.do?r_num=${review.r_num}');
					}
				};
			</script> 
			</c:if> 
			</div>
		</li>
	</ul>
	<hr size="1" width="90%" style="margin: 0px auto;">
	<ul class="card-content"> 	 
	<c:if test="${fn:endsWith(review.r_imgname,'.jpg') || 
	              fn:endsWith(review.r_imgname,'.JPG') ||
				  fn:endsWith(review.r_imgname,'.jpeg') ||
				  fn:endsWith(review.r_imgname,'.JPEG') ||
				  fn:endsWith(review.r_imgname,'.gif') ||
				  fn:endsWith(review.r_imgname,'.GIF') ||
				  fn:endsWith(review.r_imgname,'.png') ||
				  fn:endsWith(review.r_imgname,'.PNG')}">
	<div class="align-center">
		<img src="imageView.do?r_num=${review.r_num}&review_type=2" class="detail-img">
	</div><br>	
	</c:if>	
	<li>
		${review.r_content}
	</li>
	<c:if test="${!empty review.r_imgname}">
		<br><br>
		<li>
			<b>[첨부파일]</b> : <a href="file.do?r_num=${review.r_num}">${review.r_imgname}</a>
		</li>	
	</c:if>	
	</ul>
	
	<!-- 댓글 UI 시작 -->
	<div id="re_div">
		<span class="re-title"><b>댓글</b></span>
		<form>
			<input type="hidden" name="r_num" value="${review.r_num}" id="r_num">
			<textarea rows="3" cols="150" name="revw_content" id="revw_content" class="content"
					  <c:if test="${empty user}">disabled="disabled"</c:if>>
			<c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>    		
			<c:if test="${!empty user}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>
			<div class="align-right" style="padding:0 50px;">
				<input type="submit" value="전송">
			</div>
			</c:if>
		</form>
	</div>
	<!-- 댓글 목록 출력 -->
	<div class="card-content">
		<div id="output"></div>
			<div class="paging-button" style="display:none;">
				<input type="button" class="btn btn-secondary btn-sm" value="댓글 더보기">
			</div>
			<div id="loading" style="display:none;">
				<img src="${pageContext.request.contextPath}/images/loading.gif" width="50" height="50">
			</div>
			<div class="card-foot">
			<div class="align-center"> 
				<input type="button" value="목록" id="list_btn" class="btn btn-secondary btn-sm"
				onclick="location.href='list.do'">
			</div>
		</div>
	</div>
	<!-- 댓글 UI 끝 -->	
		</div>
</div>
</div>
</div>




