<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 지도 연습-3(내위치,마커표시, 인포 윈도우 표시)</title>
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

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(lat, lng); 

//마커를 생성합니다
var marker = new kakao.maps.Marker({
 position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px;"><a href="https://ictedu.co.kr" target="_blank">한국ICT인재개발원</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
 iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다

//인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
 position : iwPosition, 
 content : iwContent 
});

//마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 
}
</script>
</html>