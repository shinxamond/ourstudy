<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information2.css">    
<style>
.ck-editor__editable_inline{
	min-height:250px;
}
</style>
<!DOCTYPE html>
<body>
<!-- 중앙 컨텐츠 시작 -->
<div class="page-main">
<div class="content-main">
<div class="content-right">
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/js/uploadAdapter.js"></script>
	<h3 style="text-align:center"><b>이용후기 수정</b></h3>
	<br>
	<div class="card d-flex justify-content-center" id="card-view" >
	<form:form action="update.do" id="update_form" modelAttribute="reviewVO" enctype="multipart/form-data">
	    <form:hidden path="r_num"/>               
		<ul>
			<li>
				<label for="title"><b>제목</b></label>
				<form:input path="r_title"/>
				<form:errors path="r_title" cssClass="error-color"/>
			</li>
			<li>
				<label for="rate"><b>별점</b></label>
				<form:radiobutton path="r_rate" value="5" id="status5" style="text-align:center;"/><span style="vertical-align:2px;">★★★★★</span>
				<form:radiobutton path="r_rate" value="4" id="status4"/><span style="vertical-align:2px;">★★★★</span>
				<form:radiobutton path="r_rate" value="3" id="status3"/><span style="vertical-align:2px;">★★★</span>
				<form:radiobutton path="r_rate" value="2" id="status2"/><span style="vertical-align:2px;">★★</span>
				<form:radiobutton path="r_rate" value="1" id="status1"/><span style="vertical-align:2px;">★</span>
			</li>
			<li>
				<label for="content"><b>내용</b></label>
				<br><br>
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
				<c:if test="${!empty reviewVO.r_imgname}">
				<div id="file_detail">
					<label for="file_del"><b>사진 삭제</b></label>
					<input type="button" value="파일 삭제" id="file_del">
					[]${reviewVO.r_imgname}]이 등록되어 있습니다.
				</div>
				<script type="text/javascript">
					$(function(){
						$('#file_del').click(function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								$.ajax({
									url:'deleteFile.do',
									data:{r_num:${reviewVO.r_num}},
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
		<div class="align-center">
			<form:button id="list_btn" class="btn btn-secondary btn-sm">등록</form:button>
			<input type="button" value="목록" class="btn btn-secondary btn-sm" onclick="location.href='detail.do?r_num=${reviewVO.r_num}'">
		</div>	                   
	</form:form>
	</div>
</div>
</div>
</div>