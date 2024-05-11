<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- JSTL 의 함수를 사용하기 위해 functions 라이브러리 추가 --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#user_membership {
		margin: 25px;
	}
	
	#sec01, #sec03 {
		display: flex;
		justify-content: center;
		align-items: center;	
	}

	.content_title[data-v-88eb18f6] {
	    display: flex;
	    padding: 5px 0 6px;
	    padding-bottom: 16px;
	    border-bottom: 3px solid #222!important;
	}
	

	
	
</style>
<script>


</script>
</head>
<body>
	<%-- 헤더 영역 --%>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
		
	<article id="mainArticle">
		<div class="container">
			<%-- 사이드 바 영역 --%>
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/zman_sidebar.jsp"></jsp:include>
			</nav>
			<div class="contentArea">
				<div id="main">
<!-- 				<h1>완료된 배달내역 확인</h1>	 -->
				<div data-v-88eb18f6="" data-v-cf6a6ef4="" class="content_title">
					<div data-v-88eb18f6="" class="title">
						<h3 data-v-88eb18f6="">완료된 배달내역 확인 및 정산</h3>
					</div>
				</div>				
				
				<%--ZMAN 프로필 영역 --%>
				<section id="sec01">
					<div class="user_membership" data-v-32a5de90="" data-v-412d8616="">
						<div class="user_detail" data-v-32a5de90="">
							<div class="user_thumb01" data-v-32a5de90="">
								<br>
								<strong class="name" data-v-32a5de90="">${zman.zman_name }</strong> &nbsp;|&nbsp;
								<strong class="email" data-v-32a5de90="">${sessionScope.member_id }</strong>&nbsp;|&nbsp;
								<strong class="phone" data-v-32a5de90="">${zman.zman_phone }</strong>&nbsp;|&nbsp;
								<strong class="phone" data-v-32a5de90="">${zman.zman_transport }</strong>&nbsp;|&nbsp;
								<strong class="phone" data-v-32a5de90="">${zman.zman_status }</strong>
							</div>
						</div>
					</div>
				</section>
				<hr>
					
				<section id="sec02">
					<div class="mb-3 row">
						<label for="staticEmail" class="col-sm-2 col-form-label">해당 배달 번호</label>
						<div class="col-sm-7">
							<input type="text" readonly class="form-control-plaintext" id="zman_delivery_idx" value="${zd.zman_delivery_idx }">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputPassword" class="col-sm-2 col-form-label">배달 상품</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext" id="order_secondhand_product" value="${zd.order_secondhand_product }">
						</div>
					</div>
					
					<div class="mb-3 row">
					    <label for="inputPassword" class="col-sm-2 col-form-label">배달 수락시간</label>
					    <div class="col-sm-10">
					        <fmt:parseDate value="${zd.zman_delivery_accepttime }" pattern="yyyy-MM-dd HH:mm:ss.S" var="deliveryAcceptTime"/>
					        <fmt:formatDate value="${deliveryAcceptTime}" pattern="yy년 MM월 dd일 HH시 mm분" var="formattedDeliveryAcceptTime"/>
					        <input type="text" readonly class="form-control-plaintext" id="zman_delivery_accepttime" value="${formattedDeliveryAcceptTime}">
					    </div>
					</div>
					<div class="mb-3 row">
					    <label for="inputPassword" class="col-sm-2 col-form-label">배달 시작시간</label>
					    <div class="col-sm-10">
					        <fmt:parseDate value="${zd.zman_delivery_starttime }" pattern="yyyy-MM-dd HH:mm:ss.S" var="deliveryStartTime"/>
					        <fmt:formatDate value="${deliveryStartTime}" pattern="yy년 MM월 dd일 HH시 mm분" var="formattedDeliveryStartTime"/>
					        <input type="text" readonly class="form-control-plaintext" id="zman_delivery_starttime" value="${formattedDeliveryStartTime}">
					    </div>
					</div>
					<div class="mb-3 row">
					    <label for="inputPassword" class="col-sm-2 col-form-label">배달 종료시간</label>
					    <div class="col-sm-10">
					        <fmt:parseDate value="${zd.zman_delivery_endtime }" pattern="yyyy-MM-dd HH:mm:ss.S" var="deliveryEndTime"/>
					        <fmt:formatDate value="${deliveryEndTime}" pattern="yy년 MM월 dd일 HH시 mm분" var="formattedDeliveryEndTime"/>
					        <input type="text" readonly class="form-control-plaintext" id="zman_delivery_endtime" value="${formattedDeliveryEndTime}">
					    </div>
					</div>
					
					<div class="mb-3 row">
						<label for="inputPassword" class="col-sm-2 col-form-label">배달 출발지</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext" id="zman_delivery_startspot" value="${zd.zman_delivery_startspot }">
						</div>
					</div>
					<div class="mb-3 row">
						<label for="inputPassword" class="col-sm-2 col-form-label">배달 도착지</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext" id="zman_delivery_endspot" value="${zd.zman_delivery_endspot }">
						</div>
					</div>
					<div class="mb-3 row">
					    <label for="inputPassword" class="col-sm-2 col-form-label">배달료</label>
					    <div class="col-sm-10">
					        <fmt:formatNumber value="${zd.zman_delivery_commission}" type="number" pattern="#,###원" var="formattedDeliveryCommission"/>
					        <input type="text" readonly class="form-control-plaintext" id="zman_delivery_commission" value="${formattedDeliveryCommission}">
					    </div>
					</div>
				</section>
				
				<section id='sec03'>
					<c:choose>
					<c:when test="${empty zmanRefund.zman_refund_date }">
						<form action="zman_refund_form" method="get">
							<input type="hidden" name="zman_earning_idx" value="${zmanEarning.zman_earning_idx }">
							
	<!-- 					    <button>돌아가기</button> -->
						    <button class="btn btn-outline-dark btn-lg" type="submit">정산하기</button>
						</form>
					</c:when>
					<c:otherwise>
						<a class="btn btn-sm btn-outline-dark btn-lg" href="zman_earning">정산 완료</a>
					</c:otherwise>
					</c:choose>
				</section>
				
				
				</div> <%-- <div id="main">  --%>
			</div>
		</div>
	</article>
</body>
</body>
</html>