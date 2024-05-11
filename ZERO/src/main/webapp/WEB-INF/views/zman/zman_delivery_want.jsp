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

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="UTF-8">
<title>ZERO ZMAN</title>
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
<!-- 						<h1> 배달 예정 </h1> -->
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
	<!-- 									<img -->
	<%-- 										src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" --%>
	<!-- 										alt="사용자 이미지" class="thumb_img" data-v-32a5de90=""> -->
										
										<strong class="name" data-v-32a5de90="">${zman.zman_name }</strong> &nbsp;|&nbsp;
										<strong class="email" data-v-32a5de90="">${sessionScope.member_id }</strong>&nbsp;|&nbsp;
										<strong class="phone" data-v-32a5de90="">${zman.zman_phone }</strong>&nbsp;|&nbsp;
										<strong class="phone" data-v-32a5de90="">${zman.zman_transport }</strong>&nbsp;|&nbsp;
										<strong class="phone" data-v-32a5de90="">${zman.zman_status }</strong>
											<%-- 프로필 관리는 사이드바로 빼기 --%>
	<!-- 										<a href="/my/profile-edit" type="button" -->
	<!-- 											class="btn btn outlinegrey small" data-v-43813796="" -->
	<!-- 											data-v-32a5de90=""> 프로필 관리 </a> -->
									</div>
								</div>
							</div>
						</section>
						
						<hr>
					
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
										<div id="map-container">
											<div id="map" style="width:650px;height:350px;" data-v-32a5de90=""></div>
										</div>
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
										 					fillColor: '#666699', // 채움 색
										 					fillOpacity: 0.5, // 채움 불투명도
										 					strokeWeight: 1, // 선의 두께
										 					strokeColor: '#666699', // 선 색
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
											
											
											<%-- 임시 --%>
											<%-- 발급받은 appkey 를 넣어주기 --%>
<!-- 											<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c7b64b9fe8be0d3ba0e69ecffe2e6efe"></script> -->
<!-- 								            <script> -->
<!-- // 								                var mapContainer = document.getElementById('map'), -->
<!-- // 								                    mapOption = { -->
<!-- // 								                        center: new kakao.maps.LatLng(37.56792, 126.97101), -->
<!-- // 								                        level: 5, -->
<!-- // 								                        mapTypeId: kakao.maps.MapTypeId.ROADMAP -->
<!-- // 								                    }; -->
								
<!-- // 								                var map = new kakao.maps.Map(mapContainer, mapOption); -->
								                
<!-- // 								             // 현재 위치와 마커를 표시하는 함수 -->
<!-- // 								                function displayMarker(position, message) { -->
<!-- // 								                    var marker = new kakao.maps.Marker({ -->
<!-- // 								                        map: map, -->
<!-- // 								                        position: position -->
<!-- // 								                    }); -->

<!-- // 								                    var infowindow = new kakao.maps.InfoWindow({ -->
<!-- // 								                        content: message -->
<!-- // 								                    }); -->

<!-- // 								                    kakao.maps.event.addListener(marker, 'mouseover', function() { -->
<!-- // 								                        infowindow.open(map, marker); -->
<!-- // 								                    }); -->

<!-- // 								                    kakao.maps.event.addListener(marker, 'mouseout', function() { -->
<!-- // 								                        infowindow.close(); -->
<!-- // 								                    }); -->
<!-- // 								                } -->
								
<!-- // 								             // 현재 위치 가져와서 마커 표시 -->
<!-- // 								                if (navigator.geolocation) { -->
<!-- // 								                    navigator.geolocation.getCurrentPosition(function(position) { -->
<!-- // 								                        var lat = position.coords.latitude, -->
<!-- // 								                            lon = position.coords.longitude; -->
								
<!-- // 								                        var locPosition = new kakao.maps.LatLng(lat, lon), -->
<!-- // 								                            message = '<div style="padding:5px;">ZMAN 현재 위치!</div>'; -->
								
<!-- // 								                        displayMarker(locPosition, message); -->
								
<!-- // 								                        var circle = new kakao.maps.Circle({ -->
<!-- // 								                            map: map, -->
<!-- // 								                            center: new kakao.maps.LatLng(lat, lon), -->
<!-- // 								                            radius: 750, -->
<!-- // 								                            fillColor: '#666699', -->
<!-- // 								                            fillOpacity: 0.5, -->
<!-- // 								                            strokeWeight: 1, -->
<!-- // 								                            strokeColor: '#00ff00', -->
<!-- // 								                            strokeOpacity: 1, -->
<!-- // 								                            strokeStyle: 'solid' -->
<!-- // 								                        }); -->
				
								                        
<!-- // 								                         var positions = []; // 출발지 정보를 담을 배열 -->

<!-- // 								                         function fetchDepartureListAndCreateMarkers() { -->
<!-- // 								                        	    $.ajax({ -->
<!-- // 								                        	        url: 'getDeliveryStartspotList', // 서버의 API URL을 입력하세요. -->
<!-- // 								                        	        type: 'GET', -->
<!-- // 								                        	        dataType: 'json', -->
<!-- // 								                        	        success: function(data) { -->
<!-- // 								                        	            var positions = data.map(function(item) { -->
<!-- // 								                        	                return { -->
<!-- // 								                        	                    title: item.title, -->
<!-- // 								                        	                    address: item.address, -->
<!-- // 								                        	                    latlng: null -->
<!-- // 								                        	                }; -->
<!-- // 								                        	            }); -->

<!-- // 								                        	            var geocoder = new kakao.maps.services.Geocoder(); -->
<!-- // 								                        	            var remaining = positions.length; -->

<!-- // 								                        	            positions.forEach(function(position) { -->
<!-- // 								                        	                geocoder.addressSearch(position.address, function(result, status) { -->
<!-- // 								                        	                    if (status === kakao.maps.services.Status.OK) { -->
<!-- // 								                        	                        position.latlng = new kakao.maps.LatLng(result[0].y, result[0].x); -->

<!-- // 								                        	                        var marker = new kakao.maps.Marker({ -->
<!-- // 								                        	                            map: map, -->
<!-- // 								                        	                            position: position.latlng, -->
<!-- // 								                        	                            title: position.title -->
<!-- // 								                        	                        }); -->

<!-- // 								                        	                        kakao.maps.event.addListener(marker, 'click', function () { -->
<!-- // 								                        	                            handleMarkerClick(this.getTitle()); -->
<!-- // 								                        	                        }); -->
<!-- // 								                        	                    } else { -->
<!-- // 								                        	                        console.error('주소를 변환하는데 실패했습니다.'); -->
<!-- // 								                        	                    } -->

<!-- // 								                        	                    remaining--; -->

<!-- // 								                        	                    if (remaining === 0) { -->
<!-- // 								                        	                        // 모든 주소 변환이 완료되면 마커 생성 및 이벤트 핸들링 코드 호출 -->
<!-- // 								                        	                        // 만약 여기서 다른 로직을 실행해야 한다면 이 위치에 추가하세요. -->
<!-- // 								                        	                    } -->
<!-- // 								                        	                }); -->
<!-- // 								                        	            }); -->
<!-- // 								                        	        }, -->
<!-- // 								                        	        error: function() { -->
<!-- // 								                        	            console.error('출발지 리스트를 가져오는데 실패했습니다.'); -->
<!-- // 								                        	        } -->
<!-- // 								                        	    }); -->
<!-- // 								                        	} -->

<!-- // 								                        	// 함수 호출 -->
<!-- // 								                        	fetchDepartureListAndCreateMarkers(); -->

													
<!-- // 													    // 마커 클릭 이벤트를 처리하는 함수 -->
<!-- // 													    function handleMarkerClick(markerTitle) { -->
<!-- // 													        // AJAX를 이용하여 해당 배달 정보를 가져옵니다. -->
<!-- // 													        $.ajax({ -->
<!-- // 													            url: 'markerClickInfo', // 컨트롤러에서 지정한 URL로 바꾸세요. -->
<!-- // 													            type: 'GET', -->
<!-- // 													            data: { markerTitle: markerTitle }, // 마커의 타이틀을 전달합니다. -->
<!-- // 													            dataType: 'json', -->
<!-- // 													            success: function (data) { -->
<!-- // 													                // 받아온 데이터를 가지고 표를 생성합니다. -->
<!-- // 													                var tableHtml = ` -->
<!-- // 													                    <table class="table"> -->
<!-- // 													                        <thead> -->
<!-- // 													                            <tr> -->
<!-- // 													                                <th scope="col">배달 번호</th> -->
<!-- // 													                                <th scope="col">상품 이름</th> -->
<!-- // 													                                <th scope="col">출발지</th> -->
<!-- // 													                                <th scope="col">도착지</th> -->
<!-- // 													                                <th scope="col">수수료</th> -->
<!-- // 													                            </tr> -->
<!-- // 													                        </thead> -->
<!-- // 													                        <tbody class="table-group-divider"> -->
<!-- // 													                            <tr> -->
<%-- // 													                                <th scope="row">${data.zman_delivery_idx}</th> --%>
<%-- // 													                                <td>${data.order_secondhand_product}</td> --%>
<%-- // 													                                <td>${data.zman_delivery_startspot}</td> --%>
<%-- // 													                                <td>${data.zman_delivery_endspot}</td> --%>
<%-- // 													                                <td>${data.zman_delivery_commission}</td> --%>
<!-- // 													                            </tr> -->
<!-- // 													                        </tbody> -->
<!-- // 													                    </table> -->
<!-- // 													                `; -->
													
<!-- // 													                // 배달 정보 표시 영역에 생성한 표를 삽입합니다. -->
<!-- // 													                $('#deliveryInfo').html(tableHtml); -->
<!-- // 													            }, -->
<!-- // 													            error: function () { -->
<!-- // 													                console.error('배달 정보를 가져오는데 실패했습니다.'); -->
<!-- // 													            } -->
<!-- // 													        }); -->
<!-- // 													    } -->
													
<!-- 													</script> -->
								        </div>
								    </div>


						
						<hr>
						<h2>배달 대기 목록</h2>
					    	<%-- 배달 예정 게시판 영역 시작 --%>
							<div class="container text-center">
							<form action="zman_delivery_ing" method="post">
					    		
									<table class="table">
										<thead>
											<tr>
										    	<th scope="col" width="65px">배달 주문 번호</th>
										        <th scope="col">상품 이름</th>
										        <th scope="col">출발지</th>
										        <th scope="col">도착지</th>
<!-- 										        <th scope="col">배달거리</th> -->
										        <th scope="col" width="130px">수수료</th>
										        <th scope="col" width="100px"></th>
											</tr>
										</thead>
										<tbody class="table-group-divider">
											<c:forEach var="zd" items="${zmanDeliveryYetList }" varStatus="vs">
<%-- 											<input type="hidden" name="zman_delivery_idx" value="${zd.zman_delivery_idx }" > --%>
<%-- 						    				<input type="hidden" name="zman_id" value="${sessionScope.member_id }"> --%>
											    <tr>
											        <th scope="row">${zd.zman_delivery_idx }</th>
											        <td>${zd.order_secondhand_product }</td>
											        <td>${zd.zman_delivery_startspot }</td>
								    				<td>${zd.zman_delivery_endspot }</td>
	<!-- 							    				<td>거리</td> -->
								    				<td>
<%-- 								    					${zd.zman_delivery_commission } --%>
								    					<fmt:formatNumber value="${zd.zman_delivery_commission }" pattern="#,##0"/>원
								    				</td>
								    				<td>
								    					<a class="btn btn-sm btn-outline-dark" href="zman_delivery_ing?zman_delivery_idx=${zd.zman_delivery_idx }&zman_id=${sessionScope.member_id }">배달</a>
<!-- 							    				 		<button class="btn btn-outline-dark" type="submit">배달</button> -->
							    					</td>
											    </tr>
											</c:forEach>
										</tbody>
									</table>
								</form>
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