$(function(){
	//첫 이미지 세팅

	let photo_path = $('.profile-photo').attr('src');
	let my_photo; //업로드하고자하는 이미지 저장
	$('#upload').change(function(){
		my_photo = this.files[0];
		if(!my_photo){
			$('.profile-photo').attr('src', photo_path);
			return
		}
		
		if(my_photo.size > 1024*1024*5){
			alert(Math.round(my_photo.size/1024/5) 
			   + 'MB(5MB까지만 업로드 가능)');
			$('.profile-photo').attr('src',photo_path);
			$(this).val('');
			return;			
		}
		
		//이미지 미리보기 처리
		let reader = new FileReader();
		reader.readAsDataURL(my_photo);
		
		reader.onload = function(){
			$('.profile-photo').attr('src', reader.result);
			$('.my-photo').attr('src', reader.result);
		};
	});
	
	//서버에 데이터 전송
	$('#photo_submit').click(function(){
		if($('#upload').val() == ''){
			alert('프로필 이미지를 선택해주세요.');
			my_photo = photo_path;
			return;
		}
		
		//파일 전송
		let form_data = new FormData();
		form_data.append('upload',my_photo);
		$.ajax({
			url:'../mypage/updateProfileImg.do',
			data:form_data,
			type:'post',
			dataType:'json',
			contentType:false,
			enctype:'multipart/form-data',
			processData:false,
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 변경 가능합니다.');
				}else if(param.result == 'success'){
					alert('프로필 사진이 수정되었습니다.');
					//교체된 이미지 저장
					photo_path = $('.profile-photo').attr('src');
					$('#upload').val('');
					$('#profile-change').modal('hide');
					location.reload();
				}else{
					alert('파일 전송 중 오류가 발생했습니다.');
				}
			},
			error:function(){
				alert('네트워크 오류가 발생했습니다.');
			}
		});
	});
	
	//취소시
	$('#photo_reset').click(function(){
		$('.my-photo').attr('src',photo_path);
		$('.profile-photo').attr('src',photo_path);
		$('#upload').val('');
	});
});
