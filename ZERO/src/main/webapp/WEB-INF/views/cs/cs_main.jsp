<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmf" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/cs.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>ZERO</title>
<style type="text/css">
.hidden_nav {
	display: flex;
	outline: none!important;
}
.hidden_nav:active {
	outline: none!important;
}
@media only screen and (min-width: 768px) {
	.hidden_nav {
		display: none;
	}
}
</style>
</head>
<body>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	<article>
		<div class="container cs">
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/cs_sidebar.jsp"></jsp:include>
			</nav>
			<div class="contentArea">
				<div>
					<div class="content_title border">
						<div class="title">
							고객센터
						</div>
						<nav class="navbar navbar-light"><%-- 사이드바 사라졌을 때 햄버거 메뉴 --%>
							<a class="navbar-brand" href="#"></a>
							<button class="navbar-toggler collapsed border-0 hidden_nav" type="button" data-toggle="collapse" data-target="#csCollapse" aria-controls="csCollapse" aria-expanded="false" aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
							<jsp:include page="/WEB-INF/views/inc/cs_sidebar_hidden.jsp"></jsp:include>
						</nav>
					</div>
					<div class="content_main">
						<div class="row">
							<div class="col-12">
								<div class="row">
									<div class="col col-6">
										<div class="row">
											<div class="col col-12 col-lg-4 mt-3 d-flex justify-content-center">
												<a href="cs_qna_form" class="text-center">
													<img src="${pageContext.request.contextPath}/resources/img/online-meeting.png"  alt="..." width="100px" height="100px"style=" display:block;">
												</a>
											</div>
											<div class="col col-12 col-lg-8 mt-3">
												<h5>1:1 문의</h5>
												<span class="info">해결되지 않은 문제가 있나요? <br>1:1 문의로 문의주세요. </span>
											</div>
										</div>
									</div>
									<div class="col col-6">
										<div class="row">
											<div class="col col-12 col-lg-4 mt-3 d-flex justify-content-center">
												<a href="cs_faq" class="text-center">
													<img src="${pageContext.request.contextPath}/resources/img/faq.png"  alt="..." width="100px" height="100px"style=" display:block;">
												</a>
											</div>
											<div class="col col-12 col-lg-8 mt-3">
												<h5>FAQ</h5>
												<span class="info">자주 묻는 질문 <br>빠르고 간편하게 검색하세요. </span>
											</div>		
										</div>
									</div>
								</div>
							</div>
							
							
						</div><!-- 첫번째 row 끝-->
<!-- 						<hr> -->
						<div class="bottomRow">
							<div class="noticeArea">
								<div class="noticeTitleArea">
									<div class="title">
										공지사항
									</div>
									<a href="cs_notice">더보기></a>								
								</div>
								<div class="content_main notice">
									<ul>
										<c:forEach var="cs" items="${csList }">
											<li>
												<a href="cs_notice_view?cs_idx=${cs.cs_idx }">
													<p>${cs.cs_subject }</p>
												</a>
											</li>
										</c:forEach>
									</ul>
								</div>
								
<!-- 								<table> -->
<%-- 									<c:forEach items="${csInfoList }" var="csNotice" varStatus="i"> --%>
<!-- 								    	<tr> -->
<!-- 								    		<th> -->
<%-- 									    		<c:choose> --%>
<%-- 									    			<c:when test="${i.index eq 1 }"> --%>
<%-- 														<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg> --%>
<%-- 									    			</c:when> --%>
<%-- 									    			<c:otherwise> --%>
<!-- 														<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24"><path d="m16.114 1.553 6.333 6.333a1.75 1.75 0 0 1-.603 2.869l-1.63.633a5.67 5.67 0 0 0-3.395 3.725l-1.131 3.959a1.75 1.75 0 0 1-2.92.757L9 16.061l-5.595 5.594a.749.749 0 1 1-1.06-1.06L7.939 15l-3.768-3.768a1.75 1.75 0 0 1 .757-2.92l3.959-1.131a5.666 5.666 0 0 0 3.725-3.395l.633-1.63a1.75 1.75 0 0 1 2.869-.603ZM5.232 10.171l8.597 8.597a.25.25 0 0 0 .417-.108l1.131-3.959A7.17 7.17 0 0 1 19.67 9.99l1.63-.634a.25.25 0 0 0 .086-.409l-6.333-6.333a.25.25 0 0 0-.409.086l-.634 1.63a7.17 7.17 0 0 1-4.711 4.293L5.34 9.754a.25.25 0 0 0-.108.417Z"></path></svg> -->
<%-- 									    			</c:otherwise> --%>
<%-- 									    		</c:choose> --%>
<!-- 								   			</th> -->
<%-- 										    <th>${csNotice.cs_type }</th> --%>
<!-- 										    <td> -->
<%-- 										    	<a id="tit" href="cs_notice_view?cstypeNo=1&cs_type_list_num=${csNotice.cs_type_list_num }&pageNo=1">${csNotice.cs_subject }</a> --%>
<!-- 								    		</td> -->
<!-- 										    <td> -->
<%-- 										    	<fmf:formatDate value="${csNotice.cs_date}" pattern="yyyy.MM.dd"/> --%>
<!-- 										    </td> -->
<!-- 								    	</tr> -->
<%-- 									</c:forEach> --%>
<!-- 							    </table> -->
							</div>
					 	</div><!-- 두번째 row 끝-->
					</div><!-- content_main 끝 -->
				</div>
			</div>
		</div>
	</article>
	<footer>
	
	</footer>
</body>
</html>