<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>분실물찾기 등록</h2>
	<form:form action="lostWrite.do" id="lost_write_form"
			modelAttribute="lostVO"  enctype="multipart/form-data"/>
	<ul>
		<li>
		
		</li>
		<li>
			<label for="lf_title">제목</label>
			<form:input path="lf_title"/>
			<form:input path="lf_title" cssClass="error-color"/>
		</li>
		<li>
			<label for="lf_content">내용</label>
			<form:input path="lf_content"/>
			<form:input path="lf_content" cssClass="error-color"/>
		</li>
	
	</ul>
	<div class="align-right">
			<form:button>등록</form:button>	
	</div>
	
</div>