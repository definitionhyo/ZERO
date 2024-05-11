<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- JSTL 의 함수를 사용하기 위해 functions 라이브러리 추가 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/css/adminstyles.css" rel="stylesheet" type="text/css">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<title>ZERO</title>
<style type="text/css">
	body{
		min-width: 360px;
	}
	.container-fluid {
		max-width: 1000px;
	}

	#memberDetailInfo th {
		width: 30%;
		background-color: rgba(0, 0, 0, 0.07);
	}	

</style>
<script type="text/javascript">

	$(function() {

		let auction_regist_date = "${auctionManaging.auction_regist_date}";
		let auction_manage_check_date = "${auctionManaging.auction_manage_check_date}";
		let auction_start_datetime = "${auctionManaging.auction_start_datetime}";
		let auction_end_datetime = "${auctionManaging.auction_end_datetime}";
		
		// 변환된 변수를 사용하여 날짜 데이터를 HTML 요소에 추가
		$("#auctionRegistDate").html(getFormatDate2(auction_regist_date));
		$("#auctionManageCheckDate").html(getFormatDate(auction_manage_check_date));
		$("#auctionStartDatetime").html(getFormatDate3(auction_start_datetime));
		$("#auctionEndDatetime").html(getFormatDate3(auction_end_datetime));
		
		
		// 검수 상태가 변경될 때
		$("#auctionManageCheckStatusSelect").on("change", function() {
			let changedStatus = $("#auctionManageCheckStatusSelect>option:selected").val();
			$("#auctionManageCheckStatus").empty();
			$("#auctionManageCheckStatus").html(changedStatus);

			// 등록, 검수중 상태로 변경될 경우
			// 검수완료일, 경매시작일, 경매종료일 지정X
			if(changedStatus != "검수완료" && changedStatus != "경매불가"){
				$("#auctionManageCheckDate").empty();
				$("#auctionStartDatetime").empty();
				$("#auctionEndDatetime").empty();
				
			} else if(changedStatus == "검수완료") {
				// 검수완료 상태로 변경될 경우
				// 검수완료일, 경매시작일, 경매종료일 지정O
				$("#auctionManageCheckDate").html('<input type="datetime-local" id="auction_manage_check_date" class="form-control datepicker">');
				
				$("#auction_manage_check_date").on("input", function() {
					// 검수 완료일과 경매 시작일 계산
					// Timestampe 형식으로 변환
					let now = new Date(getFormatDate($("#auction_manage_check_date").val()));
					let year = now.getFullYear();
					let month = String(now.getMonth() + 1).padStart(2, '0');
					let day = String(now.getDate()).padStart(2, '0');
					let auctionManageCheckDate = year + "-" + month + "-" + day;
					let auctionStartDatetime = year + "-" + month + "-" + String(now.getDate() + 4).padStart(2, '0');
					let auctionEndDatetime = year + "-" + month + "-" + String(now.getDate() + 5).padStart(2, '0');
	
					$("#auctionStartDatetime").html(auctionStartDatetime);
					$("#auctionEndDatetime").html(auctionEndDatetime);					

					// Controller에 hidden 타입으로 검수완료일, 경매시작일, 경매종료일 전송
					$(".hiddenArea").append(
							'<input type="hidden" name="auction_manage_check_date" value="">'
							+ '<input type="hidden" name="auction_start_datetime" value="">'
							+ '<input type="hidden" name="auction_end_datetime" value="">'
					);
					$("input[name=auction_manage_check_date]").val(auctionManageCheckDate + " " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds());
					$("input[name=auction_start_datetime]").val(getFormatDate4(auctionStartDatetime))
					$("input[name=auction_end_datetime]").val(getFormatDate4(auctionEndDatetime))
				});
				
				
				
			} else if(changedStatus == "경매불가") {
				// 경매불가 상태로 변경될 경우
				// 검수완료일 지정O, 경매시작일/경매종료일 지정X
				$("#auctionManageCheckDate").html('<input type="datetime-local" id="auction_manage_check_date" class="form-control datepicker">');
				
				$("#auction_manage_check_date").on("input", function() {
					// 검수 완료일과 경매 시작일 계산
					// Timestampe 형식으로 변환
					let now = new Date(getFormatDate($("#auction_manage_check_date").val()));
					let year = now.getFullYear();
					let month = String(now.getMonth() + 1).padStart(2, '0');
					let day = String(now.getDate()).padStart(2, '0');
					let auctionManageCheckDate = year + "-" + month + "-" + day;
					let auctionStartDatetime = year + "-" + month + "-" + String(now.getDate() + 4).padStart(2, '0');
					let auctionEndDatetime = year + "-" + month + "-" + String(now.getDate() + 5).padStart(2, '0');
					
					// Controller에 hidden 타입으로 검수완료일 전송
					$(".hiddenArea").append(
							'<input type="hidden" name="auction_manage_check_date" value="">'
					);
					$("input[name=auction_manage_check_date]").val(auctionManageCheckDate + " " + now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds());
				});
			}
			
			
			$("#modifyButton").removeAttr("disabled");
		});
		
	});
	
	function getFormatDate(date){	// 문자열로 된 날짜 및 시각 데이터 전달받기
		let targetDate = /(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d)/g;
		let formatDate = "$1-$2-$3 $4:$5:00";
		return date.replace(targetDate, formatDate);	// 전달받은 날짜 및 시각을 지정된 형식으로 변환하여 리턴
	}

	function getFormatDate2(date){	// 문자열로 된 날짜 및 시각 데이터 전달받기
		let targetDate = /(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d):(\d\d)/g;
		let formatDate = "$1-$2-$3";
		return date.replace(targetDate, formatDate);	// 전달받은 날짜 및 시각을 지정된 형식으로 변환하여 리턴
	}
	
	function getFormatDate3(date){	// 문자열로 된 날짜 및 시각 데이터 전달받기
		let targetDate = /(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d):(\d\d)/g;
		let formatDate = "$1-$2-$3";
		return date.replace(targetDate, formatDate);	// 전달받은 날짜 및 시각을 지정된 형식으로 변환하여 리턴
	}

	function getFormatDate4(date){	// 문자열로 된 날짜 및 시각 데이터 전달받기
		let targetDate = /(\d\d\d\d)-(\d\d)-(\d\d)/g;
		let formatDate = "$1-$2-$3 00:00:00";
		return date.replace(targetDate, formatDate);	// 전달받은 날짜 및 시각을 지정된 형식으로 변환하여 리턴
	}
	
	function modify(){
		
		if($("#auctionManageCheckStatus").text() == "검수완료" && $("input[name=auction_manage_check_date]").val() == ""){
			alert("검수완료일을 지정해주세요");
		} else if($("#auctionManageCheckStatus").text() == "경매불가" && $("input[name=auction_manage_check_date]").val() == "") {
			alert("검수완료일을 지정해주세요");
		} else {
			
			$("form").submit();
		}
	}
	
</script>
</head>
<body class="sb-nav-fixed">
	<header>
		<%@ include file="../inc/admin_header.jsp" %>
		<%@ include file="../inc/admin_sidebar.jsp" %>	
	</header>
	<div id="layoutSidenav">
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">${auctionManaging.auction_idx } 상품 상세보기</h1>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="admin_auction_managing_list">경매예정 상품목록</a></li>
						<li class="breadcrumb-item active" aria-current="page">상세정보</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<b>${auctionManaging.auction_idx }</b> 상품 상세보기
						</div>
						<div class="card-body">
							<form action="admin_auction_mangaing_modify" method="post" id="auction_mangaing_modify_form">
								<div class="hiddenArea" style="overflow: hidden;"> 
									<input type="hidden" name="auction_managing_idx" value="${auctionManaging.auction_managing_idx }">
								</div>
								<table id="memberDetailInfo" class="table table-border">
									<tbody>
										<tr>
											<th>판매자 아이디</th>
											<td colspan="2">
												${auctionManaging.auction_seller_id }
											</td>
										</tr>
										<tr>
											<th>경매상품 등록일</th>
											<td colspan="2" id="auctionRegistDate">
												${auctionManaging.auction_regist_date }
											</td>
										</tr>
										<tr>
											<th>상품명</th>
											<td colspan="2">
												${auctionManaging.auction_title }
											</td>
										</tr>
										<tr>
											<th>경매시작가</th>
											<td colspan="2">
												<fmt:formatNumber value="${auctionManaging.auction_start_price }" pattern="#,##0"/>원
											</td>
										</tr>
										<tr>
											<th>즉시구매가</th>
											<td colspan="2">
												<fmt:formatNumber value="${auctionManaging.auction_max_price }" pattern="#,##0"/>원
											</td>
										</tr>
										<tr>
											<th>상품 상태</th>
											<td colspan="2">
												${auctionManaging.aution_product_status }
											</td>
										</tr>
										<tr>
											<th>상품정보</th>
											<td colspan="2">
												${auctionManaging.auction_content }
											</td>
										</tr>
										<tr>
											<th>상품이미지</th>
											<td colspan="2">
												<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${auctionManaging.auction_image1 }" alt="사용자 이미지" class="thumb_img" width=150px height=150px>
												<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${auctionManaging.auction_image2 }" alt="사용자 이미지" class="thumb_img" width=150px height=150px>
												<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${auctionManaging.auction_image3 }" alt="사용자 이미지" class="thumb_img" width=150px height=150px>
											</td>
										</tr>
										<tr>
											<th>검수상태</th>
											<td id="auctionManageCheckStatus">${auctionManaging.auction_manage_check_status}</td>
											<td class="text-end">
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="auction_manage_check_status"  id="auctionManageCheckStatusSelect" aria-label="Default select example" style="width: 170px;">
														<option value="등록" <c:if test="${auctionManaging.auction_manage_check_status eq '등록' }">selected</c:if>>등록</option>
														<option value="검수중" <c:if test="${auctionManaging.auction_manage_check_status eq '검수중' }">selected</c:if>>검수중</option>
														<option value="검수완료" <c:if test="${auctionManaging.auction_manage_check_status eq '검수완료' }">selected</c:if>>검수완료</option>
														<option value="경매불가" <c:if test="${auctionManaging.auction_manage_check_status eq '경매불가' }">selected</c:if>>경매불가</option>
													</select>
												</span>
											</td>
										</tr>
										<tr>
											<th>검수완료일</th>
											<td colspan="2" id="auctionManageCheckDate">
											</td>
										</tr>
										<tr>
											<th>경매시작일</th>
											<td colspan="2" id="auctionStartDatetime">
<%-- 												${auctionManaging.auction_start_datetime } --%>
											</td>
										</tr>
										<tr>
											<th>경매종료일</th>
											<td colspan="2" id="auctionEndDatetime">
<%-- 												${auctionManaging.auction_end_datetime } --%>
											</td>
										</tr>
										<tr>
											<th>판매자 도로명 주소</th>
											<td colspan="2">
												${auctionManaging.auction_seller_address }
											</td>
										</tr>
										<tr>
											<th>판매자 상세주소</th>
											<td colspan="2">
												${auctionManaging.auction_seller_address_detail }
											</td>
										</tr>
									</tbody>
								</table>
								<div class="text-center">
									<button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>							
									<button type="button" id="modifyButton" class="btn btn-dark text-nowrap" onclick="modify()" disabled="disabled">변경저장</button>						
<!-- 									<button type="submit" class="btn btn-dark text-nowrap">변경저장</button>						 -->
<!-- 									<button type="button" class="btn btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteMember"> -->
<!-- 										&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp; -->
<!-- 									</button> -->
								</div>
							</form>
						</div>
					</div>
				</div>

			</main>
			<footer class="py-4 bg-light mt-auto">
				<%@ include file="../inc/admin_footer.jsp" %>	
			</footer>	
		</div>
	</div>
		
	<%-- 회원 삭제 확인 모달창 --%>
	<div class="modal fade" id="confirmDeleteMember" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteMemberTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title fs-5" id="confirmDeleteMemberTitle">회원 삭제</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					삭제 후 복구가 불가합니다.<br>
					정말 삭제하시겠습니까?<br>
				</div>
				<div class="modal-footer">
					<button type="button" id="${member.member_idx }" class="btn btn-dark" onclick="location.href='admin_member_delete?member_idx=${member.member_idx }'">삭제</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
<!-- 이 스크립트들은 위로 올리면 작동하지 않음 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/scripts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/demo/chart-area-demo.js"></script>
<script src="${pageContext.request.contextPath }/resources/demo/chart-bar-demo.js"></script>
<script src="${pageContext.request.contextPath }/resources/demo/chart-pie-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/datatables-simple-demo.js"></script>
</body>
</html>