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
<%-- <%-- 알림 관련 함수 --%>
<%-- <script src="${pageContext.request.contextPath }/resources/js/alarm.js"></script> --%>
<%-- google 아이콘 --%>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/chat.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
<title>채팅 | ZERO</title>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript">
	
	let isOpen = false;
	// 버튼 클릭 시 목록보이게하는 함수
	$(function() {
		$(".listInfoBtn").on("click", function() {
			if(!isOpen) { // 목록이 열려있지 않으면
				$(".listSort").css("display", "initial");
				isOpen = true;
				
			} else {	// 목록 열려있으면
				$(".listSort").css("display", "none");
				isOpen = false;
			}
			
		});	// 버튼 클릭 시 호출되는 함수 끝
		
		$(".backBtn").on("click", function() {
			$("#chatArea").css("display", "none");
			
			// 채팅 종료
// 			sock.onclose = onClose;
// 			console.log("채팅 종료");
		}); // <- 버튼 클릭 시 호출되는 함수 끝
		
	});	// 함수 호출 끝
		
	// 채팅방 클릭 시 채팅방 보여지면서 채팅방 연결하기
	function openChatRoom(roomIdx) {
	//  => 채팅방 열기(채팅방 입장) + (추후) 알람 삭제
// 		$("#chatArea").css("display", "initial");
// 		$("#chatArea").append(
// 		);
		location.href = "chatRoom?room_idx=chat_" + roomIdx;
		
	} // 채팅방 클릭 시 함수 끝
	
	// 무한 페이지 스크롤
	let pageNum = 1;	// 임의로 설정
	let maxPage = 1;	// 최대 페이지 번호 미리 저장
	
	// 무한스크롤 기능 추가
	// 웹브라우저의 스크롤바가 바닥에 닿으면 다음 목록 조회를 위해 loadList() 함수 호출
	$(function() {
		$(window).on("scroll", function() {
			// 1. window 객체와 document 객체를 활용하여 스크롤 관련 값 가져와서 제어
			// => 스크롤바의 현재 위치, 문서가 표시되는 창(window)의 높이, 문서 전체 높이
			let scrollTop = $(window).scrollTop();	// 스크롤바 현 높이(위치)를 가지고 옴
			let windowHeight = $(window).height();	// 브라우저 창의 높이
			let documentHeight = $(document).height();	// 문서의 높이(창의 높이보다 크거나 같음)
			
			// 2. 스크롤바 위치값 + 창높이 + x 가 문서 전체 높이(documentHeight) 이상일 경우
			//		다음 페이지 게시물 목록 로딩하여 목록 하단에 추가
			let x = 50;	// 픽셀단위(여유값)
			if (scrollTop + windowHeight + x >= documentHeight) {
				// 최대 페이지번호를 초과하면
				if(pageNum <= maxPage) {
					console.log("값 받아오기");
					pageNum++;
					loadList();
				} else {
	//					alert("다음 페이지가 없습니다!");
				}
			}
			
		}); // window 끝
	}); // $(function(){}) 끝

	// 목록 불러오는 함수 정의
	function loadList() {
		// 컨트롤러로 보낼때 파라미터 처리
		let url;
		url = "chatListJson?pageNum=" + pageNum;
		
		$.ajax({
			type: "GET",
			url: url,
			dataType: "JSON",
			success: function(data) {
				maxPage = data.maxPage;
				// => 무한스크롤 시 
				console.log("maxPage : " + maxPage);
				
				// 기존에 있던 리스트 삭제
				let image = "";
				for(let room of data.chatRoomList) {
					
					// 아이디가 판매자일때
					if(room.buyer_id == "${member_id}") {
						image = '<td class="listImg" rowspan="2">';
						if(room.seller_image == null) {
							image += '<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png">';
						} else {
							image += '<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/upload/${room.seller_image }">';
						}
						image += '</td>';
						image += '<td class="chatRoomShort">';
						image += '	<span class="chatUserId">';
						image += 		room.seller_nickname;
						image += '	</span>';
						image += '	<span class="chatTimeFromNow">';
						image += 		room.chat_time_fromNow;
						image += '	</span>';
						image += '</td>';
						
					} else {	// 아이디가 구매자일 때
						image = '<td class="listImg" rowspan="2">';
						if(room.buyer_image == null) {
							image += '<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png">';
						} else {
							image += '<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/upload/${room.buyer_image }">';
						}
						image += '</td>';
						image += '<td class="chatRoomShort">';
						image += '	<span class="chatUserId">';
						image += 		room.buyer_nickname;
						image += '	</span>';
						image += '	<span class="chatTimeFromNow">';
						image += 		room.chat_time_fromNow;
						image += '	</span>';
						image += '</td>';
						
					}
					
					let roomInfo = '<tr class="listTr" onclick="openChatRoom(${room.chat_room_idx})">';
					roomInfo += image;
					roomInfo += '	<td class="productImg" rowspan="2">';
					roomInfo += '		<img alt="상품사진" src="${pageContext.request.contextPath }/resources/upload/${room.secondhand_image1 }">';
					roomInfo += '	</td>';
					roomInfo += '</tr>';
					roomInfo += '<tr onclick="openChatRoom(${room.chat_room_idx})">';
					roomInfo += '	<td class="shortChatMsg">';
					roomInfo += '		<div>' + room.chat_content + '</div>';
					roomInfo += '	</td>';
					roomInfo += '</tr>';
					
					// 목록에 표시할 JSON 객체 1개 출력문 생성(= 1개 채팅방) => 반복
					$("#chatList").append(roomInfo);
				}	// for문 종료
				
			}, error: function() {
				console.log("글 목록 요청 실패!");
			}
		});	// ajax 끝
		
	} // loadList() 끝
	
</script>
</head>
<body>
	<!-- header -->
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<%-- 크기 조절을 위해 main에 다 넣음 --%>
	<div id="chatListMain">
		
		<!-- 채팅 목록, 채팅창 영역 -->
		<div id="chatListMainArea">
			<!-- 채팅목록 영역 -->
			<aside id="chatListArea">
				<table id="chatList">
					<tr>
						<td id="title">채팅</td>
					</tr>
					<c:forEach var="room" items="${chatRoomList}">
							<tr class="listTr" onclick="openChatRoom(${room.chat_room_idx})">
								<c:choose>
									<c:when test="${room.buyer_id eq sessionScope.member_id }">
										<td class="listImg" rowspan="2">
											<c:choose>
											<%-- 프로필 사진 없을 때 --%>
												<c:when test="${empty room.seller_image }">
													<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png">
												</c:when>
												<c:otherwise>
													<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/upload/${room.seller_image }">
												</c:otherwise>
											</c:choose>
										</td>
										<td class="chatRoomShort">
											<span class="chatUserId">
												${room.seller_nickname }
											</span>
											<span class="chatTimeFromNow">
												${room.chat_time_fromNow }
											</span>
										</td>
									</c:when>
									<c:otherwise>
										<td class="listImg" rowspan="2">
											<c:choose>
											<%-- 프로필 사진 없을 때 --%>
												<c:when test="${empty room.buyer_image }">
													<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png">
												</c:when>
												<c:otherwise>
													<img alt="프로필사진" src="${pageContext.request.contextPath }/resources/upload/${room.buyer_image }">
												</c:otherwise>
											</c:choose>
										</td>
										<td class="chatRoomShort">
											<span class="chatUserId">
													${room.buyer_nickname }
											</span>
											<span class="chatTimeFromNow">
												${room.chat_time_fromNow }
											</span>
										</td>
									</c:otherwise>
								</c:choose>
								<td class="productImg" rowspan="2">
<%-- 									<img alt="상품사진" src="${pageContext.request.contextPath }/resources/img/happy.jpg"> --%>
									<img alt="상품사진" src="${pageContext.request.contextPath }/resources/upload/${room.secondhand_image1 }">
<%-- 									<a href="chatTest?room_idx=chat_${room.chat_room_idx}">채팅 테스트</a> --%>
								</td>
							</tr>
							<tr onclick="openChatRoom(${room.chat_room_idx})">
								<td class="shortChatMsg">
									<div>${room.chat_content }</div>
								</td>
							</tr>
					</c:forEach>
						
				</table>
			
			</aside>
			<!-- 채팅 영역 -->
		</div>
	</div>
	
	<!-- footer -->
	<footer>
		<%@ include file="../inc/footer.jsp"%>
	</footer>
</body>
</html>