var upoint;
var check_useP = 0;

$(function(){
	$.ajax({
	         url:'payPagePoint.do',
	         type:'post',
			 dataType:'json',
	         success:function(param){
	        	if(param.result == 'logout'){
					alert('로그인 후 이용해주세요');   
	        	}else if(param.result == 'success'){
	        		 $('#my_point').text(param.mypoint);
	        	}else{
	        		alert('오류 발생');
	        	}
	         },
	         error:function(){
	            console.log("네트워크 에러 발생");
	         }
	      });

	var mpoint;
	var fpoint;
	var tprice;
	var total;


	$('#minus_btn').on('click',function(){
		//보유중인 포인트
		mpoint = parseInt($('#my_point').text());
		
		check_useP = 1;
		
		if(mpoint >= 1000){//내 포인트가 1000 이상 있을 경우
			//사용할 포인트
			upoint = parseInt($('#use_point').val());
		
				if(upoint <= 1000){
					//남은 포인트
					fpoint = mpoint - upoint;
				
					//지불할 금액
					tprice = parseInt($('#final_price').text());
					
					//총 합계 금액
					total = tprice - upoint;
					
					$('#final_price').text(total.toLocaleString());		
					
					$('#my_point').text(fpoint.toLocaleString() + "P");
					
				}else{
					alert('1000P 부터 사용 가능합니다.');
					$('#use_point').val('').focus();
				}	
			}
	});
});



	
	var pname = $('#ticket_name').text();
	var pprice = $('#final_price').text();
	
	console.log("이름" + pname);
	console.log("금액" + pprice);
	
	IMP.init("imp36873723"); // 예: imp00000000
	
	var ajaxParam1 = {
		pay_price:$('#final_price').attr('data-pricenum'),
		pay_content:$('#ticket_name').attr('data-ticketname'),
		ticket_num:$('#ticket_num').attr('data-ticketnum'),
		pay_plan:1,
		point_point : -upoint
	}
	var ajaxParam2 = {
		pay_price:$('#final_price').attr('data-pricenum'),
		pay_content:$('#ticket_name').attr('data-ticketname'),
		ticket_num:$('#ticket_num').attr('data-ticketnum'),
		pay_plan:1,
		point_point : pprice * 0.05
	}
	
	function requestKakaoPay() {
		IMP.request_pay({
			pg : "kakaopay.TC0ONETIME",
			pay_method : "card",
			merchant_uid : "ourstudy_" + new Date().getTime(), // 주문번호
			name : pname,
			amount : pprice, // 숫자 타입
			buyer_email : "pandasticday@gmail.com",
			buyer_name : "박테스트",
		}, function(rsp) { // callback
			console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				alert(msg);
				
				$.ajax({
					url:'payResult.do',
					type:'post',
					/*data:{pay_price:$('#final_price').attr('data-pricenum'),
						  pay_content:$('#ticket_name').attr('data-ticketname'),
						  ticket_num:$('#ticket_num').attr('data-ticketnum'),
						  pay_plan:1},*/
					
				
					data: (check_useP == 1) ? ajaxParam1 : ajaxParam2,
					
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용하세요');
						}else if(param.result == 'success'){
							alert('결제 정보 저장됨');
						}else{
							alert('오류 발생');
						}
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});
				
				//location.href = "payList.do";
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
	}
	
	function requestCardPay() {
		IMP.request_pay({
			pg : "html5_inicis.INIpayTest",
			pay_method : "card",
			merchant_uid : "ourstudy_" + new Date().getTime(), // 주문번호
			name : pname,
			amount : pprice, // 숫자 타입
			buyer_email :'',
			
		}, function(rsp) { // callback	
			if (rsp.success) {
				
				var msg = '결제가 완료되었습니다.';
				alert(msg);
				
				$.ajax({
					url:'payResult.do',
					type:'post',
					data:{pay_price:$('#final_price').attr('data-pricenum'),
						  pay_content:$('#ticket_name').attr('data-ticketname'),
						  ticket_num:$('#ticket_num').attr('data-ticketnum'),
						  pay_plan:2},
					dataType:'json',
					success:function(param){
						if(param.result == 'logout'){
							alert('로그인 후 사용하세요');
						}else if(param.result == 'success'){
							alert('결제 정보 저장됨');
						}else{
							alert('오류 발생');
						}
					},
					error:function(){
						alert('네트워크 오류 발생');
					}
				});
				
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
		
	}
	