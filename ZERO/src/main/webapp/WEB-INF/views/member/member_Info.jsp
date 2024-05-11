<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
	integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
	crossorigin="anonymous"></script>
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
	href="${pageContext.request.contextPath }/resources/css/member.css"
	rel="stylesheet" type="text/css">
	
<%-- vue.js 링크 --%>
<!-- <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script> -->
<!-- <style type="text/css"> /*# sourceMappingURL=contenteditable.vue.map */</style> -->



<title>중고거래 사이트</title>
<style>

.radio_input[data-v-42808438]{
    float: right;
    margin-top: 2px;
    margin-right: 4px;
    margin-left: 4px;
}

</style>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript">
	//휴대폰 번호 입력형태 추가
	$(function(){
		var phone1 = '${member.member_phone}';
		phoneFrom(phone1);

	});
	
	<%-- 휴대폰 형태(010- 1***- *234) 출력 --%>
	function phoneFrom(data) {
	  	
	  	if(data.length == 11) {
	  		var formatted_phone = data.substring(0, 3)
	  			+'-' + data.substring(3, 4) + '***'
	  			+'-*' + data.substring(8, 11)
	        console.log('1번' + formatted_phone);
	        $(".phone").text(formatted_phone);
	  	} else {
	  		formatted_phone = data.substring(0, 3)
	  			+'-' + data.substring(3, 4) + '**'
	  			+'-*' + data.substring(7, 10)
	        console.log('2번' + formatted_phone);
	        $(".phone").text(formatted_phone);
	  	}
	}
	
	<%-- 광고 정보 수신 정보 변경 --%>
	function chgAgree(check) {
		// id, name 값 출력
		console.log("name:", check.name);
		console.log("id:", check.id);
		var checkId = check.id;
		  
		var column = "member_agreement_marketing";
		var value = "";
		  
// 		if(check.name == 'email_radio') {
// 			column = 'member_agreement_marketing_email';
// 		} else {
// 			column = 'member_agreement_marketing_sms';
// 		}
	
		if(check.id == 'agree1') {
			value = 1;
		} else {
			value = 0;
		}
		
		$.ajax({
	         type: 'post',
//	          url: 'checkUserNaver',
	         url: 'ajax/chgMarketing',
            datatype: "JSON",
            data: {
            	column: column,
            	value: value
            },
            success: function (result) {
//                 console.log('ajax - chgMarketing:' + result.stringify());
				modal('modal1');
            },
            error: function () {
                alert("오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
	}
	
	<%-- 휴대폰 번호 유효성 검사 --%>
	function isHpFormat(hp){
		if(hp == ""){
			return true;
		}
		var phoneRule = /^(01[016789]{1})[0-9]{3,4}[0-9]{4}$/;
		
		return phoneRule.test(hp);
	}
	
	<%-- 모달 --%>
	function modal(pop) {
		console.log(pop);
// 		console.log($('#modal3').classname('blind'));
		
		$("#modal2").addClass("blind");
		$("#modal3").addClass("blind");
		$('#' + pop).toggleClass('blind');
		$("#passwd1, #passwd2, #phone1").val('');
	}
	
	function closeModal(pop) {
		$('#' + pop).addClass("blind");
	}
	
	function oninputPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
	}
	
	const autoHyphen2 = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '')
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
	
	<%-- 개인정보 변경 --%>
	function saveInfo(pop) {
		console.log(pop);
		var column = "";
		var value = "";
		
		if(pop == 'phone1') { // 변경할 정보가 핸드폰인 경우
			column = 'member_phone';
			value = $('#phone1').val().replaceAll('-','');
			
			if(value == '') { // 입력 안한경우
				alert('휴대폰번호를 입력하세요');
				return;
			}
			
		} else if(pop == 'passwd2') { // 변경할 정보가 비밀번호인 경우
			column = 'member_passwd2';
			value = $('#passwd2').val();
			
			var column2 = 'origin_passwd'; 
			var value2 = $('#passwd1').val(); // 이전 비밀번호
			
			if(value == '' || value2 == '') { // 입력 안한경우
				alert('비밀번호를 입력하세요');
				return;
			}
			
		} else if(pop == 'agree1') { // 변경할 정보가 마케팅 수신 동의인 경우
			column = 'member_agreement_marketing';
			value = 1;
		} else if(pop == 'disagree1') { // 변경할 정보가 마케팅 수신 동의인 경우
			column = 'member_agreement_marketing';
			value = 0;
		}
		
		console.log('2:' + column);
		console.log('2:' + value);
		
		$.ajax({
	       type: 'post',
	       url: 'ajax/chgInfo',
           datatype: "text",
           data: {
           	column: column,
           	value: value,
           	column2: column2,
           	value2: value2
           },
           success: function (result) {
               console.log('ajax - chgInfo:' + result);
               closeModal('modal2');
               closeModal('modal3');
				
				
			   
				if(result == 'member_phone') { // 휴대폰 변경시 표시
				   phoneFrom(value);
			   } else if (result == 'false') { // 비밀번호 불일치
				   alert('비밀번호가 일치하지 않습니다');
			   		return;
			   } 
				
				modal('modal1');
				

           },
           error: function () {
               alert("오류가 발생했습니다. 다시 시도해주세요.");
           }
		});
		
		
	}
	
// 	function checkPass(pass, value) { // 이전 비밀번호 일치 확인
// 		var isReturn = false;
		
// 		$.ajax({
// 		       type: 'post',
// 		       url: 'ajax/checkPasswd',
// 	           datatype: "text",
// 	           data: {
// 	           	member_passwd: pass,
// 	           	value: value,
// 	           },
// 	           success: function (result) {
// 	               console.log('ajax - checkPasswd:' + result);
// 	               if(result == 'true') {
// 	            	   isReturn = true;
// 	               }
// 	           },
// 	           error: function () {
// 	               alert("오류가 발생했습니다. 다시 시도해주세요.");
// 	           }
// 		});
		
// 		return isReturn;
// 	}
// 	function openModal(data) {

// 		$('div[name="' + data + '"]').removeAttr('hidden');
		
// 	}

// 	function closeModal(data) {
		
		
// 		console.log('클릭한 링크의 파라미터 값:', data);
// 		console.log('hidden 값 상태:', $('div[name="' + data + '"]').attr('hidden'));

// 		$('div[name="' + data + '"]').attr('hidden','');
		
// 	}
	
</script>

</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
<%--  <header id="pageHeader"><%@ include file="assets/inc/header_zero.jsp"%></header> --%>
 
  <%--본문내용 --%>
  <article id="mainArticle">
  
  <div class="container" data-v-78dabb2d="">
		<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
			<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
		</nav>
  
  			<div class="contentArea">
			<%-- 메인영역 --%>
			

				<div  class=" my lg">
  
  
					<div class="content_area" data-v-78dabb2d="" >
						<div data-v-cf6a6ef4="" class="my_profile">
							<div data-v-88eb18f6="" data-v-cf6a6ef4="" class="content_title">
								<div data-v-88eb18f6="" class="title">
									<h3 data-v-88eb18f6="">로그인 정보</h3>
								</div>
							</div>
							<div data-v-cf6a6ef4="" class="profile_info">
								<div data-v-8b96a82e="" data-v-cf6a6ef4="" class="profile_group">
									<h4 data-v-8b96a82e="" class="group_title">내 계정</h4>
									<div data-v-0c9f3f9e="" data-v-cf6a6ef4="" class="unit" data-v-8b96a82e="">
										<h5 data-v-0c9f3f9e="" class="title">이메일 주소</h5>
										<div data-v-0c9f3f9e="" class="unit_content">
											<p data-v-24a03828="" data-v-cf6a6ef4="" class="desc email" data-v-0c9f3f9e="">${member.member_id }</p>
		<!-- 									<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn btn_modify outlinegrey small" data-v-0c9f3f9e=""> 변경 </button> -->
										</div>
									</div>
									<%-- 모달 위치 --%>
									<div data-v-cf6a6ef4="" data-v-8b96a82e="" class="modify_email" style="display: none;">
										<div data-v-4e1fd2e6="" data-v-cf6a6ef4="" class="input_box" data-v-8b96a82e="">
											<h6 data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_title">이메일 주소 변경</h6>
										<div data-v-4e1fd2e6="" class="input_item">
											<input data-v-4e1fd2e6="" type="email" autocomplete="off" class="input_txt" placeholder="s******3@naver.com"></div>
											<p data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_error">  </p>
										</div>
										<div data-v-cf6a6ef4="" data-v-8b96a82e="" class="modify_btn_box">
											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn outlinegrey medium" slot="button" data-v-8b96a82e=""> 취소 </button>
											<button data-v-43813796="" data-v-cf6a6ef4="" disabled="disabled" type="button" class="btn solid medium disabled" slot="button" data-v-8b96a82e=""> 인증 메일 발송 </button>
										</div>
									</div>
									<div data-v-0c9f3f9e="" data-v-cf6a6ef4="" class="unit" data-v-8b96a82e="">
										<h5 data-v-0c9f3f9e="" class="title">비밀번호</h5>
										<div data-v-0c9f3f9e="" class="unit_content">
<%-- 											<p data-v-24a03828="" data-v-cf6a6ef4="" class="desc password" data-v-0c9f3f9e=""><c:forEach var="i" begin="0" end="${member.member_passwd.length() }">●</c:forEach></p> --%>
											<p data-v-24a03828="" data-v-cf6a6ef4="" class="desc passwd" data-v-0c9f3f9e="">●●●●●●●●</p>
											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn btn_modify outlinegrey small" data-v-0c9f3f9e="" id="passwd" onclick="modal('modal2')"> 변경 </button>
										</div>
									</div>
									<%-- 모달 --%>
									<div data-v-cf6a6ef4="" data-v-8b96a82e="" class="modify_passwd blind" id="modal2">
										<h5 data-v-cf6a6ef4="" data-v-8b96a82e="" class="title">비밀번호 변경</h5>
										<div data-v-4e1fd2e6="" data-v-cf6a6ef4="" class="input_box" data-v-8b96a82e="">
											<h6 data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_title">이전 비밀번호</h6>
											<div data-v-4e1fd2e6="" class="input_item">
												<input data-v-4e1fd2e6="" type="password" placeholder="영문, 숫자, 특수문자 조합 8-16자" autocomplete="off" class="input_txt" name="passwd1" id="passwd1">
											</div>
											<p data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_error"> 영문, 숫자, 특수문자를 조합해서 입력해주세요. (8-16자) </p>
										</div>
										<div data-v-4e1fd2e6="" data-v-cf6a6ef4="" class="input_box" data-v-8b96a82e="">
											<h6 data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_title">새 비밀번호</h6>
											<div data-v-4e1fd2e6="" class="input_item">
												<input data-v-4e1fd2e6="" type="password" placeholder="영문, 숫자, 특수문자 조합 8-16자" autocomplete="off" class="input_txt" name="passwd2" id="passwd2">
											</div>
											<p data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_error"> 영문, 숫자, 특수문자를 조합해서 입력해주세요. (8-16자) </p>
										</div>
										<div data-v-cf6a6ef4="" data-v-8b96a82e="" class="modify_btn_box">
											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn outlinegrey medium" slot="button" data-v-8b96a82e="" onclick="closeModal('modal2')"> 취소 </button>
<!-- 											<button data-v-43813796="" data-v-cf6a6ef4="" disabled="disabled" type="button" class="btn solid medium disabled" slot="button" data-v-8b96a82e="" onclick="saveInfo('passwd2')"> 저장 </button> -->
											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn solid medium" slot="button" data-v-8b96a82e="" onclick="saveInfo('passwd2')"> 저장 </button>
										</div>
									</div>
								</div>
								<div data-v-8b96a82e="" data-v-cf6a6ef4="" class="profile_group">
									<h4 data-v-8b96a82e="" class="group_title">개인 정보</h4>
									<div data-v-0c9f3f9e="" data-v-cf6a6ef4="" class="unit" data-v-8b96a82e="">
										<h5 data-v-0c9f3f9e="" class="title">휴대폰 번호</h5>
										<div data-v-0c9f3f9e="" class="unit_content">
											<p data-v-24a03828="" data-v-cf6a6ef4="" class="desc phone" data-v-0c9f3f9e=""></p>
											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn btn_modify outlinegrey small" data-v-0c9f3f9e="" id="phone" onclick="modal('modal3')"> 변경 </button>
										</div>
									</div>
									<%-- 모달 --%>
									<div data-v-cf6a6ef4="" data-v-8b96a82e="" class="modify_phone blind" id="modal3">
										<h5 data-v-cf6a6ef4="" data-v-8b96a82e="" class="title" modal="">휴대폰 번호 변경</h5>
										<div data-v-4e1fd2e6="" data-v-cf6a6ef4="" class="input_box" data-v-8b96a82e="" modal="">
											<h6 data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_title" modal="">새 휴대폰 번호</h6>
											<div data-v-4e1fd2e6="" class="input_item" modal="">
												<input data-v-4e1fd2e6="" type="tel" placeholder="휴대폰 번호를 입력하세요" autocomplete="off" class="input_txt" name="phone1" id="phone1" oninput="autoHyphen2(this)" maxlength="13">
											</div>
											<p data-v-cf6a6ef4="" data-v-4e1fd2e6="" class="input_error" > 휴대폰 번호를 정확히 입력해주세요. </p>
										</div>
										<div data-v-cf6a6ef4="" data-v-8b96a82e="" class="modify_btn_box" modal="">
											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn outlinegrey medium small" slot="button" data-v-8b96a82e="" modal="" onclick="closeModal('modal3')"> 취소 </button>
<!-- 											<button data-v-43813796="" data-v-cf6a6ef4="" disabled="disabled" type="button" class="btn solid medium disabled small" slot="button" data-v-8b96a82e="" modal="" onclick="saveInfo('phone')"> 저장 </button> -->
											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn solid medium small" slot="button" data-v-8b96a82e="" modal="" onclick="saveInfo('phone1')"> 저장 </button>
										</div>
									</div>
									<div data-v-0c9f3f9e="" data-v-cf6a6ef4="" class="unit" data-v-8b96a82e="">
										<h5 data-v-0c9f3f9e="" class="title">회원 타입</h5>
										<div data-v-0c9f3f9e="" class="unit_content">
											<p data-v-24a03828="" data-v-cf6a6ef4="" class="desc" data-v-0c9f3f9e="">${member.member_type }</p>
<!-- 											<button data-v-43813796="" data-v-cf6a6ef4="" type="button" class="btn btn_modify outlinegrey small" data-v-0c9f3f9e=""> 변경 </button> -->
										</div>
									</div>
									<%-- 모달창 --%>
		<!-- 							<div data-v-0fdfe010="" data-v-feb03f9c="" data-v-cf6a6ef4="" class="layer lg" data-v-8b96a82e="" style=""> -->
								</div>
								<div data-v-8b96a82e="" data-v-cf6a6ef4="" class="profile_group">
									<h4 data-v-8b96a82e="" class="group_title">광고성 정보 수신</h4>
									<div data-v-0c9f3f9e="" data-v-cf6a6ef4="" class="unit to_receive" data-v-8b96a82e="">
										<div data-v-0c9f3f9e="" class="unit_content">
											<p data-v-24a03828="" data-v-cf6a6ef4="" class="desc" data-v-0c9f3f9e="">수신 여부</p>
											<div data-v-cf6a6ef4="" data-v-0c9f3f9e="" class="radio_txt_box">
												<div data-v-42808438="" data-v-cf6a6ef4="" class="radio_item" data-v-0c9f3f9e="">
													<label data-v-42808438="" class="radio_label">
<!-- 														<svg data-v-42808438="" xmlns="http://www.w3.org/2000/svg" class="ico-radio-inactive icon sprite-icons"> -->
<!-- 															<use data-v-42808438="" href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive"></use> -->
<!-- 														</svg> -->
														<span data-v-42808438="" class="label_txt">&nbsp;&nbsp;수신 동의&nbsp;&nbsp;</span>
														<input data-v-42808438="" id="agree1" type="radio" name="email_radio" class="radio_input" 
															<c:if test="${member.member_agreement_marketing ne '0'}">checked</c:if> onchange="saveInfo('agree1')">
													</label>
												</div>
												<div data-v-42808438="" data-v-cf6a6ef4="" class="radio_item" data-v-0c9f3f9e="">
													<label data-v-42808438="" class="radio_label">
<!-- 														<svg data-v-42808438="" xmlns="http://www.w3.org/2000/svg" class="ico-radio-inactive icon sprite-icons"> -->
<!-- 															<use data-v-42808438="" href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive"></use> -->
<!-- 														</svg> -->
														<span data-v-42808438="" class="label_txt">&nbsp;&nbsp;수신거부&nbsp;&nbsp;</span>
														<input data-v-42808438="" id="disagree1" type="radio" name="email_radio" class="radio_input" 
															<c:if test="${member.member_agreement_marketing eq '0'}">checked</c:if> onchange="saveInfo('disagree1')">
													</label>
												</div>
											</div>
										</div>
									</div>
<!-- 									<div data-v-0c9f3f9e="" data-v-cf6a6ef4="" class="unit to_receive" data-v-8b96a82e=""> -->
<!-- 										<div data-v-0c9f3f9e="" class="unit_content"> -->
<!-- 											<p data-v-24a03828="" data-v-cf6a6ef4="" class="desc" data-v-0c9f3f9e="">문자 메시지</p> -->
<!-- 											<div data-v-cf6a6ef4="" data-v-0c9f3f9e="" class="radio_txt_box"> -->
<!-- 												<div data-v-42808438="" data-v-cf6a6ef4="" class="radio_item" data-v-0c9f3f9e=""> -->
<!-- 													<label data-v-42808438="" class="radio_label"> -->
<!-- <!-- 														<svg data-v-42808438="" xmlns="http://www.w3.org/2000/svg" class="ico-radio-inactive icon sprite-icons"> --> 
<!-- <!-- 															<use data-v-42808438="" href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive"></use> -->
<!-- <!-- 														</svg> --> 
<!-- 														<span data-v-42808438="" class="label_txt">&nbsp;&nbsp;수신 동의&nbsp;&nbsp;</span> -->
<!-- 														<input data-v-42808438="" id="agree1" type="radio" name="message_radio" class="radio_input"  -->
<%-- 															<c:if test="${member.member_agreement_marketing_sms ne '0'}">checked</c:if> onchange="chgAgree(this)"> --%>
<!-- 													</label> -->
<!-- 												</div> -->
<!-- 												<div data-v-42808438="" data-v-cf6a6ef4="" class="radio_item" data-v-0c9f3f9e=""> -->
<!-- 													<label data-v-42808438="" class="radio_label"> -->
<!-- <!-- 														<svg data-v-42808438="" xmlns="http://www.w3.org/2000/svg" class="ico-radio-inactive icon sprite-icons"> --> 
<!-- <!-- 															<use data-v-42808438="" href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-radio-inactive"></use> -->
<!-- <!-- 														</svg> --> 
<!-- 														<span data-v-42808438="" class="label_txt">&nbsp;&nbsp;수신거부&nbsp;&nbsp;</span> -->
<!-- 														<input data-v-42808438="" id="disagree1" type="radio" name="message_radio" class="radio_input"  -->
<%-- 															<c:if test="${member.member_agreement_marketing_sms eq '0'}">checked</c:if> onchange="chgAgree(this)"> --%>
<!-- 													</label> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
								</div>
								<a data-v-cf6a6ef4="" href="member_withdrawal" class="btn_withdrawal">회원 탈퇴</a>
							</div>
							<%-- 모달 --%>
							<div class="layer_withdrawal layer lg blind" data-v-0fdfe010="" data-v-79f8507c="" data-v-48e89bd9="" modal="" id="modal1">
								<div class="layer_container" data-v-0fdfe010="" modal="">
									<a href="#" class="btn_layer_close" data-v-0fdfe010="" data-v-79f8507c="" modal="">
<!-- 												<svg xmlns="http://www.w3.org/2000/svg" class="ico-close icon sprite-icons" data-v-0fdfe010="" data-v-79f8507c=""> -->
<!-- 													<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-close" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-close" data-v-0fdfe010="" data-v-79f8507c=""></use> -->
<!-- 												</svg> -->
									</a>
									<div class="layer_header" data-v-0fdfe010="" modal="">
										<h2 class="title" data-v-0fdfe010="" data-v-79f8507c="" modal="">
<!-- 													<svg xmlns="http://www.w3.org/2000/svg" class="alert-circle-dark icon sprite-icons" data-v-0fdfe010="" data-v-79f8507c=""> -->
<!-- 														<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-alert-circle-dark" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-alert-circle-dark" data-v-0fdfe010="" data-v-79f8507c=""></use> -->
<!-- 													</svg>  -->
											회원 정보 변경
										</h2>
									</div>
									<div class="layer_content" data-v-0fdfe010="" modal="">
										<p class="modal_desc unable_desc" data-v-0fdfe010="" data-v-79f8507c="" modal="">회원정보가 변경되었습니다</p>
										<ul class="withdrawal_list" data-v-0fdfe010="" data-v-79f8507c="" modal=""></ul>
										<div class="modal_btn_box" data-v-0fdfe010="" data-v-79f8507c="" modal="">
											<button type="button" class="btn outlinegrey medium" data-v-43813796="" data-v-79f8507c="" data-v-0fdfe010="" modal="" onclick="modal('modal1')"> 확인 </button>
										</div>
									</div>
								</div>
							</div>
							
						</div>
						<%-- 서브 네비바 --%>
						<div data-v-7bcac446 class="snb_var">
							<nav id="subNav" class="snb">
							    <jsp:include page="/WEB-INF/views/inc/member_sidebar_hidden.jsp"></jsp:include>
							</nav>
                        </div>
					</div>
				</div>
			</div>
	</div>

  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  </nav>
  
  <div id="sieAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
  
  <%-- 스크립트 코드 --%>
<!--   <script src="/_nuxt/0fc2b9a.js" defer=""></script> -->
<!--   <script src="/_nuxt/c2849e3.js" defer=""></script> -->
<!--   <script src="/_nuxt/6d1f03a.js" defer=""></script> -->
<!--   <script src="/_nuxt/5402e5b.js" defer=""></script> -->
<!--   <script src="/_nuxt/31641e8.js" defer=""></script> -->
<!--   <link href="/_nuxt/css/6ca5ffb.css" rel="stylesheet" type="text/css"> -->
<!--   <link href="/_nuxt/css/caea5a4.css" rel="stylesheet" type="text/css"> -->
  
</body>