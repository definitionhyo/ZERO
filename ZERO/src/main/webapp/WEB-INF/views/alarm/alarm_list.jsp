<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- google 아이콘 --%>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<title>ZERO</title>
<%-- 소켓통신을 위한 함수들을 콜백형태로 제공 --%>
<!-- <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script> -->
</head>
<body>
	<div class="alarmArticle">
		<div class="alarmContainer">
			<div class="alarmContentArea">
				<div class="alarmTitleArea">
					<div class="alarmTitle">
						알림 &nbsp;
<!-- 						<button onclick="alarmNotify('on')"><i class="material-icons">notifications_active</i><span>알림받기</span></button> -->
<!-- 						<button class="alarmBtn alarmBtnOff" onclick="alarmNotify()"><i class="material-icons">notifications_off</i></button> -->
					</div>
					<div class="detailArea">
						<a class="moreAlarm" href="alarmAll">더보기 > </a>
					</div>
				</div>
				<hr class="alarmHr">
				<ul id="alarmList">
				
				</ul>
				
			</div>
		</div><%-- container 영역 끝 --%>
	</div>
	
	<script type="text/javascript">
		// html문서 생성 시 notification 기능에 대한 허용 여부 확인
		window.onload = function() {
			if(window.Notification) {
				Notification.requestPermission();
				notify();
			}
		}
	
		// 알림받을지 여부를 묻는 함수(추후 구현 예정)
		function alarmNotify() {
			// 아이콘 클릭 시
// 			let alarmConfirm = confirm("알림 기능을 끄시겠습니까?");
// 			if(alarmConfirm) {
// 				Notification.permission = "denied";
// 			}
			// 1. notification 기능에 대한 허용 여부 확인하기
			if(window.Notification) {
				Notification.requestPermission();
				notify();
			}
		}
		
		function notify() {
			if(Notification.permission != "granted") {
				// 권한이 승인되지 않은 상태면 알람 표시 후 권한 다시 묻기
// 				alert('알림 권한이 허용되지 않은 상태입니다!');
				Notification.requestPermission(permission => {
					if(permission === "granted") {
// 						alert('알림 권한이 허용되었습니다!');
						$(".alarmBtn i").text('notifications_active');
						$(".alarmBtn").removeClass('alarmBtnOff');
						$(".alarmBtn").addClass('alarmBtnOn');
					} else {
// 						alert('알림 권한이 차단되었습니다!');
						$(".alarmBtn i").text('notifications_off');
						$(".alarmBtn").removeClass('alarmBtnOn');
						$(".alarmBtn").addClass('alarmBtnOff');
					}
				});
			} else {
 				// 권한이 승인된 상태면
// 				let confirm = confirm('알림 권한을 차단하시겠습니까?');
				Notification.requestPermission(permission => {
					if(permission === "granted") {
// 						alert('알림 권한이 허용되었습니다!');
						$(".alarmBtn i").text('notifications_active');
						$(".alarmBtn").removeClass('alarmBtnOff');
						$(".alarmBtn").addClass('alarmBtnOn');
					} else {
// 						alert('알림 권한이 차단되었습니다!');
						$(".alarmBtn i").text('notifications_off');
						$(".alarmBtn").removeClass('alarmBtnOn');
						$(".alarmBtn").addClass('alarmBtnOff');
					}
				});
				
			}
		}
	
	</script>
	
</body>
</html>