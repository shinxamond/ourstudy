
/*==============================
		좌석 선택 확인 alert
  =============================*/
	function checkSelect(e){
		let seat_name = document.getElementById(e.getAttribute('id')).getAttribute('id');
		let seat_num = document.getElementById(e.getAttribute('id')).getAttribute('data-seatnum');
		
		let select = confirm(seat_name + '번 좌석을 선택할까요?');
		
		if(select == false){
			alert('좌석 선택이 취소되었습니다');
			return false;
		}else if(select == true){
			alert(seat_name + '좌석이 선택되었습니다.');
			let locker = confirm('사물함을 등록할까요?');
		
			if(locker == false){
				//replace, href 중 선택
				//(이전으로 못돌아감, 돌아갈 수 있음)
				location.href='select.do?seat_num=' + seat_num;
			}else if(locker == true){
				location.href='/locker/section.do';
			}
		}
		
	}
	