<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
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
	href="${pageContext.request.contextPath }/resources/css/member.css"
	rel="stylesheet" type="text/css">
	
<title>중고거래 사이트</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</script>
<style>
@media only screen and (min-width: 768px) {
	.small_area[data-v-2b15bea4] {
		height: 500px;
	}
}
</style>
</head>
<body>
 <%--네비게이션 바 영역 --%>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<article id="mainArticle">
	
	<div class="container my lg">
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
			</nav>
		
			<div data-v-473e7c14="" class="contentArea">
			<%-- 메인영역 --%>
			<div  class=" my lg">
			<div   class="content_area small_area" data-v-2b15bea4="">
			
			<div data-v-88eb18f6="" data-v-2e8df47b="" class="content_title">
				<div data-v-88eb18f6="" class="title">
					<h3 data-v-88eb18f6="">문의 내역</h3>
				</div>
			</div>
<!-- 			<div data-v-88eb18f6="" class="title"> -->
<!-- 				<h3 data-v-88eb18f6="">문의 내역</h3> -->
<!-- 			</div> -->
			 <br>
<!-- 			 <form action=""> -->
			 	<table class="table">
						<c:choose>
							<c:when test="${empty myInqList}">
								<tr>
									<td>고객님의 최근 문의 내역이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
									<tr>
								 		<th scope="col" width="200px">문의 유형</th>
								 		<th scope="col" width="200px">문의 제목</th>
								 		<th scope="col" width="400px">문의 내용</th>
								 		<th scope="col" width="150px">답변 여부</th>
								 		<th scope="col" width="200px">문의내역 변경</th>
								 	</tr>
								<c:forEach var="myInqList" items="${myInqList }">
								 	<tr>
								 		<td>${myInqList.cs_type}</td>
								 		<td>${myInqList.cs_subject }</td>
								 		<td>${myInqList.cs_content }</td>
								 		<c:choose>
								 			<c:when test="${empty myInqList.cs_reply }">
								 				<td> 답변 예정 </td>
								 			</c:when>
									 		<c:otherwise>
									 			<td> 답변 완료 </td>
									 		</c:otherwise>
								 		</c:choose>
								 		<%-- 버튼 영역 --%>
									 	<td>
											<form action="inquiry_detail" method="post" >
												<input type="hidden" value="${myInqList.cs_idx }" name="cs_idx">
<%-- 												<input type="hidden" value="${myInqList.cs_reply }" name="cs_reply"> --%>
												<button data-v-43813796="" class="btn outlinegrey" type="submit">수정 및 삭제</button>
<!-- 												<input type="submit" value="수정 및 삭제"> -->
											</form>	 	
									 	</td>
								 	</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>
						<hr>
<!-- 			 </form> -->
			<div data-v-7bcac446 class="snb_var">
				<nav id="subNav" class="snb">
					<jsp:include page="/WEB-INF/views/inc/member_sidebar_hidden.jsp"></jsp:include>
				</nav>
			</div>
		 </div>
	  </div>
	  </div>
  </article>
  
  <div id="sieAds"></div>
  <%--페이지 하단 --%>
<%--   <footer id="pageFooter"><jsp:include page="/WEB-INF/views/inc/footer.jsp"></footer> --%>
  <footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
  
  <%-- 스크립트 코드 --%>
<!--   <script src="/_nuxt/0fc2b9a.js" defer=""></script> -->
<!--   <script src="/_nuxt/c2849e3.js" defer=""></script> -->
<!--   <script src="/_nuxt/6d1f03a.js" defer=""></script> -->
<!--   <script src="/_nuxt/5402e5b.js" defer=""></script> -->
<!--   <script src="/_nuxt/31641e8.js" defer=""></script> -->
<!--   <link href="/_nuxt/css/6ca5ffb.css" rel="stylesheet" type="text/css"> -->
<!--   <link href="/_nuxt/css/caea5a4.css" rel="stylesheet" type="text/css"> -->
  
</body>