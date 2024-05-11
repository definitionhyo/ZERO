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
<!-- <link -->
<%-- 	href="${pageContext.request.contextPath }/resources/css/button.css" --%>
<!-- 	rel="stylesheet" type="text/css"> -->

	
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
.content_area[data-v-2b15bea4] {
    margin: 0 auto;
    padding: 60px 0 160px;
    width: 400px;
}


.container.my .content_area[data-v-473e7c14] {
    overflow: hidden;
    min-height: 380px;
}
*, :after, :before {
    box-sizing: border-box;
    -webkit-tap-highlight-color: rgba(0,0,0,0);
}
div {
    display: block;
    
}
body, button, input, select, table, textarea {
    font-family: Pretendard Variable,Pretendard,-apple-system,BlinkMacSystemFont,system-ui,Segoe UI,Roboto,Ubuntu,Cantarell,Noto Sans,sans-serif,Helvetica Neue,Apple SD Gothic Neo,Noto Sans KR,Malgun Gothic,Apple Color Emoji,Segoe UI Emoji,Segoe UI Symbol;
    color: #222;
    -webkit-font-feature-settings: "frac" 0,"numr" 0;
    font-feature-settings: "frac" 0,"numr" 0;
}

<%-- 프로필 관리 --%>
.lg .user_profile[data-v-4b474860], .md .user_profile[data-v-4b474860] {
    border-bottom: 1px solid #ebebeb;
}

.user_profile[data-v-4b474860] {
    display: flex;
    align-items: center;
    padding: 38px 0;
    background-color: #fff;
}

.title[data-v-88eb18f6] {
    font-size: 24px;
    letter-spacing: -.36px;
}

.title>h3[data-v-88eb18f6] {
    line-height: 29px;
    font-size: inherit;
}

h3 {
    display: block;
    font-size: 1.17em;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}

.content_title.border[data-v-88eb18f6] {
    padding-bottom: 16px;
    border-bottom: 3px solid #222;
}

<%-- 버튼 설정 --%>
.outlinegrey[data-v-43813796] {
    border: 1px solid #d3d3d3;
    color: rgba(34,34,34,.8);
}
.small[data-v-43813796], .xsmall[data-v-43813796] {
    font-size: 12px;
    letter-spacing: -.06px;
}
.small[data-v-43813796] {
    padding: 0 14px;
    height: 34px;
    border-radius: 10px;
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
    margin: 0 5px 0;
}

button {
    padding: 0;
    border: 0;
    outline: none;
    background: none;
    background-color: transparent;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    border-radius: 0;
}

.profile_btn_box .btn+.btn[data-v-4b474860] {
    margin-left: 8px;
}
<%-- 프로필 이미지 - 이름 --%>
.profile_btn_box[data-v-4b474860] {
    margin-top: 12px;
    font-size: 0;
}
.profile_detail .name[data-v-4b474860] {
    font-size: 18px;
    letter-spacing: -.27px;
    line-height: 1.2222222222;
    color: #000;
}


<%-- 프로필 정보 속성 --%>
.group_title[data-v-8b96a82e] {
    font-size: 18px;
    letter-spacing: -.27px;
}
h4 {
    display: block;
    margin-block-start: 1.33em;
    margin-block-end: 1.33em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}

<%-- 프로필 이름/이름/소개 설정 --%>
.title[data-v-0c9f3f9e] {
    font-size: 13px;
    letter-spacing: -.07px;
    font-weight: 400;
    color: rgba(34,34,34,.5);
}

h5 {
    display: block;
    font-size: 0.83em;
    margin-block-start: 1.67em;
    margin-block-end: 1.67em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
}
<%-- 영역 밑줄 설정 --%>
.unit[data-v-0c9f3f9e] {
    display: flex;
    flex-direction: column;
    padding: 25px 0 12px;
    position: relative;
    border-bottom: 1px solid #ebebeb;
}

<%-- 변경 영역 설정 --%>
.unit_content[data-v-0c9f3f9e] {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.desc_modify[data-v-e5372ca2] {
    padding-right: 58px;
}

.desc[data-v-24a03828] {
    flex: 1;
    padding-top: 8px;
    padding-bottom: 8px;
    font-size: 16px;
    letter-spacing: -.16px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}

body, button, dd, div, dl, dt, fieldset, figcaption, figure, form, h1, h2, h3, h4, h5, h6, input, legend, li, ol, p, select, table, td, textarea, th, ul {
    margin: 0;
    padding: 0;
}
<%-- 프로필 이미지 크기 지정 --%>
.thumb_img {
	width:100px;
	height:100px;
	border-radius: 50%;
	margin-right: 10px;
}


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

	<%-- 프로필 사진 변경 --%>
	function updateImage(obj) {
		 
		let profileForm = $('#profileForm')[0];  // 이녀석도 배열로 리턴이 된다.
		console.log(profileForm);
// 		let profileForm = obj.files;  // 이녀석도 배열로 리턴이 된다.
		if(profileForm.files == '') {
			alert('프로필 사진을 선택해 주세요');
		} else {
				
		    let formData = new FormData(profileForm);  // 폼의 모든 데이터를 가지고 있다.
			    
		    $.ajax({
		      type: "POST",
		      url: "${pageContext.request.contextPath }/ajax/profileUpdate",
		      contentType: false,  // x-www 으로 파싱하지 마라 
		      processData: false, // 쿼리스트링으로 파싱하지 마라
		      data: formData,
		      enctype: "multipart/form-data",
		      dataType: "text",
		      success: function(result){
// 		    	  alert(result);
		      },
		      error: function(err){
		    	  alert('프로필 등록 실패');
		      }
		    }).done((res) => {
	// 	      alert(res.msg);
		      location.reload();
		    });
		    
		}
		   
	}
	
	<%-- 이미지 이외의 정보 변경 --%>
	$(function(){
		
		$(".btn_update").on("click", function(){ // 삭제, 변경 버튼 클릭 시 
			var buttonName = $(this).attr("name");
			let column2;
			let value2; 
// 		    console.log("클릭한 버튼의 name 속성 값: " + buttonName);

			if(buttonName == 'profile_delete') { // 삭제 버튼 클릭 시
				column2 = 'member_image';
				value2 = null;
			} else {
				column2 = 'member_nickname';
				value2 = $("#member_nickname").val();
			}
			
			$.ajax({
			      type: "POST",
			      url: "/zero/ajax/profileUpdateInfo",
			      data: {
			    	  "column2":column2,
			    	  "value2":value2
			      },
			      dataType: "text",
			      success: function(result){
// 			    	  alert(result);
			      },
			      error: function(err){
			    	  alert('닉네임 중복으로 변경 실패');
			      }
			 }).done((res) => {
// 				  alert(res.msg);
			      location.reload();
			}); // ajax 끝

		}); // $(".btn_update") 온클릭 끝
		
	});
	
	
</script>

</head>
<body>
 <%--네비게이션 바 영역 --%>
	<header>
		<%@ include file="../inc/header.jsp"%>
	</header>
	
	<article id="mainArticle">
		<div class="container">
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
			</nav>
		
			<div class="contentArea">
			<%-- 메인영역 --%>
			

				<div  class=" my lg">
					<div >
			
					<%-- 본문 - 프로필 관리 --%>
						<div   class="content_area" data-v-2b15bea4="">
						<form action="user/profileUpdate" method="post" enctype="multipart/form-data" id="profileForm">
							<div data-v-75326462="" class="my_profile">
								<div data-v-88eb18f6="" data-v-75326462="" class="content_title">
									<div data-v-88eb18f6="" class="title">
										<h3 data-v-88eb18f6="">프로필 관리</h3>
									</div>
								</div>
								<div data-v-4b474860="" data-v-75326462="" class="user_profile">
									<input type="file" accept=".jpeg,.png" id="profile" name="profile" hidden="hidden" onchange="updateImage(this)">
									<div data-v-4b474860="" class="profile_thumb">
									<c:choose>
										<c:when test="${not empty member.member_image }">
											<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/upload/${member.member_image }" alt="사용자 이미지" class="thumb_img">
										</c:when>
										<c:otherwise>
											<img data-v-4b474860="" src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" alt="사용자 이미지" class="thumb_img">
										</c:otherwise>
									</c:choose>
									</div>
									<div data-v-4b474860="" class="profile_detail">
										<strong data-v-4b474860="" class="name">${member_id }</strong>
										<div data-v-4b474860="" class="profile_btn_box">
											<label for="profile">
												<div data-v-43813796="" data-v-4b474860="" class="btn outlinegrey small" >이미지 변경</div>
<!-- 												<button data-v-43813796="" data-v-4b474860="" type="button" class="btn outlinegrey small" >이미지 변경</button> -->
											</label>
											<button data-v-43813796="" data-v-4b474860="" type="button" class="btn outlinegrey small btn_update" id="profile_delete" name="profile_delete" data-data-v-4b474860=""> 삭제 </button>
										</div>
									</div>
								</div>
								<div data-v-75326462="" class="profile_info">
									<div data-v-8b96a82e="" data-v-75326462="" class="profile_group">
										<h4 data-v-8b96a82e="" class="group_title">프로필 정보</h4>
										<div data-v-0c9f3f9e="" data-v-e5372ca2="" data-v-75326462="" class="unit" data-v-8b96a82e="">
											<h5 data-v-0c9f3f9e="" class="title">닉네임</h5>
											<div data-v-0c9f3f9e="" class="unit_content">
<%-- 												<p data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify" data-v-0c9f3f9e=""> ${member.member_nickname } </p> --%>
												<input type="text" id="member_nickname" name="member_nickname" data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify" data-v-0c9f3f9e="" value="${member.member_nickname }" style="border:none;">
												<button data-v-43813796="" data-v-e5372ca2="" type="button" class="btn btn_modify outlinegrey small btn_update" data-v-0c9f3f9e="" name="member_nickname"> 변경 </button>
											</div>
										</div>
										<div data-v-0c9f3f9e="" data-v-e5372ca2="" data-v-75326462="" class="unit" data-v-8b96a82e="">
											<h5 data-v-0c9f3f9e="" class="title">이름</h5>
											<div data-v-0c9f3f9e="" class="unit_content">
												<p data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify" data-v-0c9f3f9e=""> ${member.member_name } </p>
<!-- 												<button data-v-43813796="" data-v-e5372ca2="" type="button" class="btn btn_modify outlinegrey small btn_update"  data-v-0c9f3f9e=""> 변경 </button> -->
											</div>
										</div>
										<div data-v-0c9f3f9e="" data-v-e5372ca2="" data-v-75326462="" class="unit" data-v-8b96a82e="">
											<h5 data-v-0c9f3f9e="" class="title">생일</h5>
											<div data-v-0c9f3f9e="" class="unit_content">
												<p data-v-24a03828="" data-v-e5372ca2="" class="desc desc_modify placeholder" data-v-0c9f3f9e="">${member.member_birth }  </p>
<!-- 												<button data-v-43813796="" data-v-e5372ca2="" type="button" class="btn btn_modify outlinegrey small btn_update" data-v-0c9f3f9e=""> 변경 </button> -->
											</div>
										</div>
									</div>
									<div data-v-8b96a82e="" data-v-75326462="" class="profile_group">
										<h4 data-v-8b96a82e="" class="group_title">신고내역</h4>
										<div data-v-0c9f3f9e="" data-v-75326462="" class="unit" data-v-8b96a82e="">
											<div data-v-0c9f3f9e="" class="unit_content">
												<p data-v-24a03828="" data-v-75326462="" class="desc" role="button" data-v-0c9f3f9e=""> 신고리스트 </p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div data-v-75326462="" class="v-portal" style="display: none;">
							</div>
							
						</form>	
						</div>
					</div>
				</div>
			</div>
		</div>
  </article>
  


  
  <div id="sieAds"></div>
  <%--페이지 하단 --%>
  <footer id="pageFooter"></footer>
  
  
  <%-- 스크립트 코드 --%>
<!--   <script src="/_nuxt/0fc2b9a.js" defer=""></script> -->
<!--   <script src="/_nuxt/c2849e3.js" defer=""></script> -->
<!--   <script src="/_nuxt/6d1f03a.js" defer=""></script> -->
<!--   <script src="/_nuxt/5402e5b.js" defer=""></script> -->
<!--   <script src="/_nuxt/31641e8.js" defer=""></script> -->
<!--   <link href="/_nuxt/css/6ca5ffb.css" rel="stylesheet" type="text/css"> -->
<!--   <link href="/_nuxt/css/caea5a4.css" rel="stylesheet" type="text/css"> -->
  
</body>