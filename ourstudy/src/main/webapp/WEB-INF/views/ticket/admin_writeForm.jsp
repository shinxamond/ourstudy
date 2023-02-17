<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<div class="container">
	<h2>상품등록</h2>
	<div class="container">
		<form:form action="admin_write.do" id="register_form"
			modelAttribute="ticketVO"
			class="container d-flex justify-content-center">
			<form:errors element="div" cssClass="error-color" />
			<div class="col-sm-5 justify-content-center">
				<fieldset class="col mb-3">
					<legend class="col-form-label col-sm-2 pt-0">이용권 종류</legend>
					<div class="form-check form-check-inline"
						style="padding-left: 50px;">
						<input class="form-check-input" type="radio" name="ticket_type"
							id="ticket_type1" value="kind1"> <label
							class="form-check-label" for="inlineRadio1">독서실 이용권</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="ticket_type"
							id="ticket_type2" value="kind2"> <label
							class="form-check-label" for="inlineRadio2">사물함 이용권</label>
					</div>
				</fieldset>
				<div class="row mb-3">
					<label for="ticket_name" class="col-sm-2 col-form-label">이용권명</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="inputEmail3">
					</div>
				</div>
				<div class="row mb-3">
					<label for="ticket_name" class="col-sm-2 col-form-label">설정금액</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="inputEmail3">
					</div>
				</div>
				<fieldset class="row mb-3">
					<legend class="col-form-label col-sm-2 pt-0">Radios</legend>
					<div class="col-sm-10">
						<div class="form-check">
							<input class="form-check-input" type="radio" name="gridRadios"
								id="gridRadios1" value="option1" checked> <label
								class="form-check-label" for="gridRadios1"> First radio
							</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="gridRadios"
								id="gridRadios2" value="option2"> <label
								class="form-check-label" for="gridRadios2"> Second radio
							</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="gridRadios"
								id="gridRadios3" value="option3">
								<label class="form-check-label" for="gridRadios3"> Third
								disabled radio </label>
						</div>
					</div>
				</fieldset>
				<div class="row mb-3">
					<div class="col-sm-10 offset-sm-2">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="gridCheck1">
							<label class="form-check-label" for="gridCheck1"> Example
								checkbox </label>
						</div>
					</div>
				</div>
				<button type="submit" class="btn btn-primary">Sign in</button>
			</div>
		</form:form>
	</div>
</div>