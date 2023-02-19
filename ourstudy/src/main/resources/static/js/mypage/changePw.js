$(function(){
	
	//===비밀번호 변경 체크===//
	$('#mem_pw').keyup(function(){
		if($('#confirm_passwd').val()!='' && 
		    $('#confirm_passwd').val()!=$(this).val()){
			$('#message_id').text('비밀번호 불일치')
			                .css('color','red');
		}else if($('#confirm_passwd').val()!='' &&
		     $('#confirm_passwd').val()==$(this).val()){
			 $('#message_id').text('비밀번호 일치')
		                     .css('color','#000');
		}
	});
	
	$('#confirm_passwd').keyup(function(){
		if($('#mem_pw').val()!='' && 
		    $('#mem_pw').val()!=$(this).val()){
			$('#message_id').text('비밀번호 불일치')
			                .css('color','red');
		}else if($('#mem_pw').val()!='' &&
		     $('#mem_pw').val()==$(this).val()){
			 $('#message_id').text('비밀번호 일치')
		                     .css('color','#000');
		}
	});
	
	$('#myPagechangePasswd_form').submit(function(){
		if($('#now_passwd').val().trim()==''){
			alert('현재 비밀번호를 입력하세요.');
			$('#now_passwd').val('').focus();
			return false;
		}
		if($('#mem_pw').val().trim()==''){
			alert('새비밀번호를 입력하세요.');
			$('#mem_pw').val('').focus();
			return false;
		}
		if($('#confirm_passwd').val().trim()==''){
			alert('비밀번호 확인을 입력하세요.');
			$('#confirm_passwd').val('').focus();
			return false;
		}
		if($('#mem_pw').val()!=$('#confirm_passwd').val()){
			$('#message_id').text('비밀번호 불일치')
			                .css('color','red');
            return false;
		}
	});
		
});