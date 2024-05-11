<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/member.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>ZERO</title>
<style>
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

function requestMailAuth() {
		
	document.getElementById('email').toggleAttribute('disabled');
	document.getElementById('emailAuth').classList.toggle('blind');
	document.getElementById('requestAuth').classList.toggle('blind');
	document.getElementById('authRegist').classList.toggle('blind');
	document.getElementById('authCancel').classList.toggle('blind');

	var email = $("#email").val();
	var send = $("#email").prop('disabled');
	console.log(email);
	console.log(send);
	
	if(send == true) { // 인증 메일 발송 버튼 클릭
		console.log('ajax 보내기');
	
        $.ajax({
            type: "POST",
            url: "sendAuthCode",
            data: { email: email },
            success: function (data) {
                console.log("응답 데이터:", data); // 추가된 부분
                if (data.success) {
                    alert("인증번호가 이메일로 발송되었습니다.");
                } else {
                    alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
                }
            },
            error: function () {
                alert("오류가 발생했습니다. 다시 시도해주세요.");
	            }
	    });
		
	}
	
	alert("인증 메일 발송 완료!");
	document.getElementById('mail_title').classList.toggle('blind');
	document.getElementById('auth_title').classList.toggle('blind');
	document.getElementById('mail_txt').classList.toggle('blind');
	
}

function responseMailAuth() {
	var authCode = $("#authCode").val();
	
	$.ajax({
		type: "GET",
		url: "RequestAuthMailPro",
		data: {
			email: email
		},
		dataType: "text",
		success: function(result) {
			if(result == "true") {
				console.log("인증 코드 일치!");
			} else {
				console.log("인증 코드 불일치!");
			}
		},
		error: function() {
			alert("인증 코드 비교 실패!");
		}
	});
	
}

</script>
</head>
<body>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<article id="mainArticle">
		<div class="container help">
<!-- 			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar"> -->
<%-- 				<jsp:include page="/WEB-INF/views/inc/member_sidebar.jsp"></jsp:include> --%>
<!-- 			</nav> -->
			<div class="contentArea">
			<%-- 메인영역 --%>
							<%-- 메인영역 --%>
				<div class="">
					<div class="content lg">
						<div class="help_area">
							<div>
								<h2 class="help_title" data-v-4e1fd2e6="" id="mail_title">이메일 인증 요청</h2>
								<h2 class="help_title blind" data-v-4e1fd2e6="" id="auth_title">인증 코드 입력</h2>
								<div class="help_notice" >
									<p class="notice_txt" id="mail_txt"> 가입 시 등록한 이메일 주소를 입력하면<br> 
									인증 코드를 메일로 발송해드립니다. </p>
								</div>
								<div class="input_box" data-v-4e1fd2e6="">
									<h3 class="input_title" data-v-4e1fd2e6="">이메일 주소</h3>
									<div class="input_item" data-v-4e1fd2e6="">
										<input type="text" placeholder="가입하신 이메일 주소" data-v-4e1fd2e6="" autocomplete="off" class="input_txt" name="email" id="email">
									</div>
								</div>
								<div class="blind" id="emailAuth">
									<div class="input_box" data-v-4e1fd2e6="">
										<h3 class="input_title" data-v-4e1fd2e6="">인증 코드</h3>
										<div class="input_item" data-v-4e1fd2e6="">
											<input type="text" placeholder="발송된 인증 코드를 입력해주세요" data-v-4e1fd2e6="" autocomplete="off" class="input_txt" name="authCode" id="authCode">
										</div>
									</div>
								</div>
								<div class="help_btn_box" data-v-4e1fd2e6="">
<!-- 									<a disabled="disabled" data-v-43813796="" class="btn full solid disabled" onclick="requestMailAuth()"> 인증 메일 발송 요청 </a> -->
									<a class="btn full solid" id="requestAuth" data-v-43813796="" onclick="requestMailAuth()"> 인증 메일 발송 요청 </a>
									<a class="btn full solid blind" id="authRegist" data-v-43813796="" onclick="responseMailAuth()"> 인증 등록 </a>
									<a class="btn full outlinegrey blind" id="authCancel" data-v-43813796="" onclick="requestMailAuth()"> 인증 취소 </a>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
			</div>
			
		</div>
	
	<footer>
	</footer>
	</article>
</body>
</html>