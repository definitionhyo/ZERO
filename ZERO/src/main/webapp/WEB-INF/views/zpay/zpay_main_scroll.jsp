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
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<meta charset="UTF-8">
<title>ZERO</title>
<style type="text/css">
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
	
	#-to-top {
  position: fixed;
  bottom: 50px;
  right: 50px;
  text-align: center;
  text-decoration: none;
  color: #FFFFFF;
  background-color: #2d2d2d;
  padding: 10px 12px;
  border-radius: 4px;
  font-size: 14px;
  z-index: 99;
}
</style>
<script type="text/javascript">
	let pageNum = 1;	// 기본 페이지 번호 미리 저장 - 전역변수(함수 밖에 있음)
	let maxPage = 1;	// 최대페이지 번호를 미리 저장
	let selectedSearchType = null;
	let selectedStartDate = null;
	let selectedEndDate = null;
	
	let requestData = {};	// ajax 요청 시 data를 넣을 객체
		
	$(function() {
		updateTransactionHistory();
		
		// 무한스크롤 기능 추가
		// 웹브라우저의 스크롤바가 바닥에 닿으면 다음 목록 조회를 위해 updateTransactionHistory() 함수 호출
		$(window).on("scroll", function() {	// 스크롤 동작 시 이벤트 처리
			let scrollTop = $(window).scrollTop();	// 스크롤바 현재 위치
			let windowHeight = $(window).height();	// 브라우저 창의 높이
			let documentHeight = $(document).height();	// 문서의 높이(창의 높이보다 크거나 같음)
			
			let x = 1;
			if(scrollTop + windowHeight + x >= documentHeight){
				if(pageNum < maxPage) {
					pageNum++;
					updateTransactionHistory();
				}else{
// 						alert("다음페이지가 없습니다");
				}
			}
			
		});	// 무한스크롤 끝
		
		// dealType 타입 선택 시 updateTransactionHistory() 함수 실행
		$(".dealType").on("click", function() {
			$(".dealType").removeClass("active");
			$(this).addClass("active");
			
			selectedSearchType = $(this).val();
			pageNum = 1; // 거래 유형 변경 시 페이지 번호 초기화
			$(".zpayHistoryListArea > ul").empty();
			updateTransactionHistory();
		});
	
		// 날짜 선택 시 updateTransactionHistory() 함수 실행
		$('input[name="datetimes"]').daterangepicker({
		    "showWeekNumbers": true,
		    "showDropdowns": true,
		    "locale": {
		        "format": "YYYY.MM.DD",
		        "separator": " ~ ",
		        "applyLabel": "조회",
		        "cancelLabel": "취소",
		        "fromLabel": "From",
		        "toLabel": "To",
		        "customRangeLabel": "Custom",
		        "weekLabel": "W",
		        "daysOfWeek": [
		            "일",
		            "월",
		            "화",
		            "수",
		            "목",
		            "금",
		            "토"
		        ],
		        "monthNames": [
		            "1월",
		            "2월",
		            "3월",
		            "4월",
		            "5월",
		            "6월",
		            "7월",
		            "8월",
		            "9월",
		            "10월",
		            "11월",
		            "12월"
		        ],
		        "firstDay": 1
		    },
		    "startDate": moment().startOf('date').add(-1, 'month'),	// 기본 선택 시작일
		    "endDate": moment().startOf('date'),	// 기본 선택 마지막일
		    "maxDate": new Date(),	// 선택할 수 있는 가장 마지막날
		    "opens": "center",
		    "drops": "auto",
		    "applyButtonClasses": "btn-dark"
		}, function(start, end, label) {
			selectedStartDate = start;
			selectedEndDate = end;
			pageNum = 1; // 거래 유형 변경 시 페이지 번호 초기화
			$(".zpayHistoryListArea > ul").empty();
			
			updateTransactionHistory();
			
		});	// daterangepicker() 끝
		
// 		updateTransactionHistory();
	});
			
	function updateTransactionHistory() {	
		
		requestData.pageNum = pageNum;
		
		if (selectedSearchType) {
		    requestData.searchType = selectedSearchType;
		}
		if (selectedStartDate && selectedEndDate) {
		    requestData.startDate = selectedStartDate.format('YYYY-MM-DD 00:00:00');
		    requestData.endDate = selectedEndDate.format('YYYY-MM-DD 23:59:59');
		}
		
		$.ajax({
			type : "GET", 
			url : "zpay_main_ajax", 
			data : requestData, 
			dataType : "JSON", 
			success : function(data) {
				maxPage = data.maxPage;	// 무한스크롤 다음 페이지 로딩 과정에서 페이지번호와 비교 시 활용
				console.log(maxPage);
						
// 				if(data.zpayHistoryList == ""){
// 					$(".zpayHistoryListArea").html("<div class='noHistory'>ZPAY 사용 내역이 존재하지 않습니다.</div>")
// 				}
				
				let res = ""; 
				
				for(let zpayHistory of data.zpayHistoryList) {
					res += "<li>" + 
								"<div class='zpayHistoryItem'>" + 
									"<div class='zpayHistoryItem_date'>" + 
										getFormatDate(zpayHistory.zpay_time) + 
									"</div>" + 
									"<div class='zpayHistoryItem_infoArea'>" +
										"<div class='zpayHistoryItem_info'>"
											if(zpayHistory.zpay_deal_type == '충전' || zpayHistory.zpay_deal_type == '환급') {
												res += "<a class='itemTitle itemLink'>" + zpayHistory.zpay_deal_type + "</a>"
											} else if(zpayHistory.zpay_deal_type == '중고입금' || zpayHistory.zpay_deal_type == '중고출금') {
												res += "<a href='secondhand_detail?secondhand_idx=" + zpayHistory.secondhand_idx + "&member_id=" + zpayHistory.seller_id + "' class='itemTitle itemLink'>" + zpayHistory.order_secondhand_product + "</a>"
											} else if(zpayHistory.zpay_deal_type == '경매입금' || zpayHistory.zpay_deal_type == '경매출금') {
												res += "<a href='auction_detail?id=" + zpayHistory.auctionIdxForOrderAuction + "' class='itemTitle itemLink'>" + zpayHistory.order_auction_title + "</a>"
// 												res += "<a href='auction_detail?id=" + zpayHistory.auction_idx + "' class='itemTitle itemLink'>" + zpayHistory.auction_title + "</a>"
											} else if(zpayHistory.zpay_deal_type == '경매취소환불') {
												res += "<a href='auction_detail?id=" + zpayHistory.auction_idx + "' class='itemTitle itemLink'>" + zpayHistory.order_auction_title + "</a>"
// 												res += "<a href='auction_detail?id=" + zpayHistory.auction_idx + "' class='itemTitle itemLink'>" + zpayHistory.auction_title + "</a>"
											} else if(zpayHistory.zpay_deal_type == '검수비') {
												res += "<a class='itemTitle itemLink'>" + zpayHistory.auction_title + "</a>"
											}
											
									res +=	"<div class='zpayHistoryItem_info_sub'>" +
												"<span class='payTime'>" + getFormatTime(zpayHistory.zpay_time) + "</span>" +
												"<span class='paymentType'>" + zpayHistory.zpay_deal_type + "</span>" +
											"</div>" +
										"</div>" + 
										"<div class='zpayHistoryItem_amountArea'>" +
											"<strong class='zpayHistoryItem_amount' data-dealType='" + zpayHistory.zpay_deal_type + "'>" +
												"<span></span>" + comma(zpayHistory.zpay_amount) +  "원" +
											"</strong>" +
										"<div class='zpayBalance'>" +
											comma(zpayHistory.zpay_balance) +  "원" +
										"</div>" +
									"</div>" +
								"</div>" +
							"</div>" +
						"</li>"
				}	// for문 끝
				
				$(".zpayHistoryListArea > ul").append(res);
				$(".listCount").html(data.listCount);
				$(".balanceArea .balance").html(comma(data.zpay_balance) + "원");
				amountColor();
				
			}, // success 끝
			error : function() {
				alert("요청실패");
			}
		});	// AJAX 끝
	}	// updateTransactionHistory 끝
	
	// 금액 형식 지정 함수
	function comma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	
	// 날짜 형식 지정 함수
	function getFormatDate(date){	// 문자열로 된 날짜 및 시각 데이터 전달받기
		let targetDate = /(\d\d)(\d\d)-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d).(\d)/g;
		let formatDate = "$3.$4";
		return date.replace(targetDate, formatDate);	// 전달받은 날짜 및 시각을 지정된 형식으로 변환하여 리턴
	}

	// 시간 형식 지정 함수
	function getFormatTime(date){	// 문자열로 된 날짜 및 시각 데이터 전달받기
		let targetDate = /(\d\d)(\d\d)-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d).(\d)/g;
		let formatDate = "$5:$6";
		return date.replace(targetDate, formatDate);	// 전달받은 날짜 및 시각을 지정된 형식으로 변환하여 리턴
	}
	
	// 거래타입 별 색, +- 표시 함수
	function amountColor(){
		$("strong.zpayHistoryItem_amount").each(function() {

			let zpayDealType = $(this).attr("data-dealType");
		
			if (zpayDealType == "충전" || zpayDealType == "중고입금" || zpayDealType == "경매입금" || zpayDealType == "경매취소환불") {
				$(this).css("color", "#09aa5c");
				$(this).children("span").html("+ ");
			} else if (zpayDealType == "환급" || zpayDealType == "중고출금" || zpayDealType == "경매출금" || zpayDealType == "검수비") {
				$(this).children("span").html("- ");
			}
		});
		
	}
	
	$(function() {
		// 맨 위로 가기 버튼 표시/숨기기
		$(window).on("scroll", function() {
			if ($(this).scrollTop() > 100) {
				$('#scrollTopButton').fadeIn();
			} else {
				$('#scrollTopButton').fadeOut();
			}
		});
	
		// 맨 위로 가기 버튼 클릭 시 스크롤 맨 위로 이동
		$('#scrollTopButton').click(function() {
			$('html, body').animate({ scrollTop: 0 }, 'normal');
			return false;
		});
	});
</script>
</head>
<body>
	<%-- 세션 아이디가 없을 경우 "로그인 후 사용 가능합니다" 출력 후 로그인 페이지로 이동 --%>
	<%-- 아니면, 엑세스토큰이 없을 경우 "계좌 인증 후 사용 가능합니다" 출력 후 회원정보 페이지로 이동 --%>
	<c:choose>
		<c:when test="${empty sessionScope.member_id }">
			<script>
				alert("로그인 후 사용 가능합니다");
				location.href = "./";
			</script>
		</c:when>
		<c:when test="${empty sessionScope.access_token }">
			<script>
				alert("계좌 인증 후 사용 가능합니다");
				location.href = "MemberInfo";
			</script>
		</c:when>
	</c:choose>
	<c:set var="pageNum" value="1"/>
	<c:if test="${!empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }"/>
	</c:if>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	<article>
		<a id="scrollTopButton" style="position: fixed; bottom: 20px; right: 20px; display: none;">
			<img src="${pageContext.request.contextPath }/resources/img/up.png" alt="up"  style="border-radius: 50%;" height="50">
		</a>
<!-- 		<button id="scrollTopButton" class="btn btn-primary" style="position: fixed; bottom: 20px; right: 20px; display: none;"> -->
<!-- 			맨 위로 -->
<!-- 		</button> -->
		<div class="container">
			<div class="contentAreaZpay">
			<%-- 메인영역 --%>
				<div class="zpayManageArea">
					<div class="profileArea">
						<a class="profileLink" href="member_mypage_main">
							<span class="profileImg">
							<c:choose>
								<c:when test="${not empty member.member_image }">
									<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${member.member_image }" alt="사용자 이미지" class="thumb_img" width=50px height=50px>
								</c:when>
								<c:otherwise>
									<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" alt="사용자 이미지" class="thumb_img" width=50px height=50px>
								</c:otherwise>
							</c:choose>							
							</span>
							<span class="profileInfo">
								<strong class="profileName">
									${sessionScope.member_id } 님
<!-- 									홍길동 님 -->
								</strong>
									${member.member_nickname }
<!-- 								hong -->
							</span>
						</a>
					</div>
					<div class="payWalletWidgetArea">
						<div class="zpayArea">
							<div class="balanceArea">
								<strong class="title">
									ZPAY 잔액
								</strong>
								<div class="balance">
								</div>
							</div>
							<div class="zpayLinkArea">
								<div class="zpayChargeLink">
									<a href="zpay_charge_form" class="zpayChargeButton">충전</a>
								</div>
								<div class="zpayRefundLink">
									<a href="zpay_refund_form" class="zpayRefundButton">환급</a>
								</div>
							</div>
						</div>
					</div>
				</div><%-- zpayManageArea 영역 끝 --%>
				<div class="zpayHistoryArea">
					<div class="zpayHistoryFilter">
						<div class="btn-group">
							<input type="button" class="dealType btn btn-sm btn-outline-dark rounded-pill mr-1 active" value="전체">
							<input type="button" class="dealType btn btn-sm btn-outline-dark rounded-pill mr-1" value="충전">
							<input type="button" class="dealType btn btn-sm btn-outline-dark rounded-pill mr-1" value="환급">
							<input type="button" class="dealType btn btn-sm btn-outline-dark rounded-pill mr-1" value="사용">
							<input type="button" class="dealType btn btn-sm btn-outline-dark rounded-pill mr-1" value="수익">
						</div>
					</div>
					<div class="zpayHistoryDateSelect" style="display: flex;">
						<input type="text" name="datetimes" class="form-control">
					</div>
					<div class="zpayHistoryPeriodArea">
						총 <strong class="listCount">${listCount }</strong> 건
						<span class="listPeriod">
							<span class="startDate"></span>
							<span class="endDate"></span>
						</span>
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
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
</body>
</html>