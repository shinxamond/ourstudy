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
//	reload = setInterval(function(){ location.reload(); }, 5000);
	function start(){
		//alert('시작');
		 reload =   setInterval(function(){ location.reload(); }, 700);
	};
	

		

</script>
<div class="page-main">	
		<div class="content-main"><!-- 전체 화면의 87% -->
			<!-- 사이드바 오른쪽 화면 시작 -->
			<div class="content-right">
				<h3 style="text-align:center"><b>채팅목록</b></h3>
				<!-- 검색폼 시작 -->
				<div class="section" style="text-align:center"> 
					<div class="search-bar">
						<form class="search-form d-flex align-items-center" action="talkList.do" method="get"><!-- 자동 인코딩 처리를 위해 -->
							<input type="text" name="keyword" value="${param.keyword}" placeholder="채팅방 이름">
							<button type="submit" title="Search"><i class="bi bi-search"></i></button>
						</form>
					</div>
				</div>
				<!-- 검색폼 끝 -->
	<div class="align-right">
		<input type="button" class="talkButton" value="채팅방 생성" onclick="location.href='talkRoomWrite.do'">
		<input type="button" class="talkButton" value="목록" onclick="location.href='talkList.do'">
	</div>
	<br>
	
	<c:if test="${empty list}">
	<div class="result-display">표시할 채팅방이 없습니다.</div>
	</c:if>
	
	<c:if test="${!empty list}">
	<table class="table table-hover align-center tt1">
		<tbody id="talkroom_list">
		<c:forEach var="talk" items="${list}">
		
		<tr>
			<td style="text-align:left">
				<%-- <a href="talkDetail.do?talkroom_num=${talk.talkroom_num}"> --%>
				<a href="#" data-toggle="modal" data-target="#${user.mem_num}" id="10"  data-id="${talk.talkroom_num}">
					<span>${talk.talkroom_name}</span>
				</a>
					<br>
					<span class="m${talk.talkroom_num}">${fn:substring(talk.talkVO.message,0,45)}</span><!-- fn : 함수 사용 -->
			</td>
			<td style="text-align:right">
				<c:if test="${!empty talk.talkVO.chat_date}">
					<span class="t${talk.talkroom_num}">${talk.talkVO.chat_date}</span>
					<br>
					<c:if test="${talk.room_cnt!=0}">
					<span class="c${talk.talkroom_num}" id="talk_inform">${talk.room_cnt}</span>
					</c:if>
					
					
				</c:if>
				<c:if test="${empty talk.talkVO.chat_date}">${talk.talkroom_date}</c:if>
			</td>	
		</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<table class="table table-hover table-group-divider tt2"><!-- 반응형 줄었을 때 등장 -->
		<tbody id="talkroom_list2">
		<c:forEach var="talk" items="${list}">
		
		<tr>
			<td style="text-align:left">
				<%-- <a href="talkDetail.do?talkroom_num=${talk.talkroom_num}"> --%>
				<a href="#" data-toggle="modal" data-target="#${user.mem_num}" id="10"  data-id="${talk.talkroom_num}">
					<span>${talk.talkroom_name}</span>
				</a>
					<br>
					<span class="m${talk.talkroom_num}">${fn:substring(talk.talkVO.message,0,45)}</span><!-- fn : 함수 사용 -->
					<br>
			
				<c:if test="${!empty talk.talkVO.chat_date}">
					<span class="t${talk.talkroom_num}">${talk.talkVO.chat_date}</span>
					<br>
					<c:if test="${talk.room_cnt!=0}">
					<span class="c${talk.talkroom_num}" id="talk_inform">${talk.room_cnt}</span>
					</c:if>
					<c:if test="${talk.room_cnt==0}">
					<span class="c${talk.talkroom_num}"></span>
					</c:if>
					
				</c:if>
				<c:if test="${empty talk.talkVO.chat_date}">${talk.talkroom_date}</c:if>
			</td>	
		</tr>
		</c:forEach>
		</tbody>
	</table>
	
	
		<!-- ------------------------------------------ 모달 --------------------------------------------------- -->
	
	<div class="modal fade" id="${user.mem_num}" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog modal-xl modal-dialog-centered">
      <div class="modal-content" id="mcontent">

        <!-- Modal Header -->
        <div class="modal-header" id="mheader">
	        <div>
	        	 <b><span id="roomname"></span></b><br>
				채팅 멤버 : <span id="name"></span>
	        </div>
			<div class="align-right">
				<input type="button" value="채팅방 나가기" id="delete_talkroom">
			</div>
			 <button type="button" class="close" data-dismiss="modal" onclick="start();">&times;</button>
        </div>
 
        <!-- Modal body -->
        <div class="modal-body" id="mbody">
		<div id="chatting_message"></div><!-- 다른 채팅창이 안보여서 나눔 -->
		<form method="post" id="detail_form" style="border:none;">
			<input type="hidden" name="talkroom_num" id="talkroom_num">
			<input type="hidden" name="mem_num" id="mem_num" value="${user.mem_num}">
			
			<textarea rows="5" cols="48" name="message" id="message"></textarea>
			<input type="submit" value="전송">
			
		</form>
		
		<span class="emoticon">&#128539;</span>
		<span class="emoticon">&#128512;</span>
		<span class="emoticon">&#128514;</span>
		<span class="emoticon">&#128516;</span>
		<span class="emoticon">&#128518;</span>
		<span class="emoticon">&#128519;</span>
		<span class="emoticon">&#128525;</span>
		<span class="emoticon">&#128526;</span>
		<span class="emoticon">&#128529;</span>
		<span class="emoticon">&#128541;</span>
		<span class="emoticon">&#128558;</span>
		<span class="emoticon">&#128560;</span>
		<span class="emoticon">&#128561;</span>
		<span class="emoticon">&#128563;</span>
		<span class="emoticon">&#128565;</span>
		<br>
		<span class="emoticon">&#129505;</span>
		<span class="emoticon">&#10084;</span>
		<span class="emoticon">&#9757;</span>
		<span class="emoticon">&#9994;</span>
		<span class="emoticon">&#9995;</span>
		<span class="emoticon">&#9996;</span>
		<span class="emoticon">&#10060;</span>
		<span class="emoticon">&#10067;</span>
		<span class="emoticon">&#10071;</span>
		<span class="emoticon">&#10083;</span>
		<span class="emoticon">&#11088;</span>
		<span class="emoticon">&#127800;</span>
		<span class="emoticon">&#128077;</span>
		<span class="emoticon">&#128076;</span>
		<span class="emoticon">&#128127;</span>
		<span class="emoticon">&#128144;</span>
		<span class="emoticon">&#129326;</span>
		<span class="emoticon">&#129315;</span>
		<br>
        </div>
        
        <!-- Modal footer 
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>-->
        
      </div>
    </div>
</div>
	
	<script type="text/javascript">
	function alarm_connect(room_num){
		
		message_socket = new WebSocket("ws://localhost:8001/message-ws.do");
		message_socket.onopen = function(ent){//연결
			
			message_socket.send("msg:");
			console.log("채팅페이지 접속");
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정 
		message_socket.onmessage=function(evt){
			
			let data = evt.data;
			if(data.substring(0,4) == 'msg:'){
				selectMsg(room_num);
			}
			
		};
		message_socket.onclose=function(evt){
			//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
			console.log('채팅 종료');
		}
	};
	
function alarm_connect2(){
		
		message_socket2 = new WebSocket("ws://localhost:8001/message-ws.do");
		message_socket2.onopen = function(ent){//연결
			console.log("채팅페이지 접속");
		};
		//서버로부터 메시지를 받으면 호출되는 함수 지정 
		message_socket2.onmessage=function(evt){
			
			let data = evt.data;
			
			if(data.substring(0,4) == 'arm:'){
				
					countmsg();
					countmsg2();
				
			}
			
		};
		message_socket2.onclose=function(evt){
			//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
			console.log('채팅 종료');
		}
	};
	alarm_connect2();
	
	function selectMsg(room_num){//메시지 불러오기
		
		$.ajax({
			url:'../talk/talkDetailAjax.do',
			type:'post',
			data:{talkroom_num:room_num},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){	
					alert('로그인 후 사용하세요!');
					message_socket.close();
				}else if(param.result == 'success'){
					$('#chatting_message').empty();
					
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
						$('#chatting_message').append(output);
						if($('#chatting_message')[0].scrollHeight==0){
							$('#chatting_message').animate({scrollTop:200*param.list.length},10);//스크롤이 안내려가면 강제로 내리기
						}
						//스크롤을 하단에 위치시킴
						$('#chatting_message').scrollTop($('#chatting_message')[0].scrollHeight);
					});				
					message_socket2.send("arm:");
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
	function countmsg(){
		$.ajax({
			url:'../talk/talkCountAjax.do',
			type:'post',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다');
					message_socket.close();
				}else if(param.result == 'success'){
					$('#talkroom_list').empty();
					$(param.clist).each(function(index,item){
						let output = '';
						output += '<tr>';
						output += '<td style="text-align:left">';
						output += '<a href="#" data-toggle="modal" data-target="#${user.mem_num}" id="10"  data-id="'+item.talkroom_num+'">';
						output += '<span>'+item.talkroom_name+'</span></a>';
						output += '<br>';
						if(item.talkVO!=null){
							let message1 = item.talkVO.message;
							message1 = message1.substr(0,45);
							output += '<span class="m'+item.talkroom_num+'">'+message1+'</span>';
						}
						
						output += '</td>';
						output += '<td style="text-align:right">';
						if(item.talkVO!=null){
							if(item.talkVO.chat_date != ''){
								output += '<span class="t'+item.talkroom_num+'">'+item.talkVO.chat_date+'</span>';
								output += '<br>';
								if(item.room_cnt!=0){
									output += '<span class="c'+item.talkroom_num+'" id="talk_inform">'+item.room_cnt+'</span>';
								}
							}
							if(item.talkVO.chat_date == ''){
								output += item.talkroom_date
							}
						}
						output += '</td>';
						output += '</tr>';
						
						$('#talkroom_list').append(output);
					});
				}else{
					alert('메시지 등록 오류');
					message_socket.close();
				}
			},
			error:function(){
				alert('채팅 카운트 네트워크 오류');
				message_socket.close();
			}
		});
	}
	function countmsg2(){
		$.ajax({
			url:'../talk/talkCountAjax.do',
			type:'post',
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다');
					message_socket.close();
				}else if(param.result == 'success'){
					$('#talkroom_list2').empty();
					$(param.clist).each(function(index,item){
						let output = '';
						output += '<tr>';
						output += '<td style="text-align:left">';
						output += '<a href="#" data-toggle="modal" data-target="#${user.mem_num}" id="10"  data-id="'+item.talkroom_num+'">';
						output += '<span>'+item.talkroom_name+'</span></a>';
						output += '<br>';
						if(item.talkVO!=null){
							let message1 = item.talkVO.message;
							message1 = message1.substr(0,45);
							output += '<span class="m'+item.talkroom_num+'">'+message1+'</span><br>';
						}
						
						if(item.talkVO!=null){
							if(item.talkVO.chat_date != ''){
								output += '<span class="t'+item.talkroom_num+'">'+item.talkVO.chat_date+'</span>';
								output += '<br>';
								if(item.room_cnt!=0){
									output += '<span class="c'+item.talkroom_num+'" id="talk_inform">'+item.room_cnt+'</span>';
								}
							}
							if(item.talkVO.chat_date == ''){
								output += item.talkroom_date
							}
						}
						output += '</td>';
						output += '</tr>';
						
						$('#talkroom_list2').append(output);
					});
				}else{
					alert('메시지 등록 오류');
					message_socket.close();
				}
			},
			error:function(){
				alert('채팅 카운트 네트워크 오류');
				message_socket.close();
			}
		});
	}
		
		$(document).on('click','#10',function(){//목록 클릭
			
			var room_num = $(this).data('id');
			//$('#talkroom_num').val(room_num);
			
			alarm_connect(room_num);
			
			$(document).on('click','.close',function(){
				message_socket.close();
			}); 
			
			//alert(data);
			$.ajax({
				url:'../talk/talkDetailA.do',
				type:'post',
				data:{talkroom_num:room_num},
				dataType:'json',
				success:function(param){
					if(param.result == 'logout'){
						alert('로그인 후 사용하세요!');
						//message_socket.close();
					}else if(param.result == 'success'){
						$('#roomname').text('');
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
						
						$('#roomname').append(rname);
						$('#name').text('');
						let output2 = '';
						var count = 0;
						$(param.detailList).each(function(index,item){
							if(index>0)output2+=',';
							  output2 += item.mem_id;
							  count++;
							});
							output2 += ' '+count + '명';
						$('#name').append(output2);
						
						
						
											
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
			
			$('.emoticon').click(function(){
				var value = $(this).text();
				var message_str = $("#message").val();
				message_str += value;
				$('#message').val(message_str);
			});
			
			
			
			//============채팅 등록================//
			$('#detail_form').submit(function(event){
				
				
				//기본 이벤트 제거
				event.preventDefault();
				if($('#message').val().trim()==''){
					alert('메시지를 입력하세요');
					$('#message').val('').focus();
					return false;
				}
				
				//글자수 체크
				if($('#message').val().length>1333){
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
							$('#message').val('').focus();
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
			$('#delete_talkroom').click(function(){
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
		$('#message').keydown(function(event){
			if(event.keyCode == 13 && !event.shiftKey){//엔터를 눌렀을 때
				$('#detail_form').trigger('submit');
			}
		});
		</script>
	</c:if>
		</div>
	</div>
</div>