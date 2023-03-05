<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!-- 중앙 컨텐츠 시작 -->
<script src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<div class="page-main">
	<h2>안내사항</h2>
	<br>
	<ul class="view-info">
		<li>
			<h4>${information.info_title}</h4>
		</li>
		<li>
			<c:if test="${!empty information.info_modify_date}">
			최근 수정일 : ${information.info_modify_date}
			</c:if>
			<c:if test="${empty information.info_modify_date}">
			작성일 : ${information.info_date}
			</c:if>
		</li>
	</ul>
	<c:if test="${!empty information.filename}">
	<ul>
		<li>
			첨부파일 : <a href="file.do?info_num=${information.info_num}">${information.filename}</a>
		</li>	
	</ul>
	</c:if>
	<hr size="1" width="100%">
	<p>
		${information.info_content}
	</p>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_auth == 9}">
		<input type="button" value="수정" 
			onclick="location.href='infoUpdate.do?info_num=${information.info_num}'">
		<input type="button" value="삭제" id="delete_btn"> 
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
		
		<input type="button" value="목록"
		           onclick="location.href='informationList.do'">
	</div>
</div>