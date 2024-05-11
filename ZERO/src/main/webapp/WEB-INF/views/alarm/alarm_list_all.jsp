<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link href="${pageContext.request.contextPath }/resources/css/zpay.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" /> -->

<meta charset="UTF-8">
<title>ZERO</title>
<style type="text/css">
	
	article {
		padding-bottom: 10px;
	}
	.container {
		padding-bottom: 0;
	}
	
	.daterangepicker td.in-range {
		background-color: #EBF4E9;
		border-color: transparent;
		color: #000;
		border-radius: 0;
	}
	
	.daterangepicker td.active, .daterangepicker td.active:hover {
		background-color: #09aa5c;
		border-color: transparent;
		color: #fff;
	}
	
	.daterangepicker td.end-date {
		border-radius: 0 4px 4px 0;
	}
	
	.daterangepicker td.start-date {
		border-radius: 4px 0 0 4px;
	}
	.profileInfo {
		padding-top: 10px;
	}
	#alarmMember {
		font-size: 20px;
	}
	#alarmNotice {
		color: gray;
		font-size: 15px;
		padding-top: 5px;
	}
	#alarmNotice i{
		color: #999;
		font-style: normal;
		font-size: 13px;
	}
	
</style>
<script type="text/javascript">
	
	let maxPage = 1;
	let pageNum = 1;
	
	$(function() {
		loadAlarmList('전체');
		
		$(".btn-group input[type=button]").on("click", function() {
			$(".btn-group input[type=button]").removeClass("active");
			$(this).addClass("active");
			loadAlarmList($(this).val());
		});	// 버튼 클릭 시 함수 끝
		
	});	// function() 끝
	
	function loadAlarmList(category) {
		
		$.ajax({
			type: "POST",
			data: {"category" : category},
			url: "alarmList",
			dataType: "JSON",
			success: function(data) {
				
				maxPage = data.maxPage;
				console.log(maxPage);
				// => 무한스크롤 시 
// 				console.log("maxPage : " + maxPage);
				$("#listCount").text(data.listCount);
				
				// 기존에 있던 리스트 삭제
				$(".zpayHistoryListArea ul").empty();
				
				for(let alarm of data.alarmList) {
					let isRead = "";
					if(alarm.alarm_isread == 'Y') {
						isRead = "isRead";
					}
					let date = new Date(alarm.alarm_time);
					let formatDate = ('0' + (date.getMonth() + 1)).slice(-2) + "." + ('0' + date.getDate()).slice(-2);
					let formatTime = ('0' + date.getHours()).slice(-2) + ":" + ('0' + date.getMinutes()).slice(-2);
					
					// 목록에 표시할 JSON 객체 1개 출력문 생성(= 1개 게시물) => 반복
					let str = '<li>'
							+ '	<div class="zpayHistoryItem">'
							+ '		<div class="zpayHistoryItem_date">'
							+ 			formatDate
							+ '		</div>'
							+ '		<div class="zpayHistoryItem_infoArea">'
							+ '			<div class="zpayHistoryItem_info">'
							+ '				<a href="alarmClick?url=' + alarm.alarm_link.replace("?", "--") + '" class="itemTitle itemLink ' + isRead + '">'
							+ 					alarm.alarm_type
							+ '					<div class="zpayHistoryItem_info_sub">'
							+ '						<span class="payTime">'
							+ 							formatTime
							+ '						</span>'
							+ '						<span class="paymentType  ' + isRead + '">' + alarm.alarm_message + '</span>'
							+ '					</div>'
							+ '				</a>'
							+ '		</div></div></div>'
							+ '	</li>'
					
					$(".zpayHistoryListArea ul").append(str);
				}	// for문 종료
				
			}, error: function() {
				alert("글 목록 요청 실패!");
			}
		});	// ajax 끝
	}	// loadAlarmList() 함수 끝
	
</script>
</head>
<body>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	<article>
		<div class="container">
			<div class="contentAreaZpay">
			<%-- 메인영역 --%>
				<div class="zpayManageArea">
					<div class="profileArea">
						<div class="profileInfo">
							<div id="alarmMember">
								<strong class="profileName">
									${sessionScope.member_id }님이 받은 알림
								</strong>
							</div>
							<div id="alarmNotice">
								지난 <b>3개월</b>까지의 구매내역을 확인하실 수 있습니다.<br>
								<i>채팅은 채팅 카테고리에서 확인가능</i>
							</div>
						</div>
					</div>
				</div><%-- zpayManageArea 영역 끝 --%>
				<div class="zpayHistoryArea">
					<div class="zpayHistoryFilter">
						<div class="btn-group">
							<input type="button" class="dealType btn btn-sm btn-outline-dark rounded-pill mr-1 active" value="전체">
							<c:forEach var="category" items="${categories }">
								<input type="button" class="dealType btn btn-sm btn-outline-dark rounded-pill mr-1" value="${category }">
							</c:forEach>
						</div>
					</div>
					<div class="zpayHistoryDateSelect" style="display: flex;">
						
					</div>
					<div class="zpayHistoryPeriodArea">
						총 <strong id="listCount"></strong> 건
					</div>
					<div class="zpayHistoryListArea">
						<ul>
						
						</ul>
					</div><%-- zpayHistoryListArea 영역 끝 --%>
				</div><%-- zpayHistoryArea 영역 끝 --%>
			</div><%-- contentArea 영역 끝 --%>
		</div><%-- container 영역 끝 --%>
	</article>
	<footer>
		<%@ include file="../inc/footer.jsp"%>
	</footer>

</body>
</html>