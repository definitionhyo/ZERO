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
<title>ZERO</title>
<style type="text/css">
	body{
		min-width: 360px;
	}
	.container-fluid {
		max-width: 1000px;
	}

	#zmanDetailInfo th {
		width: 30%;
		background-color: rgba(0, 0, 0, 0.07);
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
					<h1 class="mt-4"> 배달 상세 내역</h1>
					<ol class="breadcrumb">
<!-- 						<li class="breadcrumb-item"><a href="admin_zman_list">zman목록</a></li> -->
<!-- 						<li class="breadcrumb-item active" aria-current="page">상세정보</li> -->
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<b>배달 ${zmanDeliveryDetail.zman_delivery_idx }</b> 번의 상세 내역
						</div>
						<div class="card-body">
							<table id="zmanDetailInfo" class="table table-border">
								<tbody>
									<tr>
										<th>배달번호</th>
										<td>${zmanDeliveryDetail.zman_delivery_idx }</td>
									</tr>
									<tr>
										<th>ZMAN 이름</th>
										<td>${zmanDeliveryDetail.zman_name }</td>
									</tr>
									<tr>
										<th>ZMAN 아이디</th>
										<td>${zmanDeliveryDetail.zman_id }</td>
									</tr>
									<tr>
										<th>배달 상품</th>
										<td>${zmanDeliveryDetail.order_secondhand_product }</td>
									</tr>
									<tr>
										<th>판매자 아이디</th>
										<td>${zmanDeliveryDetail.seller_id }</td>
									</tr>
									<tr>
										<th>구매자 아이디</th>
										<td>${zmanDeliveryDetail.buyer_id }</td>
									</tr>
									<tr>
										<th>배달시작 주소</th>
										<td>${zmanDeliveryDetail.zman_delivery_startspot }</td>
									</tr>
									<tr>
										<th>배달완료 주소</th>
										<td>${zmanDeliveryDetail.zman_delivery_endspot }</td>
									</tr>
									<tr>
										<th>배달 수락 시간</th>
											<c:choose>
												<c:when test="${not empty zmanDeliveryDetail.zman_delivery_accepttime}">
													<td>
														${zmanDeliveryDetail.zman_delivery_accepttime }
													</td>
												</c:when>
												<c:otherwise>
													<td>
														배달 시작 전입니다.
													</td>
												</c:otherwise>
											</c:choose>
									</tr>
									<tr>
										<th>배달 시작 시간</th>
											<c:choose>
												<c:when test="${not empty zmanDeliveryDetail.zman_delivery_starttime}">
													<td>
														${zmanDeliveryDetail.zman_delivery_starttime }
													</td>
												</c:when>
												<c:otherwise>
													<td>
														배달 시작 전입니다.
													</td>
												</c:otherwise>
											</c:choose>
									</tr>
									<tr>
										<th>배달 도착 시간</th>
										<c:choose>
												<c:when test="${not empty zmanDeliveryDetail.zman_delivery_endtime}">
													<td>
														${zmanDeliveryDetail.zman_delivery_endtime }
													</td>
												</c:when>
												<c:otherwise>
													<td>
														배달 시작 전입니다.
													</td>
												</c:otherwise>
											</c:choose>
									</tr>
<!-- 									<tr> -->
<!-- 										<th>배달거리</th> -->
<%-- 										<td>${zmanDeliveryDetail.zman_delivery_distance }</td> --%>
<!-- 									</tr> -->
									<tr>
										<th>배달수수료</th>
										<td><fmt:formatNumber value="${zmanDeliveryDetail.zman_delivery_commission }" pattern="#,##0"/>원</td>
									</tr>
									<tr>
										<th>정산 시간</th>
										<c:choose>
												<c:when test="${not empty zmanDeliveryDetail.zman_refund_date}">
													<td>
														${zmanDeliveryDetail.zman_refund_date }
													</td>
												</c:when>
												<c:otherwise>
													<td>
														정산 전입니다.
													</td>
												</c:otherwise>
											</c:choose>
									</tr>
									<tr>
										<th>정산 금액</th>
										<c:choose>
												<c:when test="${not empty zmanDeliveryDetail.zman_net_profit}">
													<td>
														<fmt:formatNumber value="${zmanDeliveryDetail.zman_net_profit }" pattern="#,##0"/>원
													</td>
												</c:when>
												<c:otherwise>
													<td>
														정산 전입니다.
													</td>
												</c:otherwise>
											</c:choose>
									</tr>
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
	
	<%-- 회원상태 변경 모달창 --%>
	<div class="modal fade" id="changezmanStatus" tabindex="-1" role="dialog" aria-labelledby="changezmanStatusTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title fs-5" id="changezmanStatusTitle">회원상태변경</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					정말 변경하시겠습니까?
				</div>
				<div class="modal-footer">
					<form action="zman_login_form" method="post">
						<input type="hidden" name="play_num" value="" />  
						<input type="hidden" name="url" value="" />
						<button type="submit" class="btn btn-dark" onclick="location.href='#'">변경</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					</form>
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