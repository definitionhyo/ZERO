<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/zpay.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<title>ZERO</title>
<script type="text/javascript">
	
	$(function() {
		checkButtonStatus();
		
		// 비번이 입력될 경우 [비밀번호확인] 버튼 활성화 ========================================================================
		$("#zpay_passwd").on("input", function() {
			checkButtonStatus();
		});
		
		// [비밀번호 변경] ======================================================================================================
		$(".passwdChangeButtonArea>button").on("click", function() {
			
			let existingZpayPasswd =  $("#existing_zpay_passwd").val();
			let newZpayPasswd =  $("#new_zpay_passwd").val();
			
			$.ajax({
				type : "GET", 
				url : "zpay_passwd_change_pro", 
				data : {existing_zpay_passwd : existingZpayPasswd, new_zpay_passwd : newZpayPasswd}, 
				dataType : "text", 
				success : function(data) {
					if(data == "true"){
// 						$("#exampleModalCenter").modal("hide");
// 						$("#exampleModalCenter").removeClass("show");
						alert("비밀번호 변경 성공");
						location.reload();
					} else {
						alert("비밀번호 변경 실패");						
					}
				}, 
				error : function() {
					alert("요청실패");
				}
			});
		});
			
			
	});


	// [비밀번호확인] 버튼의 상태확인 및 변경을 수행하는 함수 ===================================================================
	function checkButtonStatus(){
		let zpayPasswd =  $("#zpay_passwd").val();
		let chargeButton = $(".chargeButtonArea>button");
		
		if(zpayPasswd != "" && zpayPasswd.length == 6){
			chargeButton.removeAttr("disabled");
		} else {
			chargeButton.attr("disabled", "disabled");
		}
	}
		
	// [비밀번호입력] 란의 [x]버튼
	// 클릭 시 [비밀번호입력] 란의 내용 null로 바꾸기
	function passwdReset() {
		$("#zpay_passwd").val(null);
		checkButtonStatus();
	}
	
	// [기존비번입력] 란의 [x]버튼
	// 클릭 시 [기존비밀번호입력] 란의 내용 null로 바꾸기
	function existingPasswdReset() {
		$("#existing_zpay_passwd").val(null);
	}
	
	// [새비번입력] 란의 [x]버튼
	// 클릭 시 [새비밀번호입력] 란의 내용 null로 바꾸기
	function newPasswdReset() {
		$("#new_zpay_passwd").val(null);
	}
	
	// 비밀번호가 숫자 6자리인지 확인하는 함수
	function checkPasswd(passwd) {
		if(/^\d{6}$/.test(passwd)){
			$("#new_zpay_passwd_check").html("사용 가능한 비밀번호입니다");
			$("#new_zpay_passwd_check").css("color", "#09aa5c");
			$(".passwdChangeButtonArea>button").removeAttr("disabled");
		}else {
			$("#new_zpay_passwd_check").html("사용 불가능한 비밀번호입니다");			
			$("#new_zpay_passwd_check").css("color", "#333");
		}
	}
</script>
<style type="text/css">
	.container {
		padding-bottom: 0;
	}
</style>
</head>
<body>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	<article>
		<div class="container">
			<div class="contentAreaZpay">
			<%-- 메인영역 --%>
				<form action="${targetURL }" method="post">
					<input type="hidden" name="member_id" value="${sessionScope.member_id }">
					<input type="hidden" name="zpayAmount" value="${zpayAmount }">
					<c:if test="${!empty order_secondhand_idx }">
						<input type="hidden" name="order_secondhand_idx" value="${order_secondhand_idx }">
					</c:if>
					<c:if test="${!empty order_auction_idx }">
						<input type="hidden" name="order_auction_idx" value="${order_auction_idx }">
					</c:if>
					<c:if test="${!empty zman_earning_idx }">
						<input type="hidden" name="zman_earning_idx" value="${zman_earning_idx }">
						<input type="hidden" name="zman_net_profit" value="${zpayAmount }">
					</c:if>
					<div class="chargeContentArea">
						<div class="chargeInputArea text-center">
							<div class="title">
								비밀번호입력
							</div>
							<div class="amountArea">
								<div class="amountInputArea">
									<input type="password" id="zpay_passwd" name="zpay_passwd" maxlength="6" onkeyup="checkPasswd(this);" placeholder="비밀번호를 입력해 주세요">
									<button type="button" class="btn" onclick="passwdReset()">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
											<path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
										</svg>
									</button>							
								</div>							
							</div><%-- amountArea 영역 끝 --%>
							<div class="changePasswd">
								<a href="#" data-toggle="modal" data-target="#exampleModalCenter">비밀번호 변경</a>
							</div>
						</div><%-- chargeInputArea 영역 끝 --%>
						<div class="chargeButtonArea">
							<button type="submit" class="btn btn-dark btn-lg btn-block">비밀번호확인</button>
						</div><%-- chargeButtenArea 영역 끝 --%>
					</div><%-- chargeContetnArea 영역 끝 --%>
				</form>
			</div><%-- contentArea 영역 끝 --%>
		</div><%-- container 영역 끝 --%>
	</article>
	<footer>
		<%@ include file="../inc/footer.jsp"%>
	</footer>
	
	<%-- 모달 --%>
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalScrollableTitle">비밀번호 변경</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="changePasswdModal">
						<div class="changePasswdInputArea text-center">
							<div class="changePasswdArea">
								<div class="inputArea">
									<input type="password" id="existing_zpay_passwd" name="existing_zpay_passwd" maxlength="6" placeholder="기존 비밀번호">
									<button type="button" class="btn" onclick="existingPasswdReset()">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
											<path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
										</svg>
									</button>	
								</div>							
								<div class="inputArea mt-3">
									<input type="password" id="new_zpay_passwd" name="new_zpay_passwd" maxlength="6" onkeyup="checkPasswd(this.value);" placeholder="새로운 비밀번호">
									<button type="button" class="btn" onclick="newZpayPasswd()">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
											<path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
										</svg>
									</button>		
								</div>
								<div id="new_zpay_passwd_check" class="text-left"></div>					
							</div><%-- changePasswdArea 영역 끝 --%>
						</div><%-- changePasswdInputArea 영역 끝 --%>
						<div class="passwdChangeButtonArea mt-3">
							<button type="button" class="btn btn-dark btn-lg btn-block" disabled="disabled">비밀번호변경</button>
						</div><%-- passwdChangeButtonArea 영역 끝 --%>
					</div><%-- changePasswdModal 영역 끝 --%>
				</div>
<!-- 				  <div class="modal-footer"> -->
<!-- 					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> -->
<!-- 					<button type="button" class="btn btn-primary">Save changes</button> -->
<!-- 				</div> -->
			</div>
		</div>
	</div><%-- 모달영역 끝 --%>

</body>
</html>