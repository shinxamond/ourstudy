<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/information2.css">   
<script src="${pageContext.request.contextPath}/js/f_condition.js"></script>
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
	<h3 style="text-align:center"><b>분실물 찾기 글쓰기</b></h3>
	<br>
	<div class="card d-flex justify-content-center" id="card-view" >
	<form:form action="lostWrite.do" id="lost_write_form"
			modelAttribute="lostVO"  enctype="multipart/form-data">
	<form:hidden path="lf_num"/>
		<form:errors element="div" cssClass="error-color"/>
	<ul>
		<li>
			<label for="type"><b>카테고리</b></label>
			<form:radiobutton path="lf_type" value="0" id="분실" checked="checked"/>분실
			<form:radiobutton path="lf_type" value="1" id="습득" />습득 
			<script type="text/javascript">
			$(document).ready(function(){
				  $("input:radio[name=lf_type]").change(function(){
					//습득
				    if($("input[name=lf_type]:checked").val() == "1"){
				    	$('#f_condition').show();
				    	$('#lost1').hide(); $('#get1').show(); 
				    	$('#lost2').hide(); $('#get2').show();
				    	$('#lost3').hide(); $('#get3').show();
				    }
				    //분실
				    else if($("input[name=lf_type]:checked").val() == "0"){
				    	$('#f_condition').hide();
				    	$('#get1').hide(); $('#lost1').show();
				    	$('#get2').hide(); $('#lost2').show(); 
				    	$('#get3').hide(); $('#lost3').show(); 
				    }
				  });
				  //날짜 현재시간 이상으로 선택 못하게 max 설정하기
				  var today = new Date();
				  var dd = today.getDate(); //오늘날짜
				  var mm = today.getMonth() + 1; // 달
				  var yyyy = today.getFullYear(); //년도
				  var hh = today.getHours(); //시간
				  var m = today.getMinutes(); //분

				  if (dd < 10)
				  {
				      dd = '0' + dd; //날짜 10보다 작으면 앞에 0 붙이기
				  } 
				  if (mm < 10)
				  {
				      mm = '0' + mm; //달 10보다 작으면 앞에 0 붙이기
				  }
				  if (hh < 10)
				  {
				      hh = '0' + hh; //시간 10보다 작으면 앞에 0 붙이기
				  }
				  if (m < 10)
				  {
				      m = '0' + m; //분 10보다 작으면 앞에 0 붙이기
				  }
				  time_max = yyyy + '-' + mm + '-' + dd + 'T' + hh + ':' + m;
				  $('#lf_time').attr('max', time_max);
			});
			</script>
		</li>
		<li id="f_condition" style="display:none">
			<label for="condition"><b>습득품 상태</b></label>
			<%-- <form:radiobutton path="f_condition" value="0" id="보관중" />보관중
			<form:radiobutton path="f_condition" value="1" id="수령완료" />수령완료--%>
			<input type="radio" name="f_condition" value="0" id="보관중" checked="checked"/>보관중
			<input type="radio" name="f_condition" value="1" id="수령완료"/>수령완료
		</li>
		<li>
			<label for="lf_title"><b>제목</b></label>
			<form:input path="lf_title"/>
			<form:errors path="lf_title" cssClass="error-color"/>
		</li>
		<li>
			<label for="lf_item"><b><span id="lost1">분실</span><span id="get1" style="display:none">습득</span> 물품</b></label>
			<form:input path="lf_item"/>
			<form:errors path="lf_item" cssClass="error-color"/>
		</li>
		<li>
			<label for="lf_loc"><b><span id="lost2">분실</span><span id="get2" style="display:none">습득</span> 위치</b></label>
			<form:input path="lf_loc" />
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
			<label for="lf_time"><b><span id="lost3">분실</span><span id="get3" style="display:none">습득</span> 날짜</b></label>
			<!-- <input type="datetime-local" id="lf_time" name="lf_time"  max=sysdate> -->
			<input type="datetime-local" id="lf_time" name="lf_time" value = "${param.lf_time}">
			<form:errors path="lf_time" cssClass="error-color"/>
			<%--  <form:input path="lf_time"/>
			<form:errors path="lf_time" cssClass="error-color"/>--%>
			
		</li>  
		<li>
				<label for="lf_content"><b>내용</b></label>
				<br><br>
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
	<div class="align-right" style="margin:0 20px;">
			<form:button id="list_btn" class="btn btn-secondary btn-sm">등록</form:button>	
			<input type="button" value="목록" class="btn btn-secondary btn-sm"
			            onclick="location.href='/community/lostList.do'">
		</div>
 </form:form>
 </div>
</div>
</div>
</div>