<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> 
<!-- 마이페이지 공부시간 내역 시작 -->
<div id = "mypage_mem_info">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h1>입/퇴실 내역</h1>
		</div>
		<hr class = "horizontal-line">
		<div class = "point-content">
			<div class = 'align-selectbox'>
				<select name="keyfield" id="keyfield">
					<option value = "1"<c:if test="${param.keyfield == 1}">selected</c:if>>날짜순</option>
					<option value = "2" <c:if test="${param.keyfield == 2}">selected</c:if>>공부시간순</option>
				</select>
				<script type="text/javascript">
					$('#keyfield').change(function(){
						location.href = "/mypage/studyTimeList.do?keyfield=" + $(this).val();
					});
				</script>
			</div>

				
				<c:if test="${count == 0}">
					입/퇴실 내역이 없습니다.
				</c:if>
				<c:if test="${count > 0}">
				<table class = "point-table">
				<tr>
					<th>입실시간</th>
					<th>퇴실시간</th>
					<th>합계 공부시간</th>
				</tr>
				<c:forEach var = "study" items = "${list}">
				<tr>
				<td>${study.in_time}</td>
				
				<c:if test = "${empty study.out_time}">
				<td colspan = "2">입실중</td>
				</c:if>
				
				<c:if test="${!empty study.out_time}">
				<td>${study.out_time}</td>
				</c:if>
				
				<c:if test="${study.total_time != 0}">
				<td>
				<c:if test="${study.total_time / 3600 >= 1}">
				<fmt:parseNumber value = "${study.total_time / 3600}"  integerOnly="true"/>시간 				
				</c:if>
				
				<c:if test="${study.total_time % 3600 / 60 >= 1}">
				<fmt:parseNumber value = "${study.total_time % 3600 / 60}"  integerOnly="true"/>분
				</c:if>
				
				<c:if test="${study.total_time / 3600 < 1 and study.total_time % 3600 / 60 < 1}">
				<fmt:parseNumber value = "${study.total_time % 3600 % 60}"  integerOnly="true"/>초
				</c:if>
				</td>
				</c:if>
				</tr>
				</c:forEach>
				<tr><th></th><th></th><th>총 공부시간</th></tr>
				<tr>
				<td></td>
				<td></td>
				<td>
				<fmt:parseNumber value = "${member.mem_study / 3600}"  integerOnly="true"/>시간 
				<fmt:parseNumber value = "${member.mem_study % 3600 / 60}"  integerOnly="true"/>분 
				<fmt:parseNumber value = "${member.mem_study % 3600 % 60}"  integerOnly="true"/>초
				</td>
				</tr>
				</table>		
				<div class = "page-button">
				${page }
				</div>	
				</c:if>

		</div>
		<div style = "text-align : center;">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	
</div>
<!-- 마이페이지 공부시간 내역 끝 -->