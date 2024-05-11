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
<!-- 스크립트 태그 추가 -->
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<style>
@media only screen and (min-width: 768px) {
	.small_area[data-v-2b15bea4] {
		height: 500px;
	}
}
</style>
<script type="text/javascript">

	$(function(){
		
	
	});
	
	// 주소 추가버튼
// 	function btnAddress(event) {

// // 		event.preventDefault();

// 		// 이벤트가 발생한 요소를 가져옵니다.
// 		const target = event.target;
// 		console.log('클릭한 링크의 class 값:', target.className);
// 		console.log('클릭한 링크의 name 값:', target.name);
// 		console.log('hidden 값 상태:', $('div[name="modal"]').attr('hidden'));
// // 		if(){
			
// // 		}
// 		$('div[name="modal"]').removeAttr('hidden');
		
// 	}
	

	
	function modal(pop) {
		console.log(pop)
		$('#' + pop).removeClass('blind');
		
		
		if(pop == 'insert') { // 새 배송지 추가 시 모달 열기
			return;
		}
		
		// 배송지 수정일 경우 모달에 값 출력
		var rew = event.target.name;
		var phoneNumber = '';
		
		console.log(rew);
		
		$('input#rew').val(rew);
		
		if(rew == 'rew_num1') { // 주소1 변경
			phoneNumber = '${member.member_address1_phone}';
			if (phoneNumber.length === 11) {
		        // 010-1111-2222 형식으로 변경
		        phoneNumber = phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 7) + '-' + phoneNumber.substring(7);
		    } else if (phoneNumber.length === 10) {
		        // 010-111-2222 형식으로 변경
		        phoneNumber = phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 6) + '-' + phoneNumber.substring(6);
		    }
			
			$('input#member_address_name_rew').val('${member.member_address1_name }');
			$('input#member_phone_rew').val(phoneNumber);
			$('input#member_zipcode_rew').val('${member.member_zipcode1 }');
			$('input#member_address_rew').val('${member.member_address1 }');
			$('input#member_address_detail_rew').val('${member.member_address_detail1 }');
			$('input#chk_main_rew').prop({checked:true, disabled:true });
			
		} else if(rew == 'rew_num2') { // 주소2 변경
			var phoneNumber = '${member.member_address2_phone}';
			if (phoneNumber.length === 11) {
		        // 010-1111-2222 형식으로 변경
		        phoneNumber = phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 7) + '-' + phoneNumber.substring(7);
		    } else if (phoneNumber.length === 10) {
		        // 010-111-2222 형식으로 변경
		        phoneNumber = phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 6) + '-' + phoneNumber.substring(6);
		    }
			$('input#member_address_name_rew').val('${member.member_address2_name }');
			$('input#member_phone_rew').val(phoneNumber);
			$('input#member_zipcode_rew').val('${member.member_zipcode2 }');
			$('input#member_address_rew').val('${member.member_address2 }');
			$('input#member_address_detail_rew').val('${member.member_address_detail2 }');
			$('input#chk_main_rew').prop("checked",false);
			
		} else if(rew == 'rew_num3') { // 주소3 변경
			var phoneNumber = '${member.member_address3_phone}';
			if (phoneNumber.length === 11) {
		        // 010-1111-2222 형식으로 변경
		        phoneNumber = phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 7) + '-' + phoneNumber.substring(7);
		    } else if (phoneNumber.length === 10) {
		        // 010-111-2222 형식으로 변경
		        phoneNumber = phoneNumber.substring(0, 3) + '-' + phoneNumber.substring(3, 6) + '-' + phoneNumber.substring(6);
		    }
			$('input#member_address_name_rew').val('${member.member_address3_name }');
			$('input#member_phone_rew').val(phoneNumber);
			$('input#member_zipcode_rew').val('${member.member_zipcode3 }');
			$('input#member_address_rew').val('${member.member_address3 }');
			$('input#member_address_detail_rew').val('${member.member_address_detail3 }');
			$('input#chk_main_rew').prop("checked",false);
			
		}
	}
	
	function closeModal(pop) {
		console.log(pop)
		$('#' + pop).addClass('blind');
		
	}
	
	<%-- 새로운 주소 추가 --%>
	function addAddress(pop) {
		console.log(pop)
		$('#' + pop).addClass('blind');
// 		var id = '${member.member_id}';
		
		var map = {
				member_id: '${member.member_id}',
				member_address_name: $('input#member_address_name').val(),
				member_phone: $('input#member_phone').val().replaceAll('-',''),
				member_zipcode: $('input#member_zipcode').val(),
				member_address: $('input#member_address').val(),
				member_address_detail: $('input#member_address_detail').val(),
				chk_main: $('input#chk_main').prop('checked')
		};
		
		$.ajax({
	        type: 'POST',
	        url: 'member_address_regist', // 컨트롤러에서 처리할 URL 경로
	        contentType: 'application/json',
	        data: JSON.stringify(map),
	        dataType: "json",
	        success: function(response) {
	            console.log(response); // 성공한 경우 처리
	            alert(response[0]);
	            location.reload();
	        },
	        error: function(error) {
	            console.error(error); // 오류 처리
	        }
	    });
	}
	
	<%-- 주소 변경 --%>
	function rewAddress(pop) {
		console.log(pop)
		$('#' + pop).addClass('blind');
		
		var map = {
				rew: $('input#rew').val(),
				member_id: '${member.member_id}',
				member_address_name: $('input#member_address_name_rew').val(),
				member_phone: $('input#member_phone_rew').val().replaceAll('-',''),
				member_zipcode: $('input#member_zipcode_rew').val(),
				member_address: $('input#member_address_rew').val(),
				member_address_detail: $('input#member_address_detail_rew').val(),
				chk_main: $('input#chk_main_rew').prop('checked')
		};
		
		$.ajax({
	        type: 'POST',
	        url: 'member_address_update', // 컨트롤러에서 처리할 URL 경로
	        contentType: 'application/json',
	        data: JSON.stringify(map),
	        dataType: "json",
	        success: function(response) {
	        	alert(response[0]);
	            location.reload();
	        },
	        error: function(error) {
	            console.error(error); // 오류 처리
	        }
	    });
	}
	
	// 주소 삭제버튼
	function deleteAddress(event) {

// 		event.preventDefault();

		// 이벤트가 발생한 요소를 가져옵니다.
		const target = event.target;
		console.log('클릭한 링크의 class 값:', target.className);
		console.log('클릭한 링크의 name 값:', target.name);
// 		console.log('hidden 값 상태:', $('div[name="modal"]').attr('hidden'));
// 		
// 		var rmv_num = target.name
// 		$('div[name="modal"]').removeAttr('hidden');

		
		var map = {
				member_id: '${member.member_id}',
				rmv_num: target.name,
		};
		
		$.ajax({
	        type: 'POST',
	        url: 'member_address_delete', // 컨트롤러에서 처리할 URL 경로
	        contentType: 'application/json',
	        data: JSON.stringify(map),
	        dataType: "json",
	        success: function(response) {
	            console.log(response); // 성공한 경우 처리
	            alert(response[0]);
	            location.reload();
	        },
	        error: function(error) {
	            console.error(error); // 오류 처리
	        }
	    });
		
	}
	
	const autoHyphen2 = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '')
		  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}

</script>
<%-- 우편번호찾기 Daum api --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function DaumPostcode(target) {
		var type = target;
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
				
                if(type == 'add') {
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('member_zipcode').value = data.zonecode;
	                document.getElementById("member_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("member_address_detail").focus();
                } else {
                	document.getElementById('member_zipcode_rew').value = data.zonecode;
                    document.getElementById("member_address_rew").value = addr;
                    document.getElementById("member_address_detail_rew").focus();
                }
            }
        }).open();
    }
</script>
<title>중고거래 사이트</title>



</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
<%--  <header id="pageHeader"><%@ include file="assets/inc/header_zero.jsp"%></header> --%>
 
  <%--본문내용 --%>
  <article id="mainArticle">
  <div id="__layout">

	<div data-v-473e7c14="" class="container my lg">
	
		<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
			<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
		</nav>
	
		<div data-v-473e7c14="" class="contentArea">

			<%-- 본문 - 주소록 관리 --%>
			<div data-v-2e8df47b="" data-v-473e7c14="" class="content_area small_area" data-v-2b15bea4="">
				<div data-v-2e8df47b="" class="my_addressbook">
					<div data-v-88eb18f6="" data-v-2e8df47b="" class="content_title">
						<div data-v-88eb18f6="" class="title">
							<h3 data-v-88eb18f6="">주소록</h3>
							<input type="hidden" name="member_id" id="member_id" val="${member.member_id }">
						</div>
						<div data-v-88eb18f6="" class="btn_box">
							<a data-v-43813796="" data-v-88eb18f6="" name="insert" class="btn btn_add insert" onclick="modal('addModal')">
								+ 새 배송지 추가
							</a>
						</div>
					</div>
					<%-- 배송지 목록 출력 부분 --%>
					<%-- 주소1 --%>	
					<form id="fr1">
						<div data-v-1c284ef0="" data-v-2e8df47b="" class="my_list">
							<div data-v-1c284ef0="" class="basic">
								<div data-v-7d49a47c="" class="my_item is_active" default-mark="기본 배송지" data-v-1c284ef0="">
									<div data-v-7d49a47c="" class="info_bind">
										<div data-v-be4e2246="" class="address_info" data-v-7d49a47c="">
											<div data-v-be4e2246="" class="name_box">
												<span data-v-be4e2246="" class="name">${member.member_address1_name}</span>
												<span data-v-be4e2246="" class="mark">기본 배송지</span>
											</div>
											<p data-v-be4e2246="" class="phone"></p>
											<div data-v-be4e2246="" class="address_box">
												<span data-v-be4e2246="" class="phone">연락처 : ${member.member_address1_phone }</span>
												<span data-v-be4e2246="" class="zipcode">(${member.member_zipcode1 })</span>
												<span data-v-be4e2246="" class="address">${member.member_address1 } ${member.member_address_detail1 }</span>
											</div>
										</div>
									</div>
									<div data-v-7d49a47c="" class="btn_bind">
										<a data-v-43813796="" data-v-7d49a47c="" name="rew_num1"  id="rew_num1" class="btn solid small update" onclick="modal('rewModal')"> 수정 </a>
<!-- 										<a data-v-43813796="" data-v-7d49a47c="" name="delete1" class="btn outlinegrey small delete" onclick="deleteAddress(event)"> 삭제 </a> -->
									</div>
								</div>
							</div>
<!-- 							<div data-v-1c284ef0="" class="other"> -->
<!-- 								<div data-v-1c284ef0="" class="other_list"></div> -->
<!-- 							</div> -->
						</div>
					</form>
					
						<c:if test="${not empty member.member_address2_name }">
							<%-- 주소2 --%>	
							<form id="fr2">
								<div data-v-1c284ef0="" data-v-2e8df47b="" class="my_list">
									<div data-v-1c284ef0="" class="basic">
										<div data-v-7d49a47c="" class="my_item is_active"  data-v-1c284ef0="">
											<div data-v-7d49a47c="" class="info_bind">
												<div data-v-be4e2246="" class="address_info" data-v-7d49a47c="">
													<div data-v-be4e2246="" class="name_box">
														<span data-v-be4e2246="" class="name">${member.member_address2_name}</span>
													</div>
													<p data-v-be4e2246="" class="phone"></p>
													<div data-v-be4e2246="" class="address_box">
														<span data-v-be4e2246="" class="phone">연락처 : ${member.member_address2_phone }</span>
														<span data-v-be4e2246="" class="zipcode">(${member.member_zipcode2 })</span>
														<span data-v-be4e2246="" class="address">${member.member_address2 } ${member.member_address_detail2 }</span>
													</div>
												</div>
											</div>
											<div data-v-7d49a47c="" class="btn_bind">
												<a data-v-43813796="" data-v-7d49a47c="" name="rew_num2" id="rew_num2" class="btn solid small update" onclick="modal('rewModal')"> 수정 </a>
												<a data-v-43813796="" data-v-7d49a47c="" name="rmv_num2" class="btn outlinegrey small delete" onclick="deleteAddress(event)"> 삭제 </a>
											</div>
										</div>
<!-- 									<div data-v-1c284ef0="" class="other"> -->
<!-- 										<div data-v-1c284ef0="" class="other_list"></div> -->
									</div>
								</div>
							</form>
						</c:if>
						<c:if test="${not empty member.member_address3_name }">
							<%-- 주소3 --%>	
							<form id="fr3">
								<div data-v-1c284ef0="" data-v-2e8df47b="" class="my_list">
									<div data-v-1c284ef0="" class="basic">
										<div data-v-7d49a47c="" class="my_item is_active"  data-v-1c284ef0="">
											<div data-v-7d49a47c="" class="info_bind">
												<div data-v-be4e2246="" class="address_info" data-v-7d49a47c="">
													<div data-v-be4e2246="" class="name_box">
														<span data-v-be4e2246="" class="name">${member.member_address3_name}</span>
													</div>
													<p data-v-be4e2246="" class="phone"></p>
													<div data-v-be4e2246="" class="address_box">
														<span data-v-be4e2246="" class="phone">연락처 : ${member.member_address3_phone }</span>
														<span data-v-be4e2246="" class="zipcode">(${member.member_zipcode3 })</span>
														<span data-v-be4e2246="" class="address">${member.member_address3 } ${member.member_address_detail3 }</span>
													</div>
												</div>
											</div>
											<div data-v-7d49a47c="" class="btn_bind">
												<a data-v-43813796="" data-v-7d49a47c="" name="rew_num3" id="rew_num1" class="btn solid small update" onclick="modal('rewModal')"> 수정 </a>
												<a data-v-43813796="" data-v-7d49a47c="" name="rmv_num3" class="btn outlinegrey small delete" onclick="deleteAddress(event)"> 삭제 </a>
											</div>
										</div>
										<div data-v-1c284ef0="" class="other">
											<div data-v-1c284ef0="" class="other_list"></div>
										</div>
									</div>
								</div>
							</form>
						</c:if>
					
					
					<%-- 모달1 --%>
					<form id="addAddress">
						<div data-v-78455e2e="" data-v-71b8d4b9="" data-v-2e8df47b="" class="layer_delivery layer lg blind" modal="" id="addModal">
							<div data-v-78455e2e="" class="layer_container" data-v-0fdfe010="" modal="">
								<a data-v-71b8d4b9="" data-v-78455e2e="" href="#" class="btn_layer_close" modal="">
									<div data-v-71b8d4b9="" data-v-78455e2e="">
										<button>X</button>
									</div>
								</a>
								<div data-v-78455e2e="" class="layer_content" modal="">
									<div data-v-78455e2e="" class="layer_header" modal="">
										<h2 data-v-71b8d4b9="" data-v-78455e2e="" class="title" modal=""> 새 주소 추가 </h2>
									</div>
									<div data-v-71b8d4b9="" data-v-78455e2e="" class="delivery_bind" modal="">
										<div data-v-71b8d4b9="" data-v-78455e2e="" class="delivery_input" modal="">
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box has_error" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">이름</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="수령인의 이름" autocomplete="off" class="input_txt" id="member_address_name" modal="">
												</div>
												<p data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_error" modal="">올바른 이름을 입력해주세요. (2 - 50자)</p>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">휴대폰 번호</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="tel" placeholder="- 없이 입력" autocomplete="off" class="input_txt" modal="" name="member_phone" id="member_phone" oninput="autoHyphen2(this)" maxlength="13">
												</div>
												<p data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_error" modal="">정확한 휴대폰 번호를 입력해주세요.</p>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">우편번호</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="우편 번호를 검색하세요" readonly="readonly" autocomplete="off" class="input_txt" id="member_zipcode" modal="">
													<a data-v-43813796="" data-v-71b8d4b9="" class="btn btn_zipcode outline small" data-v-4e1fd2e6="" modal="" onclick="DaumPostcode('add')"> 우편번호 </a>
												</div>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">주소</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="우편 번호 검색 후, 자동입력 됩니다" readonly="readonly" autocomplete="off" class="input_txt" id="member_address" modal=""></div>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">상세 주소</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="건물, 아파트, 동/호수 입력" autocomplete="off" class="input_txt" id="member_address_detail" modal="">
												</div>
											</div>
										</div>
										<div data-v-71b8d4b9="" data-v-78455e2e="" class="delivery_check" modal="">
											<div data-v-4c714e9f="" data-v-71b8d4b9="" class="checkbox_item" data-v-78455e2e="" modal="">
												<label data-v-4c714e9f="" class="check_label" modal="">
													<input data-v-4c714e9f="" id="chk_main" type="checkbox" name="chk_main" class="" modal="">
													<span data-v-4c714e9f="" class="label_txt" modal="">기본 배송지로 설정</span>
												</label>
											</div>
										</div>
									</div>
									<div data-v-71b8d4b9="" data-v-78455e2e="" class="layer_btn" modal="">
										<a data-v-43813796="" data-v-71b8d4b9="" name="closeModal" class="btn btn_delete outlinegrey medium" data-v-78455e2e="" modal="" onclick="closeModal('addModal')"> 취소 </a>
		<!-- 								<a data-v-43813796="" data-v-71b8d4b9="" disabled="disabled" href="#" class="btn btn_save solid medium disabled" data-v-78455e2e="" modal=""> 저장하기 </a> -->
										<a data-v-43813796="" data-v-71b8d4b9="" name="saveModal" class="btn btn_save solid medium" data-v-78455e2e="" modal="" onclick="addAddress('addModal')"> 저장하기 </a>
									</div>
								</div>
							</div>
						</div>
					</form>
					<%-- 모달2 --%>
					<form id="rewAddress">
						<div data-v-78455e2e="" data-v-71b8d4b9="" data-v-2e8df47b="" class="layer_delivery layer lg blind" modal="" id="rewModal">
							<div data-v-78455e2e="" class="layer_container" data-v-0fdfe010="" modal="">
								<a data-v-71b8d4b9="" data-v-78455e2e="" href="#" class="btn_layer_close" modal="">
									<div data-v-71b8d4b9="" data-v-78455e2e="">
										<button>X</button>
									</div>
								</a>
								<div data-v-78455e2e="" class="layer_content" modal="">
									<div data-v-78455e2e="" class="layer_header" modal="">
										<h2 data-v-71b8d4b9="" data-v-78455e2e="" class="title" modal=""> 주소 변경 </h2>
										<input type="hidden" name="rew" id="rew" value="">
									</div>
									<div data-v-71b8d4b9="" data-v-78455e2e="" class="delivery_bind" modal="">
										<div data-v-71b8d4b9="" data-v-78455e2e="" class="delivery_input" modal="">
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box has_error" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">이름</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="수령인의 이름" autocomplete="off" class="input_txt" id="member_address_name_rew" modal="">
												</div>
												<p data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_error" modal="">올바른 이름을 입력해주세요. (2 - 50자)</p>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">휴대폰 번호</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="tel" placeholder="- 없이 입력" autocomplete="off" class="input_txt" modal="" name="member_phone_rew" id="member_phone_rew" oninput="autoHyphen2(this)" maxlength="13">
												</div>
												<p data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_error" modal="">정확한 휴대폰 번호를 입력해주세요.</p>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">우편번호</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="우편 번호를 검색하세요" readonly="readonly" autocomplete="off" class="input_txt" id="member_zipcode_rew" modal="">
													<a data-v-43813796="" data-v-71b8d4b9="" class="btn btn_zipcode outline small" data-v-4e1fd2e6="" modal="" onclick="DaumPostcode('rew')"> 우편번호 </a>
												</div>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">주소</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="우편 번호 검색 후, 자동입력 됩니다" readonly="readonly" autocomplete="off" class="input_txt" id="member_address_rew" modal=""></div>
											</div>
											<div data-v-4e1fd2e6="" data-v-71b8d4b9="" class="input_box" data-v-78455e2e="" modal="">
												<h4 data-v-71b8d4b9="" data-v-4e1fd2e6="" class="input_title" modal="">상세 주소</h4>
												<div data-v-4e1fd2e6="" class="input_item" modal="">
													<input data-v-4e1fd2e6="" type="text" placeholder="건물, 아파트, 동/호수 입력" autocomplete="off" class="input_txt" id="member_address_detail_rew" modal="">
												</div>
											</div>
										</div>
										<div data-v-71b8d4b9="" data-v-78455e2e="" class="delivery_check" modal="">
											<div data-v-4c714e9f="" data-v-71b8d4b9="" class="checkbox_item" data-v-78455e2e="" modal="">
												<label data-v-4c714e9f="" class="check_label" modal="">
													<input data-v-4c714e9f="" id="chk_main_rew" type="checkbox" name="chk_main_rew" class="" modal="">
													<span data-v-4c714e9f="" class="label_txt" modal="">기본 배송지로 설정</span>
												</label>
											</div>
										</div>
									</div>
									<div data-v-71b8d4b9="" data-v-78455e2e="" class="layer_btn" modal="">
										<a data-v-43813796="" data-v-71b8d4b9="" name="closeModal" class="btn btn_delete outlinegrey medium" data-v-78455e2e="" modal="" onclick="closeModal('rewModal')"> 취소 </a>
		<!-- 								<a data-v-43813796="" data-v-71b8d4b9="" disabled="disabled" href="#" class="btn btn_save solid medium disabled" data-v-78455e2e="" modal=""> 저장하기 </a> -->
										<a data-v-43813796="" data-v-71b8d4b9="" name="saveModal" class="btn btn_save solid medium" data-v-78455e2e="" modal="" onclick="rewAddress('rewModal')"> 저장하기 </a>
									</div>
								</div>
							</div>
						</div>
					</form>
				
				
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
  

  
  <div id="sieAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
  
</body>