<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 중앙 컨텐츠 시작 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Leckerli+One&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/memberRegister.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirmId.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/makeEmail.js"></script>
<script>

$(document).on("keyup", ".mem_phone", function() {
	$(this).val($(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/, "$1-$2-$3" ).replace("--", "-")); 
});
function numberphone(e){
	if(e.value.length>13){
		e.value=e.value.slice(0,13);
	}
}

</script>
<div class="register-body">
<div class="register-container" id="register-container">
	<div class="form-container sign-up-container">
	<form:form action="registerUser.do" id="register_form" modelAttribute="memberVO">
		<br>
		<img src="${pageContext.request.contextPath}/image_bundle/logo.png" style="width:150px; height:145px;">
		<br>
		
		<form:errors element="div" cssClass="error-color"/>
		
			<label for="mem_id">아이디</label>
			<form:input path="mem_id" autocomplete="off"/>
			<input type="button" id="confirmId" value="아이디 중복체크">
			<span id="message_id"></span> <!-- js를 위한 span 태그 -->
			<form:errors path="mem_id" cssClass="error-color"/> <!-- 에러문구 -->
			<br>
			
			<label for="mem_pw">비밀번호</label>
			<form:password path="mem_pw"/>
			<form:errors path="mem_pw" cssClass="error-color"/>
			<br>
			
			<label for="pw_confirm">비밀번호 확인</label>
			<form:password path="pw_confirm"/>
			<span id="confirmMsg"></span>
			<br>
			
			<label for="mem_name">이름</label>
			<form:input path="mem_name"/>
			<form:errors path="mem_name" cssClass="error-color"/>
			<br>
			
			<label for="user_email">본인확인 이메일</label>
			<input type="text" id="user_email" required>
			<span id="middle">@</span>
			<select id="email_address" name="email_address" title="이메일 선택" class="email_address">
				<option value="naver.com">naver.com</option>
				<option value="gmail.com">gmail.com</option>
				<option value="daum.net">daum.net</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="nate.com">nate.com</option>
				<option value="direct">직접입력</option>
			</select>
				<input type="text" id="email_direct" name="email_direct"/>
				<input type="hidden" id="mem_email" name="mem_email" value="">
			<br>
			
			<%--=======================이메일 인증코드 구현 시작========================  --%>

			<div class="input-group-addon">
				<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
			</div>
			<div class="mail-check-box">
				<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
			</div>
			<span id="mail-check-warn"></span>
			<br>
			 <%-- =======================이메일 인증코드 구현 끝========================  --%>
			
			<label for="phone">전화번호</label>
			<form:input path="mem_phone" oninput="numberphone(this)" class="mem_phone" maxlength="13" placeholder="숫자만 입력하세요"/>
			<form:errors path="mem_phone" cssClass="error-color"/>
			<br>

			<label for="zipcode">우편번호</label>
			<form:input path="mem_zipcode"/>
			<input type="button" onclick="execDaumPostcode()" value="우편번호찾기">
			<form:errors path="mem_zipcode" cssClass="error-color"/>
			<br>

			<label for="address1">주소</label>
			<form:input path="mem_address1"/>
			<form:errors path="mem_address1" cssClass="error-color"/>
			<br>
			
			<label for="address2">상세주소</label>
			<form:input path="mem_address2"/>
			<form:errors path="mem_address2" cssClass="error-color"/>
			<br><br>
			
			<form:button id="register-submit">전송</form:button>
	</form:form>
	</div>
</div>
</div>
<!-- 우편번호 검색 시작 -->
<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('mem_zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("mem_address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("mem_address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
<!-- 우편번호 검색 끝 -->

<!-- 중앙 컨텐츠 끝 -->

