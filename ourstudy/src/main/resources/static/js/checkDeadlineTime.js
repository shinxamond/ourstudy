$(function(){
	
	//사이드바가 모든 페이지에 적용되니까 여기다가 함수 정의하자
  	//1. 세션에 입실한 시간(session 변수 name = "setIn", 입실시간) 담아두기
  	//2. JS에서 현재시간 구하기 
  	//3. 현재시간(js로 sysdate) - 입실한 시간(세션에 아까 찍어둔 date) 계산하기 두 시간 차이가 60이되면 function 실행
  	//4. function 실행되면 입실시간에 60을 더해준 뒤 다시 세션에 저장
  	//5. 3:23(입실) -> 현재시간js가져와 3:23 40 41  --- 3:24  3:24- 3:23 = 1분  session.setitem("setIn", 입실시간+60);
  	//6. 3:24(입실시간) -> 현재시간js 가져와 3:24 32 33- --- 3:25 - setIn = 1분 session.setItem(setIn 입실시간 +60);
  	//7. session에 있는 setIN 제거
	
	var reloadDiv = $('#remainTimeZone');
	
	if(sessionStorage.getItem('isSelect') == '1') {
		sessionStorage.setItem('plusSec', '0');
		
	  	setInterval(function(){
	  		var updateSec = sessionStorage.getItem('plusSec');
	  		
	  		updateSec = parseInt(updateSec) + 1;
	  		
	  		sessionStorage.setItem('plusSec', updateSec);
	  		
	  		if(updateSec >= 10) {
	  			sessionStorage.setItem('plusSec', '0');
	  			
	  			let mem_num = sessionStorage.getItem('isSelectMemnum');
	  			let seat_num = sessionStorage.getItem('isSelectSeatnum');
	  			let newRemain = 0;
	  			
	  			//컨트롤러에 mem_num 보내서 mem_ticket_hour값 가져오기
	  			$.ajax({
	  				url : '../seat/deadlineCheck.do',
	  				data : {mem_num : mem_num},
	  				type : 'post',
	  				dataType : 'json',
	  				success : function(param){
	  					if(param.result == 'success') {
	  						let remainTime = parseFloat(param.time);
	  						newRemain =	parseFloat(remainTime) - parseFloat(60.0);	
	  						$.ajax({ 
	  							url : '../seat/updateDeadline.do',
	  							data : {newRemain : newRemain},
	  							type : 'post',
	  							dataType : 'json',
	  							success : function(param){
	  								if(param.result == 'success') {
	  									//alert('처리를 안해도되지만 굳이 껴넣음');
										if(reloadDiv != ''){
											$('#remainTimeZone').load(location.href + '#remainTimeZone');
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
	  							location.href = '../ticket/study_ticketList.do?seat_num=' + seat_num;							
	  						}else {
	  							alert('5분 후 자동 퇴실됩니다.');
	  						}
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