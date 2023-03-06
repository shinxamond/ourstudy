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
	<form:hidden path="lf_num"/>
		<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li>
			<h4>분실물 찾기 글쓰기</h4>
		</li>
		<li>
			<label for="type">카테고리</label>
			<form:radiobutton path="lf_type" value="0" id="분실"  checked="checked"/>분실
			<form:radiobutton path="lf_type" value="1" id="습득" />습득 

		</li>
		<%-- <li>
			<label for="condition">습득품 상태</label>
			<form:radiobutton path="f_condition" value="0" id="보관중" />보관중
			<form:radiobutton path="f_condition" value="1" id="수령완료" />수령완료
			<input type="radio" name="f_condition" value="0" id="보관중" />보관중
			<input type="radio" name="f_condition" value="1" id="수령완료"/>수령완료
			
		</li> --%>
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
		<%-- 	<label for="lf_time">분실/습득 시간</label>
			<input type="date"  value="sysdate">			
			<input type="time" value="sysdate">   
			
			<form>
				 <label for="lf_time">분실/습득 날짜</label>
				 <input type="date" path="lf_time" id="lf_time" />
			</form> --%>
		<%-- 	<form>  
			    <label for="lf_time">분실/습득 날짜
			     <input type="datetime-local" name="lf_time"> 
			    </label>
			</form>  
			<form:errors path="lf_time" cssClass="error-color"/>  --%>
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
			<form:button>등록</form:button>	
			<input type="button" value="목록" 
			            onclick="location.href='/community/lostList.do'">
		</div>
 </form:form>
</div>