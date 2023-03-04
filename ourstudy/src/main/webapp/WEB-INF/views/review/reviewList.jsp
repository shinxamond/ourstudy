<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
<style>
.truncate-text {
    max-width: 270px; /** 현재 한글 기준 10글자 정도로 설정됨 */
    display:inline-block;
    vertical-align: middle;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
</style>
<div class="page-main">
	<h2>이용후기 목록</h2>
	<form action="list.do" id="search_form" method="get">
		<ul class="search" style="width:400px;">
			<li>
				<select name="keyfield" id="keyfield" onchange="location.href='list.do?keyfield='+this.value">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>최근작성일순</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>가나다순(이름)</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" placeholder="제목 또는 작성자 검색" style="width:160px;">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</li>
		</ul>
	</form>
	
	<c:if test="${!empty user}">
	<div class="align-right">
		<input type="button" value="글쓰기" 
		    onclick="location.href='write.do'">
	</div><br>
	</c:if>

	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>	
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>번호</th>
			<th width="400">제목</th>
			<th>작성자</th>
			<th>별점</th>
			<th>등록일</th>
		</tr>
		<c:forEach var="review" items="${list}">
		<tr>
			<td>${review.r_num}</td>
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
	</table><br>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중앙 컨텐츠 끝 -->



