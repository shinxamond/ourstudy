<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information2.css">    
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<!-- 중앙 컨텐츠 시작 -->
<!DOCTYPE html>
<body>
<div class="page-main">
<div class="content-main">
<div class="content-right">
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
	<h3 style="text-align:center"><b>안내사항 글쓰기</b></h3>
	<br>
	<div class="card d-flex justify-content-center" id="card-view" >
	<form:form action="infoWrite.do" id="info_write_form"
			modelAttribute="informationVO"  enctype="multipart/form-data">
		
		<ul>
			<li>
				<label for="info_title" ><b>제목</b></label>
				<form:input path="info_title" />
				<form:errors path="info_title" 
				                  cssClass="error-color"/>
			</li>
			<li>
				<label for="info_content"><b>내용</b></label>
				<br><br>
				<form:textarea path="info_content" />
				<form:errors path="info_content" 
				                  cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#info_content' ),{
		            	extraPlugins: [MyCustomUploadAdapterPlugin]
		            })
		            .then( editor => {
						window.editor = editor;
					} )
		            .catch( error => {
		                console.error( error );
		            } );
			    </script>
			</li>
			<li>
				<label for="upload"><b>파일 첨부</b></label>
				<input type="file" name="upload" id="upload"  >
				<form:errors element="div" cssClass="error-color"/>
			</li> 
		</ul>
		<div class="align-right" style="margin:0 20px;">
			<%-- <input type="checkbox" name="info_pin" value="1" id="info_pin"/>상단에 고정하기
			<input type="hidden" name="info_pin" value="0" id="info_pin_hidden"/> 
			   문제점 수정할 때 체크 풀려있음 --%>
			<form:checkbox path="info_pin" value="1" style="text-align:center;" label="상단에 고정하기" />
			<form:hidden path="info_pin" value="0" />		
			<form:button onclick="" id="list_btn" class="btn btn-secondary btn-sm">등록</form:button>			
			<input type="button" value="목록"  class="btn btn-secondary btn-sm"
			             onclick="location.href='/info/informationList.do'">
		</div>
	</form:form>
	</div>
</div>
</div>
</div>