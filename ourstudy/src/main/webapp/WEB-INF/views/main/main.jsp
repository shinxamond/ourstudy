<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 메인 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/talk.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main/clock.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main/quotes.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/main/calrendar.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	var message = urlParams.get('msg');
	message = encodeURIComponent(message);
	
	if(message!='null'){
	window.onload = function() {
	    Swal.fire({
	    	imageUrl: '${pageContext.request.contextPath}/images/main.png',
	    	confirmButtonColor: '#E65962 ',
	    	imageWidth: 150,
	    	imageHeight: 150,
	        title: message,
	    })
	};
	
	}
	//막대 차트(구글차트 API)
	google.charts.load("current", {packages:['corechart']});
	google.charts.setOnLoadCallback(drawChart);
	
	
	function drawChart() {
	  var data = google.visualization.arrayToDataTable([
		['이름', '공부시간', {role: 'style'}],
	    <c:forEach var="studyTime" items="${studyTime}" begin="0" end="0">
	    ['${studyTime.mem_name}', Math.floor(${studyTime.total_time}/3600), 'fill-color:#384048;'],
	    </c:forEach>
	    <c:forEach var="studyTime" items="${studyTime}" begin="1" end="1">
	    ['${studyTime.mem_name}', Math.floor(${studyTime.total_time}/3600), 'fill-color:#fcf4e8;'],
	    </c:forEach>
	    <c:forEach var="studyTime" items="${studyTime}" begin="2" end="2">
	    ['${studyTime.mem_name}', Math.floor(${studyTime.total_time}/3600), 'fill-color:#E65962;'],
	    </c:forEach>
	    <c:forEach var="studyTime" items="${studyTime}" begin="3" end="3">
	    ['${studyTime.mem_name}', Math.floor(${studyTime.total_time}/3600), 'fill-color:#384048;'],
	    </c:forEach>
	    <c:forEach var="studyTime" items="${studyTime}" begin="4" end="4">
	    ['${studyTime.mem_name}', Math.floor(${studyTime.total_time}/3600), 'fill-color:#F4ABB2;'],
	    </c:forEach>
	  ]);
	
	  var view = new google.visualization.DataView(data);
	  view.setColumns([0, 1,
	                   { calc: "stringify",
	                     sourceColumn: 1,
	                     type: "string",
	                     role: "annotation" },
	                   2]);
	
	  var options = {
	  	width: 430,
		height: 350,
		bar: {groupWidth: "30%"},
		legend: { position: "none" },
		vAxis: {textPosition: 'none', viewWindow: {max: 20}},
			 chartArea:{left:15,top:20,width:"90%",height:"80%"}
		};
	var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
	chart.draw(view, options);
	}
	
</script>

<div id="main_content_body" class="container">
	<div class="row">
		<div class="main_banner col-xxl-8">
			<img src="${pageContext.request.contextPath}/image_bundle/newbanner4.PNG" class="newbanner1">
		</div>
		<div class="card main-right-card col-xxl-4" id="cal_card">
			<div class="sec_cal">
				<div class="cal_nav">
			    	<a href="javascript:;" class="nav-btn go-prev">prev</a>
			    <div class="year-month"></div>
			    	<a href="javascript:;" class="nav-btn go-next">next</a>
			 	</div>
			  	<div class="cal_wrap">
			    	<div class="days">
			      		<div class="day">MON</div>
			      		<div class="day">TUE</div>
			      		<div class="day">WED</div>
			     	 	<div class="day">THU</div>
			     	 	<div class="day">FRI</div>
			     	 	<div class="day">SAT</div>
			     	 	<div class="day">SUN</div>
			    	</div>
			    <div class="dates"></div>
			  </div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="card main_card" id="study_time">
			<span class="main-title" style="margin:15px 0 0px 10px;">주간 공부시간 랭킹 </span>
			<c:if test="${empty studyTime}">
				<div>표시할 데이터가 없습니다</div>
			</c:if> 
			
			<c:if test="${!empty studyTime}">
				<div id="columnchart_values"></div>
			</c:if>
		</div>
		<div class="card main_card" id="all_todo">
			<span class="main-title" style="margin:15px 0 18px 5px;">안내사항 </span>
			<table class="table table-hover table-group-divider table table-striped" id="info-table">
				<tr style="background-color:#F4ABB2;">
					<th class="align-center" id="main_info_title">제목</th>
					<th class="align-center" style="color:black;" id="main_info_date">작성일</th>
				</tr>
				<c:forEach var="info" items="${infoList}">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath}/info/infoDetail.do?info_num=${info.info_num}">${info.info_title}</a>
					</td>
					<td class="align-center">	
						${info.info_date}
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<div class="guitar">
			<div class="card main_card" id="study_clock">
				<div class="digital-clock"></div>
				
			</div>
			<div class="card main_card" id="study_maxim">
				<span class="main-title" style="margin:5px 0 25px 5px;">오늘의 한 마디</span>
				<div id="quote_author">
					<div id="quote"></div>
					<div id="author"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 메인 끝 -->