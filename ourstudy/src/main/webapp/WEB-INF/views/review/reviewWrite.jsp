<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information.css">   
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<h3 style="text-align:center"><b>이용후기 쓰기</b></h3>
	<br>
	<div class="card d-flex justify-content-center" id="card-view" >
	<form:form action="write.do" id="register_form" 
	                   modelAttribute="reviewVO"
	                   enctype="multipart/form-data">
		<ul>
			<li>
				<label for="title"><b>제목</b></label>
				<form:input path="r_title"/>
				<form:errors path="r_title" cssClass="error-color"/>
			</li>
			<li>
				<label for="rate"><b>별점</b></label>
				<form:radiobutton path="r_rate" value="5" id="status5" checked="checked"/>★★★★★
				<form:radiobutton path="r_rate" value="4" id="status4"/>★★★★
				<form:radiobutton path="r_rate" value="3" id="status3"/>★★★
				<form:radiobutton path="r_rate" value="2" id="status2"/>★★
				<form:radiobutton path="r_rate" value="1" id="status1"/>★
			</li>						
			<li>
				<label for="content"><b>내용</b></label>
				<br>
				<form:textarea path="r_content"/>
				<form:errors path="r_content" cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#r_content' ),{
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
				<label for="upload"><b>사진 업로드</b></label>
				<input type="file" name="upload" id="upload" accept="image/*">
				<form:errors element="div" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button id="list_btn" class="btn btn-secondary btn-sm">등록</form:button>
			<input type="button" value="목록"  class="btn btn-secondary btn-sm" onclick="location.href='list.do'">
		</div>	                   
	</form:form>
	</div>
</div>
</div>
</div>