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
		$("#memberTypeSelect").on("change", function() {
			let changedType = $("#memberTypeSelect>option:selected").val();
			$("#memberType").empty();
			$("#memberType").html(changedType);
		});

		$("#memberMailAuthSelect").on("change", function() {
			let changedType = $("#memberMailAuthSelect>option:selected").val();
			$("#memberMailAuth").empty();
			$("#memberMailAuth").html(changedType);
		});

		$("#memberBankAuthSelect").on("change", function() {
			let changedType = $("#memberBankAuthSelect>option:selected").val();
			$("#memberBankAuth").empty();
			$("#memberBankAuth").html(changedType);
		});

		$("#memberStatusSelect").on("change", function() {
			let changedStatus = $("#memberStatusSelect>option:selected").val();
			$("#memberStatus").empty();
			$("#memberStatus").html(changedStatus);

			let now = new Date();
			let year = now.getFullYear();
			let month = String(now.getMonth() + 1).padStart(2, '0');
			let day = String(now.getDate()).padStart(2, '0');
			let memberWithdrawal = year + "-" + month + "-" + day;
			
			if(changedStatus == "활동"){
				$("#memberWithdrawal").empty();
			} else {
				$("#memberWithdrawal").html(memberWithdrawal + '<input type="hidden" id="member_withdrawal" name="member_withdrawal" value=' + memberWithdrawal + '>');
			}
		});
		
	});
	
	function modify(){
		if($("#memberStatus").text() == "탈퇴" && $("#member_withdrawal").val() == ""){
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
					<h1 class="mt-4">${member.member_name } 님 회원정보</h1>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="admin_member_list">회원목록</a></li>
						<li class="breadcrumb-item active" aria-current="page">상세정보</li>
					</ol>
					
					<%-- main 내용 작성 영역 --%>
					<div class="card mb-4">
						<div class="card-header">
							<b>${member.member_name }</b> 님 회원정보
						</div>
						<div class="card-body">
							<form action="admin_member_modify" method="post" id="member_modify_form">
								<input type="hidden" name="member_idx" value="${member.member_idx }">
								<table id="memberDetailInfo" class="table table-border">
									<tbody>
										<tr>
											<th>이름</th>
											<td colspan="2">
											<c:choose>
												<c:when test="${not empty member.member_image }">
													<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${member.member_image }" alt="사용자 이미지" class="thumb_img" width=50px height=50px>${member.member_name }
												</c:when>
												<c:otherwise>
													<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" alt="사용자 이미지" class="thumb_img" width=50px height=50px>${member.member_name }
												</c:otherwise>
											</c:choose>		
<%-- 												${member.member_image} ${member.member_name } --%>
											</td>
										</tr>
										<tr>
											<th>아이디</th>
											<td colspan="2">
												${member.member_id }
											</td>
										</tr>
										<tr>
											<th>닉네임</th>
											<td colspan="2">
												${member.member_nickname }
											</td>
										</tr>
<!-- 										<tr> -->
<!-- 											<th>비밀번호</th> -->
<%-- 											<td colspan="2">${member.member_passwd }</td> --%>
<!-- 										</tr> -->
										<tr>
											<th>회원타입</th>
											<td id="memberType">${member.member_type}</td>
											<td class="text-end">
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="member_type"  id="memberTypeSelect" aria-label="Default select example" style="width: 170px;">
														<option value="회원" <c:if test="${member.member_type eq '회원' }">selected</c:if>>회원</option>
														<option value="Z맨" <c:if test="${member.member_type eq 'Z맨' }">selected</c:if>>Z맨</option>
														<option value="직원" <c:if test="${member.member_type eq '직원' }">selected</c:if>>직원</option>
													</select>
												</span>
											</td>
										</tr>
										<tr>
											<th>이메일 인증여부</th>
											<td id="memberMailAuth">${member.member_mail_auth }	</td>
											<td class="text-end">
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="member_mail_auth"  id="memberMailAuthSelect" aria-label="Default select example" style="width: 170px;">
														<option value="Y" <c:if test="${member.member_mail_auth eq 'Y' }">selected</c:if>>Y</option>
														<option value="N" <c:if test="${member.member_mail_auth eq 'N' }">selected</c:if>>N</option>
													</select>
												</span>
											</td>
										</tr>
										<tr>
											<th>생년월일</th>
											<td colspan="2">${member.member_birth }</td>
										</tr>
										<tr>
											<th>전화번호</th>
											<td colspan="2">
												<input type="text" class="form-control" name="member_phone" value="${member.member_phone }">
											</td>
										</tr>
										<tr>
											<th>회원상태</th>
											<td id="memberStatus">${member.member_status}</td>
											<td class="text-end">
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="member_status"  id="memberStatusSelect" aria-label="Default select example" style="width: 170px;">
														<option value="활동" <c:if test="${member.member_status eq '활동' }">selected</c:if>>활동</option>
														<option value="탈퇴" <c:if test="${member.member_status eq '탈퇴' }">selected</c:if>>탈퇴</option>
													</select>
												</span>
<!-- 												<span style="display: inline-block;"> -->
<!-- 													<button type="button" class="btn btn-sm btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#changeMemberStatus">변경</button>											 -->
<!-- 												</span>	 -->
											</td>
										</tr>
										<tr>
											<th>탈퇴일</th>
											<td colspan="2" id="memberWithdrawal">
<%-- 											<c:choose> --%>
<%-- 												<c:when test="${member.member_withdrawal eq null }"> --%>
<!-- 													<input type="date" name="member_withdrawal" class="form-control datepicker"> -->
<%-- 												</c:when> --%>
<%-- 												<c:otherwise> --%>
													${member.member_withdrawal }
<%-- 												</c:otherwise> --%>
<%-- 											</c:choose> --%>
										</tr>
										<tr>
											<th>피신고건수</th>
											<td>${memberReportCount } 건</td>
											<td class="text-end">
												<button type="button" class="btn btn-sm btn-dark text-nowrap" onclick="location.href='admin_member_report?reported_member_id=${member.member_id}'">목록보기</button>
											</td>
										</tr>
										<tr>
											<th>중고거래내역 목록보기</th>
											<td>${orderSecondhandCount } 건</td>
											<td class="text-end">
												<button type="button" class="btn btn-sm btn-dark text-nowrap" onclick="location.href='admin_secondhand_order_list?member_id=${member.member_id}'">목록보기</button>
											</td>
										</tr>
										<tr>
											<th>경매내역 목록보기</th>
											<td>${orderAuctionCount } 건</td>
											<td class="text-end">
												<button type="button" class="btn btn-sm btn-dark text-nowrap" onclick="location.href='admin_auction_order_list?member_id=${member.member_id}'">목록보기</button>
											</td>
										</tr>
										<tr>
											<th>가입일</th>
											<td colspan="2">${member.member_date }</td>
										</tr>
										<tr>
											<th>주소1</th>
											<td colspan="2">
												${member.member_address1 }&nbsp;${member.member_address_detail1 }
											</td>
										</tr>
										<tr>
											<th>주소2</th>
											<td colspan="2">
												${member.member_address2 }&nbsp;${member.member_address_detail2 }
											</td>
										</tr>
										<tr>
											<th>주소3</th>
											<td colspan="2">
												${member.member_address3 }&nbsp;${member.member_address_detail3 }
											</td>
										</tr>
										<tr>
											<th>계좌인증여부</th>
											<td id="memberBankAuth">${member.member_bank_auth }</td>
											<td class="text-end">
												<span style="display: inline-block;">
													<select class="form-select form-select-sm" name="member_bank_auth"  id="memberBankAuthSelect" aria-label="Default select example" style="width: 170px;">
														<option value="Y" <c:if test="${member.member_bank_auth eq 'Y' }">selected</c:if>>Y</option>
														<option value="N" <c:if test="${member.member_bank_auth eq 'N' }">selected</c:if>>N</option>
													</select>
												</span>
											</td>
										</tr>
<!-- 										<tr> -->
<!-- 											<th>계좌등록일</th> -->
<!-- 											<td colspan="2"> -->
<!-- 											</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th>은행명</th> -->
<%-- 											<td colspan="2">${member_bank_name }</td> --%>
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th>계좌번호</th> -->
<!-- 											<td colspan="2"></td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<th>ZPAY 잔액</th> -->
<!-- 											<td></td> -->
<!-- 											<td class="text-end"> -->
<!-- 												<button type="button" class="btn btn-sm btn-dark text-nowrap">상세보기</button> -->
<!-- 											</td> -->
<!-- 										</tr> -->
									</tbody>
								</table>
								<div class="text-center">
									<button type="button" class="btn btn-outline-dark" onclick="history.back()">뒤로가기</button>							
									<button type="button" class="btn btn-dark text-nowrap" onclick="modify()">변경저장</button>						
<!-- 									<button type="submit" class="btn btn-dark text-nowrap">변경저장</button>						 -->
									<button type="button" class="btn btn-dark text-nowrap" data-bs-toggle="modal" data-bs-target="#confirmDeleteMember">
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
		
	<%-- 회원 삭제 확인 모달창 --%>
	<div class="modal fade" id="confirmDeleteMember" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteMemberTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title fs-5" id="confirmDeleteMemberTitle">회원 삭제</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					삭제 후 복구가 불가합니다.<br>
					정말 삭제하시겠습니까?<br>
				</div>
				<div class="modal-footer">
					<button type="button" id="${member.member_idx }" class="btn btn-dark" onclick="location.href='admin_member_delete?member_idx=${member.member_idx }'">삭제</button>
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