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
</style>
<script type="text/javascript">
	function emptyFile(){
		$("#insertImg").empty();
		$("#insertImg").html(
			'<input type="file" class="form-control" aria-label="cs_file" name="file" />'	
		);
	};
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
					<h1 class="mt-4">고객센터관리</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">공지사항 작성</li>
					</ol>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i>
							공지사항 작성
						</div>
						<div class="card-body">		
							<%-- main 내용 작성 영역 --%>
							<form action="admin_cs_notice_modify_pro" id="cs_form" method="post" enctype="multipart/form-data">
<%-- 								<input type="hidden" name="pageNo" value="${param.pageNo }"> 페이지번호 전송용 --%>
								<input type="hidden" name="cs_idx" value="${cs.cs_idx }" >
								<input type="hidden" name="cs_type" value="${cs.cs_type }" ><%-- 공지사항 유형 정보 전송용 --%>
								<input type="hidden" name="member_idx" value="${cs.member_idx }" >
						
								<table class="table table-striped text-center align-middle">
									<tbody>
									<tr>
										<td scope="col" class="align-middle" width="100">제목</th>
										<td scope="col" class="align-middle">
											<input type="text" class="form-control" aria-label="cs_subject" name="cs_subject" id="cs_subject" value="${cs.cs_subject }" required="required">
										</td>
									</tr>
									<tr>
										<td scope="col" class="align-middle" width="100">작성자</th>
										<td scope="col" class="align-middle">
<%-- 											<input type="text" class="form-control" aria-label="cs_name" name="member_id" value="${member.member_id }"> --%>
											<input type="text" class="form-control" aria-label="cs_name" name="member_id" value="${sessionScope.member_id }" readonly>
										</td>
									</tr>
									<tr>
										<td scope="col" class="align-middle" width="100">내용</th>
										<td scope="col" class="align-middle">
											<textarea class="form-control" rows="10" cols="200" name="cs_content" id="cs_content">${cs.cs_content }</textarea>
										</td>
									</tr>
									<tr>
										<td scope="col" class="align-middle" width="100">사진첨부</th>
										<td scope="col" class="align-middle" id="insertImg">
											<%-- 파일이 존재할 경우 파일명과 삭제버튼 표시하고, 아니면 파일 등록 버튼 표시 --%>
											<c:choose>
												<c:when test="${empty cs.cs_file }">
													<input type="file" name="file" /><br>
												</c:when>
												<c:otherwise>
													<a href="${pageContext.request.contextPath }/resources/upload/${cs.cs_file }" download="${fn:split(cs.cs_file, '_')[1] }">
														${cs.cs_file }
													</a>
													<input type="button" class="btn btn-sm btn-dark" value="삭제" onclick="emptyFile()"><br>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
									<tr>
										<td scope="col" class="align-middle"></td>
										<td scope="col" class="align-middle">
											<button class="btn btn-dark" type="button" onclick="history.back()">돌아가기</button>
											<button class="btn btn-dark" type="submit">&nbsp;&nbsp;&nbsp;수정&nbsp;&nbsp;&nbsp;</button>
											<button type="button" class="btn btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteNotice">
												&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;
											</button>
											
											<%-- 공지사항 삭제 확인 모달창 --%>
											<div class="modal fade" id="confirmDeleteNotice" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteNoticeTitle" aria-hidden="true">
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
										</td>
									</tr>
								</table>
							</form>
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