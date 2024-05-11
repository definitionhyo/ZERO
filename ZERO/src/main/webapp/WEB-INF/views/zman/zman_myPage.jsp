<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/cs.css" rel="stylesheet" type="text/css">


  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#user_membership {
		margin: 25px;
	}
	
	/* u 태그 스타일 */
	  u {
	    font-size: 1.2em; /* 원하는 크기로 조정 */
	    font-weight: bold; /* 약간 두껍게 만들기 */
	  }
	  
	button {
		align-self: center;
	}
	
	.content_title[data-v-88eb18f6] {
	    display: flex;
	    padding: 5px 0 6px;
	    padding-bottom: 16px;
	    border-bottom: 3px solid #222!important;
	}
	
	
	#sec01 {
		display: flex;
		justify-content: center;
		align-items: center;	
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
			<div class="container-fluid">
				<div class="contentArea">
					<div id="main">
						<%-- ZMAN 마이페이지 --%>
						<%-- 개인정보와 배달정보를 분리해서 나타내기 --%>
<!-- 						<h1> ZMAN 마이페이지 </h1> -->
						
						<div data-v-88eb18f6="" data-v-cf6a6ef4="" class="content_title">
							<div data-v-88eb18f6="" class="title">
								<h3 data-v-88eb18f6="">ZMAN 마이페이지</h3>
								<nav class="navbar navbar-light"><%-- 사이드바 사라졌을 때 햄버거 메뉴 --%>
									<a class="navbar-brand" href="#"></a>
									<button class="navbar-toggler collapsed border-0 hidden_nav" type="button" data-toggle="collapse" data-target="#csCollapse" aria-controls="csCollapse" aria-expanded="false" aria-label="Toggle navigation">
										<span class="navbar-toggler-icon"></span>
									</button>
									<jsp:include page="/WEB-INF/views/inc/zman_sidebar_hidden.jsp"></jsp:include>
								</nav>
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
						<form class="row g-3" action="zman_delivery_start" method="GET">
							<%-- 12 --%>
						    <div class="col-md-4">
						   		<label for="inputAddress" class="form-label"><b><u> ZMAN 번호</u></b></label>
						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_idx" disabled="disabled" value="${zman.zman_idx}">
						    </div>
						    <div class="col-md-4">
						   		<label for="inputAddress" class="form-label"><u> 활동 상태</u></label>
						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_status" disabled="disabled" value="${zman.zman_status}">
						     </div>
						    <div class="col-md-4">
						    	<%-- 탈퇴한 회원이라면 탈퇴한 날짜 --%>
						   		<label for="inputAddress" class="form-label"><u>가입일</u></label>
						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_date" disabled="disabled" value="${zman.zman_date}">
						     </div>
						     
						     <br>
						     <%-- 12 --%>
						     
						     
<!-- 							 <div class="col-md-4"> -->
<!-- 								<label for="inputEmail4" class="form-label"><u> 이름</u></label> -->
<%-- 								<input type="zman_name" readonly class="form-control-plaintext" id="zman_name" disabled="disabled" value="${zman.zman_name}"> --%>
<!-- 							 </div> -->
<!-- 						     <div class="col-md-4"> -->
<!-- 						    	<label for="inputPassword4" class="form-label"><u> 아이디</u></label> -->
<%-- 						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_id" disabled="disabled" value="${zman.zman_id}"> --%>
<!-- 						     </div> -->
							 <div class="col-md-4">
								<label for="inputEmail4" class="form-label"><u>은행명</u></label>
								<input type="zman_name" readonly class="form-control-plaintext" id="zman_area" disabled="disabled" value="${zpay.zpay_bank_name}">
							 </div>
						     <div class="col-md-4">
						    	<label for="inputPassword4" class="form-label"><u>계좌번호</u></label>
						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_area" disabled="disabled" value="${zpay.zpay_bank_account}">
						     </div>
						     <div class="col-md-4">
						    	<label for="inputPassword4" class="form-label"><u>배달수단</u></label>
						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_transport" disabled="disabled" value="${zman.zman_transport}">
						     </div>
						     
						     <br>
						     <%-- 12 --%>
	  						 <div class="col-6">
						    	<label for="inputCity" class="form-label"><u>ZMAN 주소</u></label>
						   		<input type="zman_name" readonly class="form-control-plaintext" id="zman_transport" disabled="disabled" value="${zman.zman_address}">
						  	 </div>
	  						 <div class="col-6">
						    	<label for="inputCity" class="form-label"><u>활동 지역</u></label>
						   		<input type="zman_name" readonly class="form-control-plaintext" id="zman_area" disabled="disabled" value="${zman.zman_area}">
						  	 </div>
<!-- 	  						 <div class="col-4"> -->
<!-- 						    	<label for="inputCity" class="form-label"><mark>변경하기</mark></label> -->
<%-- <%-- 						   		<input type="zman_name" readonly class="form-control-plaintext" id="zman_area" disabled="disabled" value="${zman.zman_area}"> --%> 
<!-- 						  	 </div> -->
						  	 
						     <%-- 12 --%>
<!-- 							 <div class="col-md-4"> -->
<!-- 								<label for="inputEmail4" class="form-label"><u>은행명</u></label> -->
<%-- 								<input type="zman_name" readonly class="form-control-plaintext" id="zman_area" disabled="disabled" value="${zpay.zpay_bank_name}"> --%>
<!-- 							 </div> -->
<!-- 						     <div class="col-md-4"> -->
<!-- 						    	<label for="inputPassword4" class="form-label"><u>계좌번호</u></label> -->
<%-- 						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_area" disabled="disabled" value="${zpay.zpay_bank_account}"> --%>
<!-- 						     </div> -->
						     <%-- 12 --%>
<!-- 	  						 <div class="col-md-6"> -->
<!-- 	    						<label for="inputAddress2" class="form-label"><u>휴대폰</u></label> -->
<%-- 						    	<input type="zman_name" readonly class="form-control-plaintext" id="zman_area" disabled="disabled" value="${zman.zman_phone}"> --%>
<!-- 	  						 </div> -->
<!-- 	  						 <div class="col-md-6"> -->
<!-- 	    						<label for="inputAddress2" class="form-label">&nbsp;</label> -->
<!-- 	    						<input type="zman_name" class="form-control" id="inputZmanName" disabled="disabled" value="휴대폰 번호 변경하기"> -->
<!-- 	  						 </div> -->
	  						 
	  						 
						  	 <%-- 12 --%>
	  						 <div class="col-12">


	  						 </div>
	  						 <hr>
	  						 

	  						 <div class="col-12 ">
	    						 <button class="btn btn-outline-dark btn-lg" type="submit">수정하기</button>
    						 </div>
						</form>
					</section>
					
					</div> <%-- <div id="main">  --%>
				</div>
			</div>
		</div>
	</article>
</body>
</body>
</html>