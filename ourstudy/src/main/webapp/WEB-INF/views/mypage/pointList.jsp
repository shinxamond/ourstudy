<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> 
<!-- 마이페이지 포인트 내역 시작 -->
<div class = "mypage_mem_pointList">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h3>포인트 내역</h3>
		</div>
		<hr class = "horizontal-line">
		<div class = "point-content">
		<c:if test="${count > 0}">
			<div class = 'align-selectbox'>
				<select name="keyfield" id="keyfield">
					<option value = "1"<c:if test="${param.keyfield == 1}">selected</c:if>>전체내역</option>
					<option value = "2" <c:if test="${param.keyfield == 2}">selected</c:if>>적립내역</option>
					<option value = "3" <c:if test="${param.keyfield == 3}">selected</c:if>>사용내역</option>
				</select>
				<script type="text/javascript">
					$('#keyfield').change(function(){
						location.href = "/mypage/pointList.do?keyfield=" + $(this).val();
					});
				</script>
			</div>
		</c:if>		
				<c:if test="${count == 0}">
				<div style = "text-align :center;">포인트 적립 내역이 없습니다.</div>
				</c:if>
				<c:if test="${count > 0 }">
				<table class = "point-table">
					<tr>
						<th>날짜</th>
						<th>결제내역</th>
						<th>결제방식</th>
						<th>결제금액</th>
						<th>포인트</th>
					</tr>
					<c:forEach var = "point" items = "${list}">
					<tr>
						<td>${point.pay_date}</td>
						<td>${point.pay_content}</td>
						<td>
						<c:if test="${point.pay_plan == 1 && point.point_point > 0}">
						<span>카카오페이</span>
						</c:if>
						<c:if test="${point.pay_plan == 1 && point.point_point < 0}">
						<span>카카오페이 + 포인트</span>
						</c:if>
						<c:if test="${point.pay_plan == 2 && point.point_point > 0}">
						<span>카드결제</span>
						</c:if>
						<c:if test="${point.pay_plan == 2 && point.point_point < 0}">
						<span>카드결제 + 포인트</span>
						</c:if>
						</td>
						<td><fmt:formatNumber value = "${point.pay_price}"/>원</td>
						<td>
						<c:if test="${point.point_point > 0}">
							<span style = "color : rgba(0,102,51, 1.0); font-weight : bold;">+<fmt:formatNumber value = "${point.point_point}"/></span>
						</c:if>
						<c:if test="${point.point_point < 0}">
							<span style = "color : rgba(200,0,0, 1.0); font-weight : bold;"><fmt:formatNumber value = "${point.point_point}"/></span>
						</c:if>	
						</td>
					</tr>
					
					</c:forEach>
				</table>
				<div class = "page-button">
				${page}
				</div>	
				</c:if>
		</div>
		<div style = "text-align : center;">
			<input type="button" class="btn" id="home_btn" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	
</div>
<!-- 마이페이지 포인트 내역 끝 -->