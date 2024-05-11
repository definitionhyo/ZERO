<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jtsage-datebox-bootstrap4@5.3.3/jtsage-datebox.min.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/member.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">

<meta charset="UTF-8">
<title>ZERO</title>
<style>
<%-- 상점 프로필 상단 --%>
.eLimnD {
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
    background: rgb(255, 255, 255);
}

.gHsrAW {
    /* width: 1024px; */
    margin-top: 30px;
}

.efKeHO {
    display: flex;
    width: 100%;
}
<%-- 프로필 설정 --%>
.cpvyzS {
    width: 310px;
    height: 310px;
    position: relative;
    color: rgb(255, 255, 255);
}
.jhHppC {
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

.jBJukb {
    position: absolute;
    background-size: cover;
    background-repeat: no-repeat;
    z-index: 0;
    width: 100%;
    height: 100%;
    background-image: url(${pageContext.request.contextPath }/resources/mypage_img/store_bg.png);
    background-color: rgb(181, 181, 181);
}



<%-- 프로필 이미지 --%>
.bHnJBW {
    border-radius: 50%;
    margin-bottom: 15px;
    cursor: pointer;
}

img {
    vertical-align: bottom;
    border-style: none;
}

.dxKilp {
    font-size: 16px;
    margin-bottom: 10px;
}

.gIaRHa {
    display: flex;
}

<%-- 내상점관리 버튼 --%>
.jLHspK {
    display: flex;
    margin-top: 20px;
}

.hzlLUQ:first-child {
    margin-left: 0px;
}

.hzlLUQ {
    width: 106px;
    border: 1px solid rgb(255, 255, 255);
    color: rgb(255, 255, 255);
    height: 40px;
    display: flex;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    margin-left: 10px;
    font-size: 13px;
}

a {
    color: rgb(33, 33, 33);
    text-decoration: none;
    cursor: pointer;
}

a {
    background-color: transparent;
}

<%-- 상점명 탭 --%>
.hBpLcq {
    flex: 1 0 0%;
    padding: 0px 30px;
    border-top: 1px solid rgb(238, 238, 238);
    border-right: 1px solid rgb(238, 238, 238);
    border-bottom: 1px solid rgb(238, 238, 238);
    display: flex;
    height: 310px;
    flex-direction: column;
}

.fawuLi {
    font-size: 18px;
    height: 75px;
    font-weight: 600;
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    justify-content: space-between;
    flex-shrink: 0;
}
.fJiQAJ {
    display: flex;
    -webkit-box-align: center;
    align-items: center;
}

<%-- 상점명 수정 버튼 --%>
.fawuLi .sc-ecaExY {
    margin-left: 10px;
}

.cxNNaK {
    height: 20px;
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    padding: 0px 5px;
    color: rgb(136, 136, 136);
    border: 1px solid rgb(238, 238, 238);
    font-size: 11px;
}

button {
    background-color: transparent;
    cursor: pointer;
    outline: none;
}

button, input[type="text"], input[type="tel"], input[type="number"] {
    appearance: none;
}

button, input {
    padding: 0px;
    border: 0px;
}

body, input, textarea, select, button {
    font-synthesis: none;
    -webkit-font-smoothing: antialiased;
    direction: ltr;
    text-align: left;
    color: rgb(33, 33, 33);
    letter-spacing: -0.5px;
    outline: 0px;
    border: 0px;
}


<%-- 본인인증 완료 --%>
.hYzNdy {
    font-size: 11px;
    color: rgb(77, 77, 77);
    position: relative;
}
.hYzNdy::after {
    content: "OK";
    color: rgb(255, 255, 255);
    font-size: 9px;
    background: rgb(255, 195, 34);
    border-radius: 6px;
    position: absolute;
    padding: 2px 4px 1px;
    top: -1px;
    left: -25px;
}

<%-- 상점오픈일/상점방문수/상품판매/택배발송 --%>
.zhbnl {
    height: 45px;
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    border-top: 1px solid rgb(250, 250, 250);
    border-bottom: 1px solid rgb(250, 250, 250);
    margin-bottom: 20px;
    flex-shrink: 0;
}
.adWrx {
    margin-right: 30px;
    font-size: 13px;
    color: rgb(136, 136, 136);
    display: flex;
}
.adWrx > img {
    margin-right: 10px;
}

img {
    vertical-align: bottom;
}

img {
    border-style: none;
}

img[Attributes Style] {
    width: 14px;
    aspect-ratio: auto 14 / 13;
    height: 13px;
}

img {
    overflow-clip-margin: content-box;
    overflow: clip;
}

.dBzPWd {
    margin-left: 5px;
    color: rgb(33, 33, 33);
}

.czeXQe {
    -webkit-box-flex: 1;
    flex-grow: 1;
    width: 100%;
    overflow-y: auto;
    line-height: 1.57;
    white-space: pre-wrap;
}

.isYF {
    height: 56px;
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    flex-shrink: 0;
}

<%-- 상품/상점후기/찜/팔로잉/팔로워창 --%>
.lmEPCP {
    margin-bottom: 30px;
}

*, ::before, ::after {
    box-sizing: border-box;
}
user agent stylesheet
div {
    display: block;
}

.kcRaQl {
    display: flex;
    height: 50px;
}


.focus {
    border-left: 1px solid rgb(33, 33, 33);
    flex: 1 1 0%;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    display: flex;
    border-top: 1px solid rgb(33, 33, 33);
    border-right: 1px solid rgb(33, 33, 33);
    border-bottom: 1px solid rgb(255, 255, 255);
    background: rgb(255, 255, 255);
    color: rgb(33, 33, 33);
    font-weight: 600;
}

a {
    color: rgb(33, 33, 33);
    text-decoration: none;
    cursor: pointer;
}

.gtokyO {
    margin-left: 10px;
}

<%-- 선택안된 목록 --%>
.unfocus {
    flex: 1 1 0%;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    display: flex;
    border-top: 1px solid rgb(238, 238, 238);
    border-right: 1px solid rgb(238, 238, 238);
    border-bottom: 1px solid rgb(33, 33, 33);
    background: rgb(250, 250, 250);
    color: rgb(136, 136, 136);
}


a {
    color: rgb(33, 33, 33);
    text-decoration: none;
    cursor: pointer;
}

<%-- 상품탭 --%>
.khHtgc {
    font-size: 18px;
    padding: 50px 0px 20px;
    border-bottom: 1px solid rgb(238, 238, 238);
    display: flex;
    -webkit-box-pack: justify;
    justify-content: space-between;
}
.kmGPmj {
    color: rgb(247, 47, 51);
}

<%-- 상품 분류 목록 --%>
.inRpvj {
    width: 140px;
}
.ijiqeP {
    border: 1px solid rgb(238, 238, 238);
    display: flex;
    width: 100%;
    height: 28px;
    -webkit-box-align: center;
    align-items: center;
    position: relative;
    font-size: 12px;
    color: rgb(77, 77, 77);
    background: rgb(255, 255, 255);
}

.zWYgi {
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    padding: 0px 25px 0px 10px;
    position: relative;
    width: 100%;
}

.zWYgi img {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
}

.geECny {
    position: absolute;
    top: 27px;
    left: -1px;
    width: calc(100% + 2px);
    background: rgb(255, 255, 255);
    max-height: 280px;
    overflow-y: auto;
    z-index: 3;
    border-left: 1px solid rgb(238, 238, 238);
    border-bottom: 1px solid rgb(238, 238, 238);
    border-right: 1px solid rgb(238, 238, 238);
    display: none;
}

.buSjuK {
    width: 100%;
    height: 28px;
    padding: 0px 10px;
    display: flex;
    -webkit-box-align: center;
    align-items: center;
    color: rgb(247, 47, 51);
}

.ilUMhx {
    font-size: 13px;
    display: flex;
}

.cMlJLU {
    margin-right: 20px;
    position: relative;
    display: block;
    color: rgb(247, 47, 51);
}
.gYGcwB {
    margin-right: 20px;
    position: relative;
    display: block;
}

a {
    color: rgb(33, 33, 33);
    text-decoration: none;
    cursor: pointer;
    background-color: transparent;
}

.card-img-top {
    width: 250x;
    height: 300px;
}


.photoDiv {
	position: relative;
}
/* 거래상태 버튼 */
.dealStatus{
		font-size: 1.0rem;
		position: absolute;
		top: 263px;
		right: 0px;
		border-radius: 30%;
}
.card-text{
	text-align: center;
	margin-top: 5px;
}

.card-body{
	font-size:0.9rem;
}


/* 거래가능상품보기 라디오박스? */
.form-check {
	margin-bottom:10px;
	margin-left:10px;
}

/* 탭 css */
ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}

/* 가로로 긴 카드를 위한 커스텀 스타일 */
.custom-card {
    display: flex;
    flex-direction: row;
}

.image-container {
    flex: 1;
    max-width: 20%;
    padding: 10px;
    margin: auto; 
}

.image-container img {
    width: 100%;
    height: auto;
}

.text-container {
    flex: 3;
    max-width: 70%;
    padding: 10px;
}

.card-text {
	text-align: left;
}

.card-text-reverse {
	text-align: right;
}

.test_container2 {
	flex: 1;
    max-width: 10%;
    padding: 10px;
}
.card-text2 {
	text-align: center;
}

/* 마이스토어 */
.profile_area {
    position: inherit;
    display: flex;
    width: 100%;
    height: 100%;
    -webkit-box-pack: center;
    justify-content: center;
    -webkit-box-align: center;
    align-items: center;
    flex-direction: column;
    box-shadow: rgba(4, 0, 0, 0.03) 0px 5px 10px 0px;
}

.card-text-reverse {
    position: absolute;
    bottom: 20%;
    right: 5%;
    display: grid;
}


/* 작원 화면에서 마이스토어 프로필 이미지 히든 */
@media only screen and (max-width: 768px) {
	.profile_box{
		display: none;
}


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

// 	$.ajax({
// 	    type: "GET",
// 	    url: "/zero/ajax/profileUpdateInfo",
// 	    data: {
// 	  	  "column2":column2,
// 	  	  "value2":value2
// 	    },
// 	    dataType: "text",
// 	    success: function(result){
// 	//   	  alert(result);
// 	    },
// 	    error: function(err){
// 	  	  alert('닉네임 중복으로 변경 실패');
// 	    }
// 	}).done((res) => {
// 	//	  alert(res.msg);
// 	    location.reload();
// 	}); // ajax 끝
	var num_all = 0;
	
	
	$(function(){
		
		num_all = ${sellList.size()};
		$(".sec").empty();
		$(".sec").html(num_all);
		
		var auction_num = '${param.auction}';
		if(auction_num != '') {
			changeTab("sellAuction");
		} else {
			
			$("#sellSecondHand, #sellSecondHandReview, #sellAuction, #Like").on("click", function() {
		        var id = this.id; // 클릭된 탭의 아이디 변수 저장
		        changeTab(id);
		    });
		}
		
		
		
	});
	
	function changeTab(id){
		const tabs = ["sellSecondHand", "sellSecondHandReview", "sellAuction", "Like"];
		const divs = ["secondhandDiv", "ReviewDiv", "auctionDiv", "likeDiv"]
		const urls = ["ajax/mySecondhandList", "ajax/sell_secondhand_reviews", "ajax/sell_auctionList", "ajax/myLikeList"]
		const lists = ["sellList", "sellReviewList", "sellAuctionList", "likeList"];
		let url = "";
		let div = "";
		let listClass = "";
		value2='${member.member_id}';
		
		for(var i = 0; i < tabs.length; i++) {
			
			if(tabs[i] == id) {
				$("#" + tabs[i]).addClass('focus readonly').removeClass('unfocus');
				$("."+ divs[i]).removeClass('blind');
				url = urls[i];
				div = divs[i];
				listClass = lists[i];
			} else {
				$("#" + tabs[i]).removeClass('focus readonly').addClass('unfocus');
				$("."+ divs[i]).addClass('blind');
			}
		}
		
		console.log('선택된 탭 url:' + url);
		let html = ""; 
		var myList = []; // 비어있는 배열로 초기화
		
		$.ajax({
	 	    type: "GET",
	 	    url: url,
	 	    data: {
	 	  	  "column2": "member_id",
	 	  	  "member_id":value2
	 	    },
	 	    dataType: "json",
	 	    success: function(data){
	 	  	  console.log(data);
	 	  	  console.log();
	 	  	  
	 	  	  if(data == '') { // 리스트가 없는 경우
		 	  		if(url == urls[0]) {
// 						alert('중고판매 내용 없음');
					} else if(url == urls[1]) {
// 						alert('판매후기 내용 없음');
					} else if(url == urls[2]) {
// 						alert('경매 내용 없음');
					} else if(url == urls[3]) {
// 						alert('찜 내용 없음');
					}
	 	  	  } else { // 리스트가 있는 경우
				
				if(url == urls[0]) {
// 					alert('중고판매 내용 있음');
					num_all = 0;
					for (var i = 0; i < data.length; i++) {
						num_all += 1; 
		                var item = data[i];
		                var formatDate = item.secondhand_first_date.split('T');
		                console.log(item); // 각 항목을 콘솔에 출력하거나 원하는 방식으로 처리
		                html += '<div class="row">\
		                        <div class="col-lg-12">\
		                            <a class="col" href="secondhand_detail?secondhand_idx=' + item.secondhand_idx + '&member_id=' + item.member_id + '">\
		                                <div class="card custom-card">\
		                                    <div class="image-container">\
		                                        <img src="${pageContext.request.contextPath }/resources/upload/' + item.secondhand_image1  + '" alt="Image">\
		                                    </div>\
		                                    <div class="text-container">\
		                                        <div class="card-body">\
		                                            <h5 class="card-title">' + item.secondhand_subject  + '</h5>\
		                                            <div class="card-text sell_price">판매 가격 : ' + item.secondhand_price  + ' 원</div>\
		                                            <div class="card-text sell_date">판매 등록일 : ' + formatDate[0] + ' 일</div>';
		                                            
										                if(item.secondhand_deal_status != '판매중') {                            
										                	html +=   '<div class="card-text buyer">구매자 : ' + item.order_secondhand_buyer  + '</div>\
										                                            <div class="card-text delivery">거래방법 : ' + item.order_secondhand_type  + '</div>\
										                                            <div class="card-text commission">수수료 : ' + item.order_delivery_commission  + '</div>\
										                                            <div class="card-text commission">배송상태 : ' + item.zman_delivery_status  + '</div>';
										                }
										            html +=  '<div class="card-text-reverse"><div data-v-43813796="" class="btn outlinegrey deal_status">' + item.secondhand_deal_status  + '</div></div>\
		                                        </div>\
		                                    </div>\
		                                </div>\
		                            </a>\
		                        </div>\
		                    </div>';
		            }
					
					$("." + listClass).empty();
					$("." + listClass).html(html);
					$(".sec").empty();
					$(".sec").html(num_all);
					
					
				} else if(url == urls[1]) {
// 					alert('판매후기 내용 있음');
		            num_all = 0;
					
					// 리스트 데이터를 처리하고 출력하는 로직 작성
		            for (var i = 0; i < data.length; i++) {
		            	num_all += 1;
		            	var item = data[i];
		                var formatDate = item.member_reivew_date.split('T');
		                console.log(item); // 각 항목을 콘솔에 출력하거나 원하는 방식으로 처리
		                html += '<div class="row">\
		                        <div class="col-lg-12">\
		                        <a class="col" href="secondhand_detail?secondhand_idx=' + item.secondhand_idx + '&member_id=' + item.member_id + '">\
		                                <div class="card custom-card">\
		                                    <div class="image-container">\
		                                        <img src="${pageContext.request.contextPath }/resources/upload/' + item.secondhand_image1 + '" alt="Image">\
		                                    </div>\
		                                    <div class="text-container">\
		                                        <div class="card-body">\
		                                            <h5 class="card-title">판매상품 : ' + item.secondhand_subject + '</h5>\
		                                            <div class="card-text sell_price">작성자 : ' + item.review_writer_id + '</div>\
		                                            <div class="card-text sell_price">평점 : ' + item.member_review_rating + '</div>\
		                                            <div class="card-text sell_price">내용 : ' + item.member_review_content + '</div>\
		                                            <div class="card-text sell_date"><span>작성일자 : ' + formatDate[0] + '</span></div>\
		                                        </div>\
		                                    </div>\
		                                </div>\
		                            </a>\
		                        </div>\
		                    </div>';
		            }
					$("." + listClass).empty();
					$("." + listClass).html(html);
					$(".rev").empty();
					$(".rev").html(num_all);
					
				} else if(url == urls[2]) {
// 					alert('경매 내용 있음');
// 					var myList = data.myStore; // myList 변수에 리스트 데이터 저장
	            	num_all = 0;
		            
		            // 리스트 데이터를 처리하고 출력하는 로직 작성
		            for (var i = 0; i < data.length; i++) {
		            	num_all += 1;
		            	var item = data[i];
		                var formatDate = item.auction_regist_date.split('T');
		                console.log(item.auction_regist_date);
		                console.log(formatDate);
		                if(item.auction_start_datetime != null) { // 경매중일 경우
			                var formatDate1 = item.auction_start_datetime.split('T');
			                var formatDate2 = item.auction_end_datetime.split('T');
			                var floorNumber = Math.floor(item.order_auction_commission);
			                var dateTimeObject = new Date(item.auction_start_datetime);
			                var now = new Date();

			                
			                if(item.order_auction_buyer != null) { // 낙찰 완료시
			                	var formatDate3 = item.order_auction_deliver_date.split('T');
			                }
		                }
		                
		                console.log(item); // 각 항목을 콘솔에 출력하거나 원하는 방식으로 처리
		                html += '<div class="row">\
		                        <div class="col-lg-12">';
		                        if(dateTimeObject <= now) { // 경매중일 경우
			                        html += '<a class="col" href="auction_detail?id=' + item.auction_idx + '">';
		                        } else {
			                        html += '<a class="col" href="auction_prepare_detail?id=' + item.auction_idx + '">';
		                        };
		                        
		                        html += '<div class="card custom-card">\
		                                    <div class="image-container">\
		                                        <img src="${pageContext.request.contextPath }/resources/upload/' + item.auction_image1 + '" alt="Image">\
		                                    </div>\
		                                    <div class="text-container">\
		                                        <div class="card-body">\
		                                            <h5 class="card-title">' + item.auction_title + '</h5>\
		                                            <div class="card-text sell_price">시작가격 : ' + item.auction_start_price + ' 원</div>\
		                                            <div class="card-text sell_date"><span>경매 등록일 : ' + formatDate[0] + '일</span></div>';
		                                            
		                                   if(item.auction_start_datetime != null) {
		                                	   html += '<div class="card-text auction_start_date"><span>경매 시작일 : ' + formatDate1[0] + '일 ' + formatDate1[1] + '분</span></div>\
		                                	   			<div class="card-text auction_end_date"><span>경매 종료일 : ' + formatDate2[0] + '일 ' + formatDate2[1] + '분</span></div>';
		                                	   
		                                	   	if(item.order_auction_idx != null) {
		                                	   		html += '<div class="card-text sell_date"><span>낙찰자 : ' + item.order_auction_buyer + '</span></div>\
		                                	   				<div class="card-text sell_date"><span>낙찰금액 : ' + item.order_auction_price + '원</span></div>\
		                                	   				<div class="card-text sell_date"><span>경매수수료 : ' + floorNumber + '원</span></div>\
		                                	   				<div class="card-text sell_date"><span>배송사 : ' + item.order_auction_delivery_company + '</span></div>\
		                                	   				<div class="card-text sell_date"><span>배송일 : ' + formatDate3[0] + '일 ' + formatDate3[1] + '분</span></div>';
		                                	   	}
		                                	   		
		                                   }
		                                            
		                                            
		                                   html += '<div class="card-text-reverse"><div data-v-43813796="" class="btn outlinegrey deal_status">' + item.auction_manage_check_status + '</div>';
		                                   
		                                   if(item.order_auction_buyer != null) {
		                                	   html += '<div data-v-43813796="" class="btn solid deal_status">낙찰완료</div>';
		                                   }
		                                   
		                                   html += '</div>\
		                                        </div>\
		                                    </div>\
		                                </div>\
		                            </a>\
		                        </div>\
		                    </div>';
		            }
					$("." + listClass).empty();
					$("." + listClass).html(html);
					$(".auc").empty();
					$(".auc").html(num_all);
					
					
				} else if(url == urls[3]) {
// 					alert('찜 내용 있음');
					num_all = 0;
					
					for (var i = 0; i < data.length; i++) {
						num_all += 1;
						var item = data[i];
		                var formatDate = item.secondhand_first_date.split('T');
		                console.log(item); // 각 항목을 콘솔에 출력하거나 원하는 방식으로 처리
		                html += '<div class="row">\
		                        <div class="col-lg-12">\
		                            <a class="col" href="secondhand_detail?secondhand_idx=' + item.secondhand_idx + '&member_id=' + item.member_id + '">\
		                                <div class="card custom-card">\
		                                    <div class="image-container">\
		                                        <img src="${pageContext.request.contextPath }/resources/upload/' + item.secondhand_image1 + '" alt="Image">\
		                                    </div>\
		                                    <div class="text-container">\
		                                        <div class="card-body">\
		                                            <h5 class="card-title">' + item.secondhand_subject + '</h5>\
		                                            <div class="card-text sell_price">판매 가격 : ' + item.secondhand_price + ' 원</div>\
		                                            <div class="card-text sell_date">판매 등록일 : ' + formatDate[0]  + ' 일</div>\
		                                            <div class="card-text-reverse"><div data-v-43813796="" class="btn solid deal_status">' + item.secondhand_deal_status  + '</div></div>\
		                                        </div>\
		                                    </div>\
		                                </div>\
		                            </a>\
		                        </div>\
		                    </div>';
		            }
					$("." + listClass).empty();
					$("." + listClass).html(html);
					$(".lik").empty();
					$(".lik").html(num_all);
					
				}
	 	  		  
	 	  	  }
	 	  		  
	 	  		  
	 	    },
	 	    error: function(err){
	 	  	  alert('실패');
	 	    }
	 	}).done((res) => {
	 	//	  alert(res.msg);
// 	 	    location.reload();
	 	}); // ajax 끝
	
		
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
		
			<div data-v-473e7c14="" class="contentArea">
			<%-- 메인영역 --%>
			

				<div  class=" my lg">
					<div >
			
					<%-- 본문 - 스토어 관리 --%>
						<div class="content_area" data-v-2b15bea4="">
						<div class="sc-fAJaQT gHsrAW">
							<div class="sc-jotlie lmEPCP">
								<div class="sc-hRmvpr efKeHO">
								<%-- 프로필 박스 --%>
									<div class="profile_box">
										<div class="sc-iiUIRa fgbAbR">
											<div size="310" class="sc-hgRTRy cpvyzS">
												<div class="sc-cJOK jhHppC">
													<div class="sc-ccSCjj jBJukb"></div>
												</div>
												<div class="profile_area lg">
													<div class="profile_thumb" data-v-4b474860="" style="margin:0">
														<c:choose>
															<c:when test="${not empty member.member_image }">
																<img data-v-4b474860=""  src="${pageContext.request.contextPath }/resources/upload/${member.member_image }" alt="사용자 이미지" class="thumb_img sc-gldTML bHnJBW">
															</c:when>
															<c:otherwise>
																<img data-v-4b474860="" width="100px" height="100px"  src="${pageContext.request.contextPath }/resources/mypage_img/blank_profile.4347742.png" alt="사용자 이미지" class="thumb_img sc-gldTML bHnJBW">
															</c:otherwise>
														</c:choose>
													</div>
													<div class="sc-feryYK dxKilp">상점&nbsp;${member.member_idx }호</div>
													<div class="sc-eLdqWK gIaRHa">
														<img src="${pageContext.request.contextPath }/resources/mypage_img/blank_star.png" width="15" height="14" alt="작은 별점 0점 이미지">
														<img src="${pageContext.request.contextPath }/resources/mypage_img/blank_star.png" width="15" height="14" alt="작은 별점 0점 이미지">
														<img src="${pageContext.request.contextPath }/resources/mypage_img/blank_star.png" width="15" height="14" alt="작은 별점 0점 이미지">
														<img src="${pageContext.request.contextPath }/resources/mypage_img/blank_star.png" width="15" height="14" alt="작은 별점 0점 이미지">
														<img src="${pageContext.request.contextPath }/resources/mypage_img/blank_star.png" width="15" height="14" alt="작은 별점 0점 이미지">
													</div>
													<div class="sc-jKmXuR jLHspK">
														<a class="sc-jUpvKA hzlLUQ" href="member_profile">프로필 이동</a>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="sc-gbzWSY hBpLcq">
										<div class="sc-jqIZGH fawuLi">
											<div class="sc-jRuhRL fJiQAJ">상점&nbsp;${member.member_idx }호
<!-- 												<button class="sc-ecaExY cxNNaK">상점명 수정</button> -->
											</div>
											<div class="sc-eopZyb hYzNdy">본인인증 완료</div>
											</div>
										<div class="sc-jMMfwr zhbnl row">
											<div class="sc-jGxEUC adWrx col col-lg-4 col-md-12 col-sm-12">
												<img src="${pageContext.request.contextPath }/resources/mypage_img/shop.png" width="24" height="24" alt="상점오픈일 아이콘">상점오픈일
												<div class="sc-jdeSqf dBzPWd">${member.member_date } 일</div>
											</div>
<!-- 											<div class="sc-jGxEUC adWrx col col-lg-3 col-sm-6"> -->
<!-- 												<img src="/pc-static/resource/e6792c64a6ba6f2b10a2.png" width="14" height="13" alt="상점방문수 아이콘">상점방문수 -->
<!-- 												<div class="sc-jdeSqf dBzPWd">1 명</div> -->
<!-- 											</div> -->
											<div class="sc-jGxEUC adWrx col col-lg-3 col-md-12 col-sm-12">
												<img src="${pageContext.request.contextPath }/resources/mypage_img/sell.png" width="24" height="24" alt="상품판매 아이콘">상품판매
												<div class="sc-jdeSqf dBzPWd">0 회</div>
											</div>
											<div class="sc-jGxEUC adWrx col col-lg-3 col-md-12 col-sm-12">
												<img src="${pageContext.request.contextPath }/resources/mypage_img/shipped.png" width="24" height="24" alt="상퓸발송 아이콘">택배발송
												<div class="sc-jdeSqf dBzPWd">0 회</div>
											</div>
										</div>
										<div class="sc-fkyLDJ isYF row">
											<div class="sc-cBrjTV czeXQe col col-lg-12 col-sm-12">${member.member_intro }</div>
<!-- 											<button class="sc-ecaExY cxNNaK">소개글 수정</button> -->
										</div>
									</div>
								</div>
							</div>
							<%-- 탭 목록 --%>
							<div class="sc-cNnxps cdXYEZ">
								<div class="sc-eMRERa ebVkwH">
									<div class="sc-RbTVP kcRaQl">
<!-- 										<a class="focus" href="/ajax/sell_secondhandList" id="sellSecondHand">중고 판매 -->
<!-- 										<a class="focus readonly" id="sellSecondHand">중고 판매 -->
										<a class="focus readonly" id="sellSecondHand" href="member_mystore">중고 판매
<!-- 											<span class="sc-bIqbHp gtokyO">1</span> -->
											<span class="sc-bIqbHp gtokyO"></span>
										</a>
<!-- 										<a class=" unfocus" href="/ajax/sell_secondhand_reviews" id="sellSecondHandReview">판매후기  -->
										<a class=" unfocus" id="sellSecondHandReview">판매후기 
<!-- 											<span class="sc-bIqbHp gtokyO">0</span> -->
											<span class="sc-bIqbHp gtokyO"></span>
										</a>
<!-- 										<a class=" unfocus" href="/ajax/sell_auctionList" id="sellAuction">경매 -->
										<a class=" unfocus" id="sellAuction">경매
<!-- 											<span class="sc-bIqbHp gtokyO">3</span> -->
											<span class="sc-bIqbHp gtokyO"></span>
										</a>
<!-- 										<a class=" unfocus" href="/ajax/myLikeList" id="Like">찜  -->
										<a class=" unfocus" id="Like">찜 
<!-- 											<span class="sc-bIqbHp gtokyO">0</span> -->
											<span class="sc-bIqbHp gtokyO"></span>
										</a>
									</div>
								</div>
								<div class="sc-eqPNPO crpdHA">
								<%-- 상품 목록 --%>
									<div class="secondhandDiv">
										<div class=" khHtgc">
											<div>중고 판매&nbsp;
<!-- 												<span class=" kmGPmj">1</span> -->
												<span class=" kmGPmj sec">
												</span>
											</div>
											<div class="inRpvj">
<!-- 											<div class="sc-erNlkL ijiqeP"> -->
<!-- 												<div class="sc-iuDHTM zWYgi">전체 -->
<!-- 													<img src="/pc-static/resource/9b606ef2e7d57fafa657.png" width="10" height="6" alt="카테고리 화살표 아이콘"> -->
<!-- 												</div> -->
<!-- 												<div class="sc-FQuPU iDlcuM"> -->
			<!-- 										<a class="sc-kEmuub cohUeK">전체</a> -->
			<!-- 										<a class="sc-kEmuub zPWkt">키덜트</a> -->
													<select class="form-control" id="secondhandSelect">
														<option value="전체">전체</option>
														<option value="판매중">판매중</option>
														<option value="예약중">예약중</option>
														<option value="판매완료">판매완료</option>
													</select>
<!-- 												</div> -->
<!-- 											</div> -->
											</div>
										</div>
										<%-- 중고 판매 목록 리스트 --%>
										<div class="sellList">
										<c:if test="${empty sellList}">판매 내역이 없습니다.</c:if>
											<c:forEach var="sell" items="${sellList }">
												<div class="row">
											        <div class="col-lg-12">
												            <div class="card custom-card">
												                <!-- 이미지 영역 -->
												                <div class="image-container">
												                    <img src="${pageContext.request.contextPath }/resources/upload/${sell.secondhand_image1}" alt="Image">
												                </div>
												                <!-- 설명글 영역 -->
												                <div class="text-container">
												                    <div class="card-body">
																        <a class="col" href="secondhand_detail?secondhand_idx=${sell.secondhand_idx }&member_id=${sell.member_id}">
												                        <h5 class="card-title">${sell.secondhand_subject}</h5>
																		<div class="card-text sell_price">등록가격 : ${sell.secondhand_price} 원</div>
																		<div class="card-text sell_date"><span>등록일 : ${fn:split(sell.secondhand_first_date, 'T')[0]} 일</span></div>
		                                            					<c:choose>
		                                            						<c:when test="${sell.secondhand_deal_status eq '판매중'}">
									                                            <div class="card-text delivery"><span>거래방법 : ${sell.secondhand_deliverytype_ptp} ${sell.secondhand_deliveryType_parcel} ${sell.secondhand_deliveryType_zman } </span></div>
				                                            					<div class="card-text commission"><span>결제방법 : ${sell.secondhand_paymentType_ptp} ${sell.secondhand_paymentType_zpay}</span></div>
		                                            						</c:when>
		                                            						<c:when test="${sell.secondhand_deal_status eq '예약중'}">
									         									<div class="card-text buyer">구매자 : ${sell.order_secondhand_buyer  }</div>
									                                            <div class="card-text delivery"><span>거래방법 : ${sell.order_secondhand_type}</span></div>
				                                            						
			                                            						<c:if test="${not empty sell.zman_delivery_status}">
										                                            <div class="card-text status"><span>배송상태 : ${sell.zman_delivery_status}</span></div>
										                                            <div class="card-text status"><span>담당Z맨 : ${sell.zman_id}</span></div>
										                                            <div class="card-text status"><span>담당Z맨 : ${sell.zman_id}</span></div>
					                                            					<div class="card-text commission"><span>수수료 : ${sell.order_delivery_commission} 원</span></div>
										                                            <div class="card-text status"><span>출발지 : ${sell.zman_delivery_startspot}</span></div>
										                                            <div class="card-text status"><span>도착지 : ${sell.zman_delivery_endspot}</span></div>
			                                            						</c:if>
		                                            						</c:when>
																			<c:when test="${sell.secondhand_deal_status eq '판매완료'}">
									         									<div class="card-text buyer">구매자 : ${sell.order_secondhand_buyer  }</div>
									                                            <div class="card-text delivery"><span>거래방법 : ${sell.order_secondhand_type}</span></div>
				                                            					<div class="card-text commission"><span>거래완료일 : ${fn:split(sell.order_secondhand_date, 'T')[0]} 일</span></div>
				                                            						
			                                            						<c:if test="${not empty sell.zman_delivery_status}">
										                                            <div class="card-text status"><span>배송상태 : ${sell.zman_delivery_status}</span></div>
										                                            <div class="card-text status"><span>담당Z맨 : ${sell.zman_id}</span></div>
					                                            					<div class="card-text commission"><span>수수료 : ${sell.order_delivery_commission} 원</span></div>
										                                            <div class="card-text status"><span>출발지 : ${sell.zman_delivery_startspot}</span></div>
										                                            <div class="card-text status"><span>도착지 : ${sell.zman_delivery_endspot}</span></div>
			                                            						</c:if>
		                                            						</c:when>
		                                            					</c:choose>
																        </a>
							                                            <div class="card-text-reverse">
								                                            <div data-v-43813796="" class="btn solid deal_status">${sell.secondhand_deal_status}</div>
								                                            <div data-v-43813796="" class="btn outlinegrey deal_status">글 삭제</div>
								                                            <c:if test="${sell.secondhand_deal_status eq '판매완료'}">
								                                            <div data-v-43813796="" class="btn outlinegrey deal_status">후기 등록</div>
								                                            </c:if>
							                                            </div>
												                    </div>
												                    <div class="card-body2">
												                    	
												                    </div>
												                </div>
												            </div>
											        </div>
											    </div>
											    <br>
											</c:forEach>
										</div>
									</div>
									<%-- 판매 후기 --%>
									<div class="ReviewDiv blind">
										<div class=" khHtgc">
											<div>판매 후기&nbsp;
<!-- 												<span class="sc-keFjpB edhbau">0</span> -->
												<span class="kmGPmj rev"></span>
											</div>
										</div>
										<br>
										<div class="sellReviewList">등록된 판매후기가 없습니다.</div>
										<div class="sc-ekkqgF cTdzXF">
<!-- 													<a class="sc-iBmynh gjtVmz">최신순</a> -->
<!-- 													<a class="sc-iBmynh iHPPlM">인기순</a> -->
<!-- 													<a class="sc-iBmynh iHPPlM">저가순</a> -->
<!-- 													<a class="sc-iBmynh iHPPlM">고가순</a> -->
										</div>
										<div class="sc-fKGOjr ffOQYS"></div>
									</div>
									<%-- 경매 목록 --%>
									<div class="auctionDiv blind">
										<div class=" khHtgc">
											<div>경매 판매&nbsp;
<!-- 												<span class=" ">0</span> -->
												<span class="kmGPmj auc"></span>
											</div>
											<div class="inRpvj">
												<select class="form-control" id="auctionSelect">
													<option value="전체">전체</option>
													<option value="판매중">검수중</option>
													<option value="예약중">검수완료</option>
													<option value="판매완료">판매완료</option>
												</select>
											</div>
										</div>
										<br>
										<div class="sellAuctionList">경매 내역이 없습니다.</div>
									</div>
									<%-- 찜 목록 --%>
									<div class="likeDiv blind">
										<div class=" ">
											<div class=" khHtgc">
												<div>찜 목록&nbsp;
<!-- 													<span class="sc-bOCYYb jGomlc">0</span> -->
													<span class="kmGPmj lik"></span>
												</div>
											</div>
											<br>
											<div class="likeList">
												찜 목록이 없습니다.
												</div>
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
		</div>
	</article>
	
  <footer id="pageFooter">
		<%@ include file="../inc/footer.jsp"%>
	</footer>
</body>
</html>