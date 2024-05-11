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



<!-- <meta data-n-head="ssr" charset="utf-8"><meta data-n-head="ssr" data-hid="description" name="description" content="한정판 거래의 FLEX, KICKS RULE EVERYTHING AROUND ME"><meta data-n-head="ssr" data-hid="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"><meta data-n-head="ssr" name="apple-mobile-web-app-title" content="KREAM"><meta data-n-head="ssr" name="application-name" content="KREAM"><meta data-n-head="ssr" name="msapplication-TileColor" content="#111111"><meta data-n-head="ssr" name="theme-color" content="#ffffff"><meta data-n-head="ssr" name="msapplication-config" content="/browserconfig.xml"><meta data-n-head="ssr" data-hid="google-site-verification" name="google-site-verification" content="n9xvZpoumVa_cedth9bLo1fgwQfIoGkw0Jmkray34FM"><meta data-n-head="ssr" data-hid="naver-site-verification" name="naver-site-verification" property="naver-site-verification" content="ecf6ec0ed503754fbcec5f8c0a1fa4e94297f425"><meta data-n-head="ssr" data-hid="twitter:card" name="twitter:card" property="twitter:card" content="summary_large_image"><meta data-n-head="ssr" data-hid="og:type" name="og:type" property="og:type" content="website"><meta data-n-head="ssr" data-hid="og:title" name="og:title" property="og:title" content="KREAM | 한정판 거래의 FLEX"><meta data-n-head="ssr" data-hid="og:description" name="og:description" property="og:description" content="한정판을 거래하는 가장 확실한 방법"><meta data-n-head="ssr" data-hid="og:image" name="og:image" property="og:image" content="https://kream.co.kr/images/index_og_kream.png"><meta data-n-head="ssr" data-hid="format-detection" name="format-detection" content="telephone=no"><link data-n-head="ssr" rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png"><link data-n-head="ssr" rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png"><link data-n-head="ssr" rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png"><link data-n-head="ssr" rel="manifest" href="/site.webmanifest"><link data-n-head="ssr" rel="mask-icon" href="/safari-pinned-tab.svg" color="#111111"><link data-n-head="ssr" rel="search" type="application/opensearchdescription+xml" href="/resources/opensearch.xml" title="KREAM | 한정판 거래의 FLEX"><link data-n-head="ssr" rel="preconnect" href="//kream-phinf.pstatic.net"><link data-n-head="ssr" rel="preconnect" href="https://www.googletagmanager.com"><link data-n-head="ssr" rel="preconnect" href="https://connect.facebook.net"><script async="" src="https://websdk.appsflyer.com?st=pba&amp;"></script><script async="" src="https://websdk.appsflyer.com?st=pba&amp;"></script><script async="" src="https://websdk.appsflyer.com?st=pba&amp;"></script><script async="" src="https://websdk.appsflyer.com?st=pba&amp;"></script><script async="" src="https://websdk.appsflyer.com?st=pba&amp;"></script><script async="" src="https://websdk.appsflyer.com?st=pba&amp;"></script><script type="text/javascript" async="" src="https://www.google-analytics.com/analytics.js"></script><script type="text/javascript" async="" src="https://www.googletagmanager.com/gtag/js?id=G-5LYDPM15LW&amp;l=dataLayer&amp;cx=c"></script><script type="text/javascript" async="" src="https://www.googletagmanager.com/gtag/js?id=UA-153398119-1&amp;l=dataLayer&amp;cx=c"></script><script async="" src="https://websdk.appsflyer.com?st=pba&amp;"></script><script src="https://connect.facebook.net/signals/config/740347893514718?v=2.9.111&amp;r=stable" async=""></script><script async="" src="https://connect.facebook.net/en_US/fbevents.js"></script><script data-n-head="ssr" type="application/ld+json">{"@context":"http://schema.org","@type":"Organization","name":"KREAM","url":"https://kream.co.kr/","logo":"https://kream.co.kr/images/logo.png","sameAs":["https://apps.apple.com/app/id1490580239","https://play.google.com/store/apps/details?id=com.fstudio.kream","https://www.instagram.com/kream.co.kr/","https://www.youtube.com/channel/UCHbInfTxnIbWlUFin7drigw"]}</script><link rel="preload" href="/_nuxt/0fc2b9a.js" as="script"><link rel="preload" href="/_nuxt/6d1f03a.js" as="script"><link rel="preload" href="/_nuxt/css/04c034c.css" as="style"><link rel="preload" href="/_nuxt/5402e5b.js" as="script"><link rel="preload" href="/_nuxt/css/6115a6e.css" as="style"><link rel="preload" href="/_nuxt/31641e8.js" as="script"><link rel="preload" href="/_nuxt/css/6ca5ffb.css" as="style"><link rel="preload" href="/_nuxt/c2849e3.js" as="script"><link rel="stylesheet" href="/_nuxt/css/04c034c.css"><link rel="stylesheet" href="/_nuxt/css/6115a6e.css"><link rel="stylesheet" href="/_nuxt/css/6ca5ffb.css"> -->
<!--   <style type="text/css"> /*# sourceMappingURL=contenteditable.vue.map */</style><style type="text/css">.vue-slider-dot{position:absolute;-webkit-transition:all 0s;transition:all 0s;z-index:5}.vue-slider-dot:focus{outline:none}.vue-slider-dot-tooltip{position:absolute;visibility:hidden}.vue-slider-dot-hover:hover .vue-slider-dot-tooltip,.vue-slider-dot-tooltip-show{visibility:visible}.vue-slider-dot-tooltip-top{top:-10px;left:50%;-webkit-transform:translate(-50%,-100%);transform:translate(-50%,-100%)}.vue-slider-dot-tooltip-bottom{bottom:-10px;left:50%;-webkit-transform:translate(-50%,100%);transform:translate(-50%,100%)}.vue-slider-dot-tooltip-left{left:-10px;top:50%;-webkit-transform:translate(-100%,-50%);transform:translate(-100%,-50%)}.vue-slider-dot-tooltip-right{right:-10px;top:50%;-webkit-transform:translate(100%,-50%);transform:translate(100%,-50%)}</style><style type="text/css">.vue-slider-marks{position:relative;width:100%;height:100%}.vue-slider-mark{position:absolute;z-index:1}.vue-slider-ltr .vue-slider-mark,.vue-slider-rtl .vue-slider-mark{width:0;height:100%;top:50%}.vue-slider-ltr .vue-slider-mark-step,.vue-slider-rtl .vue-slider-mark-step{top:0}.vue-slider-ltr .vue-slider-mark-label,.vue-slider-rtl .vue-slider-mark-label{top:100%;margin-top:10px}.vue-slider-ltr .vue-slider-mark{-webkit-transform:translate(-50%,-50%);transform:translate(-50%,-50%)}.vue-slider-ltr .vue-slider-mark-step{left:0}.vue-slider-ltr .vue-slider-mark-label{left:50%;-webkit-transform:translateX(-50%);transform:translateX(-50%)}.vue-slider-rtl .vue-slider-mark{-webkit-transform:translate(50%,-50%);transform:translate(50%,-50%)}.vue-slider-rtl .vue-slider-mark-step{right:0}.vue-slider-rtl .vue-slider-mark-label{right:50%;-webkit-transform:translateX(50%);transform:translateX(50%)}.vue-slider-btt .vue-slider-mark,.vue-slider-ttb .vue-slider-mark{width:100%;height:0;left:50%}.vue-slider-btt .vue-slider-mark-step,.vue-slider-ttb .vue-slider-mark-step{left:0}.vue-slider-btt .vue-slider-mark-label,.vue-slider-ttb .vue-slider-mark-label{left:100%;margin-left:10px}.vue-slider-btt .vue-slider-mark{-webkit-transform:translate(-50%,50%);transform:translate(-50%,50%)}.vue-slider-btt .vue-slider-mark-step{top:0}.vue-slider-btt .vue-slider-mark-label{top:50%;-webkit-transform:translateY(-50%);transform:translateY(-50%)}.vue-slider-ttb .vue-slider-mark{-webkit-transform:translate(-50%,-50%);transform:translate(-50%,-50%)}.vue-slider-ttb .vue-slider-mark-step{bottom:0}.vue-slider-ttb .vue-slider-mark-label{bottom:50%;-webkit-transform:translateY(50%);transform:translateY(50%)}.vue-slider-mark-label,.vue-slider-mark-step{position:absolute}</style><style type="text/css">.vue-slider{position:relative;-webkit-box-sizing:content-box;box-sizing:content-box;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;display:block;-webkit-tap-highlight-color:rgba(0,0,0,0)}.vue-slider-rail{position:relative;width:100%;height:100%;-webkit-transition-property:width,height,left,right,top,bottom;transition-property:width,height,left,right,top,bottom}.vue-slider-process{position:absolute;z-index:1}</style><script charset="utf-8" src="/_nuxt/6b9fce8.js"></script><script charset="utf-8" src="/_nuxt/bf9bb52.js"></script><script type="text/javascript" async="" src="https://wcs.naver.net/wcslog.js" id="naver-ads" data-loaded="true"></script><script src="https://www.googletagmanager.com/gtag/js?l=dataLayer&amp;id=G-SRFKTMTR0R" async=""></script><link rel="preload" as="style" href="/_nuxt/css/caea5a4.css"><script charset="utf-8" src="/_nuxt/ddc8c64.js"></script><meta http-equiv="origin-trial" content="AymqwRC7u88Y4JPvfIF2F37QKylC04248hLCdJAsh8xgOfe/dVJPV3XS3wLFca1ZMVOtnBfVjaCMTVudWM//5g4AAAB7eyJvcmlnaW4iOiJodHRwczovL3d3dy5nb29nbGV0YWdtYW5hZ2VyLmNvbTo0NDMiLCJmZWF0dXJlIjoiUHJpdmFjeVNhbmRib3hBZHNBUElzIiwiZXhwaXJ5IjoxNjk1MTY3OTk5LCJpc1RoaXJkUGFydHkiOnRydWV9"><meta http-equiv="origin-trial" content="AymqwRC7u88Y4JPvfIF2F37QKylC04248hLCdJAsh8xgOfe/dVJPV3XS3wLFca1ZMVOtnBfVjaCMTVudWM//5g4AAAB7eyJvcmlnaW4iOiJodHRwczovL3d3dy5nb29nbGV0YWdtYW5hZ2VyLmNvbTo0NDMiLCJmZWF0dXJlIjoiUHJpdmFjeVNhbmRib3hBZHNBUElzIiwiZXhwaXJ5IjoxNjk1MTY3OTk5LCJpc1RoaXJkUGFydHkiOnRydWV9"><meta data-n-head="ssr" name="robots" content="noindex"><meta data-n-head="ssr" data-hid="page-name" name="page-name" property="page-name" content="sign_in"><meta data-n-head="ssr" data-hid="Pragma" http-equiv="Pragma" content="no-cache"><meta data-n-head="ssr" data-hid="Expires" http-equiv="Expires" content="0"><meta data-n-head="ssr" data-hid="Cache-Control" http-equiv="Cache-Control" content="no-cache"><script data-n-head="ssr" src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script> -->
<!-- <style type="text/css">.vue-slider{position:relative;-webkit-box-sizing:content-box;box-sizing:content-box;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;display:block;-webkit-tap-highlight-color:rgba(0,0,0,0)}.vue-slider-rail{position:relative;width:100%;height:100%;-webkit-transition-property:width,height,left,right,top,bottom;transition-property:width,height,left,right,top,bottom}.vue-slider-process{position:absolute;z-index:1}</style> -->
<!-- <script charset="utf-8" src="/_nuxt/6b9fce8.js"></script> -->
<!-- <script charset="utf-8" src="/_nuxt/bf9bb52.js"></script> -->
<!-- <script type="text/javascript" async="" src="https://wcs.naver.net/wcslog.js" id="naver-ads" data-loaded="true"></script> -->
<!-- <script src="https://www.googletagmanager.com/gtag/js?l=dataLayer&amp;id=G-SRFKTMTR0R" async=""></script> -->
<!-- <link rel="preload" as="style" href="/_nuxt/css/caea5a4.css"> -->
<!-- <script charset="utf-8" src="/_nuxt/ddc8c64.js"></script> -->
<!-- <meta http-equiv="origin-trial" content="AymqwRC7u88Y4JPvfIF2F37QKylC04248hLCdJAsh8xgOfe/dVJPV3XS3wLFca1ZMVOtnBfVjaCMTVudWM//5g4AAAB7eyJvcmlnaW4iOiJodHRwczovL3d3dy5nb29nbGV0YWdtYW5hZ2VyLmNvbTo0NDMiLCJmZWF0dXJlIjoiUHJpdmFjeVNhbmRib3hBZHNBUElzIiwiZXhwaXJ5IjoxNjk1MTY3OTk5LCJpc1RoaXJkUGFydHkiOnRydWV9"> -->
<!-- <meta http-equiv="origin-trial" content="AymqwRC7u88Y4JPvfIF2F37QKylC04248hLCdJAsh8xgOfe/dVJPV3XS3wLFca1ZMVOtnBfVjaCMTVudWM//5g4AAAB7eyJvcmlnaW4iOiJodHRwczovL3d3dy5nb29nbGV0YWdtYW5hZ2VyLmNvbTo0NDMiLCJmZWF0dXJlIjoiUHJpdmFjeVNhbmRib3hBZHNBUElzIiwiZXhwaXJ5IjoxNjk1MTY3OTk5LCJpc1RoaXJkUGFydHkiOnRydWV9"> -->
<!-- <meta data-n-head="ssr" name="robots" content="noindex"> -->
<!-- <meta data-n-head="ssr" data-hid="page-name" name="page-name" property="page-name" content="sign_in"> -->
<!-- <meta data-n-head="ssr" data-hid="Pragma" http-equiv="Pragma" content="no-cache"> -->
<!-- <meta data-n-head="ssr" data-hid="Expires" http-equiv="Expires" content="0"> -->
<!-- <meta data-n-head="ssr" data-hid="Cache-Control" http-equiv="Cache-Control" content="no-cache"> -->
<!-- <script data-n-head="ssr" src="https://appleid.cdn-apple.com/appleauth/static/jsapi/appleid/1/en_US/appleid.auth.js"></script> -->


<title>중고거래 사이트</title>
<style>
</style>
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%>
<script type="text/javascript">
	$(function() {
		$("#btnAccountAuth").on("click", function() {
			// 새 창에서 사용자 인증 페이지 요청
			let requestUri = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
					+ "response_type=code"
					+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
					+ "&redirect_uri=http://localhost:8089/fintech/callback"
					+ "&scope=login inquiry transfer"
					+ "&state=12345678901234567890123456789012"
					+ "&auth_type=0";
			window.open(requestUri, "authWindow", "width=600, height=800");
		});
	});
</script>

</head>
<body>
 <%--네비게이션 바 영역 --%>
 <header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
 
  <%--본문내용 --%>
  <article id="mainArticle">

	<div data-v-473e7c14="" class="container my lg">
		<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
			<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
		</nav>
	
	
		<div data-v-473e7c14="" class="contentArea">

			<%-- 본문 - 계좌 관리 --%>
			<div  class="my_profile">
			<div data-v-67133191="" data-v-473e7c14="" class="content_area">
				<div data-v-67133191="" class="my_account">
					<div data-v-88eb18f6="" data-v-67133191="" class="content_title">
						<div data-v-88eb18f6="" class="title">
							<h3 data-v-88eb18f6="">계좌 등록</h3>
						</div>
					</div>
					<div data-v-028af65a="" data-v-67133191="" class="content_registration">
						<div data-v-028af65a="" class="account_registration">
							<div data-v-4e1fd2e6="" class="input_logistics_companies input_box">
								<h4 data-v-4e1fd2e6="" class="input_title">은행명</h4>
								<div data-v-4e1fd2e6="" class="input_item">
									<input data-v-4e1fd2e6="" type="text" placeholder="미등록" autocomplete="off" inputmode="numeric" class="input_txt" value="${member.zpay_bank_name }" readonly>
									<button data-v-43813796="" type="button" class="btn btn_dropdown" data-v-4e1fd2e6="">
<!-- 										<svg xmlns="http://www.w3.org/2000/svg" class="ico-arr-dir-down-circle icon sprite-icons"> -->
<!-- 											<use href="/_nuxt/54eaabd5a726b216f3c53922147167ee.svg#i-ico-arr-dir-down-circle" xlink:href="/_nuxt/54eaabd5a726b216f3c53922147167ee.svg#i-ico-arr-dir-down-circle"></use> -->
<!-- 										</svg> -->
									</button>
								</div>
							</div>
							<div data-v-4e1fd2e6="" class="input_box">
								<h4 data-v-4e1fd2e6="" class="input_title">계좌번호</h4>
								<div data-v-4e1fd2e6="" class="input_item">
									<input data-v-4e1fd2e6="" type="tel" placeholder="등록된 계좌정보가 없습니다" autocomplete="off" class="input_txt" value="${member.zpay_bank_account }" readonly>
								</div>
								<p data-v-4e1fd2e6="" class="input_error">올바른 계좌번호를 입력해주세요.</p>
							</div>
							<div data-v-4e1fd2e6="" class="input_box">
								<h4 data-v-4e1fd2e6="" class="input_title">예금주</h4>
								<div data-v-4e1fd2e6="" class="input_item">
									<input data-v-4e1fd2e6="" type="text" placeholder="예금주명" autocomplete="off" class="input_txt" value="${member.member_name }" readonly>
								</div>
								<p data-v-4e1fd2e6="" class="input_error">올바른 이름을 입력해주세요. (2-50자)</p>
							</div>
						</div>
						<div data-v-028af65a="" class="registration_btn_box">
							<c:choose>
								<c:when test="${member.member_bank_auth eq 'Y' }">
									<button id="btnAccountAuth" data-v-43813796="" data-v-028af65a="" href="#" class="btn btn_save solid medium"> 변경하기 </button>
								</c:when>
								<c:otherwise>
									<button id="btnAccountAuth" data-v-43813796="" data-v-028af65a="" href="#" class="btn btn_save solid medium"> 등록하기 </button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
					
		</div>
	</div>

  </article>
  
  <nav id="mainNav" class="d-none d-md-block sidebar">
  <%--왼쪽 사이드바 --%>
  		<%-- 마이페이지 사이드 --%>
<!--   		<div data-v-473e7c14="" class="container my lg"> -->
<!-- 			<div data-v-473e7c14="" class="snb_area"> -->
<!-- 				<a data-v-473e7c14="" href="/my" class="nuxt-link-active"> -->
<!-- 					<h2 data-v-473e7c14="" class="snb_main_title">마이 페이지</h2> -->
<!-- 				</a> -->
<!-- 				<nav data-v-7bcac446="" data-v-473e7c14="" class="snb"> -->
<!-- 					<div data-v-7bcac446="" class="snb_list"> -->
<!-- 						<strong data-v-7bcac446="" class="snb_title">쇼핑 정보</strong> -->
<!-- 						<ul data-v-bd8504ea="" data-v-7bcac446="" class="snb_menu"> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/buying" class="menu_link"> 구매 내역 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/selling" class="menu_link"> 판매 내역 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/inventory" class="menu_link"> 보관 판매 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/saved" class="menu_link"> 관심 상품 </a> -->
<!-- 							</li> -->
<!-- 						</ul> -->
<!-- 					</div> -->
<!-- 					<div data-v-7bcac446="" class="snb_list"> -->
<!-- 						<strong data-v-7bcac446="" class="snb_title">내 정보</strong> -->
<!-- 						<ul data-v-bd8504ea="" data-v-7bcac446="" class="snb_menu"> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/profile" class="menu_link"> 로그인 정보 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item menu_on"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/profile-edit" class="menu_link nuxt-link-exact-active nuxt-link-active" aria-current="page"> 프로필 관리 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/address" class="menu_link"> 주소록 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/payment" class="menu_link"> 결제 정보 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/account" class="menu_link"> 판매 정산 계좌 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/receipt" class="menu_link"> 현금영수증 정보 </a> -->
<!-- 							</li> -->
<!-- 							<li data-v-bd8504ea="" class="menu_item"> -->
<!-- 								<a data-v-bd8504ea="" href="/my/point" class="menu_link"> 포인트 </a> -->
<!-- 							</li> -->
<!-- 						</ul> -->
<!-- 					</div> -->
<!-- 				</nav> -->
<!-- 			</div> -->
<!-- 		</div> -->
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
  
</body>