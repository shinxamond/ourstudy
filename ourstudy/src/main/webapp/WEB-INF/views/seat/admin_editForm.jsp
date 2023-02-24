<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	/*form호출 버튼 토글*/
</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-3.6.0.min.js">
		$(function(){
//			$('#plus_btn').click(function(){
//				$('#insert_form').show();
//			});
			
			$('#insert_seat').click(function(){
				let choice = confirm('좌석을 추가할까요?');
				if(choice){
					$.ajax({
						url : 'seat/insert.do',
						data:{seatVo:${seatVO}},
						type : 'post',
						dataType: 'json',
						success:function(param){
							if(param.result == 'insertFail'){
								alert("추가 실패");
							}else if(param.result == 'insertSuccess'){
								//html에 append div하거나 추가한 좌석을 표시할 요소를 생성
							}else{
								alert('오류 발생');
							}
						},
						error:function(){
							alert('네트워크 오류');
						}
						
					})
				}
				
			})
		});
</script>
</head>
<body>
	<div>${list[0].seat_name}</div>
	<div>${list[1].seat_name}</div>
	<div>${list[2].seat_name}</div>
	
	<!-- 배치도가 +/저장 버튼 나옴  +누르면 모달창이 나온다. -->
	<button id="plus_btn" class="btn btn-primary" data-bs-toggle="modal"
	data-bs-target="#PlusModal">+</button>
	<button id="save_btn">저장</button>
	
	<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content head">
				<div class="modal-body p-2">
				<form:form action="/seat/insert.do" modelAttribute="seatVO" id="insert_form">
					<form:hidden path="seat_status" value="1"/>
					좌석이름<br>
					<form:input path="seat_name"/><br>
					<form:button id="insert_seat">추가</form:button>
				</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>