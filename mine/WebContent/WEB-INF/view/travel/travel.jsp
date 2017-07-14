<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="travel_section">
	<div class="inner_container">
		<div class="img_wrap">
			<div class="img">
				<img src="/img/travel.jpg"/>
			</div>
		</div>
		<div class="travel_container">
			<div class="travel_list">
				<div class="select_wrap">
					<div class="total_txt" id="total_txt"></div>
					<select>
						<option>서울</option>
						<option>경기</option>
						<option>인천</option>
						<option>강원</option>
						<option>충청</option>
						<option>전라</option>
						<option>경상</option>
						<option>제주</option>
					</select>
					<div class="btn">검색</div>
				</div>
				<div class="travel_wrap">
					<div class="list_wrap">
						<div class="list" id="travel_list"></div>
					</div>
				</div>
				<div class="course_wrap">
					<c:forEach var="i" begin="1" end="12">
						<div class="course" id="travel_course${i }"></div>
						<c:if test="${i%4!=0 }">
							<span>-></span>
						</c:if>
					</c:forEach>
				</div>
				<div class="btn_wrap">
					<div class="btn">저장</div>
					<div class="btn" onclick="travel_clear()">지우기</div>
				</div>
			</div>
			<div class="info_wrap">
				<div class="detail_info">
					<div class="info">
						<div class="title">이름</div>
						<div class="txt" id="travel_info1"></div>
					</div>
					<div class="info">
						<div class="title">주소</div>
						<div class="txt" id="travel_info2"></div>
					</div>
					<div class="info">
						<div class="title">소개</div>
						<div class="scroll">
							<div class="txt txt2" id="travel_info3"></div>
						</div>
					</div>
<!-- 					<div class="info"> -->
<!-- 						<div class="title">항목변경</div> -->
<!-- 						<div class="txt" id="travel_info4">봉주르 주뗌므 어린왕자 마을</div> -->
<!-- 					</div> -->
<!-- 					<div class="info"> -->
<!-- 						<div class="title">항목변경</div> -->
<!-- 						<div class="txt" id="travel_info5">봉주르 주뗌므 어린왕자 마을</div> -->
<!-- 					</div> -->
				</div>
				<div class="map_wrap">
					<div class="map" id="map"></div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>

	function initMap(x, y) {
	    var uluru = {lat: 37.513355, lng: 127.101099};
	    if(x != null && y != null){
	    	uluru = {lat: Number(y), lng: Number(x)};
	    }
	    var map = new google.maps.Map(document.getElementById('map'), {
	      zoom: 16,
	      center: uluru
	    });
	    var marker = new google.maps.Marker({
	      position: uluru,
	      map: map
	    });
	  }
	
	function navi() {
		var chicago = {
			lat : 37.513355,
			lng : 127.101099
		};
		var indianapolis = {
			lat : 37.513355,
			lng : 127.101122
		};
	
		var map = new google.maps.Map(document.getElementById('map'), {
			center : chicago,
			scrollwheel : true,
			zoom : 15
		});
		
		var marker = new google.maps.Marker({
	          map: map,
	          position: chicago,
	          title: 'Home'
	        });
	
		var directionsDisplay = new google.maps.DirectionsRenderer({
			map : map
		});
	
		// Set destination, origin and travel mode.
		var request = {
			destination : indianapolis,
			origin : chicago,
			travelMode : 'TRANSIT'
		};
	
		// Pass the directions request to the directions service.
		var directionsService = new google.maps.DirectionsService();
		directionsService.route(request, function(response, status) {
			if (status == 'OK') {
				// Display the route on the map.
				directionsDisplay.setDirections(response);
			}
		});
	}
	
	$(document).ready(function(){
		var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?ServiceKey=";
		var serviceKey ="E6aCwnzt7GvaVyGPlnz90bCutYTfoKHWGPGINaGfrfJDy77fHN7rBpNKacZG7Cna0ctfURHJKReKGpJaWnND1w%3D%3D";
		url += serviceKey;
		url += "&MobileOS=ETC";
		url += "&MobileApp=140720";
		url += "&numOfRows=999999";
		url += "&areaCode=1";	// tourAPI 상의 areaCode 찾아서 알아봐야함.
		url += "&sigunguCode=1";		// tourAPI 상의 sigunguCode 찾아서 알아봐야함.
		$.ajax({
			type : "get",
			url : url,
			async : false,
			success : function(txt){
				var items = txt.firstChild.firstChild.nextSibling.firstChild.childNodes;
				for(var i=0; i<items.length; i++){
					var title = items[i].getElementsByTagName("title")[0].firstChild.nodeValue;
					var contentId = items[i].getElementsByTagName("contentid")[0].firstChild.nodeValue;
					var html = "<div class='txt'><span class='travel_spot' onclick='travel_spot(this,"+contentId+")'>"+title+"</span></div>";
					$("#travel_list").append(html);
				}
				$("#total_txt").html("총 "+items.length+"개");
			}
		});
	});
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC-hjk-B_9iNJVgcCHp4h123Gty1qPlnEc&callback=initMap" async defer></script>