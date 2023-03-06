/*$("input:radio[name=lf_type]").change(function() {

		if($("#lf_type:checked").val() == "0"){

			$('input:radio[name=f_condition]').prop("disabled", false);

		} else if($("#lf_type:checked").val() == "1"){

			$('input:radio[name=f_condition]').prop("disabled", true);

		}

	});
	*/
$(document).ready(function(){
 
    // 라디오버튼 클릭시 이벤트 발생
    $("input:radio[name=lf_type]").click(function(){
 
        if($("input[name=lf_type]:checked").val() == "1"){
            $("input:radio[name=f_condition]").attr("disabled",false);
            // radio 버튼의 value 값이 1이라면 활성화
 
        }else if($("input[name=lf_type]:checked").val() == "0"){
              $("input:radio[name=f_condition]").attr("disabled",true);
            // radio 버튼의 value 값이 0이라면 비활성화
        }
    });
});