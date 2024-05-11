<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- JSTL 의 함수를 사용하기 위해 functions 라이브러리 추가 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/cs.css" rel="stylesheet" type="text/css">

<%-- DatePicker 관련 --%>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="UTF-8">
<title>ZMAN MAIN</title>
<style type="text/css">
	#user_membership {
		margin: 25px;
	}
	
	#sec01 {
		display: flex;
		justify-content: center;
		align-items: center;	
	}

	.content_title[data-v-88eb18f6] {
	    display: flex;
	    padding: 5px 0 6px;
	    padding-bottom: 16px;
	    border-bottom: 3px solid #222!important;
	}

	/* 지도 영역 CSS 시작 */ 		
	#map-container {
	  display: flex;
	  justify-content: center;
	  align-items: center;
/* 	  height: 100vh; /* 화면 높이에 맞게 설정 */ */
	}
	
	#map {
	  max-width: 100%; /* 지도의 최대 너비 설정 */
	  height: auto; /* 높이를 자동 조정하여 비율을 유지 */
	}
	
	/* 화면 너비가 500px 이하인 경우 */
	@media (max-width: 500px) {
	  #map-container {
	    padding: 0 15px; /* 너비가 작은 경우 가운데 정렬을 유지하기 위한 여백 설정 */
	  }
	
	  #map {
	    width: 100%; /* 지도의 너비를 화면 너비에 맞게 조정 */
	    height: auto; /* 높이를 자동 조정하여 비율을 유지 */
	  }
	}
	/* 지도 영역 CSS 끝 */ 		
	
</style>
<script type="text/javascript">


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
				<div id="main">
<!-- 					<h1><u>ZMAN</u></h1> -->
					<div data-v-88eb18f6="" data-v-cf6a6ef4="" class="content_title">
						<div data-v-88eb18f6="" class="title">
							<h3 data-v-88eb18f6="">ZMAN</h3>


						<nav class="navbar navbar-light"><%-- 사이드바 사라졌을 때 햄버거 메뉴 --%>
							<a class="navbar-brand" href="#"></a>
							<button class="navbar-toggler collapsed border-0 hidden_nav" type="button" data-toggle="collapse" data-target="#csCollapse" aria-controls="csCollapse" aria-expanded="false" aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
							<jsp:include page="/WEB-INF/views/inc/zman_sidebar_hidden.jsp"></jsp:include>
						</nav>
						</div>
					</div>
						
					
					<%--ZMAN 프로필 영역 --%>
					<section id="sec01">
							<div class="user_membership" data-v-32a5de90="" data-v-412d8616="">
								<div class="user_detail" data-v-32a5de90="">
									<div class="user_thumb01" data-v-32a5de90="">
									<br>
									<strong class="name" data-v-32a5de90="">${zman.zman_name }</strong> &nbsp;|&nbsp;
									<strong class="email" data-v-32a5de90="">${sessionScope.member_id }</strong>&nbsp;|&nbsp;
									<strong class="phone" data-v-32a5de90="">${zman.zman_phone }</strong>&nbsp;|&nbsp;
									<strong class="phone" data-v-32a5de90="">${zman.zman_transport }</strong>&nbsp;|&nbsp;
									<strong class="phone" data-v-32a5de90="">${zman.zman_status }</strong>
								</div>
							</div>
						</div>
					</section>
					<hr>
					
<!-- 					<section id="sec02"> -->
<!-- 						<div class="user_membership" data-v-32a5de90="" data-v-412d8616=""> -->
<!-- 							<div class="user_detail" data-v-32a5de90=""> -->
<!-- 								<div class="user_thumb01" data-v-32a5de90=""> -->
<!-- 									<h2>정산 내역</h2> -->
<!-- 										<div class="zpayHistoryDateSelect" style="display: flex;"> -->
<!-- <!-- 											<input type="text" name="datetimes"  class="form-control"> --> -->
<!-- 										<table class="table"> -->
<!-- 											<thead> -->
<!-- 												<tr> -->
<!-- 											    	<th scope="col">배달 번호</th> -->
<!-- 											        <th scope="col">상품 이름</th> -->
<!-- 											        <th scope="col">출발지</th> -->
<!-- 											        <th scope="col">도착지</th> -->
<!-- 											        <th scope="col">배달료</th> -->
<!-- 											        <th scope="col">순수익</th> -->
<!-- 											        <th scope="col" width="75px"></th> -->
<!-- 												</tr> -->
<!-- 											</thead> -->
<!-- 											<tbody class="table-group-divider"> -->
<%-- 												수정 예정 --%>
<%-- 												<c:forEach var="zd" items="${zmanDeliveryYetList }" varStatus="vs"> --%>
<%-- 												<input type="hidden" name="zman_delivery_idx" value="${zd.zman_delivery_idx }" > --%>
<%-- 							    				<input type="hidden" name="zman_id" value="${sessionScope.member_id }"> --%>
<!-- 												    <tr> -->
<%-- 												        <th scope="row">${zd.zman_delivery_idx }</th> --%>
<%-- 												        <td>${zd.order_secondhand_product }</td> --%>
<%-- 												        <td>${zd.zman_delivery_startspot }</td> --%>
<%-- 									    				<td>${zd.zman_delivery_endspot }</td> --%>
<%-- 									    				<td>${zd.zman_delivery_commission }</td> --%>
<!-- 									    				<td> -->
<!-- 								    				 		<button class="btn btn-dark" type="submit">배달</button> -->
<!-- 								    					</td> -->
<!-- 												    </tr> -->
<%-- 												</c:forEach> --%>
<!-- 											</tbody> -->
<!-- 										</table> -->
<!-- 										</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</section> -->
					<hr>
					
				<%--카카오맵 지도 API 시작 --%>
				<div id="map-container">
					<div id="map" style="width:650px;height:350px;" data-v-32a5de90=""></div>
				</div>
				
					<%-- 발급받은 appkey 를 넣어주기 --%>
					<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7b64b9fe8be0d3ba0e69ecffe2e6efe&libraries=services"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						    mapOption = {
						        center: new kakao.maps.LatLng(37.56792, 126.97101), // 지도의 중심좌표
						        level: 4, // 지도의 확대 레벨, 숫자가 클수록 넓은 범위를 보여준다
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
						        
						        var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
						        var message = '<div style="padding:5px;">ZMAN 현재 위치!</div>'; // 인포윈도우에 표시될 내용입니다
						        
						        // 마커와 인포윈도우를 표시하기
						        displayMarker(locPosition, message);
						            
						        // 지도에 원을 표시한다
						        var circle = new kakao.maps.Circle({
						            map: map, // 원을 표시할 지도 객체
						            center: locPosition, // 지도의 중심 좌표
						            radius: 500, // 원의 반지름 (단위 : m)
						            fillColor: '#666699', // 채움 색
						            fillOpacity: 0.5, // 채움 불투명도
						            strokeWeight: 1, // 선의 두께
						            strokeColor: '#666699', // 선 색
						            strokeOpacity: 1, // 선 투명도 
						            strokeStyle: 'solid' // 선 스타일
						        });
						    });
						} else { // HTML5의 GeoLocation을 사용할 수 없을 때 마커 표시 위치와 인포윈도우 내용을 설정하기
						    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667);
						    var message = 'geolocation을 사용할 수 없어요..';
						    
						    displayMarker(locPosition, message);
						}
						
						function displayMarker(position, message) {
						    // 마커를 생성합니다
						    var marker = new kakao.maps.Marker({
						        map: map,
						        position: position
						    });
						
						    var iwContent = message; // 인포윈도우에 표시할 내용
						    var infowindow = new kakao.maps.InfoWindow({
						        content: iwContent
						    });
						    
						    // 인포윈도우를 마커위에 표시
						    infowindow.open(map, marker);
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
						
						// 데이터베이스에서 가져온 주소로 마커를 표시하는 함수
					    function displayMarkersFromDB() {
					        var positionsFromDB = [
					            { title: ' 출발지', address: '부산광역시 부산진구 서면로 62' }
					            , { title: '출발지1', address: '부산광역시 부산진구 동천로 109' }
					            , { title: '출발지2', address: '부산광역시 부산진구 동천로 97' }
// 					            , { title: '예시 위치3', address: '부산광역시 부산진구 예시주소3' }
					            // ... (데이터베이스에서 가져온 주소 정보 추가)
					        ];

					        var geocoder = new kakao.maps.services.Geocoder();

					        for (var i = 0; i < positionsFromDB.length; i++) {
					            var position = positionsFromDB[i];

					            geocoder.addressSearch(position.address, function(result, status) {
					                if (status === kakao.maps.services.Status.OK) {
					                    var markerPosition = new kakao.maps.LatLng(result[0].y, result[0].x);

					                    var marker = new kakao.maps.Marker({
					                        map: map,
					                        position: markerPosition,
					                        title: position.title
					                    });

					                    kakao.maps.event.addListener(marker, 'click', function() {
					                        var infowindow = new kakao.maps.InfoWindow({
					                            content: '<div style="padding:5px;">' + position.title + '</div>'
					                        });
					                        infowindow.open(map, marker);
					                    });
					                }
					            });
					        }
					    }

					    // 데이터베이스에서 가져온 주소로 마커를 표시합니다
					    displayMarkersFromDB();

						
						// 실시간교통 타일 이미지 추가
// 						map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC); 
				
						// 지도 중심 좌표 변화 이벤트를 등록한다
		// 				kakao.maps.event.addListener(map, 'center_changed', function () {
		// 					console.log('지도의 중심 좌표는 ' + map.getCenter().toString() +' 입니다.');
		// 				});
						
						
					</script>
			<%--카카오맵 지도 API 끝 --%>
				</div> <%-- <div id="main">  --%>
			</div>
			</div>
		</div>
	</article>
</body>
</body>
</html>