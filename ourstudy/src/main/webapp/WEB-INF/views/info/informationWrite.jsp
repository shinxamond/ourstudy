<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
	<h2>안내사항 글 쓰기</h2>
	<form:form action="infoWrite.do" id="information_write_form"
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
			<!-- <li>
				<label for="info_pin">상단고정</label>
				라디오버튼
			</li> -->
		</ul>
		<div class="align-right">
			<form:button>전송</form:button>
			
		</div>
</div>