<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- <script type="text/javascript">
$(function(){
	$('#item_modify_form').submit(function(){
		if($('#upload').val()==''){ 
			alert('사진을 입력하세요');
			$('#upload').focus();
			return false;
		}
	});
});
</script>
 --><h2>물품 수정</h2>
<form:form action="itemModify.do" id="item_modify_form" modelAttribute="itemVO" enctype="multipart/form-data">
	<form:hidden path="item_num"/>
	<ul>
		<li>
			<label>상품표시여부</label>
			<form:radiobutton path="item_p_status" value="1" checked="checked"/>표시
			<form:radiobutton path="item_p_status" value="2"/>미표시
		</li>
		<li>
			<label for="item_title">물품명</label>
			<form:input path="item_title"/>
			<form:errors path="item_title" cssClass="error-color"/>
		</li>
		<li>
			<label for="item_index">물품명 식별번호</label>
			<form:input path="item_index" type="number"/>
			<form:errors path="item_index" cssClass="error-color"/>
		</li>
		<li>
			<label for="upload">사진</label>
			<input type="file" name="upload" id="upload">
			
			<c:if test="${!empty itemVO.item_imgsrc}">
				<div id="filedel">
				[${itemVO.item_imgsrc}가 등록되어 있습니다.]
				<input type="button" value="파일삭제" id="delete">
				</div>
			 	<script type="text/javascript">
			 	$(function(){
			 		$('#delete').click(function(){
			 			let choice = confirm('삭제하시겠습니까?');
			 			if(choice){
			 				$.ajax({
			 					url:'deleteFile.do',
			 					data:{item_num:${itemVO.item_num}},
			 					type:'post',
			 					dataType:'json',
			 					success:function(param){
			 						if(param.result=="success"){
			 							$('#filedel').hide();
			 						}else{
			 							alert('파일 삭제 오류 발생');
			 						}
			 					},
			 					error:function(){
			 						alert('네트워크 오류 발생');
			 					}
			 				});
			 			}
			 		})
			 	});
			 	</script>
			</c:if>
			
		</li>
		
		<li>
			<label for="item_time">대여 기간(일)</label>
			<form:input path="item_time" type="number"/>
			<form:errors path="item_time" cssClass="error-color"/>
		</li>
	</ul>
	<div class="align-center">
	<form:button>수정</form:button>
	<input type="button" value="삭제" id="delete_btn">
	<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					location.replace('itemDelete.do?item_num=${itemVO.item_num}');
				}
			};
		</script>
	<input type="button" value="목록" onclick="location.href='adminList.do'">
	</div>
</form:form>