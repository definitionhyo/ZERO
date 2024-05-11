<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <link href="${pageContext.request.contextPath }/resources/css/sidebar.css" rel="stylesheet" type="text/css"> --%>
<!--   <p class="title"> 마이페이지 </p> -->
<!--   <ul class="nav flex-column"> -->
<style>
@media only screen and (min-width: 769px) {
	.snb_var {
		display:none;
	}
}

/* 작은 화면일 때 마이페이지 서브 네비 표시 */
@media only screen and (max-width: 768px) {

	.snb_var {
		display:block;
	}

	.snb_menu .snb_item{
    border-bottom: 1px solid #ebebeb;
    margin-top: 0;
	}
	
	.snb_menu .snb_link, .snb_menu .snb_link{
	    color: #222!important;
	    display: block!important;
	    font-size: 15px!important;
	    letter-spacing: -.15px!important;
	    padding: 18px 0 19px!important;
	}
	strong {
	    font-weight: bold;
	}
	.snb_list a,.snb_list a:active,.snb_list a:focus,.snb_list a:hover {
	    -webkit-text-decoration: none;
	    text-decoration: none;
	}
	
	.snb {
    padding: 36px 24px 0!important;
	}
	
	.snb .snb_title, .snb .snb_title {
    font-size: 16px;
    letter-spacing: -.16px;
    margin-bottom: 7px;
	}
	
	.snb_title {
	    display: inline-block;
	    font-size: 18px;
	    font-weight: 700;
	    letter-spacing: -.27px;
	    line-height: 22px;
	    margin-bottom: 12px;
	    vertical-align: top;
	}
	
	.snb_link{
	    line-height: 18px;
	}
	
}
</style>
<%-- 마이페이지 히든 사이드바 --%>
<div class="snb_list">
  <strong class="snb_title"> 마이페이지 </strong>
  <ul class="snb_menu">
    <li class="snb_item">
      <a class="snb_link"href="member_mypage_main">
        마이페이지홈<span class="sr-only">(current)</span>
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="member_profile">
        프로필 관리
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="member_mypage_auctionList">
        경매내역
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="member_mypage_buyList">
        상품구매내역
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="member_mypage_write_review">
        작성한리뷰
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="zpay_main">
        나의 Z-PAY
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="member_mystore">
        판매스토어
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="member_address">
        나의 주소록 관리
      </a>
    </li>
    <li class="snb_item">
      <a class="snb_link" href="myPage_inquiry">
        나의 1:1문의
      </a>
    </li>
     <li class="snb_item">
      <a class="snb_link" href="member_Info">
        개인정보 수정
      </a>
    </li>
  </ul>
</div>
<!-- 	</ul> -->
