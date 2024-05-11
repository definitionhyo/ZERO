<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</style>
<script type="text/javascript">
function loadDetail(index, orderSecondhandIdx, orderAuctionIdx, auctionIdx, zpayHistoryIdx) {
	if (orderSecondhandIdx != 0) {
		location.href = "admin_secondhand_order_detail?order_secondhand_idx=" + orderSecondhandIdx;
// 	} else if (orderAuctionIdx != 0) {
// 		location.href = "admin_zpay_deposit_withdraw_detail?order_auction_idx=" + orderAuctionIdx;
// 	} else if (auctionIdx != 0) {
// 		window.location.href = "admin_zpay_deposit_withdraw_detail?auction_idx=" + auctionIdx;
	} else if (zpayHistoryIdx != 0) {
		location.href = "admin_zpay_deposit_withdraw_detail?zpay_history_idx=" + zpayHistoryIdx;
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
					<h1 class="mt-4">계좌 관리 - 현재잔액 : <fmt:formatNumber value="${zero_account_balance}" pattern="#,##0"/>원</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">약정계좌관리</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							약정계좌 거래내역 목록
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>거래내역번호</th>
										<th>회원아이디</th>
										<th>거래유형</th>
										<th>변동금액</th>
										<th>약정계좌잔액</th>
										<th>거래일</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="zeroAccountHistory" items="${zeroAccountHistoryList }" varStatus="vs">
										<tr>
											<td>${zeroAccountHistory.zero_account_history_idx }</td>
											<c:choose>
												<c:when test="${not empty zeroAccountHistory.member_id }">
													<td>${zeroAccountHistory.member_id }</td>
												</c:when>
												<c:otherwise>
													<td>${zeroAccountHistory.zman_id }</td>												
												</c:otherwise>
											</c:choose>
											<td>${zeroAccountHistory.zero_account_type }</td>
											<td><fmt:formatNumber value="${zeroAccountHistory.zero_account_amount}" pattern="#,##0"/></td>
											<td><fmt:formatNumber value="${zeroAccountHistory.zero_account_balance}" pattern="#,##0"/></td>
											<td>${zeroAccountHistory.zero_account_time}</td>
											<td>
												<a class="btn btn-sm btn-outline-dark" onclick="loadDetail(${vs.index}, ${zeroAccountHistory.order_secondhand_idx}, ${zeroAccountHistory.order_auction_idx}, ${zeroAccountHistory.auction_idx}, ${zeroAccountHistory.zpay_history_idx})">상세보기</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
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