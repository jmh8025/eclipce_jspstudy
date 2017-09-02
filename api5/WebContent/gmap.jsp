<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Search for up to 200 places with Radar Search</title>
<style>
/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
#map {
	height: 500px;
}
/* Optional: Makes the sample page fill the window. */
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}
</style>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDsCvBGdPdGKaFym6WNsUUoQoaU0lrGLhw&callback=initMap&libraries=places,visualization"
	async defer></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
	var resultlocal;
	var resultgoogle;
	var markers = [];
    var map;
    
function initMap() {
	var loc = {lat:37.4989993, lng:127.0299699};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 15,
    center: loc
  });

infowindow = new google.maps.InfoWindow();

  var script = document.createElement('script');
  script.src = 'test2.js';
  document.getElementsByTagName('head')[0].appendChild(script);

  icons = {
    normal: {
      name: 'normal',
      icon: 'https://cdn-images-1.medium.com/max/1600/1*ce2nCas4lq-oKDyI8J5VKw.png'
    },
    gonggi: {
      name: 'gonggi',
      icon: 'https://developers.google.com/maps/documentation/javascript/images/circle.png'
    },
    store: {
        name: 'store',
        icon: 'http://cfile9.uf.tistory.com/image/1834590F4BF169D41EAB96'
    }
}
  
  var request = {
		    location: loc,
		    radius: '100',
		    query: '자전거'
		  };
		  infowindow = new google.maps.InfoWindow();
		  var service = new google.maps.places.PlacesService(map);
		service.textSearch(request, searchresult);

}




//1.로컬js먼저읽고
window.eqfeed_callback = function(results) {
	resultlocal=results;
}

//2.구글꺼읽음
function searchresult(results, status) {
	  if (status === google.maps.places.PlacesServiceStatus.OK) {
		resultgoogle=results;
		searchsort() //resultlocal과 resultgoogle을 읽어들인뒤 searchsort로 이동
		}
}

function searchsort() {
	clearMarkers() //마
	var type; //고객이 뭘선택했는지 알기
	for (var i = 0; i < document.controls.type.length; i++) {
		if (document.controls.type[i].checked) {
			type = document.controls.type[i].value;
		}
	}
	if(type=='all'){//타입이 전부보여주세요이면
		addmarkergoogle(resultgoogle); //구글값보내버리기 아오졸려
		for (var i = 0, result; result = resultlocal[i]; i++) { //local값전부보내버렷
			addmarkerlocal(result);
		}  
	}else if((type=='normal')||(type=='gonggi')){//타입이 일반이거나 공기이면
		for (var i = 0, result; result = resultlocal[i]; i++) { 
			if(type==result.service){ //선택한값과 맵의서비스가같을때만 즉, 노말과 공기를 솎아보냄
				addmarkerlocal(result);				
			}
		}  
	}else if(type=='store'){//타입이 대리점이면
		addmarkergoogle(resultgoogle);
	}
}

function addmarkerlocal(result){
	var lat = result.lat;
	var lon = result.lon;
	var latLng = new google.maps.LatLng(lat,lon);
	marker = new google.maps.Marker({
		position: latLng,
	    map: map,
	    icon: {
	    	url: icons[result.service].icon, //service값과 일치하는 이미지읽어오기
	        anchor: new google.maps.Point(10, 10),
	        scaledSize: new google.maps.Size(10, 17)
	}
	});
	markers.push(marker); //마커를 배열에 삽입 (나중에 지우기위해서)
	var content = "이름은"+result.name+"<br>번호는"+result.tel;
	google.maps.event.addListener(marker,'click', (function(marker,content,infowindow){ 
		return function(){
			infowindow.setContent(content);
	  		infowindow.open(map,marker);
	  		};
	  		})(marker,content,infowindow));
}

function addmarkergoogle(results){
	for (var i = 0, result; result = results[i]; i++) {
	    marker = new google.maps.Marker({
	        position: result.geometry.location,
	        map: map,
	  	   icon: {
	              url: icons.store.icon, //service값과 일치하는 이미지읽어오기
	              anchor: new google.maps.Point(10, 10),
	              scaledSize: new google.maps.Size(10, 17)
	            }
	  	});
	  	markers.push(marker); //마커를 배열에 삽입 (나중에 지우기위해서)
	  	var content = "이름은"+result.name+"<br>번호는";
	  	google.maps.event.addListener(marker, 'click', function() {
		    infowindow.setContent(content);
		    infowindow.open(map, this);
		});
	}
}



function clearMarkers() { 
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
   markers = [];
}


    </script>
</head>
<body>
	<div id="map"></div>
	<form name="controls">
		<input type="radio" name="type" value="all" onclick="searchsort()"
			checked="checked" />모두 <br /> <input type="radio" name="type"
			value="normal" onclick="searchsort()" />보관소 <br /> <input
			type="radio" name="type" value="gonggi" onclick="searchsort()" />공기주입기
		<br /> <input type="radio" name="type" value="store" onclick="searchsort()" />대리점 <input onclick="clearMarkers();"
			type=button value="Hide Markers"></input>
	</form>
</body>
</html>