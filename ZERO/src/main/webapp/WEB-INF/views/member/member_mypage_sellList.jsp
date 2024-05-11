<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/default.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/sidebar.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/button.css"
	rel="stylesheet" type="text/css">



<meta charset="UTF-8">
<title>ZERO</title>

<style type="text/css">
</style>


</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
	
	<article>
		<div class="container">
			<%-- 사이드바 --%>
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
			</nav>
			<div class="contentArea">
			<%-- 메인영역 --%>
			<article id="mainArticle">
		<div class="my_purchase">
			<div class="content_title" data-v-88eb18f6="">
				<div class="title" data-v-88eb18f6="">
					<h3 data-v-88eb18f6="">상품판매 내역</h3>
					<!---->
				</div>
				<!---->
			</div>
	<!-- 거래내역 없을때 -->
		<c:if test="${empty myShList }">
		<div data-v-412d8616="" class="recent_purchase">
			<div data-v-412d8616="">
				<div data-v-7a02263e="" data-v-412d8616=""
					class="purchase_list all ask">
					<!---->
					<div data-v-6abf8c64="" data-v-7a02263e="" class="empty_area">
						<p data-v-6abf8c64="" class="desc">구매 내역이 없습니다.</p>
						<!---->
					</div>
					<div data-v-7a02263e="" class="v-portal" style="display: none;"></div>
				</div>
				<!---->
			</div>
		</div>
		</c:if>
		
		<!-- 판매내역 있을때 -->
		<c:if test="${not empty myShList }">
			<div data-v-412d8616="" class="recent_purchase">
				<div data-v-412d8616="">
					<div data-v-7a02263e="" data-v-412d8616=""
						class="purchase_list all bid">
						<!---->
						<div data-v-7a02263e="">
							<div data-v-e5d3a8ae="" data-v-7a02263e="">
								<c:forEach var="myShList" items="${myShList }">
								<div data-v-e5d3a8ae="" 
									 class="purchase_list_display_item"
									 style="background-color: rgb(255, 255, 255);"
									 onclick="location.href='secondhand_detail?secondhand_idx=${myShList.secondhand_idx}&member_id=${myShList.member_id}'">
										<div data-v-e5d3a8ae="" class="purchase_list_product">
											<div data-v-e5d3a8ae="" class="list_item_img_wrap">
												<img data-v-e5d3a8ae="" alt="myShList_image"
													src="${pageContext.request.contextPath }/resources/upload/' + myShList.secondhand_image1 + '"
													class="list_item_img"
													style="background-color: rgb(244, 244, 244);">
												<!---->
											</div>
											<div data-v-e5d3a8ae="" class="list_item_title_wrap">
												<!---->
												<p data-v-e5d3a8ae="" class="list_item_title">${myShList.secondhand_subject}</p>
											</div>
										</div>
										<div data-v-e5d3a8ae="" class="list_item_status">
											<div data-v-e5d3a8ae=""
												class="list_item_column column_secondary">
												<p data-v-7b1f182e="" data-v-e5d3a8ae=""
													class="secondary_title display_paragraph"
													style="color: rgba(34, 34, 34, 0.5);">${myShList.secondhand_first_date }</p>
											</div>
											<div data-v-e5d3a8ae="" class="list_item_column column_last">
												<p data-v-7b1f182e="" data-v-e5d3a8ae=""
													class="last_title display_paragraph"
													style="color: rgb(34, 34, 34);">${myShList.secondhand_deal_status }</p>
											</div>
										</div>
								</div>
								</c:forEach>
								<!---->
							</div>
						</div>
						<!---->
						<div data-v-7a02263e="" class="v-portal" style="display: none;"></div>
					</div>
					<!---->
				</div>
			</div>
		</c:if>
			<!---->
		</div>
	</article>

<script src="${pageContext.request.contextPath }/resources/mypage_js/49ee6ec.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/ac846b6.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/bfcc4c4.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/2ffe3b9.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/e679961.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/514df53.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/afbbed2.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/76e0661.js" defer=""></script>
<link href="${pageContext.request.contextPath }/resources/mypage_css/css/7db96f2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/bd82ddc.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/81ef50f.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/d2d1f2f.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/8a6891b.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/ddf6c56.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/10a7d17.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/4bb4200.css" rel="stylesheet" type="text/css">

</body>
</html>