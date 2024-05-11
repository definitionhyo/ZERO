<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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



<script>
function checkLicenseDup() {
    var license = document.getElementById("zman_driver_license").value;
    var resultMsg = "";
    if (license === "121403327111" || license === "111010221312") {
        resultMsg = "유효한 운전면허증 번호입니다. 계속해서 작성해주세요";
    	alert(resultMsg);
        return true;
    } else {
        resultMsg = "유효하지 않은 운전면허증 번호입니다.";
    	alert(resultMsg);
        return false;
    }
}

$(document).ready(function () {
    $('#checkLicense').click(function () {
        let isValidLicense = checkLicenseDup();
        $("#registerButton").prop("disabled", !isValidLicense);
    });
});
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

#member_zipcode1, #member_phone, #phone_dup_result, #zman_driver_license, #zman_account {
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
					<span class="blind" data-v-2b15bea4="">Z-MAN 신청</span>
				</h2><br>
				
				<form action="zman_join_pro" method="post" id="joinForm">
					<%-- 클래스 이름 바꾸기 --%>
					<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">아이디</h3>
						<input type="text" 
							   id="zman_id" 
							   name="zman_id" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   onkeyup="validateName()" 
							   required="required"
							   readonly="readonly"
							   value="${memberInfo.member_id }">
					</div><br>
					
					<div class="input_box has_button" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">이름</h3>
						<input type="text" 
							   id="zman_name" 
							   name="zman_name" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   onkeyup="validateName()" 
							   required="required"
							   readonly="readonly"
							   value="${memberInfo.member_name }">
					</div><br>
					
					<!-- DB에 값 미리저장해놓고 아니면 올바르지않습니다 맞으면 조회되었습니다 -->
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">운전면허증 번호</h3>
						<div class="btn_input_container">
						<input type="text" 
						   	   placeholder="112323" 
						   	   id="zman_driver_license" 
						   	   name="zman_driver_license" 
						   	   autocomplete="off" 
						   	   class="input_txt" 
						   	   data-v-4e1fd2e6=""
						   	   required="required">
					   	   <button type="button" id="checkLicense">운전면허증조회</button>
						</div>
					</div>
					<br>
					
					<!-- ZPAY 계좌 있을때 -->
					<c:if test="${not empty zpayCheck.zpay_idx }">
						<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
							<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">계좌 번호</h3>
							<div class="btn_input_container">
							<input type="text" 
							   	   id="zman_account" 
							   	   name="zman_account" 
							   	   autocomplete="off" 
							   	   class="input_txt" 
							   	   data-v-4e1fd2e6=""
							   	   required="required"
							   	   value="${zpayCheck.zpay_bank_account }"
							   	   readonly="readonly">
<!-- 						   	   <button type="button" id="emailAuthButton">등록하러 가기</button> -->
							</div>
						</div>
						<br>
					</c:if>
					
					<!-- ZPAY 계좌 없을때 -->
					<c:if test="${empty zpayCheck.zpay_idx }">
						<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
							<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">계좌 번호</h3>
							<div class="btn_input_container">
							<input type="text" 
							   	   id="zman_account" 
							   	   name="zman_account" 
							   	   autocomplete="off" 
							   	   class="input_txt" 
							   	   data-v-4e1fd2e6=""
							   	   required="required"
<%-- 							   	   value="${zpayCheck.zpay_bank_account }" --%>
							   	   readonly="readonly">
						   	   <button type="button" id="zpayMain">등록하러 가기</button>
							</div>
						</div>
						<br>
					</c:if>
					
					
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">사용할 수단을 선택해 주세요</h3>
						<label>
				        	<input type="checkbox" name="vehicle[]" value="자동차">
				      		<span>자동차</span>
					    </label>
						<label>
				        	<input type="checkbox" name="vehicle[]" value="오토바이">
				      		<span>오토바이</span>
					    </label>
						<label>
				        	<input type="checkbox" name="vehicle[]" value="도보">
				      		<span>도보</span>
					    </label>
						<label>
				        	<input type="checkbox" name="vehicle[]" value="자전거">
				      		<span>자전거</span>
					    </label>
					</div><br>
					
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">차량번호</h3>
						<input type="text"
							   placeholder="차량이 있는경우 입력해주세요" 
							   id="zman_car_num" 
							   name="zman_car_num" 
							   autocomplete="off" 
							   class="input_txt" 
							   data-v-4e1fd2e6=""
							   onkeyup="validateBirth()">
					</div><br>
				
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">휴대폰번호</h3>
						<div class="btn_input_container">
							<input type="text" 
								   placeholder="- 없이 입력" 
								   id="zman_phone" 
								   name="zman_phone" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required"
								   onkeyup="validatePhone()"
								   readonly="readonly"
								   value="${memberInfo.member_phone }">
						</div>
					</div><br>
				
					
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">주소지 입력</h3>
						<div class="btn_input_container">
							<input type="text" 
								   placeholder="우편번호" 
								   id="zman_zipcode1" 
								   name="zman_zipcode1" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required"
								   value="${memberInfo.member_zipcode1 }">
<!-- 							<button onclick="DaumPostcode()">우편번호 찾기</button> -->
<!-- 								<button onclick="DaumPostcode(event)">우편번호 찾기</button> -->
						</div>
							<input type="text" 
								   placeholder="도로명주소" 
								   id="zman_address" 
								   name="zman_address" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required"
								   value="${memberInfo.member_address1 }">
<!-- 							<input type="text"  -->
<!-- 								   placeholder="참고항목" -->
<!-- 								   id="member_extraAddress"  -->
<!-- 								   name="member_extraAddress"  -->
<!-- 								   autocomplete="off"  -->
<!-- 								   class="input_txt"  -->
<!-- 								   data-v-4e1fd2e6=""> -->
							<input type="text"
								   placeholder="상세주소" 
								   id="zman_address_detail" 
								   name="zman_address_detail" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required"
								   value="${memberInfo.member_address_detail1 }">
					</div>
					<br>
					
					<div class="has_button input_box" data-v-4e1fd2e6="" data-v-2b15bea4="">
						<h3 class="input_title" data-v-4e1fd2e6="" data-v-2b15bea4="">활동지역 선택</h3>
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
							<input type="text"
								   placeholder="상세주소" 
								   id="member_address_detail1" 
								   name="member_address_detail1" 
								   autocomplete="off" 
								   class="input_txt" 
								   data-v-4e1fd2e6=""
								   required="required">
					</div>
					<input type="hidden" id="zman_area" name="zman_area">
					<br>
					
					
					<div>
						<label for="agree_all">
				        	<input type="checkbox" name="agree_all" id="agree_all" value="check">
				      		<span>모두 동의합니다</span>
					    </label><br>
					    <div>
						    <label for="agree1">
						        <input type="checkbox" name="agree1" id="agree1" value="check1" class="sub_agree">
						        <span>교육이수동의여부<strong>(필수)</strong></span>
						    </label>
					        <span><a href="#" class="modal-trigger" data-source="${pageContext.request.contextPath}/resources/terms/zman_join_term1" data-modal-id="agree1Modal">내용보기</a></span>
					    </div>
					    <div>
						    <label for="agree2">
						        <input type="checkbox" name="agree2" id="agree2" value="check2" class="sub_agree">
						        <span>보험가입동의여부<strong>(필수)</strong></span>
						    </label>
						    <span><a href="#" class="modal-trigger" data-source="${pageContext.request.contextPath}/resources/terms/zman_join_term2" data-modal-id="agree2Modal">내용보기</a></span>
					    </div>
					    <div>
						    <label for="agree3">
						        <input type="checkbox" name="agree3" id="agree3" value="check3" class="sub_agree">
						        <span>위치기반동의여부<strong>(필수)</strong></span>
						    </label>
						    <span><a href="#" class="modal-trigger" data-source="${pageContext.request.contextPath}/resources/terms/zman_join_term3" data-modal-id="agree2Modal">내용보기</a></span>
					    </div>
					</div>
					

					
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
        <h5 class="modal-title" id="agree1ModalTitle">교육이수동의여부</h5>
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
       <h5 class="modal-title" id="agree2ModalTitle">보험가입동의여부</h5>
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

 <%-- 세번째 내용보기 --%>
<div class="modal fade" id="agree3Modal" tabindex="-1" role="dialog" aria-labelledby="agree3ModalTitle" aria-hidden="true">
 <div class="modal-dialog" role="document">
   <div class="modal-content">
     <div class="modal-header">
       <h5 class="modal-title" id="agree3ModalTitle">위치기반 수집 동의여부</h5>
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

<!-- 계좌 없을시 zpay_main으로 이동하는 스크립트 -->
<script>
  $(document).ready(function () {
    $("#zpayMain").on("click", function (event) {
      event.preventDefault();
      goToZpayMain();
    });
  });

  function goToZpayMain() {
    window.location.href = "zpay_main";
  }
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
        const agree3 = $("#agree3").prop("checked");

        // 필수 체크박스가 체크되지 않은 경우
        if (!agree1 || !agree2 || !agree3) {
            e.preventDefault();
            alert("필수 체크박스를 체크해주세요.");
        } else {
            // 이벤트, 혜택정보 수신동의 값을 가져와 숨겨진 입력 필드에 설정합니다.
            // $('#member_agreement_marketing').val(getMarketingAgreementValue());

            // 폼을 전송합니다.
            this.submit();
        }
    });
});
</script>

<!-- 이동수단 선택 안되있을경우 알림창 -->
<script>
  document.getElementById('joinForm').addEventListener('submit', function (event) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"][name="vehicle[]"]');
    let checked = false;
  
    for (const checkbox of checkboxes) {
      if (checkbox.checked) {
        checked = true;
        break;
      }
    }
  
    if (!checked) {
      event.preventDefault();
      alert('최소 하나의 수단을 선택해 주세요.');
    }
  });
</script>
 
 <!-- 활동할 지역 합치는 스크립트 -->
 <script type="text/javascript">
 $(document).ready(function () {
	    $('#joinForm').on('submit', function () {
	      const address1 = $('#member_address1').val().trim();
	      const addressDetail1 = $('#member_address_detail1').val().trim();
	      const zman_area = address1 + ' ' + addressDetail1;
	      $('#zman_area').val(zman_area);
	    });
	  });
 </script>
 
</body>