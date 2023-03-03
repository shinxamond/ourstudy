<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 중앙 컨텐츠 시작 -->
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>안내사항 글 쓰기</h2>
	<form:form action="infoWrite.do" id="info_write_form"
			modelAttribute="informationVO"  enctype="multipart/form-data">
		
		<ul>
			<li>
				<label for="info_title">제목</label>
				<form:input path="info_title"/>
				<form:errors path="info_title" 
				                  cssClass="error-color"/>
			
			</li>
			<li>
				<label for="info_content">내용</label>
				<form:textarea path="info_content"/>
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
				<label for="upload">파일 첨부</label>
				<input type="file" name="upload" id="upload">
			</li>
			<!-- <li>
				<label for="info_pin">상단고정</label>
				<form:checkbox path="testVar" value="001" label="A" />     
				<form:errors path="info_pin" cssClass="error-color"/>               
			</li> -->
		</ul>
		<div class="align-right">
			<form:button>등록</form:button>
			<input type="button" value="목록" 
			             onclick="location.href='/info/informationList.do'">
		</div>
	</form:form>
</div>