$(function(){
	for(i=0; i<$('.btn-toggle-nav a').length; i++){
		if($(location).attr('pathname')==$('.btn-toggle-nav a').eq(i).attr('href')){
			initcollapse();
			$('.btn-toggle-nav a').eq(i).parents('.side-bottom').find('button').trigger('click');
			$('.btn-toggle-nav a').eq(i).css({'background-color':'#f4abb2','color':'white'});
		}
	}
	
	function initcollapse(){
		$('.btn-toggle-nav a').eq(i).css({'background-color':'','color':''});
	}

});