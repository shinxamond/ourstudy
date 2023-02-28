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

	var fpoint;
	var tprice;
	var total;
	

	$('#minus_btn').on('click',function(){
		//보유중인 포인트
		console.log($('#my_point').text());
		var mpoint = parseInt($('#my_point').text());
		
		if(mpoint >= 1000){//내 포인트가 1000 이상 있을 경우
			//사용할 포인트
			var upoint = parseInt($('#use_point').val());
		
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
				
				/*$.ajax({
				url:'payResult.do',
				type:'post',
				data:{pay_price:$(this).attr('data-pricenum'),
					  pay_content:$(this).attr('data-ticketname')}
				
				});*/
				
				//location.href = "payList.do";
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
		
		console.log("ticketname테스트 >>>> " + t_name + t_amount);
		
	}
	
	function requestKakaoPay() {
		IMP.request_pay({
			pg : "kakaopay.TC0ONETIME",
			pay_method : "card",
			merchant_uid : "ourstudy0009", // 주문번호
			name : pname,
			amount : pprice, // 숫자 타입
			buyer_email : "test1@gmail.com",
			buyer_name : "박테스트",
			buyer_tel : "010-4242-4242",
			buyer_addr : "서울특별시 강남구 역삼동",
			buyer_postcode : "01181"
		}, function(rsp) { // callback
			console.log(rsp);
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				alert(msg);
				
				$.ajax({
				url:'payResult.do',
				type:'post',
				data:{pay_price:$('#final_price').attr('data-pricenum'),
					  pay_content:$('#ticket_name').attr('data-ticketname'),
					  ticket_num:$('#ticket_num').attr('data-ticketnum'),
					  pay_plan:$('[name=pay_plan]').attr('data-payplan')},
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