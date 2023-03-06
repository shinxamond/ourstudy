$(function(){
	ham = false;
	$('#trigger1').click(function(){
		if(ham){
			ham=false;
			$('#main-sidebar').animate({left:"0px"},600);
			$('#trigger1').animate({left:"160px"},600);
		}else{
			ham=true;
			$('#main-sidebar').animate({left:"-250px"},600);
			$('#trigger1').animate({left:"-90px"},600);
		}
	});
	
	$('#trigger2').click(function(){
		if(ham){
			ham=false;
			$('#main-sidebar').animate({left:"0px"},600);
			$('#trigger2').animate({left:"20px"},600);
		}else{
			ham=true;
			$('#main-sidebar').animate({left:"250px"},600);
			$('#trigger2').animate({left:"430px"},600);
		}
	});
});

