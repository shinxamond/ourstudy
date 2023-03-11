<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> 
<!-- 마이페이지 공부시간 내역 시작 -->
<div class = "mypage_mem_studyTime">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h3>입/퇴실 내역</h3>
		</div>
		<hr class = "horizontal-line">
		<div class = "point-content">
		<c:if test="${count > 0}">
			<div class = 'align-selectbox'>
				<select name="keyfield" class="keyfield">
					<option value = "1"<c:if test="${param.keyfield == 1}">selected</c:if>>날짜순</option>
					<option value = "2" <c:if test="${param.keyfield == 2}">selected</c:if>>공부시간순</option>
				</select>
				<script type="text/javascript">
					$(document).on('change','.keyfield', function(){
 						location.href = "/mypage/studyTimeList.do?keyfield=" + $(this).val();
 					});				
				</script>
			</div>
		</c:if>
				
				<c:if test="${count == 0}">
					<div style = "text-align :center;">입/퇴실 내역이 없습니다.</div>
				</c:if>
				<c:if test="${count > 0}">
				<table class = "point-table  mb-5">
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
				
				<c:if test="${study.total_time / 3600 < 1 or study.total_time % 3600 / 60 < 1}">
				<fmt:parseNumber value = "${study.total_time % 3600 % 60}"  integerOnly="true"/>초
				</c:if>
				
				</td>
				</c:if>
				</tr>
				</c:forEach>
				
				<tr>
					<th>
						<input type = "hidden" value = " ${(member.mem_study / 3600)+(((member.mem_study / 3600)%1>0.5)?(1-((member.mem_study / 3600)%1))%1:-((member.mem_study / 3600)%1))}" id = "study_hour"/>				
						<input type = "hidden" value = " ${(member.mem_study % 3600 / 60)+(((member.mem_study % 3600 / 60)%1>0.5)?(1-((member.mem_study % 3600 / 60)%1))%1:-((member.mem_study % 3600 / 60)%1))}" id = "study_min"/>				
						<input type = "hidden" value = " ${(member.mem_study % 3600 % 60)+(((member.mem_study % 3600 % 60)%1>0.5)?(1-((member.mem_study % 3600 % 60)%1))%1:-((member.mem_study % 3600 % 60)%1))}" id = "study_sec"/>				
						
				</th><th></th><th>
				<script type="text/javascript">
				$(function(){
					var floor_hour = Math.floor($('#study_hour').val());
					var floor_min = Math.floor($('#study_min').val());
					var floor_sec = Math.floor($('#study_sec').val());
					if(typeof floor_hour == "undefined" || floor_hour == null || floor_hour == "" || isNaN(floor_hour)){
						floor_hour = 0;
					}
					if(typeof floor_min == "undefined" || floor_min == null || floor_min == "" || isNaN(floor_min)){
						floor_min = 0;
					}
					if(typeof floor_sec == "undefined" || floor_sec == null || floor_sec == "" || isNaN(floor_sec)){
						floor_sec = 0;
					}
					$('#ts').attr('data-tg-on', floor_hour +'시간'+floor_min +'분'+floor_sec+'초');
					console.log(floor_hour);		
					console.log($('#study_min').val());	
					console.log($('#study_sec').val());	
				});
				</script>
					<input class="tgl tgl-flip total-study" id="cb5"
					type="checkbox" /> <label id = "ts" class="tgl-btn total-study" data-tg-off="총 공부시간" data-tg-on = ""
					 for="cb5"></label>
				</th></tr>
<%-- 				<tr>
				<td></td>
				<td></td>
				<td>
				<fmt:parseNumber value = "${member.mem_study / 3600}"  integerOnly="true"/>시간 
				<fmt:parseNumber value = "${member.mem_study % 3600 / 60}"  integerOnly="true"/>분 
				<fmt:parseNumber value = "${member.mem_study % 3600 % 60}"  integerOnly="true"/>초
				</td>
				</tr> --%>
				</table>		
				<div class = "page-button">
				${page }
				</div>	
				</c:if>

		</div>
		<div style = "text-align : center;">
			<input type="button" style="margin-bottom: 15px;" class="btn" id="home_btn" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	
</div>
<!-- 마이페이지 공부시간 내역 끝 -->