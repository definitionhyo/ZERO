<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" -->
<!-- 	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" -->
<!-- 	crossorigin="anonymous"></script> -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js"
	integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
	crossorigin="anonymous"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/default.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/sidebar.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/button.css"
	rel="stylesheet" type="text/css">
	
<%-- vue.js 링크 --%>
<!-- <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script> -->
<!-- <style type="text/css"> /*# sourceMappingURL=contenteditable.vue.map */</style> -->


<%-- 우편번호찾기 Daum api --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function DaumPostcode() {
		event.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
//                     document.getElementById("member_extraAddress").value = extraAddr;
                    addr = addr + " " + extraAddr;
                
                } else {
//                     document.getElementById("member_extraAddress").value = '';
					addr = addr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('member_zipcode1').value = data.zonecode;
                document.getElementById("member_address1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("member_address_detail1").focus();
            }
        }).open();
    }
</script>

<%-- 이용약관 내용보기 스크립트  --%>
<script type="text/javascript">
$(function () {
    // 모든 modal-trigger에 클릭 이벤트를 바인딩
    $(".modal-trigger").on("click", function () {
        // data-* 속성에서 데이터를 가져온다.
		var source = $(this).data("source");
		var modalId = $(this).data("modal-id");
        var $targetModal = $("#" + modalId);

        // 내용을 불러온 후 모달을 표시한다.
        $.get(source, function (data) {
        	$targetModal.find(".modal-body").html(data);
        	$targetModal.modal("show");
		});
        return false;
    });
});
</script>

<script type="text/javascript">
// 이름 정규식
function validateName() {
	var nameInput = document.getElementById("member_name");
	var nameMessage = document.getElementById("pass_name");
	var regex = /^[A-Za-z가-힣]{2,15}$/;
	
	if(nameInput.value.trim() === ""){
		nameMessage.innerHTML = "";
		return;
	}
	
	if (!regex.test(nameInput.value)) {
		nameMessage.innerHTML = "이름을 한글 또는 영어로 입력해주세요";
	    nameMessage.style.color = "red";
	} else {
	    nameMessage.innerHTML = "올바른 형식입니다.";
	    nameMessage.style.color = "green";
	  }
}
</script>

<script type="text/javascript">
//닉네임 중복 검사 및 정규식 검사
function checkNicknameDup() {
	var nickname = $('#member_nickname').val();
	var nickResult = document.getElementById("pass_nick");
	var regex = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;

	if(nickname.trim() === ""){
		nickResult.innerHTML = "";
   	 	return;
    }

	if (!regex.test(nickname)) {
	    nickResult.innerHTML = "2자 이상 16자 이하, 영어 또는 숫자 또는 한글 입력해주세요";
	    nickResult.style.color = "red";
	    return;
	}

	$.ajax({
		url: './nickCheck',
   		type: 'post',
    	data: { nickname: nickname },
    	success: function (cnt) {
        if (cnt == 0) {
	        nickResult.innerHTML = "사용 가능한 닉네임 입니다.";
	        nickResult.style.color = "green";
      	} else {
	        nickResult.innerHTML = "이미 사용 중인 닉네임입니다.";
	        nickResult.style.color = "red";
	      }
   		},
    	error: function (error) {
        	alert("error : " + JSON.stringify(error));
    	}
	});
}
</script>


<script type="text/javascript">
// 생년월일 정규식
function validateBirth() {
	var birthInput = document.getElementById("member_birth");
	var birthMessage = document.getElementById("birth_check");
	var regex = /^(19[0-9][0-9]|200[0-8])(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/; <%-- 만15세이상 가입가능 2008년  --%>

	if(birthInput.value.trim() === ""){
		birthMessage.innerHTML = "";
		return;
	}
	if (!regex.test(birthInput.value)) {
		birthMessage.innerHTML = "생년월일 8자리를 입력해주세요";
		birthMessage.style.color = "red";
	} else {
		birthMessage.innerHTML = "올바른 형식입니다.";
		birthMessage.style.color = "green";
	   }
}
</script>

<script type="text/javascript">
// 정규표현식으로 전화번호 판별
function validatePhone() {
    var phoneInput = document.getElementById("member_phone");
    var phoneMessage = document.getElementById("phone_dup_result");
    var regex = /^(010|011)[\d]{3,4}[\d]{4}$/;

    if (phoneInput.value.trim() === "") {
        phoneMessage.innerHTML = "";
        return;
    }

    if (!regex.test(phoneInput.value)) {
        phoneMessage.innerHTML = "올바른 전화번호를 입력해주세요.";
        phoneMessage.style.color = "red";
        return false;
    } else {
        phoneMessage.innerHTML = "올바른 형식입니다.";
        phoneMessage.style.color = "green";
        return true;
    }
}

</script>


<title>ZERO 회원가입</title>
<style>

.login_area[data-v-2b15bea4] {
    margin: 0 auto;
    padding: 60px 0 160px;
    width: 400px;
}

.logo-social[data-v-2b15bea4] {
    position: absolute;
    width: 24px;
    height: 24px;
    top: 13px;
    left: 15px;
}
.input_title[data-v-4e1fd2e6] {
    font-size: 13px;
    letter-spacing: -.07px;
    line-height: 18px;
}

.solid.disabled[data-v-43813796], .solid[data-v-43813796]:disabled {
    background-color: #ebebeb;
    color: #fff;
    cursor: default;
}

.has_button .input_txt[data-v-4e1fd2e6] {
    padding-right: 30px;
    height: 38px;
}

.input_txt[data-v-4e1fd2e6] {
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

.btn[data-v-43813796] {
    display: inline-flex;
    cursor: pointer;
    align-items: center;
    justify-content: center;
    vertical-align: middle;
    text-align: center;
    color: rgba(34,34,34,.8);
    background-color: #fff;
}

.look_link[data-v-2b15bea4] {
    margin: auto;
    padding: 0 10px;
    display: inline-flex;
    font-size: 13px;
    letter-spacing: -.07px;
}


	
<%-- 인증에러 --%>
.input_error[data-v-4e1fd2e6] {
    display: none;
}

*, :after, :before {
    box-sizing: border-box;
    -webkit-tap-highlight-color: rgba(0,0,0,0);
}

.full[data-v-43813796] {
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



.solid[data-v-43813796] {
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

.look_box[data-v-2b15bea4] {
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
<%-- 로그인 버튼 --%>
.login_btn_box[data-v-2b15bea4] {
    padding-top: 20px;
}

.social_login>.btn[data-v-2b15bea4] {
    margin-bottom: 8px;
}

<%-- 체크박스 안나와서 강제로 추가함 모양 바꿀수있으면 바꾸기? --%>
input[type=checkbox] {
  width: 20px;
  height: 20px;
  background-color: #fff;
  border: 1px solid #ccc;
  appearance: checkbox;
  -webkit-appearance: checkbox;
  -moz-appearance: checkbox;
}

<%-- 입력창 옆에 버튼 생기게--%>
.btn_input_container {
   display: flex;
   align-items: center;
}

.btn_input_container button {
    margin-left: 8px;
    flex: 1; /* 추가 됨: 검색 버튼 너비 늘리기 */
}

#member_zipcode1, #member_phone, #phone_dup_result, #member_id {
    width: 60%; /* 주소지 검색 입력란 너비 조절 */
}
</style>



</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
<%--  <header id="pageHeader"><%@ include file="assets/inc/header_zero.jsp"%></header> --%>
 
  <%--본문내용 --%>
  <article id="mainArticle">
	<div class="container login" data-v-2b15bea4="" data-v-1d0b532e="">
		<div class="content lg" data-v-2b15bea4="">
			<div class="login_area" data-v-2b15bea4="">
				<h2 class="login_title" data-v-2b15bea4="">
					<span class="blind" data-v-2b15bea4="">회원가입</span>
				</h2><br>
				
				<form action="join_pro" method="post" id="joinForm">
					<%-- 클래스 이름 바꾸기 --%>
					<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">이름</h3>
						<input type="text" 
							   placeholder="이름" 
							   id="member_name" 
							   name="member_name" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   onkeyup="validateName()" 
							   required="required"
							   value="${param.member_name }">
					</div>
					<div class="row mb-3">
		    			<label for="inputNameRegex_Result" class="col-sm-5 "></label>
				    	<div class="col-sm-12">
							<span id="pass_name"></span>
				   		</div>
					</div><br>
					
					<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">닉네임</h3>
						<input type="text" 
							   placeholder="닉네임" 
							   id="member_nickname" 
							   name="member_nickname" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   onkeyup="checkNicknameDup()" 
							   required="required">
					</div>
					<div class="row mb-3">
		    			<label for="inputNickRegex_Result" class="col-sm-5 "></label>
				    	<div class="col-sm-12">
							<span id="pass_nick"></span>
				   		</div>
					</div><br>
					
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">이메일 주소(아이디로 사용됩니다)</h3>
						<div class="btn_input_container">
						<input type="email" 
						   	   placeholder="예)zero@zero.com" 
						   	   id="member_id" 
						   	   name="member_id" 
						   	   autocomplete="off" 
						   	   class="input_txt" 
						   	   data-v-4e1fd2e6=""
						   	   required="required"
						   	   value="${param.member_id }">
					   	   <button type="button" id="emailAuthButton">인증번호 받기</button>
						</div>
					<!-- 이메일 중복 확인 일치 여부-->
					<div class="row mb-3">
				    	<label for="emailDup_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="email_dup_result"></span>
					   		</div>
					</div>
					</div>
					<br>
					
								
					<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">인증코드 확인</h3>
						<input type="text" 
							   placeholder="메일에 작성된 인증코드를 작성해주세요" 
							   id="member_id2" 
							   name="member_id2" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   maxlength="6"
							   required="required">
					</div>
					<!-- 이메일 인증코드 확인 일치 여부-->
					<div class="row mb-3">
				    	<label for="emailconfirmCode_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="email_confirm"></span>
					   		</div>
					</div>
					<br>
					
					
					
					<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">비밀번호</h3>
						<input type="password" 
							   placeholder="영문, 숫자, 특수문자(!@#$%)를 조합해서 입력해주세요. (8-16자)" 
							   id="member_passwd" 
							   name="member_passwd" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   required="required"
							   onkeyup="checkPass(this.value)">
					<div class="check_font" id="pw_check"></div>
					</div>
					
					<%-- 비밀번호 정규식 : regex --%>
					<div class="row mb-3">
		    			<label for="inputPasswordRegex_Result" class="col-sm-5 "></label>
				    	<div class="col-sm-12">
							<span id="pass_check"></span>
				   		</div>
					</div>	
					
								
					<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">비밀번호 확인</h3>
						<input type="password" 
							   placeholder="입력해주세요" 
							   id="member_passwd2" 
							   name="member_passwd2" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   onkeyup="checkconfirmPasswd(this.value)"
							   required="required">
					</div>
						<!-- 비밀번호 와 비밀번호 확인 일치 여부-->
					<div class="row mb-3">
				    	<label for="inputPasswordDupCheck_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span id="pass_confirm"></span>
<!-- 								<font id="pass_confirm" size="2"></font> -->
					   		</div>
					</div>
					<br>
					
					
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">생년월일</h3>
						<input type="text"
							   placeholder="생년월일 8자리를 입력해 주세요" 
							   id="member_birth" 
							   name="member_birth" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   required="required"
							   onkeyup="validateBirth()">
					</div>
					<%-- 생년월일 정규식 : regex --%>
					<div class="row mb-3">
		    			<label for="inputBirthRegex_Result" class="col-sm-5 "></label>
				    	<div class="col-sm-12">
							<span id="birth_check"></span>
				   		</div>
					</div><br>
				
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">휴대폰번호</h3>
						<div class="btn_input_container">
							<input type="text" 
								   placeholder="- 없이 입력" 
								   id="member_phone" 
								   name="member_phone" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required"
								   onkeyup="validatePhone()">
							<button type="button" id="phone_chk">인증번호 받기</button>
						</div>
					</div>
					<%-- 휴대폰번호 정규식 : regex --%>
					<div class="row mb-3">
		    			<label for="inputPhoneRegex_Result" class="col-sm-5 "></label>
				    	<div class="col-sm-12">
							<span id="phone_dup_result"></span>
				   		</div>
					</div><br>
				
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4=""></h3>
						<div class="btn_input_container">
							<input type="text" 
								   placeholder="인증번호를 입력해 주세요" 
								   id="member_phone2" 
								   name="member_phone2"
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   maxlength="4"
								   required="required">
						</div>
					</div>
					<!-- 핸드폰 인증코드 확인 일치 여부-->
					<div class="row mb-3">
				    	<label for="phoneChk_Result" class="col-sm-5 "></label>
					    	<div class="col-sm-12">
								<span class="phone_chk" id="phone_chk"></span>
					   		</div>
					</div>
					<br>
					
					
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">주소지 입력</h3>
						<div class="btn_input_container">
							<input type="text" 
								   placeholder="우편번호" 
								   id="member_zipcode1" 
								   name="member_zipcode1" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required">
<!-- 							<button onclick="DaumPostcode()">우편번호 찾기</button> -->
								<button onclick="DaumPostcode(event)">우편번호 찾기</button>
						</div>
							<input type="text" 
								   placeholder="도로명주소" 
								   id="member_address1" 
								   name="member_address1" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required">
<!-- 							<input type="text"  -->
<!-- 								   placeholder="참고항목" -->
<!-- 								   id="member_extraAddress"  -->
<!-- 								   name="member_extraAddress"  -->
<!-- 								   autocomplete="off"  -->
<!-- 								   class="input_txt"  -->
<!-- 								   data-v-4e1fd2e6=""> -->
							<input type="text"
								   placeholder="상세주소" 
								   id="member_address_detail1" 
								   name="member_address_detail1" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required">
					</div>
					<br>
					
					<div>
						<label for="agree_all">
				        	<input type="checkbox" name="agree_all" id="agree_all" value="check">
				      		<span>모두 동의합니다</span>
					    </label><br>
					    <div>
						    <label for="agree1">
						        <input type="checkbox" name="agree1" id="agree1" value="check1" class="sub_agree">
						        <span>이용약관 동의<strong>(필수)</strong></span>
						    </label>
					        <span><a href="#" class="modal-trigger" data-source="${pageContext.request.contextPath}/resources/terms/term" data-modal-id="agree1Modal">내용보기</a></span>
					    </div>
					    <div>
						    <label for="agree2">
						        <input type="checkbox" name="agree2" id="agree2" value="check2" class="sub_agree">
						        <span>개인정보 수집 및 이용 동의<strong>(필수)</strong></span>
						    </label>
						    <span><a href="#" class="modal-trigger" data-source="${pageContext.request.contextPath}/resources/terms/term2" data-modal-id="agree2Modal">내용보기</a></span>
					    </div>
<!-- 					    <label for="agree3"> -->
<!-- 					        <input type="checkbox" name="agree" value="3" class="sub_agree"> -->
<!-- 					        <span>개인정보 이용 동의<strong>(필수)</strong></span> -->
<!-- 					    </label> -->
						<div>
						    <label for="agree3">
						        <input type="checkbox" name="agree" value="3" class="sub_agree">
						        <span>이벤트, 혜택정보 수신동의<strong class="select_disable">(선택)</strong></span>
						    </label>
					    </div>
					</div>
					
					<!-- 이벤트, 혜택정보 수신동의 여부 -->
					<input type="hidden" name="member_agreement_marketing" id="member_agreement_marketing" value="">

					
					<div data-v-2b15bea4="" class="login_btn_box">
<!-- 						<button type="submit" data-v-43813796="" data-v-2b15bea4="" class="btn full solid"> 회원가입 </button> -->
						<button type="submit" data-v-43813796="" data-v-2b15bea4="" class="btn full solid" id="registerButton" disabled="disabled"> 회원가입 </button>
					</div>
				</form>

			</div>
		</div>
	</div>

  </article>
  
<!-- 첫번째 내용보기 -->
<div class="modal fade" id="agree1Modal" tabindex="-1" role="dialog" aria-labelledby="agree1ModalTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="agree1ModalTitle">이용약관 동의</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
<!--         <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>

 <%-- 두번째 내용보기 --%>
<div class="modal fade" id="agree2Modal" tabindex="-1" role="dialog" aria-labelledby="agree2ModalTitle" aria-hidden="true">
 <div class="modal-dialog" role="document">
   <div class="modal-content">
     <div class="modal-header">
       <h5 class="modal-title" id="agree2ModalTitle">개인정보 수집 및 이용 동의</h5>
       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
         <span aria-hidden="true">&times;</span>
       </button>
     </div>
     <div class="modal-body">
     
     </div>
     <div class="modal-footer">
       <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
     </div>
   </div>
 </div>
</div>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  
  <div id="sieAds"></div>
  <%--페이지 하단 --%>
<%--   <footer id="pageFooter"><%@ include file="assets/inc/footer.jsp"%></footer> --%>
  
  
  <%-- 스크립트 코드 --%>
<!--   <script src="/_nuxt/0fc2b9a.js" defer=""></script> -->
<!--   <script src="/_nuxt/c2849e3.js" defer=""></script> -->
<!--   <script src="/_nuxt/6d1f03a.js" defer=""></script> -->
<!--   <script src="/_nuxt/5402e5b.js" defer=""></script> -->
<!--   <script src="/_nuxt/31641e8.js" defer=""></script> -->
<!--   <link href="/_nuxt/css/6ca5ffb.css" rel="stylesheet" type="text/css"> -->
<!--   <link href="/_nuxt/css/caea5a4.css" rel="stylesheet" type="text/css"> -->

	<script type="text/javascript">
	 
	// 비밀번호 정규식 되는데 편의를 위해 주석해놓음
	  
	// 비밀번호 정규식
	function checkPass(member_passwd, member_passwd2) {
		let regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%])(?=.*[0-9]).{8,16}$/;
		
		if(regex.exec(member_passwd)) {
			document.querySelector("#pass_check").innerHTML = "사용 가능한 비밀번호입니다!"
			document.querySelector("#pass_check").style.color = "green";
		} else {
			document.querySelector("#pass_check").innerHTML = "사용 불가능한 비밀번호입니다!"
			document.querySelector("#pass_check").style.color = "red";
// 			alert("비밀번호를 다시 입력해주세요!");
			$("#member_pass").val('');
			$("#member_pass2").val('');
		}
	}

	// 비밀번호 와 비밀번호 확인 일치
	function checkconfirmPasswd(passwdCheck) {
		let member_passwd = document.querySelector('#member_passwd').value;	
		 
		if(member_passwd == passwdCheck) {
			document.querySelector("#pass_confirm").innerHTML = "비밀번호가 일치합니다!"
			document.querySelector("#pass_confirm").style.color = "green";
		} else {
			document.querySelector("#pass_confirm").innerHTML = "비밀번호가 일치하지 않습니다!"
			document.querySelector("#pass_confirm").style.color = "red";
// 			alert("비밀번호를 다시 입력해주세요!");
			$("#member_pass").val('');
			$("#member_pass2").val('');
		}
	}
	  
	  
	  
	</script>
  <script type="text/javascript">
//이메일 인증번호 발송 및 아이디 중복 확인
  function sendEmailAndCheckId() {
      var id = $('#member_id').val();
      var emailResult = document.getElementById("email_dup_result");

      $.ajax({
          url: './idCheck',
          type: 'post',
          data: { id: id },
          success: function (cnt) {
              if (cnt == 0) {
                  emailResult.innerHTML = "가입이 가능한 이메일입니다.";
                  emailResult.style.color = "green";
                  alert("가입이 가능한 아이디입니다. 인증코드를 입력해주세요");
                  
                  const email = $("#member_id").val();

                  // AJAX 요청 시작
                  $.ajax({
                      type: "POST",
                      url: "sendAuthCode",
                      data: { email: email },
                      success: function (data) {
                          if (data.success) {
                              alert("인증번호가 이메일로 발송되었습니다.");
                          } else {
                              alert("인증번호 발송에 실패했습니다. 다시 시도해주세요.");
                          }
                      },
                      error: function () {
//                           alert("오류가 발생했습니다. 다시 시도해주세요.");
                      }
                  });

              } else {
                  emailResult.innerHTML = "이미 등록된 이메일입니다.";
                  emailResult.style.color = "red";
                  alert("이미 가입된 아이디입니다. 아이디를 다시 입력해주세요!");
                  $('#member_id').val('');
                  $('#member_id').focus();
              }
          },
          error: function (error) {
              alert("error : " + JSON.stringify(error));
          }
      });
  }

  // 이메일 인증번호 발송 버튼
  $(document).ready(function () {
      $("#emailAuthButton").on("click", function (event) {
          event.preventDefault();
          sendEmailAndCheckId();
      });
  });
</script>
<script type="text/javascript">
	$("#member_id2").on("input", function () {
	    // 입력값 받아오기
	    const inputAuthCode = $(this).val();
	
	    // 인증코드가 입력된 경우에만 AJAX 요청 시작
	    if (inputAuthCode.length === 6) {
	        $.ajax({
	            type: "POST",
	            url: "checkAuthCode",
	            data: { inputAuthCode: inputAuthCode },
	            success: function (response) {
	                if (response.success) {
	                    $("#email_confirm").html(response.message);
	                    $("#email_confirm").css("color", "green");
	                    $("#member_id").attr("readonly", true); // 추가된 부분
	                    $("#member_id2").attr("readonly", true); // 추가된 부분
	                    emailAuthSuccess = true;
	                } else {
	                    $("#email_confirm").html(response.message);
	                    $("#email_confirm").css("color", "red");
	                    emailAuthSuccess = false;
	                }
	                checkAuthSuccess(); // 활성화 확인 함수 호출
	            },
	            error: function () {
// 	                alert("오류가 발생했습니다. 다시 시도해주세요.");
	            }
	        });
	    }
	});

</script>
 
<script type="text/javascript">

// 휴대폰 인증 번호 요청 및 중복 검사
function checkPhoneDupAndSend(callback) {
  var phone = $('#member_phone').val();
  var phoneResult = document.getElementById("phone_dup_result");
  $.ajax({
    url: './phoneCheck',
    type: 'post',
    data: { phone: phone },
    success: function (cnt) {
      if (cnt == 0) {
    	phoneResult.innerHTML = "가입이 가능한 번호입니다.";
        phoneResult.style.color = "green";
        callback();
      } else {
    	phoneResult.innerHTML = "이미 등록된 번호 입니다.";
        phoneResult.style.color = "red";
        alert("이미 가입된 휴대폰 번호입니다. 다른 번호를 입력해주세요!");
        $('#member_phone').val('');
        $('#member_phone').focus();
      }
    },
    error: function (error) {
      alert("error : " + JSON.stringify(error));
    }
  });
}

// 기존 휴대폰 번호 인증 코드
var code2 = "";
$("#phone_chk").click(function () {
  var phone = $("#member_phone").val();
  if (!validatePhone()) {
    alert("올바르게 입력해주세요.");
  } else {
	  checkPhoneDupAndSend(function () {
      alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오.");
      // 기존 인증번호 발송 코드는 여기에 배치
      var phone = $("#member_phone").val();
      $.ajax({
        type: "GET",
        url: "phoneCheck?phone=" + phone,
        cache: false,
        success: function (data) {
          if (data == "error") {
            alert("휴대폰 번호가 올바르지 않습니다.");
            $("#member_phone").attr("autofocus", true);
          } else {
            $("#member_phone2").attr("disabled", false);
            $("#member_phone").attr("readonly", true);
            code2 = data;
          }
        }
      });
      // 기존 인증번호 발송 코드 종료
    });
  }
});
</script>

<script type="text/javascript">
	//휴대폰 인증번호 대조
	$("#member_phone2").on("input", function() {
	    const inputValue = $("#member_phone2").val();

	    if (inputValue.length === 0) {
	        $(".phone_chk").text("");
	        phoneAuthSuccess = false;
	    } else if (inputValue == code2) {
	        $(".phone_chk").text("인증번호가 일치합니다.");
	        $(".phone_chk").css("color", "green");
	        $("#phoneDoubleChk").val("true");
	        $("#member_phone2").attr("readonly", true);
	        phoneAuthSuccess = true;
	    } else {
	        $(".phone_chk").text("인증번호가 일치하지 않습니다. 확인해주시기 바랍니다.");
	        $(".phone_chk").css("color", "red");
	        $("#phoneDoubleChk").val("false");
	        $("#member_phone2").attr("autofocus", true);
	        phoneAuthSuccess = false;
	    }
	    checkAuthSuccess(); // 활성화 확인 함수 호출
	});
</script>

<script type="text/javascript">
  // 동의 버튼
  document.getElementById("agree_all").addEventListener("change", function () {
    const allChecked = this.checked;
    const subAgrees = document.getElementsByClassName("sub_agree");
    for (let i = 0; i < subAgrees.length; i++) {
      subAgrees[i].checked = allChecked;
    }
  });

  const subAgrees = document.getElementsByClassName("sub_agree");
  for (let i = 0; i < subAgrees.length; i++) {
    subAgrees[i].addEventListener("change", function () {
      let allChecked = true;
      for (let j = 0; j < subAgrees.length; j++) {
        if (!subAgrees[j].checked) {
          allChecked = false;
          break;
        }
      }
      document.getElementById("agree_all").checked = allChecked;
    });

    subAgrees[i].parentElement.addEventListener("click", function (e) {
      if (e.target.tagName !== "INPUT") {
        subAgrees[i].checked = !subAgrees[i].checked;
        let allChecked = true;
        for (let j = 0; j < subAgrees.length; j++) {
          if (!subAgrees[j].checked) {
            allChecked = false;
            break;
          }
        }
        document.getElementById("agree_all").checked = allChecked;
      }
    });
  }
</script>
 
<script type="text/javascript">
// 마케팅 동의 체크 여부에 따라 입력할 값
function getMarketingAgreementValue() {
    var agreementCheckbox = document.querySelector('input[name="agree"]:checked');
    return agreementCheckbox ? 1 : 0;
  }

  $(document).ready(function () {
    // 회원가입 폼 제출 시 유효성 검사
    $("#joinForm").on("submit", function (e) {
      const agree1 = $("#agree1").prop("checked");
      const agree2 = $("#agree2").prop("checked");

      // 필수 체크박스가 체크되지 않은 경우
      if (!agree1 || !agree2) {
        e.preventDefault();
        alert("필수 체크박스를 체크해주세요.");
      } else {
        // 이벤트, 혜택정보 수신동의 값을 가져와 숨겨진 입력 필드에 설정합니다.
        $('#member_agreement_marketing').val(getMarketingAgreementValue());

        // 폼을 전송합니다.
        this.submit();
      }
    });
  });
</script>

<script type="text/javascript">
//   인증 성공 여부를 저장할 변수 추가   
  let phoneAuthSuccess = false;  
  let emailAuthSuccess = false;  

//  회원가입 버튼 활성화 확인 함수 추가   
   function checkAuthSuccess() {   
       // 핸드폰 및 이메일 인증이 모두 성공한 경우 회원가입 버튼 활성화 
       if (phoneAuthSuccess && emailAuthSuccess) { 
           $("#registerButton").prop("disabled", false);   
       } else {  
           $("#registerButton").prop("disabled", true);   
       }   
   }  
</script>   
  <!-- 편의를위해 위에 주석해놓음, 테스트시 위 주석풀고, 회원가입 disabled 추가해야됨 -->
 
</body>