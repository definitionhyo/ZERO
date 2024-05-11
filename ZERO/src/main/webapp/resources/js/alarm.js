/**
 * 알림 관련 함수들
 */
//	// 알림 메세지
//	let alarmMessage;
//	var socket;
//	// 로그인했을 경우만 알림 가능하게 하기 - 세션아이디 유무 판별
//	let receiver = "${member_id}";
//	console.log(receiver);
//	if(receiver != "") {
//		// 웹소켓 주소 설정 - 알림창 동기 설정
//	 	var websocketPath = document.currentScript.getAttribute('data-websocket-path');
//		socket = new SockJS(websocketPath);
////		socket = new SockJS('/alarm');
////		socket = new SockJS('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm');
//// 		socket = new SockJS('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/alarm?id=' + receiver);
//		// 서버에서 메세지를 보내면 자동으로 실행되는 함수
//		socket.onmessage = onAlarmMessage;
//		socket.onclose = onAlarmClose;
//		socket.onopen = onAlarmOpen;
//	}
//	
//	//채팅창에서 나갔을 때
//	function onAlarmClose(evt) {
//// 		var user = '${pr.username}';
//// 		var str = user + " 님이 퇴장하셨습니다.";
//// 		$("#msgArea").append(str);
//	}
//	//채팅창에 들어왔을 때
//	function onAlarmOpen(evt) {
//// 		var user = '${pr.username}';
//// 		var str = user + "님이 입장하셨습니다.";
//// 		$("#msgArea").append(str);
//	}
//	
// // receiver_id에게 type(알림 타입), msg(알림 내용) 문자열 하나로 보내기
//	function sendAlarmMessage(receiver_id, alarmType, alarmMsg) {
////		let sendSocket = new SockJS('/alarm?id=' + receiver_id);
//		
////		sendSocket.onopen = function() {
////			console.log("알림 보내는 소켓 연결!");
//			
//			// 보낼 알림 메세지 작성
//			// receiver_id에게 type(알림 타입), msg(알림 내용) 문자열 하나로 보내기
//	 		alarmMessage = receiver_id + ":" + alarmType + ":" + alarmMsg;
////			alarmMessage = alarmType + ":" + alarmMsg;
//			// 각 이벤트 시 받는 메세지를 소켓으로 전달
//			socket.send(alarmMessage);
////		};
//// 		sendSocket.onclose = function() {
//// 			console.log("알림 보내는 소켓 닫기!");
//// 		};
//		
//		
//		// 알림 내용을 DB에 저장하기
//// 		$.ajax({
//// 			data: {
//// // 				chat_datetime: now, // 이건 DB에 넣을 때 기본값으로 넣기
//// 				'chat_content': chatMessage,
//// 				'chat_content_type' : chat_content_type,
//// 				'room_idx': "${param.room_idx}",
//// 				'member_id': sender
//// 			},
//// 			url: "chatRemember",
//// 			type: "POST",
//// 			success: function(data) {
//// // 				console.log("DB 저장 성공");
//// 			},
//// 			error: function(request,status,error) {
//// 				alert("code:"+request.status+"\n"
//// 						+"message:"+request.responseText+"\n"
//// 						+"error:"+error);
//// // 				console.log("DB 저장 실패");
//// 			}
//// 		});	// ajax 끝
//		
//	}	// sendMessage(sender) 끝
//	
//		
//	//서버에서 메시지를 받았을 때
//	function onAlarmMessage(msg) {
//		
//		var data = msg.data;
//// 		var sessionId = null; // 데이터를 보낸 사람
//// 		var receiveId = null; // 알림 받을 아이디
//		var receiveType = null;
//		var receiveMessage = null;
//		
//		var arr = data.split(":");
//		console.log("받는 원 메세지 : " + data);
//		
////		var cur_session = '${member_id}'; //현재 세션에 로그인 한 사람
//		
//		receiveId = arr[0];
//		receiveType = arr[1];
//		receiveMessage = arr[2];
//		
//		console.log("받는 사람 : " + receiveId);
//		console.log("받는 알림 타입 : " + receiveType);
//		console.log("받는 알림 메세지 : " + receiveMessage);
//		
//		let now = new Date();
//		// 원하는 포맷으로 날짜와 시간을 포맷 (예: 오후 09:30)
//		let formattedTime = now.toLocaleString('ko-KR', { hour12: true, hour: 'numeric', minute: 'numeric' });
//		
//		// 메세지를 받을 아이디와 같은 경우만 표시해주기
//		if(receiver == receiveId) {
//			var strr = 	'<li class="alarmItem">';
//			strr += 	'	<div class="alarmTitle">';
//			strr += 			receiveType;
//			strr += 			'<span class="alarmTime">';
//			strr += 				formattedTime;
//			strr += 			'</span>';
//			strr += 	'	</div>';
//			strr += 	'	<div class="alarmContent">';
//			strr += 			receiveMessage;
//			strr += 	'	</div>';
//			strr += 	'</li>';
//			
//			$("#alarmList").append(strr);
//		}
//			
//	}