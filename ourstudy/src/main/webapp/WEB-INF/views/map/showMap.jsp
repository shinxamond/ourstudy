<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>오시는길</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=tbqq0xtoiu"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/map.css">
</head>
<body>
			<div class="location_con01">
				<div class="inner">
					<div class="sub_tit">
						<h3>오시는길</h3>
						<h4 class="mont"><b>D</b>irections</h4>
					</div><br>
					<div class="sub_map" id="map" style="width:70%;height:400px;"></div>
					<dl>
						<dd style="width:70%; margin:0 auto;">
							<div class="bot" style="display:inline;">
								<h5>
									<img src="${pageContext.request.contextPath}/image_bundle/location_con01_icon01.png" alt="icon" />
									지하철 이용시
								</h5>
								<ul>
									<li>
										<h6>
											<span class="col01">2호선</span>
											역삼역
										</h6>
										<p>3번출구 도보3분 거리</p>
									</li>
									<li>
										<h6>
											<span class="col01">2호선</span>
											강남역
										</h6>
										<p>1번출구 도보5분 거리</p>
									</li>
								</ul>
								<h5>
									<img src="${pageContext.request.contextPath}/image_bundle/location_con01_icon02.png" alt="icon" />
									버스 이용시
								</h5>
								<ul>
									<li class="w85">
										<h6>
											역삼역 하차
										</h6>
										<p>N13, N61, 146,341, 360, 740, 6000, 6020,1100, 1700, 2000, 2000-1, 7007, 8001</p>
									</li>
								</ul>
							</div>	
						</dd>
					</dl>
				</div>
			</div>
<script>
var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.499340971211275 , 127.03327632815363),
    zoom: 14,
    minZoom: 6,
    mapTypeId: naver.maps.MapTypeId.NORMAL,
    zoomControl: true,
    zoomControlOptions: {
        position: naver.maps.Position.TOP_RIGHT
    },
    mapTypeControlOptions: {
        style: naver.maps.MapTypeControlStyle.BUTTON,
        position: naver.maps.Position.TOP_RIGHT
    },   
    mapDataControl: false,
    logoControlOptions: {
        position: naver.maps.Position.LEFT_BOTTOM
    },
    disableKineticPan: false
});
//마커표시
var urlMarker = {
	    position: new naver.maps.LatLng(37.499340971211275, 127.03327632815363),
	    map: map,
		title: 'urlMarker',
		animation: naver.maps.Animation.DROP,
	    icon: {
	        url: '${pageContext.request.contextPath}/image_bundle/whitelogo.png',
	        size: new naver.maps.Size(50, 50),
	        scaledSize: new naver.maps.Size(40, 40),
	        origin: new naver.maps.Point(0, 0),
	        anchor: new naver.maps.Point(11, 35)
	    }
	};

var Marker = new naver.maps.Marker(urlMarker);
naver.maps.Event.addListener(Marker, 'click', function() {
    if (Marker.getAnimation() !== null) {
        Marker.setAnimation(null);
    } else {
        Marker.setAnimation(naver.maps.Animation.BOUNCE);
    }
});

var semaphore = false;

naver.maps.Event.once(map, 'init', function() {
    map.setOptions({
        mapTypeControl: true,
        scaleControl: false,
        logoControl: false
    });    
});                                          
</script>
</body>
</html>