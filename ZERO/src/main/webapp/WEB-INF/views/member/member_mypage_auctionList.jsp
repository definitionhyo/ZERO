<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
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



<meta charset="UTF-8">
<title>ZERO</title>

<!-- 후기작성하기 글씨 변경 -->  
<style type="text/css">
.last_title, .secondary_title {
      font-size: 14px; /* 원하는 글자 크기로 변경하세요 (예: 14px) */
    }

/* 평점 별 css */
#myform fieldset {
  display: inline-block;
  border: 0;
}
#myform fieldset legend {
  text-align: right;
}
#myform input[type="radio"] {
  display: none;
}
#myform label {
  font-size: 3em;
  color: transparent;
  text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover {
  color: rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label {
  color: transparent;
}
#myform input[type="radio"]:checked ~ label {
  color: transparent;
}
#myform input[type="radio"]:checked + label {
  color: rgba(250, 208, 0, 0.99);
}
#reviewContents {
  width: 100%;
  height: 150px;
  padding: 10px;
  box-sizing: border-box;
  border: solid 1.5px #d3d3d3;
  border-radius: 5px;
  font-size: 16px;
  resize: none;
}

h3[data-v-88eb18f6]::after { /* 이 부분 추가 */
    content: '';
    display: block;
    width: 100%;
    height: 3px; /* 여기서 높이 값을 새로운 크기로 변경하세요 */
    background-color: black;
    margin-top: 10px;
}    
   
.sidebar {
  margin-top: 21px;
}   
    
#mainArticle {
  margin-top: 10px;
}
    
</style>


</head>
<body>
	<%--네비게이션 바 영역 --%>
	<header id="pageHeader"><%@ include file="../inc/header.jsp"%></header>
	
	<article>
		<div class="container">
			<%-- 사이드바 --%>
			<nav id="mainNav" class="sidebarArea d-none d-md-block sidebar">
				<jsp:include page="/WEB-INF/views/inc/member_sidebar_hyo.jsp"></jsp:include>
			</nav>
			<div class="contentArea">
			<%-- 메인영역 --%>
			<article id="mainArticle">
				<div class="my_participateAuction">
					<div class="content_title" data-v-88eb18f6="">
						<div class="title" data-v-88eb18f6="">
							<h3 data-v-88eb18f6="">참가중인 경매</h3>
							<!---->
						</div>
						<!---->
					</div>
			<!-- 참가중인 경매 없을때 -->
				<c:if test="${empty participateAuction }">
				<div data-v-412d8616="" class="recent_purchase">
					<div data-v-412d8616="">
						<div data-v-7a02263e="" data-v-412d8616=""
							class="purchase_list all ask">
							<!---->
							<div data-v-6abf8c64="" data-v-7a02263e="" class="empty_area">
								<p data-v-6abf8c64="" class="desc">구매 내역이 없습니다.</p>
								<!---->
							</div>
							<div data-v-7a02263e="" class="v-portal" style="display: none;"></div>
						</div>
						<!---->
					</div>
				</div>
				</c:if>
				
				<!-- 참가중인 경매 있을때 -->
				 <c:if test="${not empty participateAuction }">
		                        <div data-v-412d8616="" class="recent_purchase">
		                            <div data-v-412d8616="">
		                                <div data-v-7a02263e="" data-v-412d8616=""
		                                    class="purchase_list all bid">
		                                    <!---->
		                                    <div data-v-7a02263e="">
		                                        <div data-v-e5d3a8ae="" data-v-7a02263e="">
		                                            <c:forEach var="participateAuction" items="${participateAuction }">
		                                                <div style="position: relative;">
		                                                    <div data-v-e5d3a8ae=""
		                                                         class="purchase_list_display_item"
		                                                         style="background-color: rgb(255, 255, 255); cursor: pointer;"
		                                                         onclick="location.href='auction_detail?id=${participateAuction.auction_idx}'">
		                                                        <div data-v-e5d3a8ae="" class="purchase_list_product">
		                                                            <div data-v-e5d3a8ae="" class="list_item_img_wrap">
		                                                                <img data-v-e5d3a8ae="" alt="participateAuction_image"
		                                                                     src="${pageContext.request.contextPath }/resources/upload/${participateAuction.auction_image1 }"
		                                                                     class="list_item_img"
		                                                                     style="background-color: rgb(244, 244, 244);">
		                                                                <!---->
		                                                            </div>
		                                                            <div data-v-e5d3a8ae="" class="list_item_title_wrap">
		                                                                <!---->
		                                                                <p data-v-e5d3a8ae="" class="list_item_title">${participateAuction.auction_title}</p>
		                                                            </div>
		                                                        </div>
		                                                        <div data-v-e5d3a8ae="" class="list_item_status">
		                                                            <div data-v-e5d3a8ae=""
		                                                                 class="list_item_column column_secondary">
		                                                                <p data-v-7b1f182e="" data-v-e5d3a8ae=""
		                                                                   class="secondary_title display_paragraph"
		                                                                   style="color: rgba(34, 34, 34, 0.5);"></p>
		                                                            </div>
		                                                            <div data-v-e5d3a8ae="" class="list_item_column column_last">
		                                                                <p data-v-7b1f182e="" data-v-e5d3a8ae=""
		                                                                   class="last_title display_paragraph"
		                                                                   style="color: rgb(34, 34, 34);">현재 입찰 금액 : ${participateAuction.auction_now_price }원</p>
		                                                            </div>
		                                                        </div>
		                                                    </div>
		                                                </div>
		                                            </c:forEach>
		                                            <!---->
		                                        </div>
		                                    </div>
		                                    <!---->
		                                    <div data-v-7a02263e="" class="v-portal" style="display: none;"></div>
		                                </div>
		                                <!---->
		                            </div>
		                        </div>
		                    </c:if>
		                    <!---->
		                </div>
                		<br><br><br>
                		
						<div class="my_successAuction">
							<div class="content_title" data-v-88eb18f6="">
								<div class="title" data-v-88eb18f6="">
									<h3 data-v-88eb18f6="">낙찰받은 경매</h3>
									<!---->
								</div>
								<!---->
							</div>
					<!-- 낙찰받은 경매 없을때 -->
						<c:if test="${empty successBid }">
						<div data-v-412d8616="" class="recent_purchase">
							<div data-v-412d8616="">
								<div data-v-7a02263e="" data-v-412d8616=""
									class="purchase_list all ask">
									<!---->
									<div data-v-6abf8c64="" data-v-7a02263e="" class="empty_area">
										<p data-v-6abf8c64="" class="desc">구매 내역이 없습니다.</p>
										<!---->
									</div>
									<div data-v-7a02263e="" class="v-portal" style="display: none;"></div>
								</div>
								<!---->
							</div>
						</div>
						</c:if>
						
						<!-- 낙찰받은 경매 있을때 -->
						 <c:if test="${not empty successBid }">
	                        <div data-v-412d8616="" class="recent_purchase">
	                            <div data-v-412d8616="">
	                                <div data-v-7a02263e="" data-v-412d8616=""
	                                    class="purchase_list all bid">
	                                    <!---->
	                                    <div data-v-7a02263e="">
	                                        <div data-v-e5d3a8ae="" data-v-7a02263e="">
	                                            <c:forEach var="successBid" items="${successBid }">
	                                                <div style="position: relative;">
	                                                    <div data-v-e5d3a8ae=""
	                                                         class="purchase_list_display_item"
	                                                         style="background-color: rgb(255, 255, 255); cursor: pointer;"
	                                                         onclick="location.href='auction_detail?id=${successBid.auction_idx}'">
	                                                        <div data-v-e5d3a8ae="" class="purchase_list_product">
	                                                            <div data-v-e5d3a8ae="" class="list_item_img_wrap">
	                                                                <img data-v-e5d3a8ae="" alt="participateAuction_image"
	                                                                     src="${pageContext.request.contextPath }/resources/upload/${successBid.auction_image1 }"
	                                                                     class="list_item_img"
	                                                                     style="background-color: rgb(244, 244, 244);">
	                                                                <!---->
	                                                            </div>
	                                                            <div data-v-e5d3a8ae="" class="list_item_title_wrap">
	                                                                <!---->
	                                                                <p data-v-e5d3a8ae="" class="list_item_title">${successBid.auction_title}</p>
	                                                            </div>
	                                                        </div>
	                                                        <div data-v-e5d3a8ae="" class="list_item_status">
	                                                            <div data-v-e5d3a8ae=""
	                                                                 class="list_item_column column_secondary">
	                                                                <p data-v-7b1f182e="" data-v-e5d3a8ae=""
	                                                                   class="secondary_title display_paragraph"
	                                                                   style="color: rgba(34, 34, 34, 0.5);"></p>
	                                                            </div>
	                                                            <div data-v-e5d3a8ae="" class="list_item_column column_last">
	                                                                <p data-v-7b1f182e="" data-v-e5d3a8ae=""
	                                                                   class="last_title display_paragraph"
	                                                                   style="color: rgb(34, 34, 34);">낙찰 받은 금액 : ${successBid.auction_final_price }원</p>
	                                                                <button onclick="auction_success_cancel(event)">낙찰 취소</button>
	                                                            </div>
	                                                        </div>
	                                                    </div>
	                                                </div>
	                                            </c:forEach>
	                                            <!---->
	                                        </div>
	                                    </div>
	                                    <!---->
	                                    <div data-v-7a02263e="" class="v-portal" style="display: none;"></div>
	                                </div>
	                                <!---->
	                            </div>
	                        </div>
	                    </c:if>
		                    <!---->
		                </div>
<%-- 						 <c:if test="${not empty successBid }"> --%>
<!-- 				                        <div data-v-412d8616="" class="recent_purchase"> -->
<!-- 				                            <div data-v-412d8616=""> -->
<!-- 				                                <div data-v-7a02263e="" data-v-412d8616="" -->
<!-- 				                                    class="purchase_list all bid"> -->
<!-- 				                                    -->
<!-- 				                                    <div data-v-7a02263e=""> -->
<!-- 				                                        <div data-v-e5d3a8ae="" data-v-7a02263e=""> -->
<%-- 				                                            <c:forEach var="successBid" items="${successBid }"> --%>
<!-- 				                                                <div style="position: relative;"> -->
<!-- 				                                                    <div data-v-e5d3a8ae="" -->
<!-- 				                                                         class="successBid_list_display_item" -->
<!-- 				                                                         style="background-color: rgb(255, 255, 255); cursor: pointer;" -->
<%-- 				                                                         onclick="location.href='auction_detail?id=${successBid.auction_idx}'"> --%>
<!-- 				                                                        <div data-v-e5d3a8ae="" class="purchase_list_product"> -->
<!-- 				                                                            <div data-v-e5d3a8ae="" class="list_item_img_wrap"> -->
<!-- 				                                                                <img data-v-e5d3a8ae="" alt="myOdShList_image" -->
<%-- 				                                                                     src="${pageContext.request.contextPath }/resources/upload/' + successBid.auction_image1 + '" --%>
<!-- 				                                                                     class="list_item_img" -->
<!-- 				                                                                     style="background-color: rgb(244, 244, 244);"> -->
<!-- 				                                                                -->
<!-- 				                                                            </div> -->
<!-- 				                                                            <div data-v-e5d3a8ae="" class="list_item_title_wrap"> -->
<!-- 				                                                                -->
<%-- 				                                                                <p data-v-e5d3a8ae="" class="list_item_title">${successBid.auction_title}</p> --%>
<!-- 				                                                            </div> -->
<!-- 				                                                        </div> -->
<!-- 				                                                        <div data-v-e5d3a8ae="" class="list_item_status"> -->
<!-- 				                                                            <div data-v-e5d3a8ae="" -->
<!-- 				                                                                 class="list_item_column column_secondary"> -->
<!-- 				                                                                <p data-v-7b1f182e="" data-v-e5d3a8ae="" -->
<!-- 				                                                                   class="secondary_title display_paragraph" -->
<%-- 				                                                                   style="color: rgba(34, 34, 34, 0.5);">${successBid.auction_manage_check_date }</p> --%>
<!-- 				                                                            </div> -->
<!-- 				                                                            <div data-v-e5d3a8ae="" class="list_item_column column_last"> -->
<!-- 				                                                                <p data-v-7b1f182e="" data-v-e5d3a8ae="" -->
<!-- 				                                                                   class="last_title display_paragraph" -->
<%-- 				                                                                   style="color: rgb(34, 34, 34);">${successBid.auction_final_price }</p> --%>
<!-- 				                                                            </div> -->
<!-- 				                                                        </div> -->
<!-- 				                                                    </div> -->
<!-- 				                                                </div> -->
<%-- 				                                            </c:forEach> --%>
<!-- 				                                            -->
<!-- 				                                        </div> -->
<!-- 				                                    </div> -->
<!-- 				                                    -->
<!-- 				                                    <div data-v-7a02263e="" class="v-portal" style="display: none;"></div> -->
<!-- 				                                </div> -->
<!-- 				                                -->
<!-- 				                            </div> -->
<!-- 				                        </div> -->
<%-- 				                    </c:if> --%>
				                    <!---->
				                </div>
            </article>
        </div>
    </div>
</article>

<!-- 리뷰쓰기 모달 -->
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="reviewModalLabel">New message</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="review-form" action="member_buyList_review" method="post">
        	 <input type="hidden" name="review_writer_id" id="review_writer_id"> 
        	 <input type="hidden" name="review_reader_id" id="review_reader_id"> 
        	 <input type="hidden" name="order_secondhand_idx" id="order_secondhand_idx"> 
        	 <input type="hidden" name="member_review_rating" id="member_review_rating"> 
<!--         	 <input type="hidden" name="member_review_content" id="member_review_content">  -->
            <div class="form-group">
            <fieldset id="myform" name="member_review_rating">
			  <span class="text-bold">별점을 선택해주세요</span>
			  <input type="radio" name="member_review_rating" value="1" id="rate1" />
			  <label for="rate1">★</label>
			  <input type="radio" name="member_review_rating" value="2" id="rate2" />
			  <label for="rate2">★</label>
			  <input type="radio" name="member_review_rating" value="3" id="rate3" />
			  <label for="rate3">★</label>
			  <input type="radio" name="member_review_rating" value="4" id="rate4" />
			  <label for="rate4">★</label>
			  <input type="radio" name="member_review_rating" value="5" id="rate5" />
			  <label for="rate5">★</label>
			</fieldset>
            </div>
            <div class="form-group">
		      <label for="message-text" class="col-form-label" id="">리뷰를 남겨주세요 (최대 100자)</label>
		      <textarea class="form-control" id="message-text" name="member_review_content" required="required"></textarea>
		      <div class="char-counter text-muted" style="float: right; display: flex;">
		        <div id="currentCount">0</div>
		        <div>&nbsp;/ 100</div>
		      </div>
		    </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="submit" id="reviewBtn" class="btn btn-primary" form="review-form" >리뷰 작성</button>
      </div>
    </div>
  </div>
</div>


<script src="${pageContext.request.contextPath }/resources/mypage_js/49ee6ec.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/ac846b6.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/bfcc4c4.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/2ffe3b9.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/e679961.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/514df53.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/afbbed2.js" defer=""></script>
<script src="${pageContext.request.contextPath }/resources/mypage_js/76e0661.js" defer=""></script>
<link href="${pageContext.request.contextPath }/resources/mypage_css/css/7db96f2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/bd82ddc.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/81ef50f.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/d2d1f2f.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/8a6891b.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/ddf6c56.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/10a7d17.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/mypage_css/4bb4200.css" rel="stylesheet" type="text/css">

<!-- 낙찰취소버튼 -->
<script type="text/javascript">
  function auction_success_cancel(event) {
    // 이벤트 전파 중단
    event.stopPropagation();

    // 여기에 낙찰 취소 처리 로직을 작성하세요.
    console.log("낙찰 취소 버튼이 클릭되었습니다.");
  }
</script>

</body>
</html>