<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="${pageContext.request.contextPath }/resources/css/header.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/alarm.css" rel="stylesheet" type="text/css">
<%-- 소켓통신을 위한 함수들을 콜백형태로 제공 --%>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<nav class="navbar navbar-expand-md fixed-top navbar-light p-0">
	<div id="logo">
		<a href="./">ZERO</a>
	</div>
	<button id="navToggle" class="navbar-toggler collapsed border-0" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
		<div id="headerArea1">
			<div id="headerArea1_inner">
				<ul id="headerArea1_list">
					<li class="headerArea1_item"><a href="cs_main" class="headerArea1_link">고객센터</a></li>
					<li class="headerArea1_item"><a href="#" class="headerArea1_link">관심상품</a></li>
					<%-- 알림 임시 --%>
					<li class="headerArea1_item alarmLi">
						<a class="headerArea1_link" onclick="alarmListOpen()">알림<span id="alarmPoint" style="display: none;">● </span></a>
						<div class="layer_box" aria-hidden="false" style="display: none;"> <%--  style="display: none;" --%>
							<div class="box_content">
<!-- 								<iframe src="shortAlarmList" -->
<!-- 									title="알림" width="100%" height="100%"> -->
<!-- 								</iframe> -->
								<%@ include file="../alarm/alarm_list.jsp"%>
							</div>
						</div>
					</li>
					<li class="headerArea1_item"><a href="chatList" class="headerArea1_link">채팅</a></li>
					<li class="headerArea1_item">
						<c:choose>
							<c:when test="${not empty sessionScope.member_id }">
								<a href="member_mypage_main" class="headerArea1_link">${sessionScope.member_id } 님</a>
							</c:when>
							<c:otherwise>
								<a href="member_login" class="headerArea1_link">로그인</a>					
							</c:otherwise>
						</c:choose>
					</li>
					<li class="headerArea1_item" <c:if test="${empty sessionScope.member_id }">hidden</c:if>><a href="member_logout" class="headerArea1_link">로그아웃</a></li>
					<li class="headerArea1_item"><a href="zman_main" class="headerArea1_link">ZMAN</a></li>
					<c:if test="${sessionScope.member_type eq '직원' }">
						<li class="headerArea1_item"><a href="admin_main" class="headerArea1_link">관리자</a></li>					
					</c:if>
					<li class="headerArea1_item"><a href="zpay_main" class="headerArea1_link">ZPAY</a></li>
				</ul>
			</div>
		</div>
		<div id="headerArea2" style="z-index: 1;">
			<div id="headerArea2_inner">
				<ul class="navbar-nav ml-auto mr-2 mt-2 mt-md-0">
					<li class="nav-item">
						<a class="nav-link" href="./">Home <span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="secondhand_list">중고</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="secondhandRegistForm">중고등록</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="auctionList_present">경매</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="auction_regist_form">경매등록</a>
					</li>
				</ul>
			
			
				<!-- 검색어 입력창 -->
				<form class="form-inline my-2 my-md-0" action="searchProductList" id="productSearchKeyword" name="productSearchKeyword" method="get" >
					<input class="form-control mr-sm-2" 
							type="text" placeholder="키워드를 입력해주세요" 
							aria-label="Search"
							name="productSearchKeyword"
	                        value="${not empty param.productSearchKeyword ? param.productSearchKeyword : ''}"> 
					<button class="btn btn-sm btn-outline-dark my-2 my-sm-0" type="submit" 
							onclick="location.href='searchProductList?productSearchKeyword=${param.productSearchKeyword}'">Search
					</button>
				</form>
			
				
			</div>
		</div>
	</div>
</nav>

<%-- 알림 관련 함수 --%>
<script>
	
	// 알림창 열고 닫는 함수
	let isAlarmListOpen = false;
	function alarmListOpen() {
		if(!isAlarmListOpen) {
			$(".layer_box").css("display", "");
			isAlarmListOpen = true;
		} else {
			$(".layer_box").css("display", "none");
			isAlarmListOpen = false;
		}
	}
	
	$(document).on("click", function(event) {
        const target = $(event.target);
        if (!target.closest(".alarmLi").length && !target.closest(".layer_box").length) {
            $(".layer_box").css("display", "none");
            isAlarmListOpen = false;
        }
    });	 // 정렬 목록이 열려있을 때 다른 곳을 누르면 목록 닫히게 하는 함수
	
	//알림 메세지
	let alarmMessage;
	var socket;
	// 로그인했을 경우만 알림 가능하게 하기 - 세션아이디 유무 판별
	let receiver = "${member_id}";
	console.log(receiver);
	if(receiver != "") {
		// 웹소켓 주소 설정 - 알림창 동기 설정
		socket = new SockJS('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm');
//			socket = new SockJS('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm?id=' + receiver);
		// 서버에서 메세지를 보내면 자동으로 실행되는 함수
		socket.onmessage = onAlarmMessage;
		socket.onclose = onAlarmClose;
		socket.onopen = onAlarmOpen;
	}

	//채팅창에서 나갔을 때
	function onAlarmClose(evt) {
//			var user = '${pr.username}';
//			var str = user + " 님이 퇴장하셨습니다.";
//			$("#msgArea").append(str);
	}
	//채팅창에 들어왔을 때
	function onAlarmOpen(evt) {
//			var user = '${pr.username}';
//			var str = user + "님이 입장하셨습니다.";
//			$("#msgArea").append(str);
	}

	// receiver_id에게 type(알림 타입), msg(알림 내용) 문자열 하나로 보내기
	function sendAlarmMessage(receiver_id, alarmType, alarmMsg, alarmMsgLink) {
			
		// 보낼 알림 메세지 작성
		// receiver_id에게 type(알림 타입), msg(알림 내용) 문자열 하나로 보내기
 		alarmMessage = receiver_id + "p]]/[" + alarmType + "p]]/[" + alarmMsg + "p]]/[" + alarmMsgLink;
		// 각 이벤트 시 받는 메세지를 소켓으로 전달
		socket.send(alarmMessage);
		
		// 알림 내용을 DB에 저장하기
		$.ajax({
			data: {
				'member_id': receiver_id,
				'alarm_message' : alarmMsg,
				'alarm_type' : alarmType,
				'alarm_link': alarmMsgLink
			},
			url: "alarmRemember",
			type: "POST",
			success: function(data) {
 				console.log("DB 저장 성공");
			},
			error: function(request,status,error) {
				alert("code:"+request.status+"\n"
						+"message:"+request.responseText+"\n"
						+"error:"+error);
 				console.log("DB 저장 실패");
			}
		});	// ajax 끝
		
	}	// sendAlarmMessage() 끝
	
	let alarmNewCount = 0;
	//서버에서 메시지를 받았을 때
	function onAlarmMessage(msg) {
		
		var data = msg.data;
		var receiveId = null; // 알림 받을 아이디
		var receiveType = null;
		var receiveMessage = null;
		var receiveLink = null;
		
		var arr = data.split("p]]/[");
// 		console.log("받는 원 메세지 : " + data);
		
//		var cur_session = '${member_id}'; //현재 세션에 로그인 한 사람
		
		receiveId = arr[0];
		receiveType = arr[1];
		receiveMessage = arr[2];
		receiveLink = arr[3];
		
		let now = new Date();
		// 원하는 포맷으로 날짜와 시간을 포맷 (예: 오후 09:30)
		let formattedTime = now.toLocaleString('ko-KR', { hour12: true, hour: 'numeric', minute: 'numeric' });
		let alarmListCount = $(".alarmItem").length;
		if(alarmListCount >= 7) {
			$(".alarmItem").last().remove();
			console.log("클래스가 alarmItem인 요소의 개수: " + alarmListCount);
		}
		
		// 메세지를 받을 아이디와 같은 경우만 표시해주기
		if(receiver == receiveId) {
			var strr = 	'<li class="alarmItem">';
			strr += 	'	<a href="alarmClick?url=' + receiveLink + '">';
			strr += 	'	<div class="alarmTitle">';
			strr += 			receiveType;
			strr += 			'<span class="alarmTime">';
			strr += 				formattedTime;
			strr += 			'</span>';
			strr += 	'	</div>';
			strr += 	'	<div class="alarmContent">';
			strr += 			receiveMessage;
			strr += 	'	</div>';
			strr += 	'	</a>';
			strr += 	'</li>';
			
			$("#alarmList").prepend(strr);
			$("#alarmPoint").css("display", "");
			
			// 팝업 알림 띄우기
			let option = { body : receiveMessage };
			
			let notification = "";
			if(Notification.permission !== "denied") {
				Notification.requestPermission(permission => {
					
					if(permission === "granted") {
						notification = new Notification("ZERO - " + receiveType, option);
						notification.onclick = function() {
							location.href = 'alarmClick?url=' + receiveLink;
						}
					}
				});
			}
			
		}
	}	// onAlarmMessage() 끝
	
	// DB에서 확인하지 않은 알림 들고오기
	$(function() {
		
		// 알림 내용을 DB에서 가져오기
		$.ajax({
			data: {
				'member_id': '${member_id}',
				'type' : '새알림'
			},
			url: "alarmCheck",
			type: "POST",
			success: function(data) {
 				console.log("DB 가져오기 성공");
 				
				// 기존에 있던 리스트 삭제
				$("#alarmList").empty();
				
				if(data != "") {
					$("#alarmPoint").css("display", "");
				}
				
				for(let alarmItem of data) {
					
					let changeLink = alarmItem.alarm_link.replace("?", "--");
					// 보여줄 시간 형식
					let formatTime = null;
					let alarmDate = new Date(alarmItem.alarm_time);
					formatTime = alarmDate.toLocaleString('ko-KR', { hour12: true, hour: 'numeric', minute: 'numeric' });
// 					console.log("alarmDate 시간만 : " + alarmDate.toLocaleString('ko-KR', { hour12: true, hour: 'numeric', minute: 'numeric' }) );
					
// 					formatTime = alarmItem.alarm_time.toLocaleString('ko-KR', { hour12: true, hour: 'numeric', minute: 'numeric' });
// 					console.log("formatTime : " + formatTime)
					
					var strr = 	'<li class="alarmItem">';
					strr += 	'	<a href="alarmClick?url=' + changeLink + '">';
					strr += 	'	<div class="alarmTitle">';
					strr += 			alarmItem.alarm_type;
					strr += 			'<span class="alarmTime">';
					strr += 				formatTime;
					strr += 			'</span>';
					strr += 	'	</div>';
					strr += 	'	<div class="alarmContent">';
					strr += 			alarmItem.alarm_message;
					strr += 	'	</div>';
					strr += 	'	</a>';
					strr += 	'</li>';
					
					$("#alarmList").append(strr);
				}
 				
			},
			error: function(request,status,error) {
				alert("code:"+request.status+"\n"
						+"message:"+request.responseText+"\n"
						+"error:"+error);
 				console.log("DB 가져오기 실패");
			}
		});	// ajax 끝
		
	});	// 페이지 열때 조회하기
	
</script>
