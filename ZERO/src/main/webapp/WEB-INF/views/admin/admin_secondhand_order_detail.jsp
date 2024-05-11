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
					<h1 class="mt-4">중고거래 주문(ORDER) 상세보기</h1>
					<ol class="breadcrumb">
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							중고거래 주문번호 <b> ${secondhandOrderDetail.order_secondhand_idx }</b>번 상품 상세보기
						</div>
						<div class="card-body">
							<form action="admin_secondhand_mangaing_modify" method="post" id="secondhand_mangaing_modify_form">
								<div class="hiddenArea" style="overflow: hidden;"> 
									<input type="hidden" name="order_secondhand_idx" value="${secondhandOrderDetail.order_secondhand_idx }">
								</div>
								<table id="secondhandOrderDetailInfo" class="table table-border">
									<tbody>
										<tr>
											<th>주문번호</th>
											<td colspan="2">
												${secondhandOrderDetail.order_secondhand_idx }
											</td>
										</tr>
										<tr>
											<th>거래 날짜</th>
											<td colspan="2" id="secondhandRegistDate">
												${secondhandOrderDetail.order_secondhand_date }
											</td>
										</tr>
										<tr>
											<th>판매자</th>
											<td colspan="2">
												${secondhandOrderDetail.order_secondhand_seller }
											</td>
										</tr>
										<tr>
											<th>구매자</th>
											<td colspan="2">
												${secondhandOrderDetail.order_secondhand_buyer }
											</td>
										</tr>
										<tr>
											<th>거래 상품명</th>
											<td colspan="2">
												${secondhandOrderDetail.order_secondhand_product }
											</td>
										</tr>
										<tr>
											<th>거래 가격</th>
											<td colspan="2">
												<fmt:formatNumber value="${secondhandOrderDetail.order_secondhand_price }" pattern="#,##0"/>원
											</td>
										</tr>
										<tr>
											<th>ZPAY 사용여부</th>
											<td colspan="2">
												${secondhandOrderDetail.order_secondhand_iszpay }
											</td>
										</tr>
										<%-- 거래 방법에 따른 차이 시작 --%>
										<c:choose>
											<%-- ZMAN 일 경우 --%>
											<c:when test="${secondhandOrderDetail.order_secondhand_type eq 'ZMAN'}">
												<tr>
													<th>거래 방법</th>
													<td colspan="2">
														${secondhandOrderDetail.order_secondhand_type }
													</td>
												</tr>
												<tr>
													<th>배송 방법</th>
													<td colspan="2">
														배달 내역 가져오기
													</td>
												</tr>
											</c:when>
											<%-- ZMAN 이 아닐 경우, 택배 / 직거래  --%>
											<c:otherwise>
												<tr>
													<th>거래 방법</th>
													<td colspan="2">
														${secondhandOrderDetail.order_secondhand_type }
													</td>
												</tr>
											</c:otherwise>
										</c:choose>
										<%-- 거래 방법에 따른 차이 끝 --%>
									
									
									</tbody>
								</table>
								<div class="text-center">
									<button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>							
									<button type="button" class="btn btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteSecondhandOrder">
												&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;
									</button>
											
									<%-- 중고거래 등록상품 삭제 확인 모달창 --%>
									<div class="modal fade" id="confirmDeleteSecondhandOrder" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteSecondhandOrderTitle" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title fs-5" id="confirmDeleteSecondhandOrderTitle">중고거래 거래내역 삭제</h5>
													<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">
													삭제 후 복구가 불가합니다.<br>
													정말 삭제하시겠습니까?<br>
												</div>
												<div class="modal-footer">
													<button type="button" id="${secondhandManagingDetail.secondhand_idx }" class="btn btn-dark" 
															onclick="location.href='admin_secondhand_order_delete?order_secondhand_idx=${secondhandOrderDetail.order_secondhand_idx }'">삭제</button>
													<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
												</div>
											</div>
										</div>
									</div> <%-- 삭제 확인 모달창 끝 --%>
								</div> <%-- 버튼 영역 끝 --%>
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