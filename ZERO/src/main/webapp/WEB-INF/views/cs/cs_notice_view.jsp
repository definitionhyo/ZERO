<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/cs.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<title>ZERO</title>
<style>

/* a>b{ */
/* 	color: #000; */
/* 	text-decoration: none; */
/* } */

/* a:hover{ */
/* 	color: #000; */
/* 	text-decoration: none; */
/* } */

/* #mainNav>ul{ */
/* 	list-style: none; */
/* } */

/* /* a링크 활성화 색상 변경 */
/* a:hover, a:active{ */
/*  color:  #ff5050 !important; */
	
/* } */


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
							공지사항
						</div>
						<nav class="navbar navbar-light"><%-- 사이드바 사라졌을 때 햄버거 메뉴 --%>
							<a class="navbar-brand" href="#"></a>
							<button class="navbar-toggler collapsed border-0 hidden_nav" type="button" data-toggle="collapse" data-target="#csCollapse" aria-controls="csCollapse" aria-expanded="false" aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>
							<jsp:include page="/WEB-INF/views/inc/cs_sidebar_hidden.jsp"></jsp:include>
						</nav>
					</div>
					<div class="content_main notice_view">
						<div class="head">
							<div class="titleArea">
								<span class="date">${cs.cs_date }</span>
								<p class="title">${cs.cs_subject }</p>
							</div>
						</div>
						<div class="contentArea">
							<div class="content">
								<%
									pageContext.setAttribute("crcn", "\r\n");	// Space, Enter
									pageContext.setAttribute("br", "<br>");
								%>
								${fn:replace(cs.cs_content, crcn, br) }
							</div>							
						</div>
						<div class="btnArea">
							 <button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</article>
	<footer>
	
	</footer>
</body>
</html>