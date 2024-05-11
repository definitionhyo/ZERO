<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/main2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
<title>ZERO</title>
<style type="text/css">

/* -----------모바일사이즈인 경우 -------------- */
@media only screen and (max-width: 768px) {	
/* 메인화면 모바일사이즈 위여백 늘리기 */
	#homeArticle{
		margin-top: 30px;
	}
}
</style>
<script type="text/javascript">
	
	function moreClick(type) {
		switch(type) {
			case 'secondhand' :
				location.href = "secondhand_list";
				break;
			case 'auction' :
				location.href = "auctionList_present";
				break;
		}
	}

</script>
</head>
<body>
	<header>
		<%@ include file="inc/header.jsp"%>
	</header>
	
	<article id="homeArticle">
		<div id="slid">
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img src="${pageContext.request.contextPath }/resources/img/2023-08-05 232415.png" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item">
						<img src="${pageContext.request.contextPath }/resources/img/2023-08-15 133021.png" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item">
						<img src="${pageContext.request.contextPath }/resources/img/2023-08-15 133235.png" class="d-block w-100" alt="...">
					</div>
				</div>
				<a class="carousel-control-prev prevArrow" href="#carouselExampleIndicators" role="button" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a>
				<a class="carousel-control-next nextArrow" href="#carouselExampleIndicators" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>
		</div>
		<div id="main">
			<hr>
			<div class="productArea">
				<div class="titleArea">
					<div class="title">중고</div>
				</div>
				<div class="HomeProductListArea">
					<c:forEach var="secondhand" items="${homeSecondhandList }">
					<div class="card">
						<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id }">
							<img class="homeImg" src="${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1}"alt="...">
							<div class="card-body">
								<p class="card-text">${secondhand.secondhand_subject }</p>
								<p class="card-price">${secondhand.secondhand_price }원</p>
							</div>
						</a>
					</div>
					</c:forEach>
				</div>
				<div class="btnArea">
					<button class="btn btn-sm btn-outline-secondary" onclick="moreClick('secondhand')">더보기</button>
				</div>
			</div>
			
			<hr>
			
			<div class="productArea">
				<div class="titleArea">
					<div class="title">경매</div>
				</div>
				<div class="HomeProductListArea">
					<c:forEach var="auction" items="${homeAuctionList }">
						<div class="card">
							<a href="auction_detail?id=${auction.auction_idx}">
<%-- 								<img class="homeImg" src="${pageContext.request.contextPath }/resources/upload/${auction.auction_image1}" alt="..."> --%>
								<img class="card-img-top homeImg" src="${pageContext.request.contextPath }/resources/upload/${auction.auction_image1}" alt="...">
								<div class="card-body">
									<p class="card-text">경매중</p>
									<p class="card-text">${auction.auction_title }</p>
									<p class="card-price">현재 입찰가 <fmt:formatNumber value="${auction.auction_now_price }" pattern="###,###"/>원</p>
								</div>
							</a>
						</div>
					</c:forEach>
					<%-- 경매중인 물건이 5개 이하일때 가져오는 경매종료 물품 --%>
					<c:if test="${not empty endAuctionList }">
						<c:forEach var="auction" items="${endAuctionList }">
							<div class="card">
								<a href="auction_detail?id=${auction.auction_idx}">
									<img class="homeImg card-img-top" src="${pageContext.request.contextPath }/resources/upload/${auction.auction_image1}" alt="...">
									<div class="card-body">
										<p class="card-text">경매종료</p>
										<p class="card-text">${auction.auction_title }</p>
										<p class="card-price">최종 낙찰가 <fmt:formatNumber value="${auction.auction_final_price }" pattern="###,###"/>원</p>
									</div>
								</a>
							</div>
						</c:forEach>
					</c:if>
				</div>
				<div class="btnArea">
					<button class="btn btn-sm btn-outline-secondary" onclick="moreClick('auction')">더보기</button>
				</div>
			</div>
		</div>
	</article>
	
	<footer>
		<%@ include file="inc/footer.jsp"%>
	</footer>
</body>
</html>