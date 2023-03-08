
/*==============================
		사물함 선택 확인 alert
  =============================*/
    function checkSelect(e) {
    	locker_num = document.getElementById(e.getAttribute('id')).getAttribute('id');
    	
    	let select = confirm(locker_num +'번 사물함을 선택할까요?');
    	
    	if(select == false) {
    		alert('사물함 선택이 취소되었습니다.');
    	}else if(select == true){
    		alert(locker_num + '번 사물함이 선택되었습니다.');
    		
    		location.href='/locker/select.do?locker_num=' + locker_num;
    	}
    }
    
    function hello() {
    	alert('이미 사물함을 이용중입니다.'); 
    	
    	location.href="/mypage/myPageMain.do";
    }