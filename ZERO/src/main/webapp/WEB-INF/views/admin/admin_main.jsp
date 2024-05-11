<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/css/adminstyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<title>ZERO</title>
<style type="text/css">
	body{
		min-width: 360px;
	}
</style>
<script type="text/javascript"></script>
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
					<h1 class="mt-4">Dashboard</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">Dashboard</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="row">
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i>
									일별 거래 금액
								</div>
								<div class="card-body"><canvas id="dailyTransactionChart" width="100%" height="40"></canvas></div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i>
									일별 거래 수
								</div>
								<div class="card-body"><canvas id="dailyDealCountChart" width="100%" height="40"></canvas></div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xl-6">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area me-1"></i>
									중고거래&경매거래 비율
								</div>
								<div class="card-body"><canvas id="secondhandAuctionDealRatioChart" width="100%" height="40"></canvas></div>
							</div>
						</div>
						<div class="col-xl-6">
							<div class="card mb-4">
									<div class="card-header">
										<i class="fas fa-chart-bar me-1"></i>
										일별 회원가입자 수
									</div>
								<div class="card-body"><canvas id="dailyMemberChart" width="100%" height="40"></canvas></div>
							</div>
						</div>
					</div>
<!-- 					<div class="row"> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 지역 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 시간 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									중고거래 인기 순위 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									경매 인기 순위 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									중고거래 / 경매거래 비율 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									경매 인기 순위 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 지역 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 시간 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 거리 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 성별 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="row"> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 주문자연령대 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="col-xl-6"> -->
<!-- 							<div class="card mb-4"> -->
<!-- 								<div class="card-header"> -->
<!-- 									<i class="fas fa-chart-pie me-1"></i> -->
<!-- 									ZMAN 통계 - 주문자연령대 -->
<!-- 								</div> -->
<!-- 								<div class="card-body"><canvas id="myPieChart" width="100%" height="40"></canvas></div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
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
<%-- <script src="${pageContext.request.contextPath }/resources/demo/secondhand_auction_deal_ratio.js"></script> --%>
<script src="${pageContext.request.contextPath }/resources/demo/chart-bar-demo.js"></script>
<script src="${pageContext.request.contextPath }/resources/demo/chart-pie-demo.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath }/resources/js/datatables-simple-demo.js"></script>
</body>
</html>