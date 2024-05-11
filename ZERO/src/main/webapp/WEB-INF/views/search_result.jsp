<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/defualt.css" rel="stylesheet" type="text/css">


<link href="${pageContext.request.contextPath }/resources/css/aution.css" rel="stylesheet" type="text/css">
<%-- google 아이콘 --%>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">



<meta charset="UTF-8">
<%-- 반응형웹페이지위한 설정 --%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 제이쿼리 -->
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<style>
<style>
#mainArticle {
	margin-top: 700px;
}
.container{
	margin-top:200px;
}
a {
	color:black;
}
h5 p {
	color:gray;
}
h4 {
	margin-bottom:50px;
}




/* 중고 카드 - 포토영역*/
.photoDiv {
	position: relative;
}
/* 찜하기 버튼 (이미지 오버) */
.likebtn { 
		font-size: 1.0rem;
		position: absolute;
		top: 263px;
		left: 10px;
		border-radius: 10%;
/* 		background-color:white; */
		

}
/* 거래상태 버튼(이미지 오버) */
.dealStatus {
		font-size: 0.7rem;
		position: absolute;
		top: 263px;
		right: 0px;
		border-radius: 40%;
}

.card-text{
	text-align: center;
	
}

.card-body{
	font-size:0.9rem;
}


/* 거래가능상품보기 라디오박스? */
.form-check {
	margin-bottom:10px;
	margin-left:10px;
}




/* 탭 css */
ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}


/* 목록 카드 css */
.card-img-top{
	width:250x;
	height:300px;
}
.row {
	margin:15px;
/* 	padding:10px; */
}
/* 카드 카테고리 */
.category {
	color:gray;
	font: bold;
/* 	background-color:lightgray; */
}
.Secondhandcount {
	font-size:15px;
	color:darkgray;
	margin-bottom:20px;
}




/* 경매상품 검색목록 영역*/
.auctionList{
	margin-top:50px;
}
p {
	color:gray;
}
.price{
	margin:0px;
}
.brand{
	font-weight: bold;
}

</style>

</head>
<body>
	<header><%@ include file="inc/header.jsp"%></header>
	
	
	
	<article>
		<div id="mainArticle">
		<div class="container">
		
			<h4> ' ${param.productSearchKeyword } ' 검색 결과 입니다 </h4>
			
			<!-- 검색결과 - 중고상품 리스트 출력 -->
			<div class="secondhandList">
				<h5> 중고 상품 </h5>
				<p> 검색된 상품 ${searchSecondhandCount } 개</p>
				
				<c:choose>
					<c:when test="${searchSecondhandCount eq 0}">
						중고상품 검색 결과가 존재하지 않습니다
					</c:when>
					
					<c:otherwise>
						<div class="row" align="left">
						<c:forEach var="secondhand" items="${searchSecondhandList }">
							<div class="col-lg-3 col-mid-4">
								<div class="card border-0" >
									<!-- 썸네일이미지 -->
									<div class="photoDiv">	
										<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
											<img src="${pageContext.request.contextPath }/resources/upload/${secondhand.secondhand_image1}" class="card-img-top" >
										</a>
										
										<!-- 찜하기 버튼 -->
										<span class="likebtn">
											<a href="#" style="align:right;">
												<img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="30px" height="30px">
											</a>
										</span>
				
										<!-- 거래상태 버튼 -->
										<span class="dealStatus"><button class="btn btn-dark">${secondhand.secondhand_deal_status}</button></span>
									</div>
									
									
									<div class="card-body">
										<!-- 카테고리 가져오기 -->
										<div class="category" style="font-size:0.8rem; ">
											${secondhand.category_name }
										</div>
										
										<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
											<!-- 제목 링크 -->
											<a href="secondhand_detail?secondhand_idx=${secondhand.secondhand_idx}&member_id=${secondhand.member_id}">
												${secondhand.secondhand_subject}
											</a>
											<!-- 찜하기 버튼 -->
				<!-- 									<br> -->
				<!-- 									<a href="#" style="align:right;"> -->
				<%-- 										<img src="${pageContext.request.contextPath }/resources/img/heartIcon.png" width="20px" height="20px"> --%>
				<!-- 									</a> -->
										</div>
										<p><fmt:formatNumber pattern="#,###" value="${secondhand.secondhand_price }"/>원</p>
										
										<p>${secondhand.secondhand_first_date }</p>
									</div><!-- cardbody끝 -->
								</div><!-- card끝 -->
								
								</div>
						</c:forEach>
						</div><%--row끝 --%>	
					</c:otherwise>
				</c:choose>
			</div><%-- secondhandList끝 --%>
			
			
		<!-- 검색결과 - 경매상품 리스트 출력 -->
		<hr>
		<div class="auctionList">
			<h5> 경매 상품 </h5>
			<p> 검색된 상품 ${listCount } 개</p>
			
			<c:choose>
				<c:when test="${listCount eq 0}">
					경매 상품 검색 결과가 존재하지 않습니다
				</c:when>
				
				<c:otherwise>
					<div class="row" align="left">
					<c:forEach var="auction" items="${AuctionList }">
						<div class="col-lg-3 col-mid-4">
							<div class="card border-0" >
								<!-- 썸네일이미지 -->
								<div class="photoDiv">	
									<a href="auction_detail?id=${auction.auction_idx}">
										<img alt="상품사진" src="${pageContext.request.contextPath }/resources/upload/${auction.auction_image1}" class="card-img-top">
									</a>
								</div>
								
								
								<div class="card-body">
									<!-- 브랜드명  -->
									<div class="brand" style="font-size:0.8rem; ">
											${auction.brand_name }
									</div>
									<div class="card-title" style="white-space: nowrap; overflow:hidden; text-overflow: elipsis;">
										<!-- 제목 링크 -->
										<a href="auction_detail?id=${auction.auction_idx}">
											${auction.auction_title}
										</a>

									</div>
									<p>경매상태</p>
									<p>입찰최저가 <fmt:formatNumber pattern="#,###" value="${auction.auction_start_price }"/>원</p>
									<p>즉시구매가 <fmt:formatNumber pattern="#,###" value="${auction.auction_max_price }"/>원</p>
									
									<p>${secondhand.secondhand_first_date }</p>
								</div><!-- cardbody끝 -->
							</div><!-- card끝 -->
							
							</div>
					</c:forEach>
					</div><%--row끝 --%>	
				</c:otherwise>
			</c:choose>
		</div><%-- auctionList끝 --%>
			
			
	
	
	
	
	
	
			
			
			

<!-- 			<!-- 검색결과 - 경매 상품 리스트 출력 -->
<!-- 			<hr> -->
<!-- 			<div class="auctionList"> -->
				
<!-- 				<h5> 경매 상품 </h5> -->
<!-- 				<hr> -->
<!-- 				<h6> 경매 예정 상품</h6> -->
				
<!-- 				<p> 검색된 상품  개</p> -->

<!-- 				2. 컨텐츠 -->
<!-- 				<article id="listContainer"> -->
<!-- 					2-1. 상품갯수, 검색창, 정렬 -->
<!-- 					<div class="listInfo"> -->
<!-- 						<span class="listInfoCount">상품 <span id="listCount"></span>개</span> -->
<!-- 	<!-- 					<input type="search" placeholder="모델명, 브랜드명 등"> -->
<!-- 						<button class="listInfoBtn"> -->
<!-- 							인기순 <i class="material-icons">swap_vert</i> -->
<!-- 						</button> -->
<%-- 							정렬 방법(기본 : 보이지 않음, 클릭 : style 지우기) --%>
<%-- 							<ul class="listSort" style="display: none;"> style="display: none;" --%>
<!-- 								<li id="list1" class="selected"><span>인기순</span> <i class="material-icons">check</i></li> -->
<!-- 								<li id="list2"><span>가격순</span> </li> -->
<!-- 								<li id="list3"><span>최신순</span> </li> -->
<!-- 							</ul> -->
<!-- 					</div> -->
<!-- 					2-2. 상품 목록 -->
<!-- 					<div class="productListArea"> -->
	
	
<!-- 					</div> -->
<!-- 				</article> -->
				
				
<!-- 				<hr> -->
<!-- 				<h6> 경매 진행중 상품 </h6> -->
<!-- 					2. 컨텐츠 -->
<!-- 					<article id="listContainer"> -->
<!-- 						2-1. 상품갯수, 검색창, 정렬 -->
<!-- 						<div class="listInfo"> -->
<!-- 							<span class="listInfoCount">상품 <span id="listCount"></span>개</span> -->
<!-- 							<input type="search" placeholder="모델명, 브랜드명 등"> -->
<!-- 							<button class="listInfoBtn"> -->
<!-- 								인기순 <i class="material-icons">swap_vert</i> -->
<!-- 							</button> -->
<%-- 								정렬 방법(기본 : 보이지 않음, 클릭 : style 지우기) --%>
<%-- 								<ul class="listSort" style="display: none;"> style="display: none;" --%>
<!-- 									<li id="list1">인기순 <i class="material-icons">check</i></li> -->
<!-- 									<li id="list2">가격순 </li> -->
<!-- 									<li id="list3">최신순 </li> -->
<!-- 								</ul> -->
<!-- 						</div> -->
<!-- 						2-2. 상품 목록 -->
<!-- 						<div class="productListArea"> -->
						
								
<!-- 						</div> -->
							
<!-- 					</article> -->
				
				
				
				
				
<!-- 				<hr> -->
<!-- 				<h6> 경매 종료된 상품</h6> -->
				
<!-- 					2. 컨텐츠 -->
<!-- 					<article id="listContainer"> -->
<!-- 						2-1. 상품갯수, 검색창, 정렬 -->
<!-- 						<div class="listInfo"> -->
<!-- 							<span class="listInfoCount">상품 <span id="listCount"></span>개</span> -->
<!-- 		<!-- 					<input type="search" placeholder="모델명, 브랜드명 등"> --> 
<!-- 							<button class="listInfoBtn"> -->
<!-- 								인기순 <i class="material-icons">swap_vert</i> -->
<!-- 							</button> -->
<%-- 								정렬 방법(기본 : 보이지 않음, 클릭 : style 지우기) --%>
<%-- 								<ul class="listSort" style="display: none;"> style="display: none;" --%>
<!-- 									<li id="list1">인기순 <i class="material-icons">check</i></li> -->
<!-- 									<li id="list2">가격순 </li> -->
<!-- 									<li id="list3">최신순 </li> -->
<!-- 								</ul> -->
<!-- 						</div> -->
<!-- 						2-2. 상품 목록 -->
<!-- 						<div class="productListArea"> -->
						
<!-- 						</div> -->
							
<!-- 					</article> -->
				
				

<!-- 			</div> -->























			</div><%--container끝 --%>
		</div><%--mainArticle끝 --%>
	</article>
	
	
	
	
	
</body>
</html>