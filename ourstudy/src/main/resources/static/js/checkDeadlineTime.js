

$(function(){
	
	//사이드바가 모든 페이지에 적용되니까 여기다가 함수 정의하자
  	//1. 세션에 입실한 시간(session 변수 name = "setIn", 입실시간) 담아두기
  	//2. JS에서 현재시간 구하기 
  	//3. 현재시간(js로 sysdate) - 입실한 시간(세션에 아까 찍어둔 date) 계산하기 두 시간 차이가 60이되면 function 실행
  	//4. function 실행되면 입실시간에 60을 더해준 뒤 다시 세션에 저장
  	//5. 3:23(입실) -> 현재시간js가져와 3:23 40 41  --- 3:24  3:24- 3:23 = 1분  session.setitem("setIn", 입실시간+60);
  	//6. 3:24(입실시간) -> 현재시간js 가져와 3:24 32 33- --- 3:25 - setIn = 1분 session.setItem(setIn 입실시간 +60);
  	//7. session에 있는 setIN 제거
	
	setTimeout(function() {
  	if(sessionStorage.getItem('buyTicket') == 'buy' && $('.setCheckInStatus').length > 0){
		sessionStorage.removeItem("buyTicket");
		location.reload();
	}
	}, 100);

	
	var logoutBtn = $('.logout-btn').length;
	var cnt = 0;
	if(logoutBtn < 1){
		sessionStorage.removeItem("isSelect");
		sessionStorage.removeItem("plusSec");
		sessionStorage.removeItem("isSelectMemnum");
		sessionStorage.removeItem("isSelectSeatnum");
	}
	
	//console.log("status=" + sessionStorage.getItem('isSelect'));
	
	//console.log("mem_num=" + sessionStorage.getItem('isSelectMemnum'));
	//console.log("seat_num=" + sessionStorage.getItem('isSelectSeatnum'));
	
	var reloadDiv = $('#remainTimeZone');
	
	if(sessionStorage.getItem('isSelect') == '1') {
		
		if(sessionStorage.getItem('plusSec') == null){
			sessionStorage.setItem('plusSec', '0');	
		}
		
	  	setInterval(function(){
	  		var updateSec = sessionStorage.getItem('plusSec');
	  		
	  		updateSec = parseInt(updateSec) + 1;
	  		
	  		sessionStorage.setItem('plusSec', updateSec);
	  		
			console.log(updateSec);
	
	  		if(updateSec >= 10) {
	  			sessionStorage.setItem('plusSec', '0');
	  			
	  			let mem_num = sessionStorage.getItem('isSelectMemnum');
	  			let seat_num = sessionStorage.getItem('isSelectSeatnum');
	  			let newRemain = 0;
	  			let remainTime;
	  			//컨트롤러에 mem_num 보내서 mem_ticket_hour값 가져오기
	  			$.ajax({
	  				url : '../seat/deadlineCheck.do',
	  				data : {mem_num : mem_num},
	  				type : 'post',
	  				dataType : 'json',
	  				success : function(param){
	  					if(param.result == 'success') {
	  						remainTime = parseFloat(param.time);
	  						newRemain =	parseFloat(remainTime) - parseFloat(60.0);	
	  						$.ajax({ 
	  							url : '../seat/updateDeadline.do',
	  							data : {newRemain : newRemain},
	  							type : 'post',
	  							dataType : 'json',
	  							success : function(param){
	  								if(param.result == 'success') {
										if(reloadDiv != ''){
											$('#remainTimeZone').load('../mypage/myPageMain.do #remainTimeZone');
										}
	  								}else {
	  									alert('잔여시간 업데이트 오류 발생');
	  								}
	  							},
	  							error : function(){
	  								alert('NETWORK ERROR(updateTime)');
	  							}
	  						});
	  					}else if(param.result == 'lessThanFive') {
	  						let check = confirm('잔여시간이 5분 남았습니다. 이용권을 추가로 결제할까요?');
	  						if(check) {
	  						remainTime = parseFloat(param.time);
	  						newRemain =	parseFloat(remainTime) - parseFloat(60.0);			
	  						$.ajax({ 
	  							url : '../seat/updateDeadline.do',
	  							data : {newRemain : newRemain},
	  							type : 'post',
	  							dataType : 'json',
	  							success : function(param){
	  								if(param.result == 'success') {
										if(reloadDiv != ''){
											sessionStorage.setItem('buyTicket', 'buy');
											$('#remainTimeZone').load('../mypage/myPageMain.do #remainTimeZone');
											
											location.href="../seat/out.do?seat_num="+seat_num;
											
											location.href = '../ticket/study_ticketList.do?seat_num=' + seat_num;
											
										}
	  								}else {
	  									alert('잔여시간 업데이트 오류 발생(5분이하일때)');
	  								}
	  							},
	  							error : function(){
	  								alert('NETWORK ERROR(updateTime)');
	  							}
	  						});								
	  														
	  						}else {
	  						remainTime = parseFloat(param.time);
	  						newRemain =	parseFloat(remainTime) - parseFloat(60.0);		
	  						$.ajax({ 
	  							url : '../seat/updateDeadline.do',
	  							data : {newRemain : newRemain},
	  							type : 'post',
	  							dataType : 'json',
	  							success : function(param){
	  								if(param.result == 'success') {
										if(reloadDiv != ''){
											$('#remainTimeZone').load('../mypage/myPageMain.do #remainTimeZone');
										}
	  								}else {
	  									alert('잔여시간 업데이트 오류 발생(5분이하인데 연장안할때)');
	  								}
	  							},
	  							error : function(){
	  								alert('NETWORK ERROR(updateTime)');
	  							}
	  						});
	  							alert('5분 후 자동 퇴실됩니다.');
	  						}
	  					}else if(param.result == 'setLogout'){
	  						$.ajax({ 
	  							url : '../seat/updateDeadline.do',
	  							data : {newRemain : 0.0},
	  							type : 'post',
	  							dataType : 'json',
	  							success : function(param){
	  								if(param.result == 'success') {
										if(reloadDiv != ''){

										}
	  								}else if(param.result == 'end'){
										cnt = cnt + 1;
										if(cnt <= 1){
											location.href="../seat/out.do?seat_num="+seat_num;
											alert('잔여시간이 모두 소진되었습니다.');
											sessionStorage.setItem("isSelect", '0');
											location.href = "../seat/selectForm.do";				
										}
									}
									else {
	  									alert('종료 후 잔여시간 업데이트 오류 발생');
	  								}
	  							},
	  							error : function(){
	  								alert('NETWORK ERROR(updateTimeWhenLogout)');
	  							}
	  						});

						}else {
	  						alert('잔여시간 불러오기 오류 발생');
	  					}
	  				},
	  				error : function(){
	  					alert('NETWORK ERROR(getTime)');
	  				}
	  			});
	  		}
	  	}, 1000);
		
	}else if(sessionStorage.getItem('isSelect') == '0') {
		sessionStorage.removeItem("isSelect");
		sessionStorage.removeItem("plusSec");
	}
});