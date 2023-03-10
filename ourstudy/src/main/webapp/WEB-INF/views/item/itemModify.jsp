<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- 로그인 된 경우에만 글쓰기버튼 활성화 --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<!DOCTYPE html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">

				<div class="it1" style="height:70vh">
				<br><h3 style="text-align:center"><b>물품수정</b></h3><br><br>
				<!-- table 시작 -->
				
					<form:form action="itemModify.do" class="item_modify_form" modelAttribute="itemVO" enctype="multipart/form-data">
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
							<form:input path="item_index" type="number" size="15"/>
							<form:errors path="item_index" cssClass="error-color"/>
						</li>
						<li>
							<label for="upload">사진</label>
							<input type="file" name="upload" id="upload">
							<form:errors path="item_ufile" cssClass="error-color"/>
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
					<form:button class="itemButton">수정</form:button>
					<input type="button" class="itemButton" value="삭제" id="delete_btn">
					<script type="text/javascript">
					$("#delete_btn").click(function () {
					    Swal.fire({
					      title: '정말로 삭제 하시겠습니까?',
					      text: "다시 되돌릴 수 없습니다. 신중하세요.",
					      icon: 'warning',
					      showCancelButton: true,
					      confirmButtonColor: '#3085d6',
					      cancelButtonColor: '#d33',
					      confirmButtonText: '삭제',
					      cancelButtonText: '취소',
					      reverseButtons: false, // 버튼 순서 거꾸로
					      
					    }).then((result) => {
					      if (result.isConfirmed) {
					    	  location.replace('itemDelete.do?item_num=${itemVO.item_num}');
					      }
					    })
					  });
						</script>
					<input type="button" class="itemButton" value="목록" onclick="location.href='adminList.do'">
					</div>
				</form:form>
				</div>
			<div class="it2">
				<h3 style="text-align:center"><b>물품수정</b></h3>
				<form:form action="itemModify.do"  class="item_modify_form2" modelAttribute="itemVO" enctype="multipart/form-data">
					<form:hidden path="item_num"/>
					
							<label>상품표시여부</label><br>
							<form:radiobutton path="item_p_status" value="1" checked="checked"/>표시
							<form:radiobutton path="item_p_status" value="2"/>미표시<br>
						
							<label for="item_title">물품명</label><br>
							<form:input path="item_title"/><br>
							<form:errors path="item_title" cssClass="error-color"/><br>
						
							<label for="item_index">물품명 식별번호</label><br>
							<form:input path="item_index" type="number" size="15"/><br>
							<form:errors path="item_index" cssClass="error-color"/><br>
						
							<label for="upload">사진</label><br>
							<input type="file" name="upload" id="upload"><br>
							<form:errors path="item_ufile" cssClass="error-color"/><br>
							<c:if test="${!empty itemVO.item_imgsrc}">
								<div id="filedel">
								[${itemVO.item_imgsrc}가 등록되어 있습니다.]
								<input type="button" value="파일삭제" id="delete2">
								</div>
							 	<script type="text/javascript">
							 	$(function(){
							 		$('#delete2').click(function(){
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
							
						
							<label for="item_time">대여 기간(일)</label><br>
							<form:input path="item_time" type="number"/><br>
							<form:errors path="item_time" cssClass="error-color"/>
					<br>
					<div class="align-center">
					<form:button class="itemButton">수정</form:button>
					<input type="button" class="itemButton" value="삭제" id="delete_btn2"> 
					<script type="text/javascript">
					$("#delete_btn2").click(function () {
					    Swal.fire({
					      title: '정말로 삭제 하시겠습니까?',
					      text: "다시 되돌릴 수 없습니다. 신중하세요.",
					      icon: 'warning',
					      showCancelButton: true,
					      confirmButtonColor: '#3085d6',
					      cancelButtonColor: '#d33',
					      confirmButtonText: '삭제',
					      cancelButtonText: '취소',
					      reverseButtons: false, // 버튼 순서 거꾸로
					      
					    }).then((result) => {
					      if (result.isConfirmed) {
					    	  location.replace('itemDelete.do?item_num=${itemVO.item_num}');
					      }
					    })
					  });
						</script>
					<input type="button" value="목록" class="itemButton" onclick="location.href='adminList.do'">
					</div>
				</form:form>
			</div>