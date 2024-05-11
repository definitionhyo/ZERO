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
<link href="${pageContext.request.contextPath }/resources/css/adminstyles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
					<h1 class="mt-4">중고거래 관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">중고거래 거래(ORDER) 목록</li>
					</ol>
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							거래(ORDER) 목록
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>거래 번호</th>
										<th>거래 일시</th>
										<th>상품 이름</th>
										<th>거래 가격</th>
										<th>거래 상태</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="orderSecondhandList" items="${orderSecondhandList}" varStatus="vs">
									<tr>
										<td>${orderSecondhandList.order_secondhand_idx }</td>
										<td>${orderSecondhandList.order_secondhand_date }</td>
										<td>${orderSecondhandList.order_secondhand_product }</td>
										<td>
											<fmt:formatNumber value="${orderSecondhandList.order_secondhand_price }" pattern="#,##0"/>원
										</td>
										<td>${orderSecondhandList.order_secondhand_type }</td>
										
<%-- 										<c:choose> --%>
<%-- 											거래 방법이 ZMAN 일 경우 --%>
<%-- 											<c:when test="${orderSecondhandList.order_secondhand_type eq 'ZMAN'}"> --%>
												<td>
<!-- 													<a class="btn btn-sm btn-outline-dark" -->
<%-- 													href="admin_secondhand_order_detail?secondhand_idx=${orderSecondhandList.order_secondhand_idx }&zman_delivery_idx=${orderSecondhandList.zman_delivery_idx}">상세보기</a> --%>
<!-- 												</td> -->
<%-- 											</c:when> --%>
<%-- 											거래 방법이 ZMAN 이 아닐 경우 --%>
<%-- 											<c:otherwise> --%>
<!-- 												<td> -->
													<a class="btn btn-sm btn-outline-dark" href="admin_secondhand_order_detail?order_secondhand_idx=${orderSecondhandList.order_secondhand_idx }&order_secondhand_type=${orderSecondhandList.order_secondhand_type }">상세보기</a>
												</td>
<%-- 											</c:otherwise> --%>
<%-- 										</c:choose> --%>
										
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div> <%-- 메인 영역 끝 --%>
					
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