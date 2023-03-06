<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!-- 중앙 컨텐츠 시작 -->


<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
<div class="page-main">
	<h2>분실물찾기 수정</h2>
	<form:form action="lostUpdate.do" id="lost_update_form"
			modelAttribute="lostVO"  enctype="multipart/form-data">
	<form:hidden path="lf_num"/>
		<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li>
			<label for="type">카테고리</label>
			<c:if test="${lostVO.lf_type == 0}">
			분실
			</c:if>
			<c:if test="${lostVO.lf_type == 1}">
			습득
			
			</c:if>
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
			<form:input path="lf_loc"/>
			<form:errors path="lf_loc" cssClass="error-color"/>
		</li>
		<li>
			<label for="lf_time">분실/습득 날짜</label>
			<form:input path="lf_time"/>
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
			<form:button>수정</form:button>	
			<input type="button" value="목록" 
			            onclick="location.href='/community/lostList.do'">
	</div>
	
	</form:form>
	
</div>