<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- 마이페이지 메인 회원정보 시작 -->
<div id = "mypage_mem_info">
	<div class = "wrap-meminfo">
		<div class ="mypage-title">
			<h4 class = "sum-title">최근대여물품</h4>
		</div>
		<hr class = "horizontal-line">
		<div>
				<c:if test="${count == 0}">
					<div style = "text-align : center; margin-top : 35px;">최근에 대여한 물품이 없습니다.</div>
				</c:if>
				
				<c:if test="${count > 0}">
				<table id = "main_item_table">
				<tr>
					<th>물품명</th>
					<th>대여기간</th>
					<th>대여상태</th>
					<th>반납처리</th>
				</tr>
				<c:forEach var = "item" items = "${list }">
				<tr class = "main-item-tr">
					<td>
						<img src="${pageContext.request.contextPath}/item/imageView.do?item_num=${item.item_num}" width="50" height="50" class="my-photo"><span>  &nbsp;<a href = "${pageContext.request.contextPath}/item/userRental.do?item_index=${item.item_index}">${item.item_title}</a></span>
					</td>
					<td>${item.item_start}~${item.item_utime}</td>
					
					<td id = "${item.item_num}">
					<script type="text/javascript">
						$(function() {
							var date = new Date();//"2023-03-01"
							var year = date.getFullYear();
							var month = ("0" + (1 + date.getMonth())).slice(-2);
							var day = ("0" + date.getDate()).slice(-2);
							var result = year + month +  day;//현재시간
							var utime = '${item.item_utime}';
							var id = utime.split("-");
							var result2 = id[0] + id[1] + id[2];//반납시간
							result*=1;//형변환 s -> i
							result2*=1;
							if (result > result2 && '${item.item_r_status}' == 2) {
								$('#${item.item_num}').css('color','red');
								$('#${item.item_num}').css('font-weight','bold');
								$('#${item.item_num}').text('대여기간초과');
							}
						});
					</script>
					<c:if test="${item.item_r_status==2}"> <!-- 대여중이니까 당연히 버튼이 뜨지 멍청아 -->
					<span style = "font-weight : bold;">대여중</span>
					<td><input type="button" value="반납" onclick="location.href='${pageContext.request.contextPath}/item/userItemReturn.do?item_num=${item.item_num}'"></td>
					</c:if>
					
					<c:if test="${item.item_r_status==3}">
					반납
					<td></td>
					</c:if>
					</td>
				</tr>
				</c:forEach>
				</table>
				</c:if>

			
		</div>
	</div>
	
</div>
<!-- 마이페이지 메인 회원정보 끝 -->