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
					<h1 class="mt-4">중고거래 등록상품 상세보기</h1>
					<ol class="breadcrumb">
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							중고거래 번호 <b> ${secondhandManagingDetail.secondhand_idx }</b>번 상품 상세보기
						</div>
						<div class="card-body">
							<form action="admin_secondhand_mangaing_modify" method="post" id="secondhand_mangaing_modify_form">
								<div class="hiddenArea" style="overflow: hidden;"> 
									<input type="hidden" name="secondhand_idx" value="${secondhandManagingDetail.secondhand_idx }">
								</div>
								<table id="memberDetailInfo" class="table table-border">
									<tbody>
										<tr>
											<th>중고상품 번호</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_idx }
											</td>
										</tr>
										<tr>
											<th>판매자 아이디</th>
											<td colspan="2">
												${secondhandManagingDetail.member_id }
											</td>
										</tr>
										<tr>
											<th>중고거래 상품 등록일</th>
											<td colspan="2" id="secondhandRegistDate">
												${secondhandManagingDetail.secondhand_first_date }
											</td>
										</tr>
										<tr>
											<th>거래 상태</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_deal_status }
											</td>
										</tr>
										<tr>
											<th>결제 방법</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_paymentType_ptp }
											</td>
										</tr>
										<tr>
											<th>배송 방법</th>
											<td colspan="2">
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${secondhandManagingDetail.secondhand_deal_status eq '거래완료'  --%>
<%-- 																	and secondhandManagingDetail.secondhand_deliveryType_ptp eq 'ZMAN'}"> --%>
<%-- 														${secondhandManagingDetail.secondhand_deliveryType_ptp } --%>
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
														${secondhandManagingDetail.secondhand_deliveryType_ptp }
<%-- 													</c:otherwise> --%>
<%-- 												</c:choose> --%>
											</td>
										</tr>
										<tr>
											<th>카테고리</th>
											<td colspan="2">
												${secondhandManagingDetail.category_name }
											</td>
										</tr>
										<tr>
											<th>상품명</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_subject }
											</td>
										</tr>
										<tr>
											<th>상품정보</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_content }
											</td>
										</tr>
										<tr>
											<th>판매가격</th>
											<td colspan="2">
												<fmt:formatNumber value="${secondhandManagingDetail.secondhand_price }" pattern="#,##0"/>원
											</td>
										</tr>
										<tr>
											<th>상품이미지1</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_image1 }
											</td>
										</tr>
										<tr>
											<th>상품이미지2</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_image2 }
											</td>
										</tr>
										<tr>
											<th>상품이미지3</th>
											<td colspan="2">
												${secondhandManagingDetail.secondhand_image3 }
											</td>
										</tr>
									</tbody>
								</table>
								<div class="text-center">
									<button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>							
									<button type="button" class="btn btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteSecondhand">
												&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;
									</button>
											
									<%-- 중고거래 등록상품 삭제 확인 모달창 --%>
									<div class="modal fade" id="confirmDeleteSecondhand" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteSecondhandTitle" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title fs-5" id="confirmDeleteSecondhandTitle">중고거래 등록상품 삭제</h5>
													<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
												</div>
												<div class="modal-body">
													삭제 후 복구가 불가합니다.<br>
													정말 삭제하시겠습니까?<br>
												</div>
												<div class="modal-footer">
													<button type="button" id="${secondhandManagingDetail.secondhand_idx }" class="btn btn-dark" 
															onclick="location.href='admin_secondhand_managing_delete?secondhand_idx=${secondhandManagingDetail.secondhand_idx }'">삭제</button>
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