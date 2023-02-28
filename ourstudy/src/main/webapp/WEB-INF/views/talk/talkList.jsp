<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/message.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/talk.css">
<script type="text/javascript">

			var reload;
			reload = setInterval(function(){ location.reload(); }, 5000);
			function start(){
				//alert('시작');
				 reload =   setInterval(function(){ location.reload(); }, 5000);
			};
			function end(){
				//alert('끝');
				 clearInterval(reload);
			};

	</script>
<div class="page-main" id="pageList">
	<h2>채팅목록</h2>
	<form action="talkList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" onclick="location.href='talkList.do'">
			</li>
		</ul>
	</form>
	<div class="align-right">
		<input type="button" value="채팅방 생성" onclick="location.href='talkRoomWrite.do'">
	</div>
	<div class="align-right">
		<!-- <input type="button" value="새로고침 시작" onclick="start();" id="start" style="background-color:#B4FBFF">
		<input type="button" value="새로고침 종료" onclick="end();" id="end"> -->
	</div>
	
	<c:if test="${empty list}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	
	<c:if test="${!empty list}">
	<table class="striped-table">
		<c:forEach var="talk" items="${list}">
		
		<tr id="${talk.talkroom_num}">
			<td style="text-align:left">
				<%-- <a href="talkDetail.do?talkroom_num=${talk.talkroom_num}"> --%>
				<a href="#" data-toggle="modal" data-target="#${talk.talkroom_num}" id="10${talk.talkroom_num}"  data-id="${talk.talkroom_num}">
					<span>${talk.talkroom_name}</span>
				</a>
					<br>
					<span>${fn:substring(talk.talkVO.message,0,45)}</span><!-- fn : 함수 사용 -->
			</td>
			<td style="text-align:right">
				<c:if test="${!empty talk.talkVO.chat_date}">
					${talk.talkVO.chat_date}<br>
					<c:if test="${talk.room_cnt!=0}">
					<span id="talk_inform">${talk.room_cnt}</span>
					</c:if>
				</c:if>
				<c:if test="${empty talk.talkVO.chat_date}">${talk.talkroom_date}</c:if>
			</td>	
		</tr>
		
		<script type="text/javascript">
		//중복 제거 
		var isSubmitted = false;  
		$(document).on('click','#10${talk.talkroom_num}',function(){//목록 클릭
			end();

			function alarm_connect(){
				//alert('소켓연결');
				message_socket = new WebSocket("ws://localhost:8001/message-ws.do");
				message_socket.onopen = function(ent){//연결
					if(${talk.talkroom_num}){
						message_socket.send("msg:");
					}
					console.log("채팅페이지 접속");
				};
				//서버로부터 메시지를 받으면 호출되는 함수 지정 
				message_socket.onmessage=function(evt){
					let data = evt.data;
					if(${talk.talkroom_num} && data.substring(0,4) == 'msg:'){
						selectMsg${talk.talkroom_num}();
					}
				};
				message_socket.onclose=function(evt){
					//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
					console.log('채팅 종료');
				}
			}
			alarm_connect();
			
			$(document).on('click','.close',function(){
				message_socket.close();
			}); 
			
			
			function selectMsg${talk.talkroom_num}(){//메시지 불러오기
				$.ajax({
					url:'../talk/talkDetailAjax.do',
					type:'post',
					data:{talkroom_num:${talk.talkroom_num}},
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){	
							alert('로그인 후 사용하세요!');
							message_socket.close();
						}else if(param.result == 'success'){
							$('#chatting_message${talk.talkroom_num}').empty();
							
							//채팅 날짜 표시
							let chat_date = '';
							
							$(param.list).each(function(index,item){
								let output = '';
								
								//날짜 추출 한번만 나온단
								if(chat_date != item.chat_date.split(' ')[0]){//저장된 날짜가 없으면
									chat_date = item.chat_date.split(' ')[0];//날짜 저장
									output += '<div class="date-position"><span>'+chat_date+'</span></div>';
								}
								
								if(item.message.indexOf('@{exit}@')>=0){
									//탈퇴 메시지 처리
									output += '<div class="exit-message">';
									output += item.message.substring(0,item.message.indexOf('@{exit}@'));
									output += '</div>';
								}else{
									//일반 메시지 처리
									if(item.mem_num == $('#mem_num').val()){
										//본인 메시지
										output += '<div class="form-position">';
										output += '<div>';
									}else{
										//타인 메시지
										output += '<div class="to-position">';
										output += '<div class="space-photo">'
										output += '<img src="../mypage/viewProfile.do?mem_num='+item.mem_num+'" width="40" height="40" class="my-photo">';
										output += '</div><div class="space-message">';
										output += '<div class="yname">' + item.mem_id + '</div>';
									}
									//output += '<div>'
									output += '<span class="item">' + item.message.replace(/\r\n/g,'<br>').replace(/\r/,'<br>').replace(/\n/,'<br>') + '</span>';
									
										if(item.mem_num == $('#mem_num').val()){
											output += '<div class="rdate">'+ item.read_count + '<br>' + (item.chat_date.split(' ')[1]).split(':')[0] + ':' + (item.chat_date.split(' ')[1]).split(':')[1] + '</div>';
										}else{
											output += '<div class="ldate">'+ item.read_count + '<br>' + (item.chat_date.split(' ')[1]).split(':')[0] + ':' + (item.chat_date.split(' ')[1]).split(':')[1] + '</div>';
										}
										//output += '</div>';
									output += '</div><div class="space-clear"></div>';
									output == '</div>'
								}
								
								//문서 객체에 추가
								$('#chatting_message${talk.talkroom_num}').append(output);
								//스크롤을 하단에 위치시킴
								$('#chatting_message${talk.talkroom_num}').scrollTop($('#chatting_message${talk.talkroom_num}')[0].scrollHeight);
								
							});
												
						}else{
							alert('채팅 메시지 읽기 오류 발생');
							message_socket.close();
						}
					},
					error:function(){
						alert('메시지 읽기 네트워크 오류 발생');
						message_socket.close();
					}
				});
			}
			
			var data = $(this).data('id');
			
			//alert(data);
			$.ajax({
				url:'../talk/talkDetailA.do',
				type:'post',
				data:{talkroom_num:data},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요!');
						//message_socket.close();
					}else if(param.result == 'success'){
						$('#roomname${talk.talkroom_num}').text('');
						let rname = '';
						var roomnum = '';
						$(param.talkRoomVO).each(function(index,item){
								rname += item.talkroom_name;
								roomnum += item.talkroom_num;
							});
						rname += ' 채팅방';
						//alert(roomnum);
						//alert(rname);
						$('#talkroom_num').val(roomnum);
						
						$('#roomname${talk.talkroom_num}').append(rname);
						$('#name${talk.talkroom_num}').text('');
						let output2 = '';
						var count = 0;
						$(param.detailList).each(function(index,item){
							if(index>0)output2+=',';
							  output2 += item.mem_id;
							  count++;
							});
							output2 += ' '+count + '명';
						$('#name${talk.talkroom_num}').append(output2);
						$('#myModal').show();
						
						
											
					}else{
						alert('채팅 메시지 읽기 오류 발생');
						//message_socket.close();
					}
				},
				error:function(){
					alert('메시지 읽기 네트워크 오류 발생');
					//message_socket.close();
				}
			});
			
			//============채팅 등록================//
			$('#detail_form${talk.talkroom_num}').submit(function(event){
				//중복제거
				 function oneTimeSubmit(){  
				    if(isSubmitted == false){
				      isSubmitted = true;
				    }else{
				     alert("데이터를 전송중입니다. 확인메세지가 나올 때 까지 기다리세요");
				    }
				   }
				
				//기본 이벤트 제거
				event.preventDefault();
				if($('#message${talk.talkroom_num}').val().trim()==''){
					alert('메시지를 입력하세요');
					$('#message${talk.talkroom_num}').val('').focus();
					return false;
				}
				
				//글자수 체크
				if($('#message${talk.talkroom_num}').val().length>1333){
					alert('메시지는 1333자까지만 입력 가능합니다.');
					return false;
				}
				
				let form_data = $(this).serialize();
				
				//서버와 통신
				$.ajax({
					url:'../talk/writeTalk.do',
					type:'post',
					data:form_data,
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인해야 작성할 수 있습니다');
							message_socket.close();
						}else if(param.result == 'success'){
							//폼 초기화
							$('#message${talk.talkroom_num}').val('').focus();
							//메시지가 저장되었다고 소켓에 신호를 보냄
							message_socket.send('msg:');
							//---------임시 처리 시작---------//
							//selectMsg();
							//---------임시 처리 끝---------//
						}else{
							alert('메시지 등록 오류');
							message_socket.close();
						}
					},
					error:function(){
						alert('채팅 등록 네트워크 오류');
						message_socket.close();
					}
				});
			});
			
			//=========채팅방 나가기==========//
			$('#delete_talkroom${user.mem_num}').click(function(){
				let choice = confirm('채팅방을 나가길 원하시나요?');
				if(!choice){
					return;
				}
				
				$.ajax({
					url:'../talk/deleteTalkRoomMember.do',
					type:'post',
					data:{talkroom_num:$('#talkroom_num').val(),mem_num:$('#mem_num').val()},
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인해야 작성할 수 있습니다');
							message_socket.close();
						}else if(param.result == 'success'){
							alert('정상적으로 채팅방 나갔습니다.');
							location.href='../talk/talkList.do';
						}else{
							alert('채팅방 나가기 오류 발생');
							message_socket.close();
						}
					},
					error:function(){
						alert('네트워크 오류 발생');
						message_socket.close();
					}
				});
				
			});
			
			
		});
		
		//=========메시지 입력 후 enter 이벤트 처리========//
		$('#message${talk.talkroom_num}').keydown(function(event){
			if(event.keyCode == 13 && !event.shiftKey){//엔터를 눌렀을 때
				$('#detail_form${talk.talkroom_num}').trigger('submit');
			}
		});
		
		isSubmitted = false;
		</script>
			<!-- ------------------------------------------ 모달 --------------------------------------------------- -->
	
	<div class="modal fade" id="${talk.talkroom_num}" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-xl modal-dialog-centered">
      <div class="modal-content" id="mcontent">

        <!-- Modal Header -->
        <div class="modal-header" id="mheader">
	        <div>
	        	 <b><span id="roomname${talk.talkroom_num}"></span></b><br>
				채팅 멤버 : <span id="name${talk.talkroom_num}"></span>
	        </div>
			<div class="align-right">
				<input type="button" value="채팅방 나가기" id="delete_talkroom${user.mem_num}">
			</div>
			 <button type="button" class="close" data-dismiss="modal" onclick="start();">&times;</button>
        </div>
 
        <!-- Modal body -->
        <div class="modal-body" id="mbody">
		<div id="chatting_message${talk.talkroom_num}" style="width:500px; height:500px; overflow-y:scroll;"></div><!-- 다른 채팅창이 안보여서 나눔 -->
		<form method="post" id="detail_form${talk.talkroom_num}">
			<input type="hidden" name="talkroom_num" id="talkroom_num" value="${talk.talkroom_num}">
			<input type="hidden" name="mem_num" id="mem_num" value="${user.mem_num}">
			
			<textarea rows="5" cols="62" name="message" id="message${talk.talkroom_num}"></textarea>
			<input type="submit" value="전송">
			
		</form>
        </div>
        
        <!-- Modal footer 
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>-->
        
      </div>
    </div>
</div>
			
			
		</c:forEach>
	</table>
	</c:if>
	
</div>