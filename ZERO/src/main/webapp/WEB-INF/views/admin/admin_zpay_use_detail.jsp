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
		$("#memberTypeSelect").on("change", function() {
			let changedType = $("#memberTypeSelect>option:selected").val();
			$("#memberType").empty();
			$("#memberType").html(changedType);
		});

		$("#memberStatusSelect").on("change", function() {
			let changedStatus = $("#memberStatusSelect>option:selected").val();
			$("#memberStatus").empty();
			$("#memberStatus").html(changedStatus);

			let now = new Date();
			let year = now.getFullYear();
			let month = String(now.getMonth() + 1).padStart(2, '0');
			let day = String(now.getDate()).padStart(2, '0');
			let memberWithdrawal = year + "-" + month + "-" + day;
			
			if(changedStatus == "활동"){
				$("#memberWithdrawal").empty();
			} else {
				$("#memberWithdrawal").html(memberWithdrawal + '<input type="hidden" id="member_withdrawal" name="member_withdrawal" value=' + memberWithdrawal + '>');
			}
		});
		
	});
	
	function modify(){
// 		alert($("#memberStatus").text());
// 		alert($("#member_withdrawal").val());
// 		if($("#member_withdrawal").val() == ""){
	
		if($("#memberStatus").text() == "탈퇴" && $("#member_withdrawal").val() == ""){
			alert("탈퇴일을 지정해주세요");
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
					<h1 class="mt-4">${zpayHistory.zpay_history_idx } 번 내역 상세보기</h1>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="admin_zpay_use_list">ZPAY 목록</a></li>
						<li class="breadcrumb-item active" aria-current="page">상세정보</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<b>${zpayHistory.zpay_history_idx }</b> 번 내역 상세보기
						</div>
						<div class="card-body">
							<table id="memberDetailInfo" class="table table-border">
								<tbody>
									<tr>
										<th>내역 번호</th>
										<td colspan="2">
											${zpayHistory.zpay_history_idx }
										</td>
									</tr>
									<tr>
										<th>ZPAY 번호</th>
										<td colspan="2">
											${zpayHistory.zpay_idx }
										</td>
									</tr>
									<tr>
										<th>변동금액</th>
										<td colspan="2">
											<fmt:formatNumber value="${zpayHistory.zpay_amount}" pattern="#,##0"/>
										</td>
									</tr>
									<tr>
										<th>시간</th>
										<td colspan="2">
											${zpayHistory.zpay_time }
										</td>
									</tr>
									<tr>
										<th>ZPAY 잔액</th>
										<td colspan="2">
											<fmt:formatNumber value="${zpayHistory.zpay_balance}" pattern="#,##0"/>
										</td>
									</tr>
									<tr>
										<th>ZPAY 거래 유형</th>
										<td colspan="2">
											${zpayHistory.zpay_deal_type }
										</td>
									</tr>
									<c:choose>
										<c:when test="${!empty zpayHistory.order_secondhand_idx }">
											<tr>
												<th>중고거래번호</th>
												<td>${zpayHistory.order_secondhand_idx }</td>
												<td class="text-end">
													<button type="button" class="btn btn-sm btn-dark text-nowrap" onclick="location.href='admin_secondhand_order_detail?order_secondhand_idx=${zpayHistory.order_secondhand_idx}'">상세보기</button>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<th>경매거래번호</th>
												<td>${zpayHistory.order_auction_idx }</td>
												<td class="text-end">
													<button type="button" class="btn btn-sm btn-dark text-nowrap" onclick="location.href='#'">상세보기</button>
												</td>
											</tr>												
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div class="text-center">
								<button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>							
							</div>
						</div>
					</div>
				</div>

			</main>
			<footer class="py-4 bg-light mt-auto">
				<%@ include file="../inc/admin_footer.jsp" %>	
			</footer>	
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