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
			   location.href='/main/main.do';
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
      
      if(mpoint >= 1000){//내 포인트가 1000 이상 있을 경우

		 check_useP = 1;
	
         //사용할 포인트
         upoint = parseInt($('#use_point').val());
			console.log("upoint1"+upoint);
            if(upoint >= 1000){
               //남은 포인트
               fpoint = mpoint - upoint;
            
               //지불할 금액
               tprice = parseInt($('#final_price').text());
               
               if((tprice / 2) >= upoint){
					//총 합계 금액
               		total = tprice - upoint;
               
               		$('#final_price').text(total);      
               		$('#my_point').text(fpoint.toLocaleString() + "P");

				
					console.log("포인트>"  + upoint);
				}else{
						alert('결제 금액의 절반 이상 사용 불가합니다.');
               			$('#use_point').val('').focus();
				}
               
            }else if(upoint == 0){
				check_useP = 0;
               	$('#final_price').text($('#ticket_total_price').val());   
               	$('#my_point').text(mpoint.toLocaleString() + "P");

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
   console.log($('#p_point').text());

   IMP.init("imp36873723"); // 예: imp00000000
   
  function requestKakaoPay() {
	$.ajax({
		url:'checkTicket.do',
		data:{ticket_num:$('#ticket_num').attr('data-ticketnum'),
			  mem_ticket_hour:$('#ticket_hour').attr('data-hournum'),
			  mem_ticket_term:$('#ticket_term').attr('data-termnum'),
			  ticket_type:$('#ticket_type').attr('data-typenum')},
		dataType:'json',
		success:function(param){
			if(param.result=='logout'){
				alert('로그인 후 이용해주세요');
				location.href='/main/main.do';
			}else if(param.result=="cantBuy"){
				alert('사용중인 이용권을 사용 후 구매 가능합니다.');
			}
			else if(param.result=='success'){
				
	//==============카카오페이 시작============//
   	var pprice = $('#final_price').text();
	var useP = document.getElementById('use_point');

   var ajaxParam1 = {
      pay_price:$('#final_price').attr('data-pricenum'),
      pay_content:$('#ticket_name').attr('data-ticketname'),
      ticket_num:$('#ticket_num').attr('data-ticketnum'),
      locker_num:$('#pay_kakao').attr('data-lockernum'),
      pay_plan:1,
	  check_useP:1,
      point_point : -useP.value
   }
   var ajaxParam2 = {
      pay_price:$('#final_price').attr('data-pricenum'),
      pay_content:$('#ticket_name').attr('data-ticketname'),
      ticket_num:$('#ticket_num').attr('data-ticketnum'),
      locker_num:$('#pay_kakao').attr('data-lockernum'),
      pay_plan:1,
	  check_useP:0,
      point_point : pprice * 0.05
   }	
    console.log(useP.value);
	
      IMP.request_pay({
         pg : "kakaopay.TC0ONETIME",
         pay_method : "card",
         merchant_uid : "ourstudy_" + new Date().getTime(), // 주문번호
         name : pname,
         amount : pprice,
      }, function(rsp) { // callback
         console.log(rsp);
         if (rsp.success) {            
            $.ajax({
               url:'payResult.do',
               type:'post',
               data: (check_useP == 1) ? ajaxParam1 : ajaxParam2,
               dataType:'json',
               success:function(param){
                  if(param.result == 'logout'){
                     alert('로그인 후 사용하세요');
					 location.href='/main/main.do';
                  }else if(param.result == 'success'){
                     alert('결제 완료 되었습니다');
					 location.href='/main/main.do';
                  }else if(param.result == 'inUse'){
					alert('사물함 기간이 연장되었습니다.');
					location.href='/main/main.do';
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
     //==============카카오페이 끝============//
			}else{
				alert('오류 발생');
			}
		},
		error:function(){
			alert('네트워크 오류');
		}
	});
  }

   function requestCardPay() {
   		$.ajax({
		url:'checkTicket.do',
		data:{ticket_num:$('#ticket_num').attr('data-ticketnum'),
			  mem_ticket_hour:$('#ticket_hour').attr('data-hournum'),
			  mem_ticket_term:$('#ticket_term').attr('data-termnum')},
		dataType:'json',
		success:function(param){
			if(param.result=='logout'){
				alert('로그인 후 이용해주세요');
				location.href='/main/main.do';
			}else if(param.result=="cantBuy"){
				alert('사용중인 이용권을 사용 후 구매 가능합니다.');
			}
			else if(param.result=='success'){
				//============카드 결제=============//
				var pprice = $('#final_price').text();
				var name = $('#mem_name').attr('user.mem_name');
		     	 IMP.request_pay({
			         pg : "html5_inicis.INIpayTest",
			         pay_method : "card",
			         merchant_uid : "ourstudy_" + new Date().getTime(), // 주문번호
			         name : pname,
			         amount : pprice,
					 buyer_name : name,
			         buyer_email :'',
			         
			      }, function(rsp) { // callback   
			         if (rsp.success) {
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
								 location.href='/main/main.do';
			                  }else if(param.result == 'success'){
			                     alert('결제 완료 되었습니다');
								 location.href='/main/main.do';
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
   		}
	});
}