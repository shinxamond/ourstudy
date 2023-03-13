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
                  $('#my_point').text(param.mypoint.toLocaleString() + "P");
              }else{
                 alert('오류 발생');
              }
            },
            error:function(){
               console.log("네트워크 에러 발생");
            }
         });

	/*
	var mpoint;
	var fpoint;
	var tprice;
	var total;


   $('#minus_btn').on('click',function(){
      //보유중인 포인트
	  var parsingPoint = $('#my_point').text().replace(/\D/g,'');
      mpoint = parseInt(parsingPoint); 
	  //사용할 포인트
      upoint = parseInt($('#use_point').val()); 
      
      if(mpoint >= 1000){//내 포인트가 1000 이상 있을 경우

		 check_useP = 1;
	
            if(upoint >= 1000){
               //남은 포인트
               fpoint = mpoint - upoint;
            
               //지불할 금액
               tprice = $('#final_price').attr('data-pricenum');
               
               if((tprice / 2) >= upoint){
					//총 합계 금액
               		total = tprice - upoint;
               
               		$('#final_price').text(total.toLocaleString()+"원");         
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
         }else if(mpoint < upoint){
			alert('보유하신 포인트보다 큰 숫자를 입력하셨습니다.');
			$('#use_point').val('').focus();
		 }else{
			alert('1000P 이상 보유 후 사용해주세요.');
			$('#use_point').val('').focus();
		}
   });*/
});

	var mpoint;
	var fpoint;
	var tprice;
	var total;
	
function minus(){
      //보유중인 포인트
	  var parsingPoint = $('#my_point').text().replace(/\D/g,'');
      mpoint = parseInt(parsingPoint);
	  //사용할 포인트
      upoint = parseInt($('#use_point').val());
      
      if(mpoint >= 1000){//내 포인트가 1000 이상 있을 경우

		 check_useP = 1;
	
            if(upoint >= 1000){
               //남은 포인트
               fpoint = mpoint - upoint;
            
               //지불할 금액
               tprice = $('#final_price').attr('data-pricenum');
               
               if((tprice / 2) >= upoint){
					//총 합계 금액
               		total = tprice - upoint;
               
               		$('#final_price').text(total.toLocaleString()+"원");      
               		$('#my_point').text(fpoint.toLocaleString() + "P");
				
					console.log("포인트>"  + upoint);
				}else{
						alert('결제 금액의 절반 이상 사용 불가합니다.');
               			$('#use_point').val('').focus();
				}
			}else if(upoint == ''){//포인트 미 사용 시 
				check_useP = 0;
				alert('입력하세요');
               	$('#final_price').text($('#ticket_total_price').val()); 
               	$('#my_point').text(mpoint.toLocaleString() + "P");

			}else{
               alert('1000P 부터 사용 가능합니다.');
               $('#use_point').val('').focus();
            }   
         }else if(mpoint < upoint){
			alert('보유하신 포인트보다 큰 숫자를 입력하셨습니다.');
			$('#use_point').val('').focus();
		 }else{
			alert('1000P 이상 보유 후 사용해주세요.');
			$('#use_point').val('').focus();
		}
}

   var pname = $('#ticket_name').text();
   var pprice = $('#final_price').text();
   var uname = $('#mem_name').attr('data-memname');   

   console.log("이름" + pname);
   console.log("금액" + pprice);
   console.log($('#p_point').text());

   IMP.init("imp36873723"); // 예: imp00000000
   
  function requestKakaoPay() {
   	var pprice = $('#final_price').attr('data-pricenum');
	var useP = document.getElementById('use_point');
	var f_price = pprice - useP.value;

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
         amount : f_price,
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
   
   function requestCardPay() {
		var pprice = $('#final_price').attr('data-pricenum');
		var useP = document.getElementById('use_point');
		var f_price = pprice - useP.value;

			    var ajaxParam1 = {
			      pay_price:$('#final_price').attr('data-pricenum'),
			      pay_content:$('#ticket_name').attr('data-ticketname'),
			      ticket_num:$('#ticket_num').attr('data-ticketnum'),
			      locker_num:$('#pay_kakao').attr('data-lockernum'),
			      pay_plan:2,
				  check_useP:1,
			      point_point : -useP.value
			   }
			    var ajaxParam2 = {
			      pay_price:$('#final_price').attr('data-pricenum'),
			      pay_content:$('#ticket_name').attr('data-ticketname'),
			      ticket_num:$('#ticket_num').attr('data-ticketnum'),
			      locker_num:$('#pay_kakao').attr('data-lockernum'),
			      pay_plan:2,
				  check_useP:0,
			      point_point : pprice * 0.05
			   }	
			     console.log(useP.value);
	
	 	 IMP.request_pay({
	         pg : "html5_inicis.INIpayTest",
	         pay_method : "card",
	         merchant_uid : "ourstudy_" + new Date().getTime(), // 주문번호
	         name : pname,
	         amount : f_price,
			 buyer_name : uname,
	         buyer_email :'',
	         
	      }, function(rsp) { // callback   
	         if (rsp.success) {
	            $.ajax({
	               url:'payResult.do',
	               type:'post',
	               data:(check_useP == 1) ? ajaxParam1 : ajaxParam2,
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