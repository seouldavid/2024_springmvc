<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 지도 연습-1</title>
</head>
<body>
<%--
	카카오 디벨로퍼 로그인 후 내 어플리케이션에서 애플리케이션 선택 후 javascript키 복사 fc85670f51b33ffbe7bd5977d1bc043c
 	제품 - 로컬 - 선택 - 문서보기 -지도 -maps api - web - 시작하기 -sample에 모든 정보 다 있다.
 --%>
 <!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fc85670f51b33ffbe7bd5977d1bc043c"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨(1-14)
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
</script>
</body>
</html>