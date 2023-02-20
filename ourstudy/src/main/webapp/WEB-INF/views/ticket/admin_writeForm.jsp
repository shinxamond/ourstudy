<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="container">
	<h4>이용권 등록</h4>
	<div class="container">
		<form:form action="admin_write.do" id="ticket_regi_form"
			modelAttribute="ticketVO"
			class="container d-flex justify-content-xxl-center">
			<form:errors element="div" cssClass="error-color" />
			<div class="col-md-5">
				<fieldset class="col mb-3">
					<legend class="col-form-label col-sm-2 pt-1.5"
						style="margin-right: 10px; text-align: center;">이용권 종류</legend>
					<div class="btn-group" role="group">
						<input type="radio" class="btn-check" name="ticket_kind"
							   id="ticket_kind1" autocomplete="off">
						<label class="btn btn-outline-primary" for="ticket_kind1">독서실 이용권</label>
						<input type="radio" class="btn-check" name="ticket_kind"
							   id="ticket_kind2" autocomplete="off">
						<label class="btn btn-outline-primary" for="ticket_kind2">사물함 이용권</label>
					</div>
					<!-- <input type="radio" class="btn-check" name="options-outlined"
						id="ticket_kind1" autocomplete="off"> <label
						class="btn btn-outline-primary" for="ticket_kind1">독서실 이용권</label>
					<input type="radio" class="btn-check" name="options-outlined"
						id="ticket_kind2" autocomplete="off"> <label
						class="btn btn-outline-primary" for="ticket_kind2">사물함 이용권</label> -->
					
					<!-- <div class="form-check form-check-inline"
						style="padding-left: 50px;">
						<input class="form-check-input" type="radio" name="ticket_type"
							id="ticket_type1" value="kind1"> <label
							class="form-check-label" for="inlineRadio1">독서실 이용권</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="ticket_type"
							id="ticket_type2" value="kind2"> <label
							class="form-check-label" for="inlineRadio2">사물함 이용권</label>
					</div> -->
				</fieldset>
				<div class="row mb-3">
					<label for="ticket_name" class="col-sm-2 col-form-label">이용권명</label>
					<div class="col-sm-10">
						<form:input path="ticket_name" class="form-control" id="ticket_name"
							style="margin-left: 5px;"/>	
						<form:errors path="ticket_name" cssClass="error-color" style="margin-left: 5px;"/>
					</div>
				</div>
				<div class="row mb-3">
					<label for="ticket_price" class="col-sm-2 col-form-label">설정금액</label>
					<div class="col-sm-10">
						<form:input path="ticket_price" class="form-control" id="ticket_price"
							style="margin-left: 5px;"/>
					</div>
				</div>
				<fieldset class="row mb-3">
					<legend class="col-form-label col-sm-2 pt-0">이용권 타입</legend>
					<div class="col-sm-10">
						<div style="margin-left: 5px;">
							<div class="form-check form-check-inline">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type1"/>
								<label class="form-check-label" for="ticket_type1"> 2시간 </label>
							</div>
							<div class="form-check form-check-inline" style="margin-left:50px;">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type7"/>
								<label class="form-check-label" for="ticket_type7"> 1주 </label>
							</div>

							<div class="form-check">
								<div class="form-check-inline">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type2"/>
									<label class="form-check-label" for="ticket_type2"> 4시간 </label>
								</div>
								<div class="form-check form-check-inline" style="margin-left:50px;">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type8"/>
									<label class="form-check-label" for="ticket_type8"> 2주 </label>
								</div>
							</div>
							<div class="form-check">
								<div class="form-check-inline">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type3"/>
									<label class="form-check-label" for="ticket_type3"> 8시간 </label>
								</div>
								<div class="form-check form-check-inline" style="margin-left:50px;">
									<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
										id="ticket_type9"/>
									<label class="form-check-label" for="ticket_type9"> 4주 </label>
								</div>
							</div>
							<div class="form-check">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type4"/>
								<label class="form-check-label" for="ticket_type4"> 12시간 </label>
							</div>
							<div class="form-check">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type5"/>
								<label class="form-check-label" for="ticket_type5"> 50시간 </label>
							</div>
							<div class="form-check">
								<form:radiobutton path="ticket_type" class="form-check-input" name="ticket_type"
									id="ticket_type6"/>
								<label class="form-check-label" for="ticket_type6"> 100시간 </label>
							</div>
						</div>
					</div>
				</fieldset>
				<button type="submit" class="btn btn-primary" style="float: right;">
					이용권 등록</button>
			</div>
		</form:form>
	</div>
</div>