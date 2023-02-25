$(function(){
	
	//=================이메일 합치기==================
	$("#email_direct").hide();
	
	//이메일 앞부분
	$("#user_email").change(function(){
		email();
	});

	$("#email_address").change(function() {
	if($("#email_address").val() == "direct"){
		$("#email_direct").show();
		$(document).on('keyup','#email_direct',function(){
			email();
		});
	}else{
		$("#email_direct").hide();
		email();
	}
	});
	
	$('#register_form').submit(function(){
		
		if($("#email_address").val()=="direct"){
			if($('#email_direct').val()==''){
				$("#email_direct").show();
				$('#email_direct').val('').focus();
				return false;
			}
		}
		
		if($('#mem_pw').val()==''){
			$('#mem_pw').val('').focus();
			$("#message_pw").text("비밀번호 필수입력");
			return false;
		}
		
	});
	
	
	//합치기
	function email(){
		let email = $("#user_email").val();
		let middle = $("#middle").text();
		var address;
		if($("#email_address").val()=="direct"){
			address = $("#email_direct").val();
		}else{
			address = $("#email_address").val();
		}
		
		if(email!='' && address!=''){
			$("#mem_email").val(email+middle+address);
		}
	};
	
	
	//============이메일 인증코드==============
	$('#mail-Check-Btn').click(function() {
		const email = $('#mem_email').val();
		console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
		const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
		
		$.ajax({
			type : 'get',
			url : '../mailCheck?email='+email, // GET방식이라 Url 뒤에 email 붙임
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code =data;
				alert('인증번호가 전송되었습니다.')
			}			
		});
				
	}); // end send eamil

	// 인증번호 비교 
	$('.mail-check-input').keyup(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#mail-check-warn');
		
		if(inputCode === code){
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
		}else{
			$resultMsg.html('인증번호가 불일치 합니다.');
			$resultMsg.css('color','red');
			
		}
	});

	
	//=============비밀번호 확인===============
	$("#mem_pw,#pw_confirm").keyup(function(){
		let mem_pw = $("#mem_pw").val();
		let pw_confirm = $("#pw_confirm").val();
		
		if(mem_pw=='' && pw_confirm==''){
			$("#confirmMsg").text("");
			return;
		}
		
		if(mem_pw!='' && pw_confirm!=''){
			if(mem_pw == pw_confirm){
				$("#confirmMsg").text("비밀번호 일치");
				return;
			}
			if(mem_pw != pw_confirm){
				$("#confirmMsg").text("비밀번호 불일치");
				return;
			}
		}
	});
	
});

	

