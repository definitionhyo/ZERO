<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

</style>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<script type="text/javascript">

	// 체크 박스 모두 클릭 시 모달 생성
	function isCheck() {
		
		var check1 = $("#title0").prop("checked");
		var check2 = $("#title1").prop("checked");
		var check3 = $("#title2").prop("checked");
		var check4 = $("#check1").prop("checked");
		
		console.log(check1 + ', ' + check2 + ', ' + check3 + ', ' + check4);
		console.log(check1 && check2 && check3 && check4);
		
		if(check1 && check2 && check3 && check4) { // 체크박스가 모두 선택된 경우
			openModal('modal1');
		} else {
			openModal('modal4');
		}
	}
	

	
	// 변수에 해당하는 모달 생성
	function openModal(data) {

		$('div[name="' + data + '"]').removeAttr('hidden');
		
	}

	function closeModal(data) {
		
		
// 		event.preventDefault();
	
		// 이벤트가 발생한 요소를 가져옵니다.
// 		const target = event.target;
		console.log('클릭한 링크의 파라미터 값:', data);
// 		console.log('클릭한 링크의 class 값:', target.className);
// 		console.log('클릭한 링크의 name 값:', target.name);
		console.log('hidden 값 상태:', $('div[name="' + data + '"]').attr('hidden'));

		$('div[name="' + data + '"]').attr('hidden','');
		
	}
	
	// 회원이 현재 경매 참가중일 경우 탈퇴 취소
	function openCheckModal(data) {

		console.log('클릭한 링크의 파라미터 값:', data);
// 		event.preventDefault();
		
		$('div[name="' + data + '"]').removeAttr('hidden');
		
		$.ajax({
			type: "GET",
			url: '${pageContext.request.contextPath }/ajax/checkWithrawal',
			dataType: "text",
			success: function(data) {
				// ajax 결과값에 따라 모달 출력
				console.log(data);
				if(data == 'true'){ // 회원 정보 삭제 성공
					closeModal('modal1');
					openModal('modal2');
				} else { // 회원 정보 삭제 실패
					closeModal('modal1');
					openModal('modal3');
				}
			},
			error: function() {
				alert("탈퇴 요청 실패!");
			}
		});
		
		

	}
	
	

</script>

</head>
<body>
 <%--네비게이션 바 영역 --%>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<article id="mainArticle">
	
		<div class="container my lg">
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
			</nav>
		
			<%-- 메인영역 --%>
			<div data-v-473e7c14="" class="contentArea">
			
				<div class="content_area" data-v-48e89bd9="" data-v-78dabb2d="">
					<div class="my_withdrawal" data-v-48e89bd9="">
						<div class="content_title" data-v-88eb18f6="" data-v-48e89bd9="">
							<div class="title" data-v-88eb18f6="">
								<h3 data-v-88eb18f6="">회원탈퇴</h3>
							</div>
						</div>
						<div class="content" data-v-48e89bd9="">
							<div class="withdrawal_wrap" data-v-48e89bd9="">
								<div data-v-48e89bd9="">
									<h4 class="group_title" data-v-48e89bd9="">회원탈퇴에 앞서 아래 내용을 반드시 확인해 주세요.</h4>
										<div class="withdrawal_terms" data-v-48e89bd9="">
										<div class="terms_box" data-v-48e89bd9="">
											<h5 class="terms_title" data-v-48e89bd9="">
												<div class="checkbox_item" data-v-4c714e9f="" data-v-48e89bd9="">
													<input id="title0" type="checkbox" name="" class="" data-v-4c714e9f="">
													<label for="title0" class="check_label" data-v-4c714e9f="">
<!-- 														<svg xmlns="http://www.w3.org/2000/svg" class="icon sprite-icons ico-check-inactive" data-v-4c714e9f=""> -->
<!-- 															<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" data-v-4c714e9f=""></use> -->
<!-- 														</svg> -->
														<span class="label_txt" data-v-4c714e9f="">ZERO을 탈퇴하면 회원 정보 및 서비스 이용 기록이 삭제됩니다.</span>
													</label>
												</div>
											</h5>
											<div class="terms_detail" data-v-48e89bd9="">
												<ul class="terms_list" data-v-48e89bd9="">
													<li class="terms_item" data-v-48e89bd9=""> 내 프로필, 거래내역(구매/판매), 관심상품, 보유상품, STYLE 게시물(게시물/댓글), 미사용 보유 포인트 등 사용자의 모든 정보가 사라지며 재가입 하더라도 복구가 불가능합니다. </li>
													<li class="terms_item" data-v-48e89bd9=""> 탈퇴 14일 이내 재가입할 수 없으며, 탈퇴 후 동일 이메일로 재가입할 수 없습니다 </li>
												</ul>
											</div></div><div class="terms_box" data-v-48e89bd9="">
											<h5 class="terms_title" data-v-48e89bd9="">
												<div class="checkbox_item" data-v-4c714e9f="" data-v-48e89bd9="">
													<input id="title1" type="checkbox" name="" class="" data-v-4c714e9f="">
													<label for="title1" class="check_label" data-v-4c714e9f="">
<!-- 														<svg xmlns="http://www.w3.org/2000/svg" class="icon sprite-icons ico-check-inactive" data-v-4c714e9f=""> -->
<!-- 															<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" data-v-4c714e9f=""></use> -->
<!-- 														</svg> -->
														<span class="label_txt" data-v-4c714e9f="">관련 법령 및 내부 기준에 따라 별도 보관하는 경우에는 일부 정보가 보관될 수 있습니다.</span>
													</label>
												</div>
											</h5>
											<div class="terms_detail" data-v-48e89bd9="">
												<h6 class="terms_subtitle" data-v-48e89bd9=""> 1. 전자상거래 등 소비자 보호에 관한 법률 </h6>
												<ul class="terms_list" data-v-48e89bd9="">
													<li class="terms_item" data-v-48e89bd9=""> 계약 또는 청약철회 등에 관한 기록: 5년 보관 </li>
													<li class="terms_item" data-v-48e89bd9=""> 대금결제 및 재화 등의 공급에 관한 기록: 5년 보관 </li>
													<li class="terms_item" data-v-48e89bd9=""> 소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관 </li>
												</ul>
											</div>
											<div class="terms_detail" data-v-48e89bd9="">
												<h6 class="terms_subtitle" data-v-48e89bd9=""> 2. 통신비밀보호법 </h6>
												<ul class="terms_list" data-v-48e89bd9="">
													<li class="terms_item" data-v-48e89bd9=""> 접속 로그 기록: 3개월 보관 </li>
												</ul>
											</div>
											<div class="terms_detail" data-v-48e89bd9="">
												<h6 class="terms_subtitle" data-v-48e89bd9=""> 3. 내부 기준에 따라 별도 보관 </h6>
												<ul class="terms_list" data-v-48e89bd9="">
													<li class="terms_item" data-v-48e89bd9=""> 부정이용 방지를 위해 이름, 이메일(로그인ID), 휴대전화번호, CI/DI: 3년 보관 </li>
												</ul>
											</div>
										</div>
										<div class="terms_box" data-v-48e89bd9="">
											<h5 class="terms_title" data-v-48e89bd9="">
												<div class="checkbox_item" data-v-4c714e9f="" data-v-48e89bd9="">
													<input id="title2" type="checkbox" name="" class="" data-v-4c714e9f="">
													<label for="title2" class="check_label" data-v-4c714e9f="">
<!-- 														<svg xmlns="http://www.w3.org/2000/svg" class="icon sprite-icons ico-check-inactive" data-v-4c714e9f=""> -->
<!-- 															<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" data-v-4c714e9f=""></use> -->
<!-- 														</svg> -->
														<span class="label_txt" data-v-4c714e9f="">ZERO 탈퇴가 제한된 경우에는 아래 내용을 참고하시기 바랍니다.</span>
													</label>
												</div>
											</h5>
											<div class="terms_detail" data-v-48e89bd9="">
												<ul class="terms_list" data-v-48e89bd9="">
													<li class="terms_item" data-v-48e89bd9=""> 진행 중인 거래(판매/구매)가 있을 경우: 해당 거래 종료 후 탈퇴 가능 </li>
													<li class="terms_item" data-v-48e89bd9=""> 진행 중인 입찰(판매/구매)가 있을 경우: 해당 입찰 삭제 후 탈퇴 가능 </li>
													<li class="terms_item" data-v-48e89bd9=""> 미납 수수료(착불 발송비/페널티)가 있을 경우: 해당 결제 완료 후 탈퇴 가능 </li>
													<li class="terms_item" data-v-48e89bd9=""> 이용 정지 상태인 경우: 이용 정지 해제 후 탈퇴 가능 </li>
												</ul>
											</div>
										</div>
									</div>
									<div class="withdrawal_check" data-v-48e89bd9="">
										<div class="checkbox_item" data-v-4c714e9f="" data-v-48e89bd9="">
											<input id="check1" type="checkbox" name="" class="" data-v-4c714e9f="">
											<label for="check1" class="check_label" data-v-4c714e9f="">
<!-- 												<svg xmlns="http://www.w3.org/2000/svg" class="icon sprite-icons ico-check-inactive" data-v-4c714e9f=""> -->
<!-- 													<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-check-inactive" data-v-4c714e9f=""></use> -->
<!-- 												</svg> -->
												<span class="label_txt" data-v-4c714e9f="">회원탈퇴 안내를 모두 확인하였으며 탈퇴에 동의합니다.</span>
											</label>
										</div>
									</div>
									<div class="withdrawal_btn_box" data-v-48e89bd9="">
										<a class="btn outlinegrey medium" data-v-43813796="" data-v-48e89bd9="" onclick="isCheck()"> 탈퇴하기 </a>
										<a class="btn solid medium" data-v-43813796="" data-v-48e89bd9="" onclick="history.back()"> 취소하기 </a>
									</div>
									<%-- 모달1 --%>
									<div class="layer_withdrawal layer lg" hidden data-v-0fdfe010="" data-v-79f8507c="" data-v-48e89bd9="" name="modal1" modal="">
										<div class="layer_container" data-v-0fdfe010="" modal="">
											<a href="#" class="btn_layer_close" data-v-0fdfe010="" data-v-79f8507c="" modal="">
<!-- 												<svg xmlns="http://www.w3.org/2000/svg" class="ico-close icon sprite-icons" data-v-0fdfe010="" data-v-79f8507c=""> -->
<!-- 													<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-close" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-close" data-v-0fdfe010="" data-v-79f8507c=""></use> -->
<!-- 												</svg> -->
											</a>
											<div class="layer_header" data-v-0fdfe010="" modal="">
												<h2 class="title" data-v-0fdfe010="" data-v-79f8507c="" modal=""> 정말 탈퇴하시겠습니까? </h2>
											</div>
											<div class="layer_content" data-v-0fdfe010="" modal="">
												<p class="modal_desc" data-v-0fdfe010="" data-v-79f8507c="" modal="">탈퇴하기 클릭 시 바로 탈퇴 처리됩니다.<br>탈퇴 후 14일 이내 재가입할 수 없으며,<br>재가입 시 동일 이메일을 사용할 수 없습니다.</p>
												<div class="modal_btn_box" data-v-0fdfe010="" data-v-79f8507c="" modal="">
													<button type="button" class="btn medium outlinegrey" data-v-43813796="" data-v-79f8507c="" data-v-0fdfe010="" modal="" onclick="openCheckModal('modal2');closeModal('modal1')"> 탈퇴하기 </button>
													<button type="button" class="btn solid medium" data-v-43813796="" data-v-79f8507c="" data-v-0fdfe010="" modal="" onclick="closeModal('modal1')"> 취소하기 </button>
												</div>
											</div>
										</div>
									</div>
									<%-- 모달2 --%>
									<div class="layer_withdrawal layer lg" hidden data-v-0fdfe010="" data-v-79f8507c="" data-v-48e89bd9="" modal="" name="modal2">
										<div class="layer_container" data-v-0fdfe010="" modal="">
											<a href="#" class="btn_layer_close" data-v-0fdfe010="" data-v-79f8507c="" modal="">
<!-- 												<svg xmlns="http://www.w3.org/2000/svg" class="ico-close icon sprite-icons" data-v-0fdfe010="" data-v-79f8507c=""> -->
<!-- 													<use href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-close" xlink:href="/_nuxt/acb390973b7035ca670703769afdcb18.svg#i-ico-close" data-v-0fdfe010="" data-v-79f8507c=""></use> -->
<!-- 												</svg> -->
											</a>
											<div class="layer_header" data-v-0fdfe010="" modal="">
												<h2 class="title" data-v-0fdfe010="" data-v-79f8507c="" modal=""> 회원 탈퇴가 완료되었습니다. </h2>
											</div>
											<div class="layer_content" data-v-0fdfe010="" modal="">
												<p class="modal_desc" data-v-0fdfe010="" data-v-79f8507c="" modal="">그동안 서비스를 이용해 주셔서 감사합니다.<br>14일 후 ZERO을 다시 이용할 수 있습니다.</p>
												<div class="modal_btn_box" data-v-0fdfe010="" data-v-79f8507c="" modal="">
													<button type="button" class="btn outlinegrey medium" data-v-43813796="" data-v-79f8507c="" data-v-0fdfe010="" modal="" onclick="location.href='member_logout'"> 확인 </button>
												</div>
											</div>
										</div>
									</div>
									<%-- 모달3 --%>
									<div class="layer_withdrawal layer lg" hidden data-v-0fdfe010="" data-v-79f8507c="" data-v-48e89bd9="" modal="" name="modal3">
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
													탈퇴 불가한 회원입니다. 
												</h2>
											</div>
											<div class="layer_content" data-v-0fdfe010="" modal="">
												<p class="modal_desc unable_desc" data-v-0fdfe010="" data-v-79f8507c="" modal="">경매 판매중 또는 낙찰 중에는 탈퇴하실 수 없습니다.</p>
												<ul class="withdrawal_list" data-v-0fdfe010="" data-v-79f8507c="" modal=""></ul>
												<div class="modal_btn_box" data-v-0fdfe010="" data-v-79f8507c="" modal="">
													<button type="button" class="btn outlinegrey medium" data-v-43813796="" data-v-79f8507c="" data-v-0fdfe010="" modal="" onclick="history.back()"> 확인 </button>
												</div>
											</div>
										</div>
									</div>
									<%-- 모달4 --%>
									<div class="layer_withdrawal layer lg" hidden data-v-0fdfe010="" data-v-79f8507c="" data-v-48e89bd9="" modal="" name="modal4">
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
													탈퇴 동의 체크박스를 모두 체크해주십시오. 
												</h2>
											</div>
											<div class="layer_content" data-v-0fdfe010="" modal="">
												<p class="modal_desc unable_desc" data-v-0fdfe010="" data-v-79f8507c="" modal="">체크박스가 모두 체크되어있는지 확인해주십시오</p>
												<ul class="withdrawal_list" data-v-0fdfe010="" data-v-79f8507c="" modal=""></ul>
												<div class="modal_btn_box" data-v-0fdfe010="" data-v-79f8507c="" modal="">
													<button type="button" class="btn outlinegrey medium" data-v-43813796="" data-v-79f8507c="" data-v-0fdfe010="" modal="" onclick="closeModal('modal4')"> 확인 </button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
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