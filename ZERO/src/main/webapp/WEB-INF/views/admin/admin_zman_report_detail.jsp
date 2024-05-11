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

	#memberDetailInfo th {
		width: 30%;
		background-color: rgba(0, 0, 0, 0.07);
	}	

</style>
<script type="text/javascript">
	$(function() {
		$("#reortStatusChange").on("change", function() {
			let changedStatus = $("#reortStatusChange>option:selected").val();
			$("#reportStatus").empty();
			$("#reportStatus").html(changedStatus);
		});
	});
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
					<h1 class="mt-4">ZMAN 신고 상세보기</h1>
					<ol class="breadcrumb">
						
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							ZMAN 신고 상세보기
						</div>
						<div class="card-body">
							<form action="admin_member_report_status_modify" method="post">
								<input type="hidden" name="report_idx" value="${report.report_idx }">
								<table id="memberDetailInfo" class="table table-border">
									<tbody>
										<tr>
											<th>신고번호</th>
											<td>${report.report_idx }</td>
										</tr>
										<tr>
											<th>신고일</th>
											<td>${report.report_datetime }</td>
										</tr>
										<tr>
											<th>신고자</th>
											<td>${report.report_member_id }</td>
										</tr>
										<tr>
											<th>피신고자(ZMAN)</th>
											<td>${report.reported_zman_id }</td>
										</tr>
										<tr>
											<th>신고내용</th>
											<td>${report.report_content }</td>
										</tr>
										<tr>
											<th>신고된 배달 날짜</th>
											<td>${report.zman_delivery_endtime }</td>
										</tr>
										<tr>
											<th>신고 관련 배달 물품</th>
											<td>${report.order_secondhand_product }</td>
										</tr>
<!-- 										<tr> -->
<!-- 											<th>신고 관련 배달 물품</th> -->
<%-- 											<td>${report.order_secondhand_product }</td> --%>
<!-- 										</tr> -->
										<tr>
											<th>신고처리상태</th>
											<td>
												<span id="reportStatus" style="display: inline-block;">${report.report_status}</span>
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="report_status"  id="reortStatusChange" aria-label="Default select example" style="width: 170px;">
														<option value="처리전" <c:if test="${report.report_status eq '처리전' }">selected</c:if>>처리전</option>
														<option value="처리중" <c:if test="${report.report_status eq '처리중' }">selected</c:if>>처리중</option>
														<option value="처리완료" <c:if test="${report.report_status eq '처리완료' }">selected</c:if>>처리완료</option>
													</select>
												</span>
<%-- 												<input type="text" class="form-control" name="member_type" value="${report.report_status }"> --%>
											</td>
										</tr>
									</tbody>
								</table>
								<div class="text-center">
									<button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>							
									<button type="button" class="btn btn-dark"  data-bs-toggle="modal" data-bs-target="#changeMemberReport">변경저장</button>							
								</div>
								<%-- 회원상태 변경 모달창 --%>
								<div class="modal fade" id="changeMemberReport" tabindex="-1" role="dialog" aria-labelledby="changeMemberReportTitle" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title fs-5" id="changeMemberReportTitle">신고처리상태변경</h5>
												<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												정말 변경하시겠습니까?
											</div>
											<div class="modal-footer">
												<form action="member_login_form" method="post">
													<input type="hidden" name="play_num" value="" />  
													<input type="hidden" name="url" value="" />
													<button type="submit" class="btn btn-dark">변경</button>
													<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
												</form>
											</div>
										</div>
									</div>
								</div>
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