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
<title>ZERO</title>
<style type="text/css">
	body{
		min-width: 360px;
	}
</style>
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
					<h1 class="mt-4">고객센터관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">공지사항목록</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							공지사항목록 
							<a href="cs_notice" class="btn btn-sm btn-outline-dark" style="float: right;">고객센터 바로가기</a>					
						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>작성자</th>
										<th>제목</th>
										<th>작성일</th>
										<th>상세보기</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="cs" items="${csList }" varStatus="vs">
										<tr>
											<td>${cs.member_nickname }</td>
											<td>${cs.cs_subject }</td>
											<td>${cs.cs_date }</td>
<%-- 											<td><fmt:formatDate value="${cs.cs_date }" pattern="yy-MM-dd" /></td> --%>
											<td>
												<a class="btn btn-sm btn-outline-dark" href="admin_cs_notice_modify_form?cs_idx=${cs.cs_idx }">수정</a>
												<button type="button" class="btn btn-sm btn-outline-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteNotice${vs.index }">삭제</button>
											</td>
										</tr>
										<%-- 공지사항 삭제 확인 모달창 --%>
										<div class="modal fade" id="confirmDeleteNotice${vs.index }" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteNoticeTitle" aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title fs-5" id="confirmDeleteNoticeTitle">공지사항 삭제</h5>
														<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
													</div>
													<div class="modal-body">
														삭제 후 복구가 불가합니다.<br>
														정말 삭제하시겠습니까?<br>
													</div>
													<div class="modal-footer">
														<button type="button" id="${cs.cs_idx }" class="btn btn-dark" onclick="location.href='admin_cs_notice_delete?cs_idx=${cs.cs_idx}'">삭제</button>
														<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</tbody>
							</table>
							<a class="btn btn-sm btn-outline-dark" href="admin_cs_notice_write_form">글쓰기</a>
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