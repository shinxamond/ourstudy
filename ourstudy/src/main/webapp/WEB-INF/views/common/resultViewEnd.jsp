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
function WinClose(){
	
    window.open('about:blank','_self').close(); 
    window.opener=self;
    self.close(); 
}
window.onload = function() {
	let timerInterval;
	var a=5;
	Swal.fire({
	  title: '회원 탈퇴 완료',
	  imageUrl: '${pageContext.request.contextPath}/images/boom.png',
	  html: '------<h3></h3>------',
	  timer: 5000,
	  timerProgressBar: true,
	  didOpen: () => {
	    Swal.showLoading()
	    const b = Swal.getHtmlContainer().querySelector('h3')
	    timerInterval = setInterval(() => {
	      b.textContent = a--;
	    }, 1000)
	  },
	  willClose: () => {
	    clearInterval(timerInterval)
	  }
	}).then((result) => {
	  if (result.dismiss === Swal.DismissReason.timer) {
		  WinClose();
	  }
	})
};


     
</script>
<%-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
$("#delete_btn2").click(function () {
					    Swal.fire({
					      title: '정말로 삭제 하시겠습니까?',
					      text: "다시 되돌릴 수 없습니다. 신중하세요.",
					      icon: 'warning',
					      showCancelButton: true,
					      confirmButtonColor: '#3085d6',
					      cancelButtonColor: '#d33',
					      confirmButtonText: '삭제',
					      cancelButtonText: '취소',
					      reverseButtons: false, // 버튼 순서 거꾸로
					      
					    }).then((result) => {
					      if (result.isConfirmed) {//삭제 누르면 실행
					    	  location.replace('itemDelete.do?item_num=${itemVO.item_num}');
					      }
					    })
					  }); --%>