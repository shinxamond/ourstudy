$(function(){
	
	//=================이메일 합치기==================
	$("#email_direct").hide();
	
	//이메일 앞부분
	$("#user_email").change(function(){
		email();
	});
	
	/* 하나로 만들고 싶은 기본 코드
	//이메일 뒷부분
	$("#email_address").change(function() {
		//직접입력 선택
		if($("#email_address").val() == "direct") {
			$("#email_direct").show();
		}else {
			$("#email_direct").hide();
		}
		email();
	});
	*/
	
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

});

