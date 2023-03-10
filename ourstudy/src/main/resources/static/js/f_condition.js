$(document).ready(function(){
  $("input:radio[name=lf_type]").click(function(){
    if($("input[name=lf_type]:checked").val() == "1"){
      $("input:radio[name=f_condition]").attr("disabled",false);
    }else if($("input[name=lf_type]:checked").val() == "0"){
      $("input:text[name=lf_type]").attr("disabled",true);
    }
  });
});