<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#user_membership {
		margin: 25px;
	}
</style>
<script>

</script>
</head>
<body>
	<%-- 헤더 영역 --%>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
		
	<article id="mainArticle">
		<div class="container">
			<%-- 사이드 바 영역 --%>
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/zman_sidebar.jsp"></jsp:include>
			</nav>
			
			<%-- 본문 내용 --%>
			<div class="container-fluid">
				<div class="contentArea">
					<div>
						<%-- 해당 페이지 이름 출력 --%>
						<h1> 배달 예정 목록 </h1>
						
						<%-- ZMAN 지도 영역 시작  --%>
						<%--
							zman_delivery_want 뷰페이지에서는 배달 예정 목록의 "출발지" 값만 가져와서
							마크로 출력한다.
							AJAX 를 사용하여 해당 마크를 클릭 시 해당 배달 예정(주문건)에 대한 값을 간단하게 출력해준다. 
						--%>
						<div class="container text-center">
							<div class="row">
								<%-- 현재 위치 지도 영역 표시 --%>
								<div class="col">
										<%--카카오맵 지도 API 시작 --%>
										<div id="map" style="width:500px;height:350px;" data-v-32a5de90=""></div>
											<%-- 발급받은 appkey 를 넣어주기 --%>
											<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7b64b9fe8be0d3ba0e69ecffe2e6efe"></script>
											<script>
												var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
												    mapOption = {
												        center: new kakao.maps.LatLng(37.56792, 126.97101), // 지도의 중심좌표
												        level: 5, // 지도의 확대 레벨, 숫자가 클수록 넓은 범위를 보여준다
												        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
												    }; 
										
												// 지도를 생성한다 
												var map = new kakao.maps.Map(mapContainer, mapOption); 
										
												// HTML5의 geolocation으로 사용할 수 있는지 확인
												// ZMAN 의 현재 위치 를 마커로 표시하기
												if (navigator.geolocation) {
												    
												    // GeoLocation을 이용해서 접속 위치를 얻어오기
												    navigator.geolocation.getCurrentPosition(function(position) {
												        
												        var lat = position.coords.latitude, // 위도
												            lon = position.coords.longitude; // 경도
												        
												        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
												            message = '<div style="padding:5px;">ZMAN 현재 위치!</div>'; // 인포윈도우에 표시될 내용입니다
												        
												        // ZMAN 현재 위치 - 마커와 인포윈도우를 표시하기
												        displayMarker(locPosition, message);
												            
														// 지도에 원을 표시한다
										 				var circle = new kakao.maps.Circle({
										 					map: map, // 원을 표시할 지도 객체
										 					center : new kakao.maps.LatLng(lat, lon), // 지도의 중심 좌표
										 					radius : 750, // 원의 반지름 (단위 : m)
										 					fillColor: '#00ff00', // 채움 색
										 					fillOpacity: 0.5, // 채움 불투명도
										 					strokeWeight: 1, // 선의 두께
										 					strokeColor: '#00ff00', // 선 색
										 					strokeOpacity: 1, // 선 투명도 
										 					strokeStyle: 'solid' // 선 스타일
										 				});	 
														
										 			// 마커를 표시할 위치와 title 객체 배열입니다 
										 			// 학원 현재 위치
										 				// alert(lat); // 35.1544453
														// alert(lon); // 129.060646
													
													// ********** positions 배열 에 위도와 경도를 저장
													
													// DB 에서 출발지에 대한 값들을 배열 형태로 가져오기
													// -> 출발지 를 좌표로 검색해서 그 값들을 저장하기
													
										 				var positions = [
										 				    {
										 				        title: '서면로 62', 
										 				        latlng: new kakao.maps.LatLng(35.156233, 129.057934)
										 				    },
										 				    {
										 				        title: '배달1', 
										 				        latlng: new kakao.maps.LatLng(35.154423, 129.069477)
										 				    },
										 				    {
										 				        title: '배달2', 
										 				        latlng: new kakao.maps.LatLng(35.154444, 129.070946)
										 				    },
										 				    {
										 				        title: '배달3',
										 				        latlng: new kakao.maps.LatLng(35.155275, 129.060976)
										 				    }
										 				];
								
										 				// 마커 이미지의 이미지 주소입니다
										 				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
										 				    
										 				for (var i = 0; i < positions.length; i ++) {
										 				    
										 				    // 마커 이미지의 이미지 크기 입니다
										 				    var imageSize = new kakao.maps.Size(24, 35); 
										 				    
										 				    // 마커 이미지를 생성합니다    
										 				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
										 				    
										 				    // 마커를 생성합니다
										 				    var marker = new kakao.maps.Marker({
										 				        map: map, // 마커를 표시할 지도
										 				        position: positions[i].latlng, // 마커를 표시할 위치
										 				        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
										 				        image : markerImage // 마커 이미지 
										 				    });
										 				    
										 				}
														    // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
															kakao.maps.event.addListener(marker, 'click', function() {
															    alert('마커를 클릭했습니다!22222222222222');
															});
												    });
												    
												    
												} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정하기
												    
												    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
												        message = 'geolocation을 사용할수 없어요..'
												        
												    displayMarker(locPosition, message);
												}
								
												// 지도에 마커와 인포윈도우를 표시하는 함수
												function displayMarker(locPosition, message) {
								
												    // 마커를 생성합니다
												    var marker = new kakao.maps.Marker({  
												        map: map, 
												        position: locPosition
												    }); 
												    
												    var iwContent = message, // 인포윈도우에 표시할 내용
												        iwRemoveable = true;
								
												    // 인포윈도우를 생성
												    var infowindow = new kakao.maps.InfoWindow({
												        content : iwContent,
												        removable : iwRemoveable
												    });
												    
												    // 인포윈도우를 마커위에 표시
												    infowindow.open(map, marker);
												    
												    // 지도 중심좌표를 접속위치로 변경
												    map.setCenter(locPosition);      

												    // 마커에 클릭 이벤트를 등록한다 (우클릭 : rightclick)
													kakao.maps.event.addListener(marker, 'click', function() {
													    alert('마커를 클릭했습니다!');
													});
												}
												
												// 실시간교통 타일 이미지 추가
												map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
										
												// 지도 중심 좌표 변화 이벤트를 등록한다
								// 				kakao.maps.event.addListener(map, 'center_changed', function () {
								// 					console.log('지도의 중심 좌표는 ' + map.getCenter().toString() +' 입니다.');
								// 				});
											</script>
										<%--카카오맵 지도 API 끝 --%>
								</div>
							</div>
							
						<hr>
							<%-- AJAX 마커 클릭 시 간단 정보 출력 영역 시작--%>
							<div class="row">
							    <div class="col">
							    	<table class="table">
							    		<thead>
							    			<tr>
							    				<th scope="col">배달 물품</th>
							    				<th scope="col">출발지</th>
							    				<th scope="col">도착지</th>
							    				<th scope="col">배달 거리</th>
							    				<th scope="col">배달료</th>
							    			</tr>
							    		</thead>
							    		<tbody>
							    			<tr>
							    				 <td>${zd.order_secondhand_product }</td>
							    				 <td>${zd.zman_delivery_startspot }</td>
							    				 <td>${zd.zman_delivery_endspot }</td>
							    				 <td>거리,,, </td>
							    				 <td>${zd.zman_delivery_commission }</td>
							    			</tr>
							    		</tbody>
							    	</table>
							    </div>
							</div>
							<%-- AJAX 마커 클릭 시 간단 정보 출력 영역 끝--%>
						
						<hr>
					    	<%-- 배달 예정 게시판 영역 시작 --%>
							<div class="container text-center">
									<table class="table">
										<thead>
											<tr>
										    	<th scope="col">ZMAN 배달 번호</th>
										        <th scope="col">상품 이름</th>
										        <th scope="col">출발지</th>
										        <th scope="col">도착지</th>
										        <th scope="col">배달거리</th>
										        <th scope="col">수수료</th>
											</tr>
										</thead>
										<tbody class="table-group-divider">
										    <tr>
										        <th scope="row">${zd.zman_delivery_idx }</th>
										        <td>${zd.order_secondhand_product }</td>
										        <td>${zd.zman_delivery_startspot }</td>
							    				<td>${zd.zman_delivery_endspot }</td>
							    				<td>거리</td>
							    				<td>${zd.zman_delivery_commission }</td>
										    </tr>
										</tbody>
									</table>
								</div>
								<%-- 배달 예정 게시판 영역 끝 --%>
								
						</div> <%-- <div class="container text-center"> 끝 --%>
					</div> <%-- <div id="main"> 끝 --%>
				</div>
			</div> <%-- <div class="container-fluid"> 끝 --%>
		</div>
	</article>
</body>
</body>
</html>