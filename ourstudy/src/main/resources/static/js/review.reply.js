$(function(){
	let currentPage;
	let count;
	let rowCount;

	//textarea에 내용 입력시 글자수 체크
	$(document).on('keyup','textarea',function(){
		//입력한 글자수 구하기
		let inputLength = $(this).val().length;
		
		if(inputLength>300){//300자를 넘어선 경우
			$(this).val($(this).val().substring(0,300));
		}else{//300자 이하인 경우
			//남은 글자수 구하기
			let remain = 300 - inputLength;
			remain += '/300';
			if($(this).attr('id') == 'revw_content'){
				//등록 폼 글자수
				$('#re_first .letter-count').text(remain);
			}else{
				//수정 폼 글자수
				$('#mre_first .letter-count').text(remain);
			}
		}	
	});

	//댓글 등록
	$('#re_form').submit(function(event){
		//기본 이벤트 제거
		event.preventDefault();
		
		if($('#revw_content').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#revw_content').val('').focus();
			return false;
		}
		
		let form_data = $(this).serialize();
		$.ajax({
			url:'writeReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//등록된 데이터가 표시될 수 있도록 목록 갱신
					selectList(1);
				}
			},
			error:function(){
				alert('네트워크 오류 발생!');
			}
		});	
	});
	
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}	
			
	//댓글 목록
	function selectList(pageNum){
		currentPage = pageNum;
		
		//로딩 이미지 노출
		$('#loading').show();
		
		$.ajax({
			url:'listReply.do',
			type:'post',
			data:{pageNum:pageNum,r_num:$('#r_num').val()},
			dataType:'json',
			success:function(param){
				//로딩 이미지 감추기
				$('#loading').hide();
				count = param.count;
				rowCount = param.rowCount;
				
				if(pageNum == 1){
					//처음 호출시 해당 ID의 div의 내부 내용물 제거
					$('#output').empty();
				}
				
				//댓글 목록 작업
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					output += '<ul class="detail-info">';
					output += '<li>';
					output += '<img src="../mypage/viewProfile.do?mem_num='+item.mem_num+'" width="40" height="40" class="my-photo">';
					output += '</li>';					
					output += '<li style="margin-left:10px;"  id="reply_name">';
					if(item.mem_name){
						output += '<b>' + item.mem_name + '</b>';
					}
					if(item.revw_mdate){
						output += '<span class="modify-date">&nbsp;&nbsp;&nbsp;&nbsp;최근 수정일 : ' + item.revw_mdate + '</span>';
					}else{
						output += '<span class="modify-date">&nbsp;&nbsp;&nbsp;&nbsp;등록일 : ' + item.revw_date + '</span>';
					}
					output += '</li>';
					output += '</ul>';
					output += '<div class="sub-item">';
					output += '<p>' + item.revw_content.replace(/\r\n/g,'<br>') + '</p>';
					if(param.user_num == item.mem_num){
						output += '<div class="reply_btn"><button type="button" class="modify-btn btn btn-outline-pink" data-num="'+item.revw_num+'">수정</button>';
						output += '<button type="button" class="delete-btn btn btn-outline-pink" data-num="'+item.revw_num+'">삭제</button></div>';
					}
					output += '<hr size="1" width="90%" style="margin: 10px auto;" noshade>';
					output += '</div>';
					output += '</div>';
					
					//문서 객체에 추가
					$('#output').append(output);
				});
				
				//paging button 처리
				if(currentPage>=Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
					//다음 페이지가 존재
					$('.paging-button').show();
				}
			},
			error:function(){
				//로딩 이미지 감추기
				$('#loading').hide();
				alert('네트워크 오류 발생');
			}
		});
		
	}
	
	//다음 댓글 보기 버튼 클릭시 데이터 추가
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	
	//댓글 수정
	//댓글 수정 버튼 클릭시 수정폼 노출
	$(document).on('click','.modify-btn',function(){
		//댓글 글번호 
		let revw_num = $(this).attr('data-num');
		//댓글 내용
		let content = $(this).parent().parent().find('p').html().replace(/<br>/g,'\r\n');
		
		//댓글수정 폼 UI
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="revw_num" id="mre_num" value="'+revw_num+'">';
		modifyUI += '<div id="mre_first"><span class="letter-count">300/300</span></div>';
		
		modifyUI += '<div class="inner-text">';
		modifyUI += '<textarea class="form-control rep-content inner-text" name="revw_content" id="mre_content">'+content+'</textarea>';
		modifyUI += '</div>';
		
		modifyUI += '<div id="mre_second">';
		modifyUI += '<button type="submit" class="btn btn-outline-pink">수정</button>';
		modifyUI += '<button type="button" class="re-reset btn btn-outline-pink">취소</button>';
		modifyUI += '</div>';
		modifyUI += '</div>';
		modifyUI += '</form>';

		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면
		//숨김 sub-item을 환원시키고 수정 폼을 초기화함
		initModifyForm();
		//지금 클릭해서 수정하고자 하는 데이터는 감추기
		//수정버튼을 감싸고 있는 div
		$(this).parent().parent().hide();
		
		//수정폼을 수정하고자 하는 데이터가 있는 div에 노출
		$(this).parents('.item').append(modifyUI);
		
		//입력한 글자수 셋팅
		let inputLength = $('#mre_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);		
	});
	
	//수정폼에서 취소 버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	//댓글 수정 폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mre_form').remove();
	}
	
	//댓글 수정 처리
	$(document).on('submit','#mre_form',function(event){
		//기본 이벤트 제거
		event.preventDefault();
		
		if($('#mre_content').val().trim()==''){
			alert('내용을 입력하세요!');
			$('#mre_content').val('').focus();
			return false;
		}
		
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result == 'success'){
					//수정 데이터 표시
					$('#mre_form').parent().find('p')
					   .html($('#mre_content').val()
		                   .replace(/</g,'&lt;')
                           .replace(/>/g,'&gt;')
                           .replace(/\r\n/g,'<br>')
                           .replace(/\r/g,'<br>')
                           .replace(/\n/g,'<br>'));
					//최근 수정일 표시
					$('#mre_form').parent().find('.modify-date')
					                       .text('\u00A0'+'\u00A0'+'\u00A0'+'\u00A0'+'최근 수정일 : 5초 미만');
					//수정 폼 초기화
					initModifyForm();
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글은 수정할 수 없습니다.');
				}else{
					alert('댓글 수정시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
	});
	
	//댓글 삭제
	$(document).on('click','.delete-btn',function(){
		//댓글 번호
		let revw_num = $(this).attr('data-num');
		
		//서버와 통신
		$.ajax({
			url:'deleteReply.do',
			type:'post',
			data:{revw_num:revw_num},
			dataTpye:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('삭제 완료!');
					selectList(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('댓글 삭제시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	//초기 데이터(목록) 호출
	selectList(1);
	
});




