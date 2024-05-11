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

.help_area {
    margin: 0 auto;
    padding: 60px 0 160px;
    width: 400px;
}

.help-social {
    position: absolute;
    width: 24px;
    height: 24px;
    top: 13px;
    left: 15px;
}

.help_title {
    padding-bottom: 41px;
    text-align: center;
    font-size: 32px;
    letter-spacing: -.48px;
    color: #000;
    border-bottom: 2px solid #000;
}

.help_notice {
    padding: 40px 0 30px;
}
.help_notice .notice_txt {
    font-size: 14px;
    letter-spacing: -.21px;
}

.input_txt {
    padding: 8px 0;
    width: 100%;
    font-size: 15px;
    letter-spacing: -.15px;
    line-height: 22px;
    border-bottom: 1px solid #ebebeb;
}

.input_title {
    font-size: 13px;
    letter-spacing: -.07px;
    line-height: 18px;
}

.solid.disabled, .solid:disabled {
    background-color: #ebebeb;
    color: #fff;
    cursor: default;
}

.has_button .input_txt {
    padding-right: 30px;
    height: 38px;
}

.input_txt {
    padding: 8px 0;
    width: 100%;
    font-size: 15px;
    letter-spacing: -.15px;
    line-height: 22px;
    border-bottom: 1px solid #ebebeb;
}

input, textarea {
    padding: 0;
    outline: 0;
    border: 0;
    resize: none;
    border-radius: 0;
    -webkit-appearance: none;
    background-color: transparent;
}

.btn {
    display: inline-flex;
    cursor: pointer;
    align-items: center;
    justify-content: center;
    vertical-align: middle;
    text-align: center;
    color: rgba(34,34,34,.8);
    background-color: #fff;
}

.look_link {
    margin: auto;
    padding: 0 10px;
    display: inline-flex;
    font-size: 13px;
    letter-spacing: -.07px;
}


	
<%-- 인증에러 --%>
.input_error {
    display: none;
}

*, :after, :before {
    box-sizing: border-box;
    -webkit-tap-highlight-color: rgba(0,0,0,0);
}

.full {
    width: 100%;
    font-size: 16px;
    letter-spacing: -.16px;
    font-weight: 700;
    height: 52px;
    border-radius: 12px;
}

 div {
    padding: 0px;
    background: white;
    display: block;
}

p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}



.solid {
    font-weight: 700;
    color: #fff;
    background-color: #222;
}

*, :after, :before {
    box-sizing: border-box;
    -webkit-tap-highlight-color: rgba(0,0,0,0);
}

link {
    display: none;
}

body, button, input, select, table, textarea {
    font-family: Pretendard Variable,Pretendard,-apple-system,BlinkMacSystemFont,system-ui,Segoe UI,Roboto,Ubuntu,Cantarell,Noto Sans,sans-serif,Helvetica Neue,Apple SD Gothic Neo,Noto Sans KR,Malgun Gothic,Apple Color Emoji,Segoe UI Emoji,Segoe UI Symbol;
    color: #222;
    -webkit-font-feature-settings: "frac" 0,"numr" 0;
    font-feature-settings: "frac" 0,"numr" 0;
}

.look_box {
    margin-top: 20px;
    display: flex;
    justify-content: space-evenly;
}

li, ol, ul {
    list-style: none;
}

ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}

h2 {
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}
<%-- 버튼 --%>

.help_btn_box {
    padding-top: 44px;
}

.help_btn_box>.btn {
    margin-bottom: 8px;
}

.outline {
    border: 1px solid #d3d3d3;
}


	
</style>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript">
$(function(){
	
// 	var phone1 = $("#phone");
// 	phoneFrom(phone1);



});

//정규표현식으로 전화번호 판별
function validatePhone() {
    var phoneInput = document.getElementById("phone");
//     var phoneMessage = document.getElementById("input_error_phone");
    var regex = /^(010|011)-[\d]{4}-[\d]{3,4}$/;

    if (!regex.test(phoneInput.value)) {
    	console.log('1'+phoneInput.value);
    	$("#input_error_phone").css({
		    "display": "block",
		});
//     	obj.focus();
//         return false;
        
    } else {
    	console.log('2'+phoneInput.value);
        $("#input_error_phone").css({
		    "display": "none",
		});
    }
}

<%-- 버튼 활성화 함수 호출 --%>
function handleInput() {
	  const input = document.getElementById('phone');
	  autoHyphen2(input);
	  validatePhone()
	  btnChange(input);
}

<%-- 입력 전화번호 형태 표시 --%>
const autoHyphen2 = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}

<%-- 전화번호 11자리 이상일 경우에만 버튼 클릭 --%>
function btnChange(input) {
	  if (input.value.length > 11) {
	    $('#btnFind').removeClass('disabled');
	  } else {
	    $('#btnFind').addClass('disabled');
	  }
}
<%-- 마스킹된 이메일 출력 --%>
function clickBtn() {
	$("#emailDiv, #btnRewrite, #btnLogin").removeClass('blind');
	$("#phone").addClass('readonly');
	$("#btnFind").addClass('blind');
// 	$("#goLoginBtn").removeClass('blind');
	$("#input_error_phone").css({
		    "display": "none",
	});
	
	var testPhone = $('#phone').val().replaceAll('-','');
	console.log(testPhone);
	
	$.ajax({
        type: 'post',
//         url: 'checkUserNaver',
        url: 'ajax/checkUserEmail',
       datatype: "text",
       data: {
    	   phone: testPhone
       },
       success: function (result) {
           console.log('ajax - checkUserEmail:' + result);
           
           if(result != 'false') {
	           var masked_email = result.replace(/^(.{2})(.*)(.{3})(@.*)$/, (_, prefix, middle, suffix, domain) => prefix + '*'.repeat(middle.length) + suffix + '*'.repeat(domain.length));
	
	           console.log(masked_email); // Output: "ad***@nav******"
	           $("#email").text(masked_email);
           } else {
        	   $("#email").text('등록된 이메일이 없습니다!');
           }
           
       },
       error: function () {
    	   $("#email").text('등록된 이메일이 없습니다!');
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
								<h2 class="help_title" data-v-2b15bea4="">이메일 아이디 찾기</h2>
								<div class="help_notice">
									<p class="notice_txt"> 가입 시 등록한 휴대폰 번호를 입력하면<br> 
									이메일 주소의 일부를 알려드립니다. </p>
								</div>
								<div class="input_box">
									<h3 class="input_title">휴대폰 번호</h3>
									<div class="input_item">
										<input type="tel" placeholder="가입하신 휴대폰 번호" autocomplete="off" class="input_txt" id="phone" oninput="handleInput();" maxlength="13">
									</div>
									<p class="input_error" id="input_error_phone" data-v-4e1fd2e6="" data-v-2b15bea4="">휴대폰 번호를 정확히 입력해주세요.</p>
								</div>
								<div class="input_box blind" id="emailDiv">
									<h3 class="input_title">이메일</h3>
									<div class="input_item">
										<p class="input_txt" id="email" ></p>
									</div>
								</div>
								<div class="help_btn_box">
									<a disabled="disabled" class="btn full solid disabled" data-v-43813796="" id="btnFind" onclick="clickBtn()"> 이메일 아이디 찾기 </a>
									<a class="btn full outlinegrey blind" data-v-43813796=""  id="btnRewrite" onclick="location.href='member_find_id'"> 다시 작성하기 </a>
									<a class="btn full solid blind" data-v-43813796=""  id="btnLogin" onclick="location.href='member_login'"> 로그인 화면으로 이동 </a>
								</div>
<!-- 								<div class="help_btn_box blind" id="goLoginBtn"> -->
<!-- 								</div> -->
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