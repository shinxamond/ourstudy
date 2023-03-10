<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information.css">
<!-- 중앙 컨텐츠 시작 -->
<!DOCTYPE html>
<body>
<div class="page-main">
<div class="content-main">
<div class="content-right">
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
	<h3 style="text-align:center"><b>안내사항</b></h3>

	<div class="card d-flex justify-content-center" id="card-view" >
	<ul class="card-head">
		<li>
			<h3><b>${information.info_title}</b></h3>
		</li>
		<li>
			<b>관리자</b> <img src="/images/favicon.ico">
		</li>
		<li style="color : #868E96; font-size:10pt;"> 
			<c:if test="${!empty information.info_modify_date}">
			작성일 : ${information.info_date} · 최근 수정일 : ${information.info_modify_date}
			</c:if>
			<c:if test="${empty information.info_modify_date}">
			작성일 : ${information.info_date}
			</c:if>
		</li>
	</ul> 
	<hr size="1" width="90%" style="margin: 0px auto;">
	<ul class="card-content">
		<li>
			${information.info_content}
			<c:if test="${!empty information.filename}">
			<br><br>
			<b>[첨부파일]</b> : <a href="file.do?info_num=${information.info_num}">${information.filename}</a>
			</c:if>
		</li>
	</ul>
	<hr size="1" width="90%" style="margin: 0px auto;">
	<ul class="card-foot" >
		<div class="align-center">
		<input type="button" value="목록" id="list_btn" class="btn btn-secondary btn-sm"
		           onclick="location.href='informationList.do'">
			<div style="float:right;">
			<c:if test="${!empty user && user.mem_auth == 9}">
			<input type="button" value="수정"  class="btn btn-secondary btn-sm"
				onclick="location.href='infoUpdate.do?info_num=${information.info_num}'">
			<input type="button" value="삭제"  class="btn btn-secondary btn-sm"> 
			</c:if>
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				delete_btn.onclick=function(){
					let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('infoDelete.do?info_num=${information.info_num}');
					}
				};
			</script>
			</div>
		</div>
	</ul>
	</div> <!-- 카드 끝 -->	
</div>
</div>
</div>
</body>