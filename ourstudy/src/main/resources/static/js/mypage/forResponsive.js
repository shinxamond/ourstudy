var status = 0;
$(function(){
	let mem_statusForCheckIn = $('.setCheckInStatus').attr('id');
	let mem_numForCheckIn = $('.setCheckInMemnum').attr('id');
	let seat_numForCheckIn = $('.setCheckSeatNum').attr('id');

	
	if(mem_statusForCheckIn != ''){
		sessionStorage.setItem("isSelect", mem_statusForCheckIn);
	}
	if(mem_numForCheckIn != '') {
		sessionStorage.setItem("isSelectMemnum", mem_numForCheckIn);
	}
	if(seat_numForCheckIn != '') {
		sessionStorage.setItem("isSelectSeatnum", seat_numForCheckIn);
	}


	var mem_main = $('.mypage_mem_info_main').clone();
	var mem_info = $('.mypage_mem_info').clone();
	var mem_modify = $('.mypage_mem_info_modify').clone();
	var mem_delete = $('.mypage_mem_delete').clone();
	var mem_changePw = $('.mypage_mem_changePasswd').clone();
	var mem_pointList = $('.mypage_mem_pointList').clone();
	var mem_studyTime = $('.mypage_mem_studyTime').clone();
	var mem_selectSeat = $('.mypage_mem_selectSeat').clone();
	
	
	var windowWidth = $( window ).width();
		if(windowWidth >= 992){
		$('#insert_content_info').remove();
		$('#insert_content_time').remove();
		$('#insert_content_point').remove();
	}
	
	let delay = 300;
	let timer = null;
	
	$(window).resize(function(){
		var windowWidth = $( window ).width();
		if(windowWidth >= 992){
		$('#insert_content_info').remove();
		$('#insert_content_time').remove();
		$('#insert_content_point').remove();
		}else{
			if(localStorage.getItem("status") == "showMem_info" ){
				mem_info.appendTo($('#insert_content_info'));
				$('.mypage_mem_info').eq(1).remove();			
			}else if(localStorage.getItem("status") == "showMem_studyTime" ){
				mem_studyTime.appendTo($('#insert_content_time'));
				$('.mypage_mem_studyTime').eq(1).remove();		
			}else if(localStorage.getItem("status") == "showMem_point" ){
				mem_pointList.appendTo($('#insert_content_point'));
				$('.mypage_mem_pointList').eq(1).remove();	
			}else if(localStorage.getItem("status") == "showMem_modify" ){
				mem_modify.appendTo($('#insert_content_info'));
				$('.mypage_mem_info_modify').eq(1).remove();
			}else if(localStorage.getItem("status") == "showMem_changePw" ){
				mem_changePw.appendTo($('#insert_content_info'));
				$('.mypage_mem_changePasswd').eq(1).remove();
			}else if(localStorage.getItem("status") == "showMem_delete" ){
				mem_delete.appendTo($('#insert_content_info'));
				$('.mypage_mem_delete').eq(1).remove();
			}
		}
	});
	
	$(window).on('resize', function(){
	clearTimeout(timer);
	timer = setTimeout(function(){
        location.reload();
	}, delay);
});

	/*마이페이지 메인 호출시*/
	if($('#mypage_mem_info_main').val() > 0){
		var windowWidth = $( window ).width();
		if(windowWidth < 992){
			localStorage.setItem("status", "showMain");

		}else{
			$('#insert_content_info').remove();
			$('#insert_content_time').remove();
			$('#insert_content_point').remove();
		}
	}
	if(localStorage.getItem("status") == "showMain"){
		localStorage.setItem("status", 0);
	}		
	/*마이페이지 회원정보 호출시*/
	$('#mem_info_btn').click(function(){
		localStorage.setItem("status", "showMem_info");
	});
	if(localStorage.getItem("status") == "showMem_info"){
		if($( window ).width() < 992){
			mem_info.appendTo($('#insert_content_info'));
			$('.mypage_mem_info').eq(1).remove();
		}
	}
		
	/*마이페이지 공부시간 호출시*/
	$('#mem_studyTime_btn').click(function(){
		localStorage.setItem("status", "showMem_studyTime");
	});
	if(localStorage.getItem("status") == "showMem_studyTime"){
		if($( window ).width() < 992){
			mem_studyTime.appendTo($('#insert_content_time'));
			$('.mypage_mem_studyTime').eq(1).remove();
		}
	}
	

	/*마이페이지 포인트 호출시*/
	$('#mem_point_btn').click(function(){
		localStorage.setItem("status", "showMem_point");
	});		
	if(localStorage.getItem("status") == "showMem_point"){
		if($( window ).width() < 992){
			mem_pointList.appendTo($('#insert_content_point'));
			$('.mypage_mem_pointList').eq(1).remove();			
		}
	}	
	
	/*마이페이지 정보수정 호출시*/
	$('#mem_modify_btn').click(function(){
		localStorage.setItem("status", "showMem_modify");
	});
	if(localStorage.getItem("status") == "showMem_modify"){
		if($( window ).width() < 992){
			mem_modify.appendTo($('#insert_content_info'));
			//$('.mypage_mem_info_modify').eq(1).css('display', 'none');
			$('.mypage_mem_info_modify').eq(1).remove();
		}
	}	
	
	/*마이페이지 비밀번호변경 호출시*/
	$('#mem_changePw_btn').click(function(){
		localStorage.setItem("status", "showMem_changePw");
	});
	if(localStorage.getItem("status") == "showMem_changePw"){
		if($( window ).width() < 992){
			mem_changePw.appendTo($('#insert_content_info'));
			//$('.mypage_mem_changePasswd').eq(1).css('display', 'none');
			$('.mypage_mem_changePasswd').eq(1).remove();
		}
	}
	
	/*마이페이지 회원탈퇴 호출시*/
	$('#mem_delete_btn').click(function(){
		localStorage.setItem("status", "showMem_delete");
	});
	if(localStorage.getItem("status") == "showMem_delete"){
		if($( window ).width() < 992){
			mem_delete.appendTo($('#insert_content_info'));
			//$('.mypage_mem_delete').eq(1).css('display', 'none');
			$('.mypage_mem_delete').eq(1).remove();
		}
	}					
});