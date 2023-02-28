$(function(){
	//삭제 시 전체 선택
	$('#chk_all').on('click',function(){
		if($('#chk_all').is(':checked')){
			$('.choice-btn').prop('checked',true);
			$('#del_btn').prop('disabled',false);
		}else{
			$('.choice-btn').prop('checked',false);
			$('#del_btn').prop('disabled',true);
		}
	});
	$('.choice-btn').on('click',function(){
		if($('input[class=choice-btn]:checked').length
							== $('.choice-btn').length){
			//전체 체크박스 선택
			$('#chk_all').prop('checked',true);
			$('#del_btn').prop('disabled',false);
		}else{
			//부분 체크박스 선택
			$('#chk_all').prop('checked',false);
			$('#del_btn').prop('disabled',false);
		}
	});
	
	$('.del-btn').on('click',function(){
		$.ajax({
			url:'deleteTicket.do',
			type:'post',
			data:{ticket_num:$(this).attr('data-ticketnum')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 사용하세요!');
				}else if(param.result == 'success'){
					alert('선택한 상품을 삭제했습니다.');
					location.href="admin_ticketList.do";
				}else{
					alert('이용권 삭제 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
});