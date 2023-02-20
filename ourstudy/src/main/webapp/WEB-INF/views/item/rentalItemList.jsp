<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/item.css">
<div class="page-main">
	<h1 class="align-center">대여 목록</h1>
	<c:if test="${count == 0}">
		<div class="result-display">대여한 물품이 없습니다</div>
	</c:if>
	<c:if test="${count > 0}">
		<div id="userItemList">
			<c:forEach var="item" items="${list}">
				<div id="userItemList-area">
					<img src="imageView.do?item_num=${item.item_num}" width="250"
						height="250" class="my-photo"> <br>
					<h4>${item.item_title}</h4>
					<br> <span id="rental_text">기간 : ${item.item_utime}</span><br>
					<script type="text/javascript">
						$(function() {
							var date = new Date();//"2023-05-06"
							var year = date.getFullYear();
							var month = ("0" + (1 + date.getMonth())).slice(-2);
							var day = ("0" + date.getDate()).slice(-2);
							var result = year + month +  day;//현재시간
							var utime = '${item.item_utime}';
							var id = utime.split("-");
							var result2 = id[0] + id[1] + id[2];//반납시간
							result*=1;//형변환 s -> i
							result2*=1;
							if (result > result2) {
								$('#rtext').css('display','');
							}
						});
					</script>
					<c:if test="${item.item_r_status==2}">
						<span id="rental_text">대여 상태 : 대여중</span>
						<br>
						<input type="button" value="반납"
							onclick="location.href='userItemReturn.do?item_num=${item.item_num}'">
					</c:if>
					<c:if test="${item.item_r_status==3}">
						<span id="rental_text">대여 상태 : 반납</span>
					</c:if>
					<h4 id="rtext" style="display:none; color:red">반납시간을 초과했습니다</h4>
				</div>
			</c:forEach>
			<div id="clear"></div>
		</div>
	</c:if>
</div>