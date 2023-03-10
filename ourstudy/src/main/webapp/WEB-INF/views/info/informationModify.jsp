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
	<h3 style="text-align:center"><b>안내사항 수정</b></h3>
	<br>
	<div class="card d-flex justify-content-center" id="card-view" >
		<form:form action="infoUpdate.do" id="info_update_form"
			modelAttribute="informationVO"  enctype="multipart/form-data">
		<form:hidden path="info_num"/>
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<label for="info_title"><b>제목</b></label>
				<form:input path="info_title" />
				<form:errors path="info_title" cssClass="error-color"/>
			</li>	
			<li>
				<label for="info_content"><b>내용</b></label>
				<form:textarea path="info_content"/>
				<form:errors path="info_content" cssClass="error-color"/>
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
				<input type="file" name="upload" id="upload">
				<c:if test="${!empty informationVO.filename}">
				<div id="file_detail" style="padding:5px 0 0 130px;">
					<input type="button" value="파일삭제"
					                 class="btn btn-secondary btn-sm"    id="file_del">
					[${informationVO.filename}] 파일이 등록되어 있습니다.
				</div>
				<script type="text/javascript">
					$(function(){
						$('#file_del').click(function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								$.ajax({
									url:'deleteFile.do',
									data:{info_num:${informationVO.info_num}},
									type:'post',
									dataType:'json',
									success:function(param){
										if(param.result == 'logout'){
											alert('로그인 후 사용하세요');
										}else if(param.result == 'success'){
											$('#file_detail').hide();
										}else{
											alert('파일 삭제 오류 발생');
										}
									},
									error:function(){
										alert('네트워크 오류 발생');
									}
								});
							}
						});
					});
				</script>
				</c:if>
			</li>
		</ul>
		<div class="align-right">
			<form:checkbox path="info_pin" value="1" label="상단에 고정하기" />
			<form:hidden path="info_pin" value="0" />		
			<form:button id="list_btn" class="btn btn-secondary btn-sm">수정</form:button>
			<button type="button" class="btn btn-secondary btn-sm" onclick="location.href='informationList.do'">목록</button>
			${page}
		</div>	    
	</form:form>
	</div>
</div>
</div>
</div>