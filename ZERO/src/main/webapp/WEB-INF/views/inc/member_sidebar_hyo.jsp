<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<%-- <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script> --%> <!-- 마이페이지 후기작성하기 안되서 주석처리해놓음 -0813정의효 -->
<script type="text/javascript">
$(document).ready(function(){
	let currentPosition = parseInt($(".sidebar").css("top"));
	$(window).scroll(function() {
		let position = $(window).scrollTop(); 
		$(".sidebar").stop().animate({"top":position+currentPosition+"px"},800);
	});
});	

</script>
<div class="sidebar">
  <p class="title"> 마이페이지 </p>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link" href="member_mypage_main">
        마이페이지홈<span class="sr-only">(current)</span>
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="member_profile">
        프로필 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="member_mypage_auctionList">
        경매내역
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="member_mypage_buyList">
        상품구매내역
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="member_mypage_writeReviewList">
        작성한 리뷰
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="zpay_main">
        나의 Z-PAY
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="member_mystore">
        판매스토어
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="member_address">
        나의 주소록 관리
      </a>
    </li>
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="myPage_inquiry">
        나의 1:1문의
      </a>
    </li>
    <hr>
     <li class="nav-item">
      <a class="nav-link" href="member_Info">
        개인정보 수정
      </a>
    </li>
    <hr>
  </ul>
</div>