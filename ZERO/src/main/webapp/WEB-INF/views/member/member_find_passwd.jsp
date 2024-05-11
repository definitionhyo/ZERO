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
$(function(){
	
	// 이메일 함수
	const emailCheck = document.getElementById("member_id");
	// 이메일 형식 체크 함수
	emailCheck.addEventListener("keyup",(e)=> {
        validEmail(e.target);
    });
	
	// 빈칸 입력시 인증 발송 금지
	$("#myForm").submit(function(e) {
	      var memberId = $("#member_id").val().trim();
	      var memberPhone = $("#member_phone").val().trim();
	      
	      if (/^\s*$/.test(memberId)) { // 스페이스바로만 이루어진 공백 감지
	          e.preventDefault(); // 등록 방지
	          
	          alert("아이디를 입력해주세요.");
	      } else if (/^\s*$/.test(memberPhone)) { // 스페이스바로만 이루어진 공백 감지
	    	  e.preventDefault(); // 등록 방지
	    	  alert("핸드폰 번호를 입력해주세요.");
	      }
	      
	});
	
	$("#sendMail").on("click", function() { // 메일 발송하기 버튼 클릭
		
		$("#btnRewrite, #btnLogin").removeClass("blind");
		$("#sendMail").addClass("blind");
		$("#member_id, #member_phone").addClass("readonly");
		
		sendAuth();
		
	});
	
});


function sendAuth() { // 인증번호 전송 전송
	
	// 1. 이메일과 휴대폰 번호가 가입된 정보와 일치할 경우  (버튼 클릭 disabled 클래스 삭제로 활성화)
	var memberId = $("#member_id").val();
	var memberPhone = $("#member_phone").val().replaceAll('-','');
	
	console.log(memberId + ', ' + memberPhone);
	// 2. 버튼 클릭 시 폼 데이터 전송
	$.ajax({
        type: 'POST',
        url: 'ajax/sendMailPasswd',
       datatype: "json",
       data: {
    	   "member_id": memberId,
    	   "member_phone": memberPhone
       },
       success: function (result) {
           console.log('ajax - sendMailPasswd:' + result);
           if(result == 'true') {
        	   alert("메일이 발송되었습니다!");
           } else {
        	   alert("메일 발송이 실패했습니다!");
           }
           
//            alert(result);
           
       },
       error: function () {
    	   alert('오류 발생');
       }
   });
	
	
}

// 핸드폰 입력 형태 표시(000-0000-0000)
function handleInput() {
	  const input = document.getElementById('member_phone');
	  autoHyphen2(input);
}

const autoHyphen2 = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}

// 이메일 형식 체크 정규식
function validEmail(obj){
    console.log(obj);
    if(validEmailCheck(obj)==false){ // 이메일 형식에 맞지 않을 때
//	    	alert('올바르지 않은 메일 형식입니다.')
		$("#input_error_email").css({
		    "display": "block",
		});
//	        obj.value='';            // 형식에 맞지 않을 때 공백 처리
        obj.focus();
        return false;
    }else{
    	$("#input_error_email").css({
		    "display": "none",
		});
    }
}

// 이메일 정규식
function validEmailCheck(obj){
//     var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,}$/i;
    return (obj.value.match(pattern)!=null)
   
}

</script>
</head>
<body>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<article>
		<div class="container">
<!-- 			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar "> -->
<%-- 				<jsp:include page="/WEB-INF/views/inc/member_sidebar.jsp"></jsp:include> --%>
<!-- 			</nav> -->
			<div class="contentArea">
				<%-- 메인영역 --%>
				<div class="help">
					<div class="content lg">
						<div class="help_area">
							<div>
								<h2 class="help_title" >비밀번호 찾기</h2>
								<div class="help_notice">
									<p class="notice_txt"> 가입 시 등록하신 이메일와 휴대폰 번호을 입력하시면,<br>
										이메일로 임시 비밀번호를 전송해 드립니다. 
									</p>
								</div>
								<form action="request_authMail_find_passwd" method="post" id="myForm">
									<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
										<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">이메일 주소</h3>
										<div class="input_item" data-v-4e1fd2e6="">
											<input type="email" data-v-4e1fd2e6="" placeholder="예) zero@zero.co.kr" autocomplete="off" class="input_txt" name="member_id" id="member_id">
										</div>
										<p class="input_error" id="input_error_email" data-v-4e1fd2e6="" data-v-2b15bea4="">이메일 주소를 정확히 입력해주세요.</p>
									</div>
									<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
										<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">휴대폰 번호</h3>
										<div class="input_item" data-v-4e1fd2e6="">
											<input type="tel" data-v-4e1fd2e6="" placeholder="가입하신 휴대폰 번호" autocomplete="off" class="input_txt" name="member_phone" id="member_phone" oninput="handleInput()" maxlength="13">
										</div>
										<p class="input_error" id="input_error_phone" data-v-4e1fd2e6="" data-v-2b15bea4="">휴대폰 번호를 정확히 입력해주세요.</p>
									</div>
									<div class="help_btn_box">
	<!-- 									<a disabled="disabled" href="#" class="btn full solid disabled"> 문자 발송하기 </a> -->
										<a class="btn full solid " data-v-43813796="" id="sendMail"> 메일 발송하기 </a>
										<a class="btn full outlinegrey blind" data-v-43813796="" id="btnRewrite" href="member_find_passwd"> 다시 작성하기 </a>
										<a class="btn full solid btnLogin blind" data-v-43813796="" id="btnLogin" href="member_login"> 로그인화면으로 이동 </a>
									</div>
								</form>
							</div>
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