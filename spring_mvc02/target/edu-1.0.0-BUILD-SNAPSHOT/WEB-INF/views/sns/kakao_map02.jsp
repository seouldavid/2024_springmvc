<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 지도 연습-2(내위치)</title>
<script type="text/javascript">
	let lng;
	let lat;
	navigator.geolocation.getCurrentPosition(function(position){
		lat = position.coords.latitude;
		lng = position.coords.longitude;
		geo_map(lat,lng);
	});
</script>
</head>
<body>
<!-- 내 위치의 위도와 경도 구해서 넣기 -->
 <!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fc85670f51b33ffbe7bd5977d1bc043c"></script>
<script>
function geo_map(lat,lng) {
	
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat,lng), // 지도의 중심좌표
        level: 2// 지도의 확대 레벨(1-14)
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
}
</script>
</body>
</html>