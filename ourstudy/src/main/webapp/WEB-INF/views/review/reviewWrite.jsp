<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 중앙 컨텐츠 시작 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>글쓰기</h2>
	<form:form action="write.do" id="register_form" 
	                   modelAttribute="reviewVO"
	                   enctype="multipart/form-data">
		<ul>
			<li>
				<label for="title">제목</label>
				<form:input path="r_title"/>
				<form:errors path="r_title" cssClass="error-color"/>
			</li>
			<li>
				<label for="rate">별점</label>
				<form:radiobutton path="r_rate" value="5" id="status1" checked="checked"/>★★★★★
				<form:radiobutton path="r_rate" value="4" id="status2"/>★★★★
				<form:radiobutton path="r_rate" value="3" id="status3"/>★★★
				<form:radiobutton path="r_rate" value="2" id="status3"/>★★
				<form:radiobutton path="r_rate" value="1" id="status3"/>★
			</li>						
			<li>
				<label for="content">내용</label>
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
				<label for="upload">사진 업로드</label>
				<input type="file" name="upload" id="upload" accept="image/*">
				<form:errors element="div" cssClass="error-color"/>
			</li>
		</ul>
		<div class="align-center">
			<form:button>전송</form:button>
			<input type="button" value="목록" onclick="location.href='list.do'">
		</div>	                   
	</form:form>
</div>
<!-- 중앙 컨텐츠 끝 -->