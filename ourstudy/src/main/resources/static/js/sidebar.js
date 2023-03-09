$(function(){
	//하나씩 id값 주기
	/*
	if($(location).attr('pathname')==$('#item-collapsed1').attr('href')){
		$('#item-collapse').addClass('show');
		$('#item-collapsed1').css({'background-color':'#f4abb2','color':'white'});
		console.log("클릭한 링크 : " + $('#item-collapsed1').attr('href'));
		console.log("현재 링크 : " + $(location).attr('pathname'));
	}
	if($(location).attr('pathname')==$('#item-collapsed2').attr('href')){
		$('#item-collapse').addClass('show');
		$('#item-collapsed2').css({'background-color':'#f4abb2','color':'white'});
		console.log("클릭한 링크 : " + $('#item-collapsed2').attr('href'));
		console.log("현재 링크 : " + $(location).attr('pathname'));
	}*/
	
	//일반
	for(i=-1; i<$('.btn-toggle-nav a').length-1; i++){
		if($(location).attr('pathname')==$('.btn-toggle-nav a').eq(i).attr('href')){
		initcollapse();
		$('.btn-toggle-nav a').eq(i).closest('div').addClass('show');
		$('.btn-toggle-nav a').eq(i).css({'background-color':'#f4abb2','color':'white'});
		console.log("클릭한 링크 : " + $('.btn-toggle-nav a').eq(i).attr('href'));
		console.log("현재 링크 : " + $(location).attr('pathname'));
		}
	}
	
	function initcollapse(){
		$('.collapse').removeClass('show');
		$('.btn-toggle-nav a').eq(i).css({'background-color':'','color':''});
	}
	
	//관리자
	
});
