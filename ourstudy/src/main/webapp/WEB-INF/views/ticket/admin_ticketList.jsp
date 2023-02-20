<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 중앙 컨텐츠 시작 -->
<script type="text/javascript">
	
</script>
<div class="container">
	<h3>이용권 목록</h3>
	<button type="button" class="btn btn-primary"
		onclick="location.href='admin_write.do'">이용권 등록하기</button>
	<div class="container d-flex justify-content-center">
		<c:if test="${count == 0}">
			<table class="table table-group-divider align-center">
				<tr>
					<td>표시할 이용권이 없습니다</td>
				</tr>
			</table>
		</c:if>
		<c:if test="${count > 0}">
			<c:forEach var="ticket" items="${list}">
				<div class="card" style="width: 40rem;">
					<div class="card-header">독서실 이용권(시간제)</div>
					<div class="card-body">
						${ticket.ticket_name}
						<div style="float: right;">${ticket.ticket_price}</div>
						<div style="margin-top: 5px;">
							<button type="button" class="btn btn-primary"
								style="float: right;">구매하기</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>
<!-- 중앙 컨텐츠 끝 -->