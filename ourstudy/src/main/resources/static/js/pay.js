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

	$('#minus_btn').on('click',function(){
		//보유중인 포인트
		console.log($('#my_point').text());
		var mpoint = parseInt($('#my_point').text());
		
		//사용할 포인트
		if(mpoint >= 1000){
		var upoint = parseInt($('#use_point').val());
		
		//남은 포인트
		var fpoint = mpoint - upoint;
		
		//지불할 금액
		var tprice = parseInt($('#final_price').text());
		
		//총 합계 금액
		var total = tprice - upoint;
		
		$('#final_price').text(total.toLocaleString() + "원");		
		
		$('#my_point').text(fpoint.toLocaleString() + "P");
		}else{
			alert('1000P 부터 사용 가능합니다.');
			$('#use_point').val('').focus();
		}	
	});
});

IMP.init("imp36873723"); // 예: imp00000000 

	function requestCardPay() {
		IMP.request_pay({
			pg : "html5_inicis.INIpayTest",
			pay_method : "card",
			merchant_uid : "s0005", // 주문번호
			name : "독서실 4주 이용권",
			amount : 100, // 숫자 타입
			buyer_email : "test2@gmail.com",
			buyer_name : "이테스트",
			buyer_tel : "010-4242-4242",
			buyer_addr : "서울특별시 강남구 역삼동",
			buyer_postcode : "01181"
		}, function(rsp) { // callback
			$.ajax({
				url:'../pay/payPage.do',
				type:'post',
				
			});
			
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				alert(msg);
				location.href = "payList.do";
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
			merchant_uid : "ourstudy0007", // 주문번호
			name : "독서실 100시간 이용권",
			amount : 100000, // 숫자 타입
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
				location.href = "payList.do";
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
	}