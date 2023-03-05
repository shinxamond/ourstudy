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
	<h2>분실물찾기 등록</h2>
	<form:form action="lostWrite.do" id="lost_write_form"
			modelAttribute="lostVO"  enctype="multipart/form-data">
	<ul>
		<li>
			<h4>분실물 찾기 글쓰기</h4>
		</li>
		<li>
			<label for="type">카테고리</label>
			<form:radiobutton path="lf_type" value="0" id="습득" checked="checked"/>습득
			<form:radiobutton path="lf_type" value="1" id="분실"/>분실
		</li>
		<!-- 비활성화 
		<li>
			<label for="condition">습득품 상태</label>
			
		</li>  -->
		<li>
			<label for="lf_title">제목</label>
			<form:input path="lf_title"/>
			<form:errors path="lf_title" cssClass="error-color"/>
		</li>
		<li>
			<label for="lf_item">분실/습득 물품</label>
			<form:input path="lf_item"/>
			<form:errors path="lf_item" cssClass="error-color"/>
		</li>
		<li>
			<label for="lf_loc">분실/습득 위치</label>
			<form:input path="lf_item"/>
			<form:errors path="lf_item" cssClass="error-color"/>
		</li>
		<li>
			<label for="lf_time">분실/습득 시간</label>
			<input type="date" value="sysdate">
			<input type="time" value="sysdate" min="06:00" max="24:00">
			<form:errors path="lf_time" cssClass="error-color"/>
		</li> 
		<li>
				<label for="lf_content">내용</label>
				<form:textarea path="lf_content"/>
				<form:errors path="lf_content" 
				                  cssClass="error-color"/>
				<script>
				 function MyCustomUploadAdapterPlugin(editor) {
					    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
					        return new UploadAdapter(loader);
					    }
					}
				 
				 ClassicEditor
		            .create( document.querySelector( '#lf_content' ),{
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
	
	</ul>
	<div class="align-right">
			<form:button>등록</form:button>	
			<input type="button" value="목록" 
			            onclick="location.href='/community/lostList.do'">
		</div>
 </form:form>
</div>