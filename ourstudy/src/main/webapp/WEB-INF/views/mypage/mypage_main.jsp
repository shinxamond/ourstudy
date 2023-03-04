<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- 마이페이지 메인 회원정보 시작 -->
<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"></script>
<div id = "mypage_mem_info">
	<div class = "wrap-meminfo">
		<div>
			<div class ="mypage-title">
			<h4 class = "sum-title">주간공부시간</h4>
			</div>
			<hr class = "horizontal-line">
				<canvas id = "line-chart" width = "1040" height = "310"></canvas>
				<script type="text/javascript">
				var mon = ('${time[0]}'/3600 <=  0) ? 0 : '${time[0]}' / 3600;
				var tue = ('${time[1]}'/3600 <=  0) ? 0 : '${time[1]}' / 3600;
				var wed = ('${time[2]}'/3600 <=  0) ? 0 : '${time[2]}' / 3600;
				var thu = ('${time[3]}'/3600 <=  0) ? 0 : '${time[3]}' / 3600;
				var fri = ('${time[4]}'/3600 <=  0) ? 0 : '${time[4]}' / 3600;
				var sat = ('${time[5]}'/3600 <=  0) ? 0 : '${time[5]}' / 3600;
				var sun = ('${time[6]}'/3600 <=  0) ? 0 : '${time[6]}' / 3600;
				new Chart(document.getElementById('line-chart'), {
					type : 'line',
					data : {
						labels : ['${week[0]}', '${week[1]}', '${week[2]}','${week[3]}', '${week[4]}', '${week[5]}','${week[6]}'],
						datasets : [{
							data : [mon, tue, wed, thu, fri, sat, sun],
							label : '내 공부시간',
							borderColor : '#006633',
							backgroundColor: '#006633',
							pointStyle : 'dash',
							fill : true,
							tension : 0.3,
							borderWidth : 3,
						}]},
					options : {
						scales :{
							y :{
								ticks :{
									display : true,
									stepSize : 0.5,
								},
								min : 0,
								suggestedMin : 0
							},
							x : {
								grid: {
									display : false
								}
							}
						}
					}
				});
			</script>
		</div>
		
		
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
				<c:if test="${item.item_r_status==2}">
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