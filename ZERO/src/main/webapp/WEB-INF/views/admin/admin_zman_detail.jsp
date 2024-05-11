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

	#zmanDetailInfo th {
		width: 30%;
		background-color: rgba(0, 0, 0, 0.07);
	}	

</style>
<script type="text/javascript">
	$(function() {
		$("#zmanStatusSelect").on("change", function() {
			let changedStatus = $("#zmanStatusSelect>option:selected").val();
			$("#zmanStatus").empty();
			$("#zmanStatus").html(changedStatus);
		});
	});
	
	$(function() {
		$("#zmanTransportSelect").on("change", function() {
			$("#modifyButton").removeAttr("disabled");
			
			let changedStatus = $("#zmanStatusSelect>option:selected").val();
			$("#zmanTransport").empty();
			$("#zmanTransport").html(changedStatus);
		});
	});
	
	$(function() {
		$("#zmanStatusSelect").on("change", function() {
			let changedStatus = $("#zmanStatusSelect>option:selected").val();
			$("#zmanStatus").empty();
			$("#zmanStatus").html(changedStatus);
			
			let now = new Date();
			let year = now.getFullYear();
			let month = String(now.getMonth() + 1).padStart(2, '0');
			let day = String(now.getDate()).padStart(2, '0');
			let zmanWithdrawal = year + "-" + month + "-" + day;

			
			if(changedStatus != "탈퇴"){
				$("#zmanWithdrawal").empty();
			} else {
				$("#zmanWithdrawal").html(zmanWithdrawal + '<input type="hidden" id="zman_withdrawal" name="zman_withdrawal" value="' + zmanWithdrawal + '">');
			}
			
			$("#modifyButton").removeAttr("disabled");
		});
		
		$(".zman_phone").on("click", function() {
			$("#modifyButton").removeAttr("disabled");
		})
		
	});
	
	
	function modify(){
// 		alert($("#memberStatus").text());
// 		alert($("#member_withdrawal").val());
// 		if($("#member_withdrawal").val() == ""){
	
		if($("#zmanStatus").text() == "탈퇴" && $("#zman_withdrawal").val() == ""){
			alert("탈퇴일을 지정해주세요");
		} else {
			$("form").submit();
		}
	}
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
					<h1 class="mt-4">${zman.zman_name } 님 회원정보</h1>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="admin_zman_list">zman목록</a></li>
						<li class="breadcrumb-item active" aria-current="page">상세정보</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<b>${zman.zman_name }</b> 님 회원정보
						</div>
						<div class="card-body">
							<form action="admin_zman_modify" method="post">
								<input type="hidden" name="zman_idx" value="${zman.zman_idx }">
								<input type="hidden" name="zman_id" value="${zman.zman_id }">
								<table id="zmanDetailInfo" class="table table-border">
									<tbody>
										<tr>
											<th>이름</th>
											<td colspan="2">${zman.zman_name }</td>
										</tr>
										<tr>
											<th>아이디</th>
											<td colspan="2">${zman.zman_id }</td>
										</tr>
										<tr>
											<th>생년월일</th>
											<td colspan="2">${zman.member_birth }</td>
										</tr>
										<tr>
											<th>전화번호</th>
											<td colspan="2">
												<input type="text" class="form-control zman_phone" name="zman_phone" value="${zman.zman_phone }">
											</td>
										</tr>
										<tr>
											<th>주소</th>
											<td colspan="2">${zman.zman_address } ${zman.zman_address_detail }</td>
										</tr>
										<tr>
											<th>zman 가입일</th>
											<td colspan="2">${zman.zman_date }</td>
										</tr>
										<tr>
											<th>zman상태</th>
											<td id="zmanStatus">${zman.zman_status }</td>
											<td class="text-end">
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="zman_status"  id="zmanStatusSelect" aria-label="Default select example" style="width: 170px;">
														<option value="활동" <c:if test="${zman.zman_status eq '활동' }">selected</c:if>>활동</option>
														<option value="대기" <c:if test="${zman.zman_status eq '대기' }">selected</c:if>>대기</option>
														<option value="정지" <c:if test="${zman.zman_status eq '정지' }">selected</c:if>>정지</option>
														<option value="탈퇴" <c:if test="${zman.zman_status eq '탈퇴' }">selected</c:if>>탈퇴</option>
													</select>
												</span>
	<!-- 											<span style="display: inline-block;"> -->
	<!-- 												<button type="button" class="btn btn-sm btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#changezmanStatus">변경</button>											 -->
	<!-- 											</span> -->
											</td>
										</tr>
<!-- 										<tr> -->
<!-- 											<th>탈퇴일</th> -->
<%-- 											<c:choose> --%>
												
<%-- 												<c:when test="${empty zman.zman_withdrawal }"> --%>
<!-- 													<td colspan="2" id="zmanWithdrawal"> -->
<!-- 														활동 중인 ZMAN / 탈퇴일 없음 -->
<!-- 													</td> -->
<%-- 												</c:when> --%>
<%-- 												<c:choose> --%>
<!-- 													<td> -->
<%-- 														${zman.zman_withdrawal } --%>
<!-- 													</td> -->
<%-- 												</c:choose> --%>
<%-- 											</c:choose> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th>배달 내역 상세보기</th> -->
<!-- 											<td colspan="2" class="text-end"> -->
<!-- 												<button type="button" class="btn btn-sm btn-dark text-nowrap">상세보기</button> -->
<!-- 											</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th>수익 내역 상세보기</th> -->
<!-- 											<td colspan="2" class="text-end"> -->
<!-- 												<button type="button" class="btn btn-sm btn-dark text-nowrap">상세보기</button> -->
<!-- 											</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th>계좌등록일</th> -->
<!-- 											<td colspan="2"></td> -->
<!-- 										</tr> -->
										<tr>
											<th>은행명</th>
											<td colspan="2">${zman.zpay_bank_name }
											</td>
										</tr>
										<tr>
											<th>계좌번호</th>
											<td colspan="2">${zman.zpay_bank_account }
											</td>
										</tr>
										<tr>
											<th>배달수단</th>
											<td id="zmanTransport">${zman.zman_transport }</td>
											<td class="text-end">
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="zman_transport"  id="zmanTransportSelect" aria-label="Default select example" style="width: 170px;">
														<option value="도보,자전거" <c:if test="${zman.zman_status eq '도보,자전거' }">selected</c:if>>도보,자전거</option>
														<option value="오토바이" <c:if test="${zman.zman_status eq '오토바이' }">selected</c:if>>오토바이</option>
														<option value="자동차" <c:if test="${zman.zman_status eq '자동차' }">selected</c:if>>자동차</option>
													</select>
												</span>
	<!-- 											<span style="display: inline-block;"> -->
	<!-- 												<button type="button" class="btn btn-sm btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#changezmanStatus">변경</button>											 -->
	<!-- 											</span> -->
											</td>
											
										</tr>
										<tr>
											<th>운전면허증 번호</th>
											<td colspan="2">${zman.zman_driver_license }</td>
										</tr>
										<tr>
											<th>교육이수 날짜</th>
											<td colspan="2">${zman.zman_education_completion }</td>
										</tr>
										<tr>
											<th>보험가입 날짜</th>
											<td colspan="2">${zman.zman_insurance_status }</td>
										</tr>
										<tr>
											<th>위치 기반 정보 수집 동의 날짜</th>
											<td colspan="2">${zman.zman_location_agreement }</td>
										</tr>
									</tbody>
								</table>
								<div class="text-center">
									<button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>							
										<button type="button" id="modifyButton" class="btn btn-dark text-nowrap" onclick="modify()" disabled="disabled">변경저장</button>						
										<button type="button" class="btn btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteZman">
											&nbsp;&nbsp;&nbsp;삭제&nbsp;&nbsp;&nbsp;
										</button>						
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
	
	<%-- zman 삭제 확인 모달창 --%>
	<div class="modal fade" id="confirmDeleteZman" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteZmanTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title fs-5" id="confirmDeleteZmanTitle">zman 삭제</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					삭제 후 복구가 불가합니다.<br>
					정말 삭제하시겠습니까?<br>
				</div>
				<div class="modal-footer">
					<button type="button" id="${zman.zman_idx }" class="btn btn-dark" onclick="location.href='admin_zman_delete?zman_idx=${zman.zman_idx }'">삭제</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
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