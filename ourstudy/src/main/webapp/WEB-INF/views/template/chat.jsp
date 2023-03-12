<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/talk.css?after">
<script type="text/javascript">
var reload;
if(${user.mem_auth == 1}){
	function start(){
		//alert('시작');
		 reload =   setInterval(function(){ location.reload(); }, 700);
	};
	function end(){
		//alert('끝');
	clearInterval(reload);
};
}


$(function(){
	alert(${check});
	if(${check==0}){
		$('#talkCheck').hide();
		$('#roomc').text('채팅방 생성 완료(↑ 클릭)');
	}
	if(${check==1}){
		$('#talkCheck').hide();
		$('#roomc').text('채팅방이 있습니다(↑ 클릭)');
	}
	$('#roomcheckB').click(function(){
		$('#roomcheckB').hide();
	});
});
</script>
<c:if test="${!empty user && user.mem_auth==1 && empty check}">
<form action="/talk/maintalkRoomWrite.do" method="post" id="check_talk_form">
	<input type="hidden" name="members" value="${user.mem_num}">
	<input type="hidden" name="members" value="842">
	<input type="hidden" name="talkroom_name" id="talkroom_name" value="admin, ${user.mem_id}">
	
	<button id="roomcheckB" class="btnC" style="position: fixed; right: 40px; bottom: 43px; font-size:55px; color:#e65962; border:none; background-color:#F6E3CE; border-radius: 80px; z-index:998">📭</button>
	<span  style="position: fixed; right: 40px; bottom: 30px; z-index:998">채팅방 확인하기</span>
	<span class="emessage">✉</span>
</form>
</c:if>

<c:if test="${!empty check}">
	<button type="button" class="btn btn-primary btnC" data-bs-toggle="modal" id="10" data-id="${room_num}" data-bs-target="#talkview" style="position: fixed; right: 40px; bottom: 43px; background-color:#F6E3CE; border-radius: 80px; border:none;  color:#e65962; font-size:55px; z-index:998">📭</button>
	<c:forEach var="talk_count" items="${roomList}">
		<c:if test="${talk_count.room_cnt > 0 }">
		<span class="c${room_num}" id="talk_inform" style="position: fixed; right: 47px; bottom: 110px; z-index:999">${talk_count.room_cnt}</span>
		</c:if>
		<c:if test="${talk_count.room_cnt == 0 }">
		<span class="c${room_num}" style="position: fixed; right: 47px; bottom: 110px; z-index:999"></span>
		</c:if>
	</c:forEach>
	<span id="roomc" style="position: fixed; right: 10px; bottom: 30px; z-index:998"></span>
	<span class="emessage">✉</span>
</c:if>

<!-- Modal -->
<div class="modal fade" id="talkview" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="maincontent">
      <div class="modal-header" id="mainheader">
	        <div>
	        	 <b><span id="roomname"></span></b><br>
				채팅 멤버 : <span id="name"></span>
	        </div>
			<div class="align-right">
			</div>
			 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="background-color:white;"onclick="start();"></button>
        </div>
 
        <!-- Modal body -->
        <div class="modal-body" id="mainbody">
		<div id="chatting_message2"></div><!-- 다른 채팅창이 안보여서 나눔 -->
		<form method="post" id="detail_form">
			<input type="hidden" name="talkroom_num" id="talkroom_num" value="${room_num}">
			<input type="hidden" name="mem_num" id="mem_num" value="${user.mem_num}">
			
			<textarea rows="5" cols="60" name="message" id="message2"></textarea>
			<input type="submit" value="전송">
		</form>
		&nbsp;
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
		<br>&nbsp;
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
    </div>
  </div>
</div>

<script type="text/javascript">

let message_socket;//웹소켓 식별자
let message_socket2;//웹소켓 식별자

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
		alert('ㅁㅁ');
		let data = evt.data;
		if(data.substring(0,4) == 'arm:'){
			countmsg();
		}
		
	};
	message_socket2.onclose=function(evt){
		//소켓이 종료된 후 부과적인 작업이 있을 경우 명시
		console.log('채팅 종료');
	}
};
if(${user!=null}){
	alarm_connect2();
	}

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
				$('#chatting_message2').empty();
				
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
					$('#chatting_message2').append(output);
					if($('#chatting_message2')[0].scrollHeight==0){
						$('#chatting_message2').animate({scrollTop:200*param.list.length},10);//스크롤이 안내려가면 강제로 내리기
					}
					//스크롤을 하단에 위치시킴
					$('#chatting_message2').scrollTop($('#chatting_message2')[0].scrollHeight);
					
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
				
				$(param.clist).each(function(index,item){
					
					$('.c'+item.talkroom_num).text(item.room_cnt);
					$('.c'+item.talkroom_num).css({"background-color":"red","color":"white","border-radius":"15px","display":"inline-block","height":"20px","width":"20px","text-align":"center","font-size":"15px"});
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
			//alert('aa');
			end();
			var room_num = $(this).data('id');
			alarm_connect(room_num);
			
			
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
				var message_str = $("#message2").val();
				message_str += value;
				$('#message2').val(message_str);
			});
			
			//============채팅 등록================//
			$('#detail_form').submit(function(event){
				
				//기본 이벤트 제거
				event.preventDefault();
				if($('#message2').val().trim()==''){
					alert('메시지를 입력하세요');
					$('#message2').val('').focus();
					return false;
				}
				
				//글자수 체크
				if($('#message2').val().length>1333){
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
							$('#message2').val('').focus();
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
		$('#message2').keydown(function(event){
			if(event.keyCode == 13 && !event.shiftKey){//엔터를 눌렀을 때
				$('#detail_form').trigger('submit');
			}
		});
		
		</script>
		


<!-- 메인 끝 -->