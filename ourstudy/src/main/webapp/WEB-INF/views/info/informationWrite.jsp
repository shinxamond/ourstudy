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
		</ul>
		<div class="align-right">
			<%-- <input type="checkbox" name="info_pin" value="1" id="info_pin"/>상단에 고정하기
			<input type="hidden" name="info_pin" value="0" id="info_pin_hidden"/> 
			   문제점 수정할 때 체크 풀려있음 --%>
			<form:checkbox path="info_pin" value="1" label="상단에 고정하기" />
			<form:hidden path="info_pin" value="0" />		
			<form:button>등록</form:button>
			<input type="button" value="목록" 
			             onclick="location.href='/info/informationList.do'">
		</div>
	</form:form>
</div>