<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 메인 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/talk.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main/clock.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main/quotes.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.min.js"></script>

<script>
	//막대 차트(구글차트 API)
	google.charts.load("current", {packages:['corechart']});
	google.charts.setOnLoadCallback(drawChart);
	google.charts.setOnLoadCallback(drawDoughnut1);
	google.charts.setOnLoadCallback(drawDoughnut2);
	
	function drawChart() {
	  var data = google.visualization.arrayToDataTable([
	    ['이름', '공부시간', {role: 'style'}],
	    <c:forEach var="studyTime" items="${studyTime}">
	    ['${studyTime.mem_name}', ${studyTime.mem_study}, 'fill-color:#037332;'],
	    </c:forEach>
	  ]);
	
	  var view = new google.visualization.DataView(data);
	  view.setColumns([0, 1,
	                   { calc: "stringify",
	                     sourceColumn: 1,
	                     type: "string",
	                     role: "annotation" },
	                   2]);
	
	  var options = {
	    width: 500,
	    height: 350,
	    bar: {groupWidth: "50%"},
	    legend: { position: "none" },
	    vAxis: {textPosition: 'none', viewWindow: {max: 70}},
	   	chartArea:{left:15,top:30,width:"93%",height:"80%"}
	  };
	  var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
	  chart.draw(view, options);
	}
	
	//도넛차트(가짜데이터)
	function drawDoughnut1() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          pieHole: 0.6,
          legend: { position: "none" },
          chartArea:{left:10,top:5,width:"90%",height:"90%"},
          'height':195
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart1'));
        chart.draw(data, options);
      }
	
	function drawDoughnut2() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     9],
          ['Eat',      3],
          ['Watch TV', 4],
          ['Sleep',    13]
        ]);

        var options = {
          pieHole: 0.6,
          legend: { position: "none" },
          chartArea:{left:10,top:5,width:"90%",height:"90%"},
          'height':195
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart2'));
        chart.draw(data, options);
      }
   
</script>

<%-- 도넛 차트(char.js 라이브러리)  --%>
<script>
	var ctx = document.getElementById('testChart');
	var config = {
		type:'doughnut',
		data:{
			datasets:[{
				data:[10,20,30,40,50],
				backgroundColor:['red','orange','yellow','green','blue'],
				label:'Dataset 1'
			}],
			labels:['red','orange','yellow','green','blue']
		},
		options:{
			responsive:true,
			legend:{
				position:'top',
			},
			title:{
				display:true,
				text:'Chart.js Doughnut Chart'
			},
			animation{
				animateScale:true,
				animateRotate:true
			}
		}
	};
	var myDoughnutChart = new Chart(ctx, config);
</script>


<div id="main_content_body" class="container">
	<div class="row" id="body_header">
		<div class="digital-clock card main_card" id="clock">
			<span id="quote"></span>
			<span id="author"></span>
			00:00:00
		</div>
	</div>
	<div class="row">
		<div class="card main_card" id="study_banner">
			<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" >
			  <div class="carousel-indicators">
			    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
			    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
			  </div>
			  <div class="carousel-inner">
			    <div class="carousel-item active" data-bs-interval="2000">
			      <img src="${pageContext.request.contextPath}/image_bundle/banner1.PNG" class="d-block w-100" >
			    </div>
			    <div class="carousel-item" data-bs-interval="3000">
			      <img src="${pageContext.request.contextPath}/image_bundle/banner2.PNG" class="d-block w-100">
			    </div>
			    <div class="carousel-item" data-bs-interval="3000">
			      <img src="${pageContext.request.contextPath}/image_bundle/banner3.PNG" class="d-block w-100">
			    </div>
			  </div>
			</div>		
		</div>
		<div class="card main_card" id="study_board">
		<span class="main-title" style="margin:5px 0 10px 5px;">> 안내사항 </span>
			<table class="table table-hover table-group-divider table table-striped">
				<tr style="background-color:#037332;">
					<th width="320" class="align-center" style="color:#daebe3;">제목</th>
					<th class="align-center" style="color:#daebe3;">작성일</th>
				</tr>
				<c:forEach var="info" items="${infoList}">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath}/info/infoDetail.do?info_num=${info.info_num}" style="margin-left:5px;">${info.info_title}</a>
					</td>
					<td class="align-center">	
						${info.info_date}
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="card main_card" id="study_time">
			<span class="main-title" style="margin:15px 0 0px 10px;">> 일주일 공부시간 랭킹 </span>
			<div id="columnchart_values"></div>
		</div>
		<div class="card main_card" id="all_time">
		<div>
			<div id="donutchart1"></div>
			</div>
			<div id="donutchart2"></div>
  			<%-- <canvas id="testChart" width="60vw" height="60vh"></canvas> --%>
		</div>
		<div class="card main_card" id="study_photo">
			<span class="main-title" style="margin:10px 0 15px 5px;">> 우리 독서실 </span>
			<span class="align-center">
				<img src="${pageContext.request.contextPath}/image_bundle/study1.jpg" class="study_photo">
				<img src="${pageContext.request.contextPath}/image_bundle/study2.jpg" class="study_photo">
			</span>
			<span class="align-center">
				<img src="${pageContext.request.contextPath}/image_bundle/study3.jpg" class="study_photo">
				<img src="${pageContext.request.contextPath}/image_bundle/study4.PNG" class="study_photo">
			</span>
		</div>
	</div>
</div>

<!-- 메인 끝 -->
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
	if(${check==0}){
		$('#talkCheck').hide();
		$('#roomc').text('채팅방 생성 완료(↑ 클릭)');
	}
	if(${check==1}){
		$('#talkCheck').hide();
		$('#roomc').text('채팅방이 있습니다(↑ 클릭)');
	}
});
</script>
<c:if test="${!empty user && user.mem_auth==1}">
<form action="/talk/maintalkRoomWrite.do" method="post" id="check_talk_form">
	<input type="hidden" name="members" value="${user.mem_num}">
	<input type="hidden" name="members" value="527">
	<input type="hidden" name="talkroom_name" id="talkroom_name" value="${user.mem_id}, admin9">
	<input type="submit" value="채팅방 확인" id="talkCheck" style="position: fixed; right: 40px; bottom: 50px;">
</form>
</c:if>

<c:if test="${!empty check}">
	<button type="button" class="btn btn-primary" data-bs-toggle="modal" id="10" data-id="${room_num}" data-bs-target="#talkview" style="position: fixed; right: 40px; bottom: 50px; background-color:white; border:none;"><img src="${pageContext.request.contextPath}/images/chat.jfif" width="50" height="50" class="my-photo">
	</button>
	<c:forEach var="talk_count" items="${roomList}">
		<c:if test="${talk_count.room_cnt > 0 }">
		<span class="c${room_num}" id="talk_inform" style="position: fixed; right: 47px; bottom: 87px;">${talk_count.room_cnt}</span>
		</c:if>
	</c:forEach>
	<span id="roomc" style="position: fixed; right: 40px; bottom: 30px;"></span>
</c:if>
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
				
				$(param.clist).each(function(index,item){
					
					$('.c'+item.talkroom_num).text(item.room_cnt);
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
			
			//============채팅 등록================//
			$('#detail_form').submit(function(event){
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
		<!-- Modal -->
<div class="modal fade" id="talkview" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content" id="mcontent">
      <div class="modal-header" id="mheader">
	        <div>
	        	 <b><span id="roomname"></span></b><br>
				채팅 멤버 : <span id="name"></span>
	        </div>
			<div class="align-right">
			</div>
			 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="start();"></button>
        </div>
 
        <!-- Modal body -->
        <div class="modal-body" id="mbody">
		<div id="chatting_message" style="width:500px; height:500px; overflow-y:scroll;"></div><!-- 다른 채팅창이 안보여서 나눔 -->
		<form method="post" id="detail_form">
			<input type="hidden" name="talkroom_num" id="talkroom_num" value="${room_num}">
			<input type="hidden" name="mem_num" id="mem_num" value="${user.mem_num}">
			
			<textarea rows="5" cols="60" name="message" id="message"></textarea>
			<input type="submit" value="전송">
			
		</form>
        </div>
    </div>
  </div>
</div>


<!-- 메인 끝 -->