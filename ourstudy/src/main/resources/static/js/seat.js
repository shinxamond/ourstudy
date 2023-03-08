
/*==============================
		좌석 선택 확인 alert
  =============================*/
	function checkSelect(e){
		let seat_name = document.getElementById(e.getAttribute('id')).getAttribute('id');
		let seat_num = document.getElementById(e.getAttribute('id')).getAttribute('data-seatnum');
		
		
		let select = confirm(seat_name + '번 좌석을 선택할까요?');
		console.log(seat_num);
		
		if(select == false){
			alert('좌석 선택이 취소되었습니다');
		}else if(select == true){
			alert(seat_name + '번 좌석이 선택되었습니다.');
			
			setInterval(function(){
				console.log("들어왔니?");
				let mem_num = document.getElementById(e.getAttribute('id')).getAttribute('data-memnum');
				console.log(mem_num);
				let newRemain = 0;
				
				//컨트롤러에 mem_num 보내서 mem_ticket_hour값 가져오기
				$.ajax({
					url : '../seat/deadlineCheck.do',
					data : {mem_num : mem_num},
					type : 'post',
					dataType : 'json',
					success : function(param){
						if(param.result == 'success') {
							console.log(param.time);
							let remainTime = parseFloat(param.time);
							console.log(remainTime);
							newRemain =	parseFloat(remainTime) - parseFloat(60.0);	
							console.log(newRemain);
							
							$.ajax({
								url : '../seat/updateDeadline.do',
								data : {newRemain : newRemain},
								type : 'post',
								dataType : 'json',
								success : function(param){
									if(param.result == 'success') {
										alert('처리를 안해도되지만 굳이 껴넣음');
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
								location.href='../seat/select.do?seat_num=' + seat_num;
							}
						}else {
							alert('잔여시간 불러오기 오류 발생');
						}
					},
					error : function(){
						alert('NETWORK ERROR(getTime)');
					}
				});
				
				//newRemain 컨트롤러에 넘겨주기
				console.log(newRemain);

				
			}, 60000);
		}
	}
