$(function(){
	for(i=0; i<$('.btn-toggle-nav a').length; i++){
		if($(location).attr('pathname')==$('.btn-toggle-nav a').eq(i).attr('href')){
			let thisAtt = $('.btn-toggle-nav a').eq(i);
			if(thisAtt.attr('data-ad-num') >= 4 && thisAtt.attr('data-ad-num') <= 9){
				thisAtt.parents('.side-bottom').find('button[data-type=ad]').trigger('click');	
				thisAtt.parents('.side-bottom').find('button[data-ad-num='+thisAtt.attr('data-ad-num')+']').trigger('click');	
				initcollapse();
				thisAtt.css({'background-color':'#f4abb2','color':'white'});	
			}else{
				initcollapse();
				thisAtt.parents('.side-bottom').find('button[data-ad-num]').trigger('click');
				thisAtt.css({'background-color':'#f4abb2','color':'white'});
			}
		}
	}
	
	function initcollapse(){
		$('.btn-toggle-nav a').eq(i).css({'background-color':'','color':''});
	}

});