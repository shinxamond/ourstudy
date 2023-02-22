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
				email2();
			});
		}else{
			$("#email_direct").hide();
			email();
		}
	});
	
	function email(){
		let email = $("#user_email").val();
		let middle = $("#middle").text();
		let address = $("#email_address").val();
		if(email!='' && address!=''){
			$("#mem_email").val(email+middle+address);
		}
	};
	
	function email2(){
		let email = $("#user_email").val();
		let middle = $("#middle").text();
		let address = $("#email_direct").val();
		if(email!='' && address!=''){
			$("#mem_email").val(email+middle+address);
		}
	};
	
	//=============비밀번호 확인===============
	$("#pw_confirm").focusout(function(){
		let mem_pw = $("#mem_pw").val();
		let pw_confirm = $("#pw_confirm").val();
		
		if(mem_pw != pw_confirm){
			$("#confirmMsg").text("비밀번호가 일치하지 않습니다.");
		}else{
			$("#confirmMsg").text("비밀번호가 일치합니다.");
		}
	});



	//============이메일 인증코드==============
	$('#mail-Check-Btn').click(function() {
		$("#email_address").change(function() {
			if($("#email_address").val() == "direct"){
				$("#email_direct").show();
				$(document).on('keyup','#email_direct',function(){
					email2();
				});
			}else{
				$("#email_direct").hide();
				email();
			}
		});
		
		
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
	// blur -> focus가 벗어나는 경우 발생
	$('.mail-check-input').blur(function () {
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

});

