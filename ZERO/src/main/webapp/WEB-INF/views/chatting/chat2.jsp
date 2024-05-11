<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>

<%-- 소켓통신을 위한 함수들을 콜백형태로 제공 --%>
<!-- <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> -->
<%-- 알림 관련 함수 --%>
<%-- <script src="${pageContext.request.contextPath }/resources/js/alarm.js"></script> --%>
<%-- google 아이콘 --%>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/chat.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>채팅 | ZERO</title>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/js/sockjs.min.js"></script>
</head>
<body>
	<!-- header -->
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<%-- 세션 아이디 받기 - 없으면 fail_back --%>
	<input type="hidden" id="userid" value="${userid }">
	
	<%-- 크기 조절을 위해 main에 다 넣음 --%>
	<div id="main">
		<!-- nav - 메뉴영역 -->
		<nav>
			채팅
		</nav>
		<hr id="navLine">
		
		<!-- 채팅 목록, 채팅창 영역 -->
<!-- 		<div class="container"> -->
			<section id="chatArea"> <%-- style="display: none;" --%>
<%-- 				<%@ include file="chat.jsp"%> --%>
				<%-- 위에 상품정보와 약속잡기, 송금하기 등이 있는 영역 --%>
				<article class="chatPage">
<!-- 					<i class="material-icons backBtn">arrow_back</i> -->
<!-- 					<hr> -->
					<div class="art_firstRow">
						<div class="product_photo co01">
<%-- 							<img alt="상품사진" src="${pageContext.request.contextPath }/resources/img/슬라이드3.jpg" onclick="secondhandDetail()"> --%>
							<img alt="상품사진" src="${pageContext.request.contextPath }/resources/upload/${secondhandInfo.secondhand_image1}">
						</div>
						<div class="co02" onclick="secondhandDetail()">
							<div class="co02-1">${secondhandInfo.secondhand_deal_status }</div>
							<div class="co02-2">${secondhandInfo.secondhand_subject }</div><br>
							<div class="co02-3">
								<fmt:formatNumber pattern="###,###" value="${secondhandInfo.secondhand_price }"/>원
							</div>
						</div>
						<div class="co03">
<!-- 							<button> -->
<!-- 								<i class="material-icons">sim_card_alert</i>신고하기 -->
<!-- 							</button> -->
						</div>
					</div>
					<div class="art_secondRow">
						<div>
							<%-- 판매자의 경우 거래하기 아이콘버튼 넣기 --%>
							<%-- 판매자가 누르면 상태가 바뀐다는 것 알려주기 - 확인 - 상태 : 예약중으로 변경,  --%>
							<c:if test="${secondhandInfo.member_id eq sessionScope.member_id && secondhandInfo.secondhand_deal_status eq '판매중'}">
								<button id="doDeal" data-toggle="modal" data-target="#needConfirm">
									<i class="material-icons">done</i><span>거래하기 </span>
								</button>
							</c:if>
							<%-- 2. 약속버튼, z페이 보내기, 후기보내기(보냈으면 후기확인) 버튼 활성화 --%>
							<c:if test="${secondhandInfo.secondhand_deal_status eq '예약중' && orderSecondhandInfo.order_secondhand_buyer eq sessionScope.member_id}">
								<button onclick="reservationNext('time')"><i class="material-icons">access_time</i><span>약속잡기 </span></button>
								<c:if test="${isZpayUser && sessionScope.member_id eq chatRoom.buyer_id && orderSecondhandInfo.order_secondhand_status eq '거래진행중'}">
									<button onclick="reservationNext('zpay')" id="sendZpayBtn"><i class="material-icons">attach_money</i><span>송금하기 </span></button>
								</c:if>
								<%-- 직거래나 택배거나 결제까지 완료한 상태면 --%>
							</c:if>
							<c:if test="${orderSecondhandInfo.order_secondhand_buyer eq sessionScope.member_id && ((orderSecondhandInfo.order_secondhand_type eq ('직거래' or '택배') && orderSecondhandInfo.order_secondhand_status ne '거래완료')  || orderSecondhandInfo.order_secondhand_status eq '결제완료') }">
								<button id="dealFinish" data-toggle="modal" data-target="#needDoneConfirm">
									<i class="material-icons">done</i><span>거래완료 </span>
								</button>
							</c:if>
							<c:if test="${orderSecondhandInfo.order_secondhand_status eq '거래완료'}">
								<button onclick="reservationNext('review')"><i class="material-icons">edit</i><span>후기쓰기 </span></button>
							</c:if>
							<%-- 찜하기 버튼과 버튼 클릭 시 상태 변경용 히든 타입 태그 --%>
							<form id="openZform" method="post" action="ZpayForm" target="_blank">
							<c:if test="${not empty orderSecondhandInfo }">
							    <input type="hidden" name="order_secondhand_idx" value="${orderSecondhandInfo.order_secondhand_idx }">
							    <input type="hidden" name="order_secondhand_type" value="${orderSecondhandInfo.order_secondhand_type }">
							    <input type="hidden" name="secondhand_subject" value="${secondhandInfo.secondhand_subject }">
							    <input type="hidden" name="order_secondhand_price" id="order_secondhand_price" value=${orderSecondhandInfo.order_secondhand_price }>
							    <input type="hidden" name="seller_id" value="${chatRoom.seller_id}">
							    <input type="hidden" name="buyer_id" value="${chatRoom.buyer_id}">
							    <input type="hidden" name="seller_nickname" value="${chatRoom.seller_nickname}">
							    <input type="hidden" name="buyer_nickname" value="${chatRoom.buyer_nickname}">
							    <input type="hidden" name="secondhand_idx" value="${secondhandInfo.secondhand_idx }">
							</c:if>
							</form>
							
						</div>
					</div>
					<hr>
				</article>
				<%-- 채팅창 영역 --%>
				<div class="chatMsgInputArea">
					<div id="chatMsgArea">
						<%-- 나오는 채팅만큼 보여주고 위로 무한스크롤?
						세션아이디와 비교해 세션아이디가 보낸 메세지는 오른쪽, 아닌 메세지는 왼쪽으로 정렬 --%>
						<div id="msgArea"><%-- class="col" --%>
							<c:forEach var="chat" items="${chatList }">
								<c:choose>
									<%-- 채팅 타입이 '안내' 일 때 --%>
									<c:when test="${chat.chat_content_type eq '안내' or chat.member_id eq 'notice@test.com' }">
										<div class="noticeMsg">
											<span>
												${chat.chat_content }
											</span>
										</div>
									</c:when>
									<%-- 세션아이디가 보낸 아이디와 같을 때 --%>
									<c:when test="${chat.member_id eq sessionScope.member_id }">
										<div class="msgitem">
											<div class="alert msgRight">
												<div class="msgTime">
													<input type="hidden" class="date" value="${chat.chat_datetime }">
													<fmt:formatDate value="${chat.chat_datetime }" pattern="a hh:mm"/>
												</div>
												<div class="msg">
													<b>${chat.chat_content }</b>
												</div>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="msgitem">
											<div class="alert msgLeft">
												<div class="msg">
													<b>${chat.chat_content }</b>
												</div>
												<div class="msgTime">
													<input type="hidden" class="date" value="${chat.chat_datetime }">
													<fmt:formatDate value="${chat.chat_datetime }" pattern="a hh:mm"/>
												</div>
											</div>
										</div>
									
									</c:otherwise>
								</c:choose>
								
							</c:forEach>
							
							<!-- 이미지 등록 영역 -->
							<div id="img_zone">
								<div id="img_preview0">
									<input type="image" id="imgup_sum" onclick=""
										src="" width="150px" height="150px">
									<!-- 삭제버튼 -->
									<span id="del_sum" class="chk_style"  onclick="del_sum(1)">x</span>
								</div>
							</div>
						</div>
						<%-- 채팅 입력 영역 --%>
						<article class="inputArea">
							<div class="input-group mb-3"> <%-- style="display: none;" --%>
							<button class="listInfoBtn" style="display: none;" ><i class="material-icons">add</i></button><br>
								<div>
								</div>
								<c:choose>
									<c:when test="${secondhandInfo.secondhand_deal_status eq '판매중' || (sessionScope.member_id eq orderSecondhandInfo.order_secondhand_buyer || sessionScope.member_id eq orderSecondhandInfo.order_secondhand_seller) }">
										<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2">
										<div class="input-group-append">
											<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
										</div>
									</c:when>
									<c:otherwise>
										<input type="text" id="msg" class="form-control" placeholder="판매중인 아닌 상품은 채팅이 불가능합니다!" disabled aria-label="Recipient's username" aria-describedby="button-addon2">
										<div class="input-group-append">
											<button class="btn btn-outline-secondary" type="button" id="button-send" disabled>전송</button>
										</div>
									</c:otherwise>
								</c:choose>
								
							</div>
								<%-- + 버튼 클릭 시 나오는 기능들 --%>
								<div>
									<table class="listSort" style="display: none;"> <%-- style="display: none;" --%>
										<tr>
											<td>
												<a onclick="img_preview()">
													<i class="material-icons" id="imgup">photo</i><br>
													 사진보내기 
												</a>
												<!-- 파일업로드 용 폼 -->
												<form enctype="multipart/form-data" id="imgform" method="post" action="sendPhoto">
													<input type="file" id="sumimage"   name="chatImage" style="display: none;" accept=".jpg, .jpeg, .png">
	<!-- 												<input type="file" id="imageFile1" name="" style="display: none;" accept=".jpg, .jpeg, .png"> -->
	<!-- 												<input type="file" id="imageFile2" name="" style="display: none;" accept=".jpg, .jpeg, .png"> -->
												</form>
											</td>
											<td>
		<!-- 											<i class="material-icons">map</i>지도보내기(나의위치) -->
												<a><i class="material-icons">location_on</i><br> 지도보내기 </a>
											</td>
	<!-- 										<td> -->
	<!-- 											<a><i class="material-icons">access_time</i><br> 약속잡기 </a> -->
	<!-- 										</td> -->
	<!-- 										<td> -->
	<!-- 											<a><i class="material-icons">attach_money</i><br> 송금하기 </a> -->
	<!-- 										</td> -->
										</tr>
									</table>
								</div>
								<%-- 기능들 영역 끝 --%>
						</article>
						<%-- 채팅 입력 영역 끝 --%>
					</div>
				</div>
			</section>
				
<!-- 		</div> -->
		<!-- 채팅 구현 끝부분 -->
		
	</div>
	
	
	<%-- 거래금액, 거래수단 안내 모달 영역 --%>
	<div class="modal fade" id="needConfirm" tabindex="-1" role="dialog" aria-labelledby="needSessionId" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="needSessionId">거래하기 확인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center" id="modalMsg">
	      <%-- 메세지가 표시되는 부분 --%>
		      정말 상대방과 거래하시겠습니까?<br>
		      최종 거래금액을 입력하고 진행하실 거래방법을 눌러주세요<br>
		      <div class="modal-price">
		      	최종거래금액 : 
			    <input type="number" id="finalPrice" placeholder="ex) ${secondhandInfo.secondhand_price }" min="0">원<br>
			    <div>(Z맨 거래의 경우 거래완료 시<br>최종거래금액에서 3000원 뺀 금액이 Z페이로 입금됩니다.)</div>
			    <input type="hidden" id="dealPrice">
		      </div>
		      <div class="dealBtns">
	        	<button type="button" class="btn btn-dark" onclick="dealNext(1)" data-dismiss="modal" aria-label="Close">만나서 거래하기</button>
	        	<button type="button" class="btn btn-dark" onclick="dealNext(2)" data-dismiss="modal" aria-label="Close">Z맨 (+3000원)</button>
	        	<button type="button" class="btn btn-dark" onclick="dealNext(3)" data-dismiss="modal" aria-label="Close">택배로 받기</button><br>
		      </div>
	      </div>
	      <div class="modal-footer justify-content-center">
	        <button type="button" class="btn btn-dark" data-dismiss="modal" aria-label="Close">아니오</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<%-- 거래완료 안내 모달 영역 --%>
	<div class="modal fade" id="needDoneConfirm" tabindex="-1" role="dialog" aria-labelledby="needSessionId" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="needSessionId">거래완료 확인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body text-center" id="modalMsg">
	      <%-- 메세지가 표시되는 부분 --%>
		      물건은 잘 받아보셨나요?<br>
		      확인 버튼을 클릭하시면 거래가 종료됩니다! <br>
	      </div>
	      <div class="modal-footer justify-content-center">
        	<button type="button" class="btn btn-dark" onclick="reservationNext('done')" data-dismiss="modal" aria-label="Close">확인</button>
	        <button type="button" class="btn btn-dark" data-dismiss="modal" aria-label="Close">아니오</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
<%-- 사진 보내는 함수 관련 js파일 연결 --%>
<script src="${pageContext.request.contextPath }/resources/js/chat_img.js"></script>
<script type="text/javascript">
	
	// 스크롤 위치 조정
	// 요소 가져오기
	let scrollContainer = document.querySelector('#msgArea');
	// 요소 영역의 높이와 스크롤 높이 가져오기
	let scrollHeight = scrollContainer.scrollHeight;
	let containerHeight = scrollContainer.clientHeight;
	// 스크롤 위치 조정
	scrollContainer.scrollTop = scrollHeight - containerHeight;
	
	// 채팅 메세지
	let chatMessage;
	let chatImgMessage;
	// 채팅 보내는 사람(안내일때는 그때마다 바꾸는걸로)
	let sender = "${member_id}";
	
	//전송 버튼 누르는 이벤트
	$("#button-send").on("click", function(e) {
		chatMessage = $('#msg').val();
		chatImgMessage = $("#imgform input").val();
		
		if(chatMessage != "") {	// 빈칸이 아닐때만 전송하기
			sendMessage(sender);
			$('#msg').val('');
		}
// 		else if(chatImgMessage != "") {	// 이미지가 있을 때 버튼을 누르면
// 			console.log(chatImgMessage);
// 			var form = document.getElementById("imgform");
// 	        form.submit();
// 		}
	});
	
	// 엔터 누르면 보내지는 이벤트
	$("#msg").keydown(function(key) {
		chatMessage = $('#msg').val();
		
		if(chatMessage != "" && key.keyCode == 13) {
			sendMessage(sender);
			$('#msg').val('');
		}
	});
	
	// 채팅일 알람(다른날 채팅이면 날짜 알려주기)
	// 채팅창에서 가장 최근 올라온 메세지의 datetime을 받음(sethour)
	let lastDatetime = new Date($(".date").last().val());
// 	console.log("최후 : " + lastDatetime);	// Thu Aug 03 2023 00:00:00 GMT+0900
	let formatNow = formatDate(new Date());
	
	function formatDate(data){
        let date = new Date(data);
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');

        let formattedDate = year + '년 ' + month + "월 " + day + "일 ";
        return formattedDate;
    }
	
// 	console.log(formatDate(lastDatetime));
// 	console.log(now);
	
	// ================== 웹소켓을 통한 채팅창 동기 과정 ==================================
	var sock = new SockJS('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chatting?=chat_${param.room_idx}');
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;
	
	function sendMessage(sender) {
		
		let chat_content_type = '일반';

		if(formatDate(lastDatetime) != formatNow) {
			formatNow = "&-안내" + formatNow;
			sock.send(formatNow);
			
			// 안내 내용을 DB에 저장하기
			$.ajax({
				data: {
//	 				chat_datetime: now, // 이건 DB에 넣을 때 기본값으로 넣기
					'chat_content': formatNow,
					'chat_content_type' : '안내',
					'room_idx': "${param.room_idx}",
					'member_id': "notice@test.com"
				},
				url: "chatRemember",
				type: "POST",
				success: function(data) {
					console.log("DB 저장 성공");
					
				},
				error: function(request,status,error) {
					alert("code:"+request.status+"\n"
							+"message:"+request.responseText+"\n"
							+"error:"+error);
// 					console.log("DB 저장 실패");
				}
			});	// ajax 끝
		} else if(sender == 'notice@test.com') {
			// 안내메세지 관리
			chat_content_type = '안내';
		}
// 		console.log("sender 안내가 맞나? :" + (sender == 'notice@test.com'));
		// 채팅 내용을 DB에 저장하기
		$.ajax({
			data: {
// 				chat_datetime: now, // 이건 DB에 넣을 때 기본값으로 넣기
				'chat_content': chatMessage,
				'chat_content_type' : chat_content_type,
				'room_idx': "${param.room_idx}",
				'member_id': sender
			},
			url: "chatRemember",
			type: "POST",
			success: function(data) {
// 				console.log("DB 저장 성공");
			},
			error: function(request,status,error) {
				alert("code:"+request.status+"\n"
						+"message:"+request.responseText+"\n"
						+"error:"+error);
// 				console.log("DB 저장 실패");
			}
		});	// ajax 끝
		
		// 각 이벤트 시 받는 메세지를 소켓으로 전달
		sock.send(chatMessage);
		
	}// sendMessage(sender) 끝
	
	//서버에서 메시지를 받았을 때
	function onMessage(msg) {
		
		var data = msg.data;
		var sessionId = null; //데이터를 보낸 사람
		var message = null;
		
		var arr = data.split(":");
		
// 		for(var i=0; i<arr.length; i++){
// 			console.log('arr[' + i + ']: ' + arr[i]);
// 		}
		var cur_session = '${member_id}'; //현재 세션에 로그인 한 사람
		
		sessionId = arr[0];
		message = arr[1];
		
		let now = new Date();
		// 원하는 포맷으로 날짜와 시간을 포맷 (예: 오후 09:30)
		let formattedTime = now.toLocaleString('ko-KR', { hour12: true, hour: 'numeric', minute: 'numeric' });
		
		if(message.startsWith("&-안내")) {	// 안내메세지인 경우
			let noticeMessage = message.split("&-안내")[1];
			var str = '<div class="noticeMsg">';
// 			str += '<div>';
			str += noticeMessage;
// 			str += '</div>';
			str += '</div>';
			
			$("#msgArea").append(str);
// 			console.log("안내문자 :" + noticeMessage);
			
		}else if(sessionId == cur_session){ //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
			
			var str = "<div class='msgitem'>";
			str += "<div class='alert msgRight'>";
			str += "<div class='msgTime'>";
			str += formattedTime;
			str += "</div>";
			str += "<div class='msg'>";
			str += "<b>" + message + "</b>";
// 			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div></div>";
			
			$("#msgArea").append(str);
			
			// 알림 보내기
			let messager = null;
			let holder = null;
			if(sessionId == "${chatRoom.seller_id}") {
				messager = "${chatRoom.seller_nickname}";
				holder = "${chatRoom.buyer_id}";
			} else {
				messager = "${chatRoom.buyer_nickname}";
				holder = "${chatRoom.seller_id}";
			}
			
			// 알림 보내는 함수
			sendAlarmMessage(holder, "채팅", messager + " : " + message, "chatRoom?room_idx=chat_" + "${chatRoom.chat_room_idx}");
			
		} else{
			
			var str = "<div class='msgitem'>";
			str += "<div class='alert msgLeft'>";
			str += "<div class='msg'>";
			str += "<b>" + message + "</b>";
// 			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div>";
			str += "<div class='msgTime'>";
			str += formattedTime;
			str += "</div></div></div>";
			
			$("#msgArea").append(str);
		}
	    
		// 스크롤 위치 조정
		// 요소 가져오기
		scrollContainer = document.querySelector('#msgArea');
		// 요소 영역의 높이와 스크롤 높이 가져오기
		scrollHeight = scrollContainer.scrollHeight;
		containerHeight = scrollContainer.clientHeight;
		// 스크롤 위치 조정
		scrollContainer.scrollTop = scrollHeight - containerHeight;
	}
	//채팅창에서 나갔을 때
	function onClose(evt) {
// 		var user = '${pr.username}';
// 		var str = user + " 님이 퇴장하셨습니다.";
// 		$("#msgArea").append(str);
	}
	//채팅창에 들어왔을 때
	function onOpen(evt) {
// 		var user = '${pr.username}';
// 		var str = user + "님이 입장하셨습니다.";
// 		$("#msgArea").append(str);
	}
	
	// ==========================================================================
	// 무한 스크롤 구현중
	// 전역변수 (함수바깥에 정의)
	let pageNum = 1;	// 임의로 설정 (1은 따로 미리 받아옴)
	let maxPage = 1;	// 최대 페이지 번호 미리 저장
	
	// 스크롤 위치 저장
	scrollContainer = document.querySelector('#msgArea');
	// 요소 영역의 높이와 스크롤 높이 가져오기
	containerHeight = scrollContainer.clientHeight;
// 	scrollHeight = scrollContainer.scrollHeight;
	// 스크롤 위치 조정
// 	scrollContainer.scrollTop = scrollHeight - containerHeight;
	
	let chatScrollTop;
	let msgAreaHeight;
	
	$("#msgArea").on("scroll", function() {
		// 1. window 객체와 document 객체를 활용하여 스크롤 관련 값 가져와서 제어
		// => 스크롤바의 현재 위치, 문서가 표시되는 창(window)의 높이, 문서 전체 높이
		chatScrollTop = $("#msgArea").scrollTop();	// 스크롤바 현 높이(위치)를 가지고 옴
		msgAreaHeight = $("#msgArea").height();	// 브라우저 창의 높이
// 		documentHeight = $("#msgArea").clientHeight;	// 문서의 높이(창의 높이보다 크거나 같음)
// 		console.log("chatScrollTop : " + chatScrollTop);
// 		console.log("msgAreaHeight : " + msgAreaHeight);
// 		console.log("documentHeight : " + documentHeight);
	});
	
	// 스크롤 감지 이벤트 핸들러
	function handleScroll() {
// 		var chatArea = document.getElementById("msgArea");
// 		if(chatArea.scrollTop === 0) {
		if(chatScrollTop === 0) {
			
			// 사용자가 스크롤을 위로 올렸을 때 처리하는 로직
			console.log("새로운 채팅 로드하기!");
			if(pageNum <= maxPage) {
				let prevChatHeight = $("#msgArea").clientHeight;
				
				pageNum++;
				loadList();
				
				// 업데이트 후 스크롤 위치 유지하기
				let newScrollHeight = $("#msgArea").clientHeight;
				let scrollOffset = newScrollHeight - prevChatHeight;
				$(this).scrollTop(scrollOffset);
				// 스크롤 위치 조정
// 				containerNextHeight = scrollContainer.clientHeight;
// 				scrollContainer.scrollTop = documentHeight;
			} else {
				
			}
		}
	}
	
	// 스크롤 감지 이벤트 등록
	var chatArea = document.getElementById("msgArea");
	chatArea.addEventListener("scroll", handleScroll);
	
	// 목록 불러오는 함수 정의		

	function loadList() {
		let url;
		// 컨트롤러로 보낼때 파라미터 처리
		url = "chatMsgList?pageNum=" + pageNum + "&chat_room_idx=" + ${chat_room_idx};
		console.log(url);
		$.ajax({
			type: "GET",
			url: url,
			dataType: "JSON",
			success: function(data) {
				maxPage = data.maxPage;
// 				console.log(maxPage);
				// => 무한스크롤 시 
				console.log("maxPage : " + maxPage);
// 				$("#listCount").text(data.listCount);
				
				for(let chat of data.beforeChatList) {
					// 영역에 넣을 메세지 하나
					let chatItem;
					let datetime = new Date(chat.chat_datetime);
					let formattedTime = datetime.toLocaleString('ko-KR', { hour12: true, hour: 'numeric', minute: 'numeric' });
					// 안내 메세지일 때
					if(chat.chat_content_type == '안내' || chat.member_id == 'notice@test.com') {
						chatItem = '<div class="noticeMsg">';
						chatItem += '<span>';
						chatItem += chat.chat_content;
						chatItem += '</span>';
						chatItem += '</div>';
					
					} else if(chat.member_id == '${sessionScope.member_id}') {
						// 메세지 보낸 사람이 (로그인 한)본인일 때
						chatItem = '<div class="msgitem">';
						chatItem += '	<div class="alert msgRight">';
						chatItem += '		<div class="msgTime">';
						chatItem += 			formattedTime;
						chatItem += '		</div>';
						chatItem += '		<div class="msg">';
						chatItem += '			<b>' + chat.chat_content + '</b>';
						chatItem += '		</div></div></div>';
						
					} else {
						// 채팅
						chatItem = '<div class="msgitem">';
						chatItem += '	<div class="alert msgLeft">';
						chatItem += '		<div class="msg">';
						chatItem += '			<b>' + chat.chat_content + '</b>';
						chatItem += '		</div>';
						chatItem += '		<div class="msgTime">';
						chatItem += 			formattedTime;
						chatItem += '		</div></div></div>';
					}
						
					// 목록에 표시할 JSON 객체 1개 출력문 생성(= 1개 게시물) => 반복
					$("#msgArea").prepend(chatItem);
				}	// for문 종료
				
			}, error: function() {
				alert("글 목록 요청 실패!");
			}
		});	// ajax 끝
		
	} // loadList() 끝
	
	// ====================== 텍스트 외 다른 입력 기능 ==========================
	let isOpen = false;
	// 버튼 클릭 시 목록보이게하는 함수
	$(function() {
		$(".listInfoBtn").on("click", function() {
			if(!isOpen) { // 목록이 열려있지 않으면
				$(".listSort").css("display", "");
				isOpen = true;
				
				
			} else {	// 목록 열려있으면
				$(".listSort").css("display", "none");
				isOpen = false;
			}
			
		});	// 버튼 클릭 시 호출되는 함수 끝
		
		// Z맨 호출 정보를 입력 외에는 사용못하게 하기
		if("${zmanCallInfo.zman_delivery_status}" == '입력 중') {
			$(".callZBtn").attr("disabled", false);
		} else {
			$(".callZBtn").attr("disabled", true);
		}
		
		
	});	// 함수 호출 끝
	
	function secondhandDetail() {
		// 상품정보 클릭 시 상품 글로 이동
		location.href = "secondhand_detail?secondhand_idx=" + ${chatRoom.secondhand_idx} + "&member_id=" + "${chatRoom.seller_id}";
	}
	
	
	// ================= 버튼들 기능 함수 =========================
	// 거래를 위한 변수와 함수들
	let finalPrice;
	function dealNext(num) {
		// 전역변수
		finalPrice = $("#finalPrice").val();
		$("#order_secondhand_price").attr("value", finalPrice);
		$("#dealPrice").attr("value", finalPrice);
		
		
		if(finalPrice == "") {
			alert("최종 거래 금액이 입력되지 않았습니다!\n입력 후 거래방법을 눌러주세요!");
			return;
		}
		
		let chatMessageBtn;
		
		// 채팅내용 : chatMessage에 저장(안내니까 "-&안내" 붙이기)하고 sendMessage(sender) 실행시키기
		switch(num) {
			case 1 :
				// 1-1. 만나서 거래하기 클릭 => 안내 메세지 띄우기
				chatMessage = '&-안내' + '${chatRoom.seller_nickname}' + '님이 <b>만나서 거래하기</b>를 선택하셨습니다.<br> 안전거래 되세요!<br>';
				chatMessage += '최종가격  <span id="payPrice">' + finalPrice + '</span>원';
				setOrderSecondhand("직거래");
				break;
			case 2 :
				// 1-2. z맨 클릭 => 안내 메세지 띄우고 판매자-출발주소, 구매자-도착주소 받는 폼 보여주기(보고나서는 수정불가)
				chatMessage = '&-안내' + '${chatRoom.seller_nickname}' + '님이 <b>Z맨으로 거래하기</b>를 선택하셨습니다.<br> 출발지와 도착지를 입력해주세요!<br>';
				chatMessage += '최종가격  <span id="payPrice">' + finalPrice + '</span>(+ 3000)원<br>';
				chatMessageBtn = '<button class="btn btn-dark callZBtn" onclick="toZ()">';
				chatMessageBtn += 'Z맨 호출 접수</button>';
				setOrderSecondhand("Z맨");
				chatMessage += chatMessageBtn;
				break;
			case 3 :
				// 1-3. 택배로 받기 클릭 => 안내 메세지 띄우고 판매자에게 택배회사 주소가 담긴 버튼 보여주기(안내메세지 판별해 버튼 보여주기)
				chatMessage = '&-안내' + '${chatRoom.seller_nickname}' + '님이 <b>택배로 받기</b>를 선택하셨습니다.<br> 안전거래 되세요!<br>';
				chatMessage += '최종가격  <span id="payPrice">' + finalPrice + '</span>원<br>';
				chatMessage += '<c:if test="${secondhandInfo.member_id eq sessionScope.member_id}">';
				chatMessageBtn = '<button class="btn btn-dark applyTB" onclick="location.href=\'https://www.cjlogistics.com/ko/tool/parcel/reservation-general\'">CJ대한통운 택배예약</button>';
				chatMessageBtn1 = '</c:if>';
				setOrderSecondhand("택배");
				// 세션에 따라 보이는 값 달리하기 위한 변수들 합쳐서 DB에 저장하기
				chatMessage += chatMessageBtn + chatMessageBtn1;
				// 일시적으로 보이게 하기(DB저장은 아님)
				break;
				
		}	// switch문 끝
		// 메세지 보내기
		sendMessage('notice@test.com');
		
		// 거래하기 비활성화
		$("#doDeal").attr("disabled", true);
		
		// 알림 보내는 함수
		sendAlarmMessage("${chatRoom.buyer_id}", "거래", "${chatRoom.seller_nickname}" + "님이 거래하기를 선택하셨습니다!", "chatRoom?room_idx=chat_" + "${chatRoom.chat_room_idx}");
		// 2. 약속버튼, z페이 보내기, 후기보내기(보냈으면 후기확인) 버튼 활성화
				
	}	// 거래버튼 시 실행 함수 끝
	
	// 받은 거래타입과 금액, 채팅방에 있는 정보(buyer_id, seller_id, secondhand_idx, secondhand_product)를
	// DB ORDER_SECONDHAND에 저장
	function setOrderSecondhand(type) {
		
		$.ajax({
			data: {
				"type": type,
				"order_secondhand_price": finalPrice,
				"order_secondhand_seller": "${chatRoom.seller_id}",
				"order_secondhand_buyer": "${chatRoom.buyer_id}",
				"order_secondhand_product": "${secondhandInfo.secondhand_subject }",
				"secondhand_idx" : ${chatRoom.secondhand_idx}
			},
			url: "ChatDeal",
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
		});	// ajax끝
		
	}	// setOrderSecondhand() 끝
	
	let payPrice = $("#payPrice").text();
	// Z맨 호출 폼으로 이동하기 위함 함수
	function toZ() {
		console.log("금액 : " + payPrice);
// 		console.log("${secondhandInfo.secondhand_idx }");
// 		console.log("${secondhandInfo.secondhand_subject }");
// 		console.log("${chatRoom.seller_id}");
// 		console.log("${chatRoom.buyer_id}");
		let requestUrl = "chatToZ?"
				+ "&order_secondhand_idx=" + "${orderSecondhandInfo.order_secondhand_idx }"
				+ "&secondhand_idx=" + "${secondhandInfo.secondhand_idx }"
// 				+ "&secondhand_subject=" + "${secondhandInfo.secondhand_subject }"
				+ "&order_secondhand_price=" + payPrice
				+ "&seller_id=" + "${chatRoom.seller_id}"
				+ "&buyer_id=" + "${chatRoom.buyer_id}"
				+ "&order_secondhand_status=" + "${orderSecondhandInfo.order_secondhand_status}"
				;
				
		window.open(requestUrl, "newWindow", "width=450, height=600, left=500, top=100");
	}
	
	// 새 창에서 받아와서 안내채팅치기
	// Z맨 호출하기를 누르면 실행되는 함수(채팅)
	function subNotice(type, typeMsg) {
		switch(type) {
			case 'call':
				chatMessage = "&-안내" + typeMsg;
				sendMessage('notice@test.com');
				$(".callZBtn").attr("disabled", true);
				// 알림 보내는 함수
				sendAlarmMessage("${chatRoom.buyer_id}", "Z맨"
						, "Z맨 호출이 접수되었습니다! 상품명 - " + "${secondhandInfo.secondhand_subject }", "chatRoom?room_idx=chat_" + "${chatRoom.chat_room_idx}");
				break;
			case 'zpay':
				chatMessage = "&-안내" + typeMsg;
				sendMessage('notice@test.com');
				$("#sendZpayBtn").hide();
				break;
		}
	}
	
	
	function reservationNext(type) {
		// 전역변수
		let reservUrl;
		switch(type) {
			case 'time' :
// 				reservUrl = ;
				break;
			case 'zpay' :
				console.log("송금할 최종 가격 : " + payPrice);
		        var form = document.getElementById("openZform");
		        form.submit();
				
				break;
			case 'review' :
// 				reservUrl = ;
				break;
			case 'done' :	// 거래완료 - 확인 클릭 시
				// zpay를 사용한 경우
				if ("${orderSecondhandInfo.order_secondhand_status}" == '결제완료' ) {
					let doneUrl = "zpay_send_to_seller";
					let idx = ${orderSecondhandInfo.order_secondhand_idx} + 0 ;
					
					$.ajax({
						data: {
							"order_secondhand_idx": idx,
						},
						url: doneUrl,
						type: "POST",
						success: function(data) {
							console.log("거래완료 의사 전달 완료 - Z맨, Z페이");
						},
						error: function(request,status,error) {
// 							alert("놀라지마세요! z맨, z페이 거래완료 테스트중인데 DB에 잘들어가요!\n" + "error:" + error);
							console.log("DB 저장 실패 - z맨");
							chatMessage = "거래가 완료되었습니다! 후기로 서로에게 따뜻한 마음을 전해보세요!";
							sendMessage('notice@test.com');
							// 알림 보내는 함수
						}
					});	// ajax끝
				}	// if문 끝
				
				// 공통적으로 중고상품 판매완료라고 상태변경하기
				$.ajax({
					data: {
						"secondhand_idx": ${secondhandInfo.secondhand_idx },	//여기까지함 => (상품)판매완료, (오더)거래완료 수정해주기
					},
					url: "finishDeal",
					type: "POST",
					success: function(data) {
						console.log("거래완료 의사 전달 완료 - 택배, 만나서의 경우");
						
					},
					error: function(request,status,error) {
						alert("놀라지마세요! 상태변경하는 테스트중인데 DB에 잘들어가요!\n" + "error:" + error);
						console.log("DB 저장 실패 - 택배, 만나서의 경우");
					}
				});	// ajax끝
				
				// 작업 끝나면 버튼에 비활성화하기
				$("#dealFinish").attr("disabled", true);
				
				break;
		}
		// switch문 끝
	}
	

	
</script>
	
	<!-- footer -->
<!-- 	<footer> -->
<%-- 		<%@ include file="../inc/footer.jsp"%> --%>
<!-- 	</footer> -->
</body>
</html>