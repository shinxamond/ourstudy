<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 이용권 수정 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_form.css">
<div class="container" id="main_content">
	<div>
		<form:form action="admin_ticketModify.do" id="ticket_modi_form"
			modelAttribute="ticketVO"
			class="container d-flex justify-content-center">
			<form:hidden path="ticket_num"/>
			<form:errors element="div" cssClass="error-color" />
			<div class="card col-md-5">
			<div style="margin-bottom: 15px;">
				<fieldset class="col mb-1">
					<legend class="col-form-label col-sm-3 pt-1.5"
						style="margin-left:-25px; text-align: center;">이용권 종류</legend>
					<div class="btn-group" role="group" style="margin-left: 37px;">
						<form:radiobutton path="ticket_kind" class="btn-check" name="ticket_kind"
							   id="ticket_kind1" autocomplete="off" value="1"/>
						<label class="btn btn-outline-danger" id="ticket_kind1" for="ticket_kind1">독서실 이용권</label>
						<form:radiobutton path="ticket_kind" class="btn-check" name="ticket_kind"
							   id="ticket_kind2" autocomplete="off" value="2"/>
						<label class="btn btn-outline-danger" id="ticket_kind2" for="ticket_kind2">사물함 이용권</label>
					</div>
				</fieldset>
				<form:errors path="ticket_kind" cssClass="error-color" style="margin-left: 150px;"/>
				</div>
				<div class="row mb-3">
					<label for="ticket_name" class="col-sm-3 col-form-label">이용권명</label>
					<div class="col-sm-9">
						<form:input path="ticket_name" class="form-control" id="ticket_name"
							style="margin-left: 5px;"/>	
						<form:errors path="ticket_name" cssClass="error-color"/>
					</div>
				</div>
				<div class="row mb-3">
					<label for="ticket_price" class="col-sm-3 col-form-label">설정금액</label>
					<div class="col-sm-9">
						<form:input path="ticket_price" class="form-control" id="ticket_price"
							style="margin-left: 5px;"/>
						<form:errors path="ticket_price" cssClass="error-color" style="margin-left: 5px;"/>
					</div>
				</div>
				<fieldset class="row mb-3">
					<legend class="col-form-label col-sm-3 pt-0">이용권 타입</legend>
					<div class="col-sm-9">
						<div style="margin-left: 5px;">
							<div class="form-check form-check-inline">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type1" value="1"/>
								<label class="form-check-label" for="ticket_type1"> 2시간 </label>
							</div>
							<div class="form-check form-check-inline" style="margin-left:50px;">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type7" value="7"/>
								<label class="form-check-label" for="ticket_type7"> 1주 </label>
							</div>

							<div class="form-check">
								<div class="form-check-inline">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type2" value="2"/>
									<label class="form-check-label" for="ticket_type2"> 4시간 </label>
								</div>
								<div class="form-check form-check-inline" style="margin-left:50px;">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type8" value="8"/>
									<label class="form-check-label" for="ticket_type8"> 2주 </label>
								</div>
							</div>
							<div class="form-check">
								<div class="form-check-inline">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type3" value="3"/>
									<label class="form-check-label" for="ticket_type3"> 8시간 </label>
								</div>
								<div class="form-check form-check-inline" style="margin-left:50px;">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type9" value="9"/>
									<label class="form-check-label" for="ticket_type9"> 4주 </label>
								</div>
							</div>
							<div class="form-check">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type4" value="4"/>
								<label class="form-check-label" for="ticket_type4"> 12시간 </label>
							</div>
							<div class="form-check">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type5" value="5"/>
								<label class="form-check-label" for="ticket_type5"> 50시간 </label>
							</div>
							<div class="form-check">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type6" value="6"/>
								<label class="form-check-label" for="ticket_type6"> 100시간 </label>
							</div>
						</div>
					</div>
				</fieldset>
				<div class="d-flex justify-content-end">
				<button type="submit" class="btn" id="modify_btn">수정</button>
				<button type="button" class="btn" id="list_btn" onclick="location.href='admin_ticketList.do'">목록</button>
			</div>
			</div>
		</form:form>
	</div>
</div>
<!-- 이용권 수정 끝 -->