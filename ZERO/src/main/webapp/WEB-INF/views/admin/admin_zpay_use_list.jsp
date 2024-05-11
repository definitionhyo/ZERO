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
					<h1 class="mt-4">ZPAY 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">충전환급관리</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							ZPAY 충전환급 목록
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>거래번호</th>
										<th>아이디</th>
										<th>금액</th>
										<th>거래유형</th>
										<th>날짜</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="zpayHistory" items="${zpayHistoryList }" varStatus="vs">
										<tr>
											<td>${zpayHistory.zpay_history_idx }</td>
											<td>${zpayHistory.member_id }</td>
											<td><fmt:formatNumber value="${zpayHistory.zpay_amount}" pattern="#,##0"/>원</td>
											<c:choose>
												<c:when test="${zpayHistory.zpay_deal_type eq '중고입금' or zpayHistory.zpay_deal_type eq '경매입금'}">
													<td style="color: #09aa5c;">${zpayHistory.zpay_deal_type }</td>
												</c:when>
												<c:otherwise>
													<td>${zpayHistory.zpay_deal_type }</td>												
												</c:otherwise>
											</c:choose>
											<td>${zpayHistory.zpay_time }</td>
											<td>
												<a class="btn btn-sm btn-outline-dark" href="admin_zpay_use_detail?zpay_history_idx=${zpayHistory.zpay_history_idx }">상세보기</a>
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