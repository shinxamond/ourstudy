<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	alert('${message}');
	location.href='${url}';
</script> 원래 코드 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
window.onload = function() {
    Swal.fire({
    	imageUrl: '${pageContext.request.contextPath}/images/main.png',
    	imageWidth: 250,
    	imageHeight: 250,
        title: '${message}',
        
    }).then((result) => {
        if (result.isConfirmed) {
            // 확인 버튼을 클릭한 경우 페이지 이동을 수행합니다.
            location.href = '${url}';
        }
    });
};
     
</script>