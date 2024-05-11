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
	
	//[비밀번호확인] 버튼의 상태확인 및 변경을 수행하는 함수 ===================================================================
	function checkButtonStatus(){
		let zpayPasswd1 =  $("#zpay_passwd1").val();
		let zpayPasswd2 =  $("#zpay_passwd2").val();
		let chargeButton = $(".chargeButtonArea>button");
		
		if (/^\d{6}$/.test(zpayPasswd1) && /^\d{6}$/.test(zpayPasswd2) && zpayPasswd1 === zpayPasswd2) {
			$(".chargeButtonArea button").prop("disabled", false);
		} else {
			$(".chargeButtonArea button").prop("disabled", true);
		}
	}
	
	
	$(function(){		
		// 비밀번호가 입력될 경우 [비밀번호확인] 버튼 활성화 ====================================================================
		$(function() {
			$("#zpay_passwd1, #zpay_passwd2").on("input", function() {
				checkButtonStatus();
			});
		});
	});
	
	
	// [비밀번호입력] 란의 [x]버튼
	// 클릭 시 [비밀번호입력] 란의 내용 null로 바꾸기
	function passwdReset1() {
		$("#zpay_passwd1").val(null);
		checkButtonStatus();
	}
	
	function passwdReset2() {
		$("#zpay_passwd2").val(null);
		checkButtonStatus();
	}
	
	// 비밀번호가 숫자 6자리인지 확인하는 함수
	function checkPasswd1(passwd1) {
		if(/^\d{6}$/.test(passwd1)){
			$("#zpay_passwd_check1").html("사용 가능한 비밀번호입니다");
			$("#zpay_passwd_check1").css("color", "#09aa5c");
			checkButtonStatus();
		}else {
			$("#zpay_passwd_check1").html("사용 불가능한 비밀번호입니다");			
			$("#zpay_passwd_check2").css("color", "#333");
			checkButtonStatus();
		}
	}
	
	// 재입력한 비빌번호가 숫자 6자리 이면서 처음 입력한 비밀번호와 일치하는지 확인하는 함수
	function checkPasswd2(passwd2) {
		if(/^\d{6}$/.test(passwd2) && passwd2 == $("#zpay_passwd1").val()){
			$("#zpay_passwd_check2").html("비밀번호가 일치합니다");
			$("#zpay_passwd_check2").css("color", "#09aa5c");
			checkButtonStatus();
		}else {
			$("#zpay_passwd_check2").html("비밀번호가 일치하지 않습니다");			
			$("#zpay_passwd_check2").css("color", "#333");
			checkButtonStatus();
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
				<form action="zpay_regist" method="post">
					<input type="hidden" name="user_name" value="${user_name }">
					<input type="hidden" name="fintech_use_num" value="${fintech_use_num }">
					<input type="hidden" name="bank_name" value="${bank_name }">
					<input type="hidden" name="account_num_masked" value="${account_num_masked }">
					<div class="chargeContentArea">
						<div class="chargeInputArea text-center">
							<div class="title">
								충전, 환급 및 송금 시 사용할 비밀번호를 지정해주세요
							</div>
							<div class="amountArea">
								<div class="amountInputArea">
									<input type="password" id="zpay_passwd1" name="zpay_passwd1" maxlength="6" onkeyup="checkPasswd1(this.value);" placeholder="숫자 6자리를 입력해주세요">
									<button type="button" class="btn" onclick="passwdReset1()">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
											<path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
										</svg>
									</button>	
								</div>							
								<div id="zpay_passwd_check1" class="text-left"></div>					
								<div class="amountInputArea mt-3">
									<input type="password" id="zpay_passwd2" name="zpay_passwd2" maxlength="6" onkeyup="checkPasswd2(this.value);" placeholder="비밀번호를 재입력해주세요">
									<button type="button" class="btn" onclick="passwdReset2()">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
											<path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
										</svg>
									</button>		
								</div>							
								<div id="zpay_passwd_check2" class="text-left"></div>					
							</div><%-- amountArea 영역 끝 --%>
							<div class="withdrawalAccountArea">
							</div><%-- withdrawalAccountArea 영역 끝 --%>
						</div><%-- chargeInputArea 영역 끝 --%>
						<div class="chargeButtonArea">
							<button type="submit" class="btn btn-dark btn-lg btn-block" disabled>비밀번호설정</button>
						</div><%-- chargeButtenArea 영역 끝 --%>
					</div><%-- chargeContetnArea 영역 끝 --%>
				</form>
			</div><%-- contentArea 영역 끝 --%>
		</div><%-- container 영역 끝 --%>
	</article>
	<footer>
		<%@ include file="../inc/footer.jsp"%>
	</footer>

</body>
</html>