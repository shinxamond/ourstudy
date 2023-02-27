<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>안내사항 수정</h2>
		<form:form action="infoUpdate.do" id="information_update_form"
			modelAttribute="informationVO"  enctype="multipart/form-data"/>
		<ul>
			<li>
				<label for="info_title">제목</label>
				<form:input path="info_title"/>
				<form:input path="info_title" cssClass="error-color"/>
			</li>	
			<li>
				<label for="info_content">내용</label>
				<form:input path="info_content"/>
				<form:input path="info_content" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>수정</form:button>
		</div>	    
</div>