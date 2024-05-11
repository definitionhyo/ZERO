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
					<h1 class="mt-4">${auctoionOrder.auction_idx } 상품 상세보기</h1>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="admin_auction_managing_list">경매예정 상품목록</a></li>
						<li class="breadcrumb-item active" aria-current="page">상세정보</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<b>${auctoionOrder.auction_idx }</b> 상품 상세보기
						</div>
						<div class="card-body">
							<table id="memberDetailInfo" class="table table-border">
								<tbody>
									<tr>
										<th>판매자 아이디</th>
										<td colspan="2">
											${auctoionOrder.order_auction_seller }
										</td>
									</tr>
									<tr>
										<th>구매자 아이디</th>
										<td colspan="2">
											${auctoionOrder.order_auction_buyer }
										</td>
									</tr>
									<tr>
										<th>경매상품 등록일</th>
										<td colspan="2" id="auctionRegistDate">
											${auctoionOrder.auction_regist_date }
										</td>
									</tr>
									<tr>
										<th>상품명</th>
										<td colspan="2">
											${auctoionOrder.auction_title }
										</td>
									</tr>
									<tr>
										<th>상품정보</th>
										<td colspan="2">
											${auctoionOrder.auction_content }
										</td>
									</tr>
									<tr>
										<th>상품이미지</th>
										<td colspan="2">
											<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${auctoionOrder.auction_image1 }" alt="사용자 이미지" class="thumb_img" width=150px height=150px>
											<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${auctoionOrder.auction_image2 }" alt="사용자 이미지" class="thumb_img" width=150px height=150px>
											<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${auctoionOrder.auction_image3 }" alt="사용자 이미지" class="thumb_img" width=150px height=150px>
										</td>
									</tr>
									<tr>
										<th>경매종료일</th>
										<td colspan="2" id="auctionEndDatetime">
												${auctoionOrder.auction_end_datetime }
										</td>
									</tr>
									<tr>
										<th>거래가</th>
										<td colspan="2">
											<fmt:formatNumber value="${auctoionOrder.order_auction_price }" pattern="#,##0"/>원
										</td>
									</tr>
									<tr>
										<th>경매수수료</th>
										<td colspan="2">
											<fmt:formatNumber value="${auctoionOrder.order_auction_commission }" pattern="#,##0"/>원
										</td>
									</tr>
									<tr>
										<th>배달번호</th>
										<td colspan="2">
											${auctoionOrder.order_auction_delivery_idx }
										</td>
									</tr>
									<tr>
										<th>택배사</th>
										<td colspan="2">
											${auctoionOrder.order_auction_delivery_company }
										</td>
									</tr>
									<tr>
										<th>판매자 도로명 주소</th>
										<td colspan="2">
											${auctoionOrder.auction_seller_address } ${auctoionOrder.auction_seller_address_detail }
										</td>
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