$(function(){
	for(i=0; i<$('.btn-toggle-nav a').length; i++){
		if($(location).attr('pathname')==$('.btn-toggle-nav a').eq(i).attr('href')){
			//관리자 체크
			if($('.btn-toggle-nav a').eq(i).attr('data-ad-num') == $('.btn-toggle-nav a').eq(i).parents('.side-bottom').find('button').attr('data-ad-num')){
				if($('.btn-toggle-nav a').eq(i).parents('.side-bottom').find('button[data-ad-num]').attr('data-ad-num') == 4 && $('.btn-toggle-nav a').eq(i).parents('.side-bottom').find('button[data-ad-num]').attr('data-ad-num') == 7){
					$('.btn-toggle-nav a').eq(i).parents('.side-bottom').find('button[data-type=ad]').trigger('click');	
					$('.btn-toggle-nav a').eq(i).parents('.side-bottom').find('button[data-ad-num='+$('.btn-toggle-nav a').eq(i).parents('.side-bottom').find('button').attr('data-ad-num')+']').trigger('click');	
					initcollapse();
					$('.btn-toggle-nav a').eq(i).css({'background-color':'#f4abb2','color':'white'});	
				}else{
					initcollapse();
					$('.btn-toggle-nav a').eq(i).parents('.side-bottom').find(button[data-ad-num]).trigger('click');
					$('.btn-toggle-nav a').eq(i).css({'background-color':'#f4abb2','color':'white'});
				}
			}
		}
	}
	
	function initcollapse(){
		$('.btn-toggle-nav a').eq(i).css({'background-color':'','color':''});
	}

});