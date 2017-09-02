<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><html>
<head>
<script src="js/jquery-3.2.1.js"></script>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no"> 
<!-- 위치정보 API를 가져오는 코드 -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDsCvBGdPdGKaFym6WNsUUoQoaU0lrGLhw&libraries=places"> </script>
<script type="text/javascript"> 
window.onload = function() { 
	var options = {
	        // 가능한 경우, 높은 정확도의 위치(예를 들어, GPS 등) 를 읽어오려면 true로 설정
	        // 그러나 이 기능은 배터리 지속 시간에 영향을 미친다. 
	        enableHighAccuracy: false, // 대략적인 값이라도 상관 없음: 기본값
	        
	        // 위치 정보가 충분히 캐시되었으면, 이 프로퍼티를 설정하자, 
	        // 위치 정보를 강제로 재확인하기 위해 사용하기도 하는 이 값의 기본 값은 0이다.
	        maximumAge: 0,     // 5분이 지나기 전까지는 수정되지 않아도 됨
	        
	        // 위치 정보를 받기 위해 얼마나 오랫동안 대기할 것인가?
	        // 기본값은 Infinity이므로 getCurrentPosition()은 무한정 대기한다.
	        timeout: 15000    // 15초 이상 기다리지 않는다.
	    }
	 
	    if(navigator.geolocation) // geolocation 을 지원한다면 위치를 요청한다. 
	        navigator.geolocation.getCurrentPosition(MyPosition, error, options);
	    else
	        elt.innerHTML = "이 브라우저에서는 Geolocation이 지원되지 않습니다.";
	    
	    // geolocation 요청이 실패하면 이 함수를 호출한다.
	    function error(e) {
	        // 오류 객체에는 수치 코드와 텍스트 메시지가 존재한다.
	        // 코드 값은 다음과 같다.
	        // 1: 사용자가 위치 정보를 공유 권한을 제공하지 않음.
	        // 2: 브라우저가 위치를 가져올 수 없음.
	        // 3: 타임아웃이 발생됨.
	        elt.innerHTML = "Geolocation 오류 "+e.code +": " + e.message;
	    }
} 
function MyPosition(initmap) { 
	var lat2 = initmap.coords.latitude; 
	var lng2 = initmap.coords.longitude; 
	alert("tt")
	var loc = {lat:lat2, lng:lng2};

	  map = new google.maps.Map(document.getElementById('map'), {
	    center: loc,
	    zoom: 15
	  });

	var request = {
	    location: loc,
	    radius: '100',
	    query: '자전거'
	  };
	  infowindow = new google.maps.InfoWindow();
	  var service = new google.maps.places.PlacesService(map);
	service.textSearch(request, callback);
}



function callback(results, status) {
	  if (status === google.maps.places.PlacesServiceStatus.OK) {
	   
	    	
	      alert(results[1].formatted_address)
	    
	  }
	}

	function createMarker(place) {
	  var placeLoc = place.geometry.location;
	  var marker = new google.maps.Marker({
	    map: map,
	    position: place.geometry.location
	  });

	  google.maps.event.addListener(marker, 'click', function() {
	    infowindow.setContent(place.name);
	    infowindow.open(map, this);
	  });
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
d222d<br>
<div id="map" style="width: 500px; height: 500px"></div>
</body>
</html>
</html>