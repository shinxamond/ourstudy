
/*==============================
		좌석 선택 확인 alert
  =============================*/
	function checkSelect(e){
		let seat_name = document.getElementById(e.getAttribute('id')).getAttribute('id');
		let seat_num = document.getElementById(e.getAttribute('id')).getAttribute('data-seatnum');
		let mem_num = document.getElementById(e.getAttribute('id')).getAttribute('data-memnum');
		
		
		let select = confirm(seat_name + '번 좌석을 선택할까요?');
		console.log(seat_num);
		
		if(select == false){
			alert('좌석 선택이 취소되었습니다');
		}else if(select == true){
			alert(seat_name + '번 좌석이 선택되었습니다.');
			//sessionStorage.setItem("mem_numForSeatTime", mem_num);
			location.href='../seat/select.do?seat_num=' + seat_num;
			//입실이 되었을 때 시간이 가게한다. 근데 이제.. 어떤 페이지에서도 적용이 되도록.
			//일단 필요한 데이터 : mem_num -> seatForm.jsp에서 받아올것
			//입실이 된 순간부터 시작해야됨 -> seat.js에서 받아올 것
			//입실이 딱 승인 된 순간부터 세션에 뭔가 하나를 남겨 sidebar setInterval 함수가 그 세션에 담긴 데이터를 보고 동작
			//if(isSelect == 'selectOK'){셋인터벌 실행} no {}

			 // 저장
			//console.log(sessionStorage.getItem("isSelect"));	// mineItRecord
			//sessionStorage.removeItem("mineSession"); // 삭제
			
		}
	}
